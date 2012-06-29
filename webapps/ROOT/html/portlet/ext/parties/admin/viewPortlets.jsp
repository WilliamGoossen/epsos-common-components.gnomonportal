<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<%
List portletsList=(List) request.getAttribute("portletsList");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.list.portlets") %></h2>
<!-- Portlets List -->
<%
String portletNameSearch = request.getParameter("portletName");
portletNameSearch = (portletNameSearch == null) ? "" : portletNameSearch;
String imgPath = themeDisplay.getPathThemeImage();
%>
<form action="
<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/parties/admin/viewPortlets" />
</portlet:actionURL>" method="post">

<table>
<tr valign="center">
<td valign="center">
<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.admin.portlet.title") %></span> 
</td><td valign=center>
<input type="text" class="gamma1-FormArea" name="portletName" value="<%= portletNameSearch %>">
</td><td valign=center>
<input type="image" src="<%=imgPath %>/common/search.gif" border="0" >
</td></tr></table></form>
<BR>



<form name="Parties_Admin_Portlets_Button_Form" method="post" action="/some/url">

<display:table id="portlets" name="portletsList" requestURI="//ext/parties/admin/viewPortlets" 
pagesize="20" sort="list"  style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("portlets")).getField1().toString()%>"></display:column>
<display:column class="gamma1" property="field2" titleKey="parties.admin.portlet.title" sortable="true" />
</display:table>

<% if (portletsList.size() > 0) { %>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/loadPortletRolesAndActions" />
  <tiles:put name="buttonName" value="loadButtonPortlet" />
  <tiles:put name="buttonValue" value="parties.button.edit-permissions" />
  <tiles:put name="formName"   value="Parties_Admin_Portlets_Button_Form" />
  <tiles:put name="actionParam" value="portletid"/>
  <tiles:put name="actionParamValue" value="group1"/>
</tiles:insert>

<% } %>

</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-admin") %></html:link></TD>
</TR></TABLE>