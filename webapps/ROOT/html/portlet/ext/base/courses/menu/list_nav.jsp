<%@ include file="/html/portlet/ext/base/courses/init.jsp" %>

<portlet:defineObjects />

<%
String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");




if(instancePortletBrowseType.equals("topics")) {%>
<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/courses/list"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.courses.BsCourse"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/courses/menu/list_menu.jsp"/>
</tiles:insert>
<%} else if(instancePortletBrowseType.equals("metadata")) {%>
	<%if (request.getParameter("propertyName")!=null ) {%>

<tiles:insert page="/html/portlet/ext/struts_includes/metadataContentBrowser.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/courses/list"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.courses.BsCourse"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/courses/menu/list_menu.jsp"/>
	<tiles:put name="propertyName" value="<%=request.getParameter("propertyName").toString()%>"/>
	
</tiles:insert>
<%} else if(request.getParameter("keywords")==null || request.getParameter("keywords").toString().equals("")) {%>
	<tiles:insert page="/html/portlet/ext/struts_includes/metadataContentBrowser.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/courses/list"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.courses.BsCourse"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/courses/menu/list_menu.jsp"/>
	
	
</tiles:insert>
<%}%>
	
<% } else if(instancePortletBrowseType.equals("years")) {%>

<tiles:insert page="/html/portlet/ext/struts_includes/yearBarContentBrowser.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/courses/list"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.courses.BsCourse"/>
</tiles:insert>

<% }  %>

<%--
<table width="100%" border="0">
  <tr>
    <th colspan="3" scope="col">&nbsp;</th>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td width="50">
		<tiles:insert page="/html/portlet/ext/includes/date_search.jsp" flush="true">
		<tiles:put name="struts_action" value="/ext/courses/list"/>
		<tiles:put name="contentClass" value="gnomon.hibernate.model.base.courses.BsCourse"/>
		</tiles:insert>
	</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="3">&nbsp;</td>
  </tr>
</table>
--%>