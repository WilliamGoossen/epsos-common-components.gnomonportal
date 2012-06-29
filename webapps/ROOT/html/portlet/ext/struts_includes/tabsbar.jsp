<%@ include file="/html/common/init.jsp" %>
<%@ page import="com.ext.util.TabsDescription" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<%
   TabsDescription tabsDesc = null;
   if (tileAttribute != null)
	   tabsDesc = (TabsDescription)request.getAttribute(tileAttribute);
   else
   	   tabsDesc = (TabsDescription)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TabsDescription.ATTRIBUTE);
   		
   if (tabsDesc != null) {
   int numOfTabs = tabsDesc.getNumOfTabs();
   int widthOfTab = tabsDesc.getWidthOfTab();
   int selectedTab = tabsDesc.getSelectedTabIndex();
   TabsDescription.TabLink[] tabLinks = tabsDesc.getTabLinks();
   
   if (numOfTabs > 0) {
   %>
<%--   
<table width="<%= (widthOfTab+16)*numOfTabs %>" border="0" cellspacing="0" cellpadding="0" height=25>
   <tr>
   <% for (int i=0; i<numOfTabs; i++) { %>
   	   <% TabsDescription.TabLink item = tabLinks[i]; %>
       <% 	if (selectedTab != i) { %>
       
          <td>
          <table width="<%= widthOfTab+16 %>" border="0" cellspacing="0" cellpadding="0" height=25>
          <tr>
          <td width="8"><img src="/html/themes/portlet/gnomon_theme/img/tab_left_on.gif" width="8" height="25"></td>
            <% if (item.disabled) { %>
            <td width="<%= widthOfTab %>" class="TabsHeaderDisabled">
            <% } else { %>
            <td width="<%= widthOfTab %>" class="TabsHeaderOn">
            <% } %>
               <div align="center"> <% if (item.disabled) { %>
               						<%= LanguageUtil.get(pageContext, item.title) %>
               						<% } else { %>
               								<a href="<portlet:actionURL>
               								<portlet:param name="struts_action" value="<%= item.struts_action %>"/>
               								<portlet:param name="<%= TabsDescription.SELECTED_TAB %>" value="<%= String.valueOf(i) %>"/>
										    <% if (item.params != null) {
										    	for (int p=0; p<item.params.length; p++) { %>
										    	<portlet:param name="<%= item.params[p] %>" value="<%= item.paramValues[p] %>"/>
										    <% } 
										    } %>
               								</portlet:actionURL>">
							               <%= LanguageUtil.get(pageContext, item.title) %>
							               </a>
							               <% } %>
							               </div></td>
              <td width="8"><img src="/html/themes/portlet/gnomon_theme/img/tab_right_on.gif" width="8" height="25"></td>
             </tr>
          </table>
          </td>
          
       <% } else {  // if selectedTab %>
       
          <td>
          <table width="<%= widthOfTab+16 %>" border="0" cellspacing="0" cellpadding="0" height=25>
          <tr>
          <td width="8"><img src="/html/themes/portlet/gnomon_theme/img/tab_left.gif" width="8" height="25"></td>
            <td width="<%= widthOfTab %>" class="TabsHeader">
               <div align="center"><a href="<portlet:actionURL>
               								<portlet:param name="struts_action" value="<%= item.struts_action %>"/>
               								<portlet:param name="<%= TabsDescription.SELECTED_TAB %>" value="<%= String.valueOf(i) %>"/>
										    <% if (item.params != null) {
										    	for (int p=0; p<item.params.length; p++) { %>
										    	<portlet:param name="<%= item.params[p] %>" value="<%= item.paramValues[p] %>"/>
										    <% } 
										    } %>
               								</portlet:actionURL>">
               <%= LanguageUtil.get(pageContext, item.title) %>
              <td width="8"><img src="/html/themes/portlet/gnomon_theme/img/tab_right.gif" width="8" height="25"></td>
             </tr>
          </table>
          </td>
          
       <% } // end if not selectedTab %>
   <% } // end for %>
   </tr>
   
</table>
--%>

<ul class="tabs">
<% for (int i=0; i<numOfTabs; i++) { %>
   <% TabsDescription.TabLink item = tabLinks[i]; %>
   
   <li <%= ((selectedTab == i)) ? "class=\"current\"" : "" %> >
        <% if (item.disabled) { %>
		   <%= LanguageUtil.get(pageContext, item.title) %>
        <% } else { %>
		<a href="<portlet:actionURL>
               								<portlet:param name="struts_action" value="<%= item.struts_action %>"/>
               								<portlet:param name="<%= TabsDescription.SELECTED_TAB %>" value="<%= String.valueOf(i) %>"/>
										    <% if (item.params != null) {
										    	for (int p=0; p<item.params.length; p++) { %>
										    	<portlet:param name="<%= item.params[p] %>" value="<%= item.paramValues[p] %>"/>
										    <% } 
										    } %>
               								</portlet:actionURL>">
               <%= LanguageUtil.get(pageContext, item.title) %></a>
        <% } %>
   </li>
<% } // end for %>
</ul>


<% } // end if numOfTabs>0 %>

<% } // end if tabsDesc != null %>

