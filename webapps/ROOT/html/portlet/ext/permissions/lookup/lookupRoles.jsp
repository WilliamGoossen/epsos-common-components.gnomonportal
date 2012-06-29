<%@ include file="/html/portlet/ext/permissions/init.jsp" %>

<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.liferay.portal.model.Role" %>

<link href="/html/themes/portlet/gnomon_theme/style.css" rel="stylesheet" type="text/css">

<% try {

	String lookupFieldIdHtmlId = request.getParameter("lookupFieldIdHtmlId");
	String lookupFieldDisplHtmlId = request.getParameter("lookupFieldDisplHtmlId");
	String openerFormName = request.getParameter("openerFormName");
%>

<%@ include file="/html/portlet/ext/struts_includes/Lookup_js.jsp" %>

<%
String lookupActionUrl = "/ext/permissions/roleLookupStrutsAction?actionURL=true";
%>
<html:form action="<%= lookupActionUrl %>" method="post">
<table>
	<tr><td>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
		<tiles:put name="formName" value="GnRoleLookupForm"/>
	</tiles:insert>
	</td><td>
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "gn.button.search") %>">
	</td></tr>
</table>
</html:form>
<br>
<%
List itemsList=(List) request.getAttribute("itemsList");
%>
<form name="Role_Lookup_List_Form" method="post" action="/some/url">
<h1 class="title1"><%= LanguageUtil.get(pageContext, "gn.permissions.settings.list-roles" ) %></h1>
<display:table id="items" name="itemsList" requestURI="//ext/permissions/roleLookupStrutsAction" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% Role listItem = (Role)pageContext.getAttribute("items"); %>
<display:column class="gamma1">
<input type="radio" name="group1" value="<%=listItem.getRoleId() + "&" + listItem.getName() %>">
</display:column>
<display:column class="gamma1" property="name" titleKey="gn.permissions.settings.publishroleid" sortable="true" headerClass="sortable"/>
</display:table>
<% if (itemsList.size() > 0) { %>
<input type="button" class="portlet-form-button" name="Select" value="<%= LanguageUtil.get(pageContext, "gn.button.select")%>" onclick="onSelect('Role_Lookup_List_Form', 'group1')">
<% } %>
<input type="button" class="portlet-form-button" name="Clear" value="<%= LanguageUtil.get(pageContext, "gn.button.clear")%>" onclick="onClear()">

</form>


<% } catch (Exception e) {} %>