<%@ include file="/html/portlet/ext/crm/helpdesk/categories/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.portlet.crm.helpdesk.categories.auditors.CrCategoryAuditorForm" %>

<%
Integer categoryid = (Integer)request.getAttribute("categoryid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/helpdeskCategories/updateAuditor?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.helpdesk.category.auditor.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/helpdeskCategories/deleteAuditor?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.helpdesk.category.auditor.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/crm/helpdeskCategories/addAuditor?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.helpdesk.category.auditor.add";
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<table>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="CrCategoryAuditorForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>
<tr>
<td colspan="3">
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.auditor.rights") %></legend>
<bean:define id="rights" name="CrCategoryAuditorForm" property="auditRights"/>
<% String auditRights = rights.toString(); 
for (int i=0; i<CrCategoryAuditorForm.ALL_RIGHTS.length; i++)
{
	%>
	<input type="checkbox" name="<%=  CrCategoryAuditorForm.ALL_RIGHTS_NAMES[i] %>" 
	       value="true" <%= loadaction.equals("delete") || loadaction.equals("view") ? "disabled" : "" %>
	       <%= CrCategoryAuditorForm.hasRight(auditRights, CrCategoryAuditorForm.ALL_RIGHTS[i]) ? "checked" : "" %>>
	 <%= LanguageUtil.get(pageContext, CrCategoryAuditorForm.ALL_RIGHTS_LANGUAGE_KEYS[i]) %> <br>	
	<%
}
%>
</fieldset>
</td>
</tr>
</table>
<br>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>


<%
java.util.HashMap map = new java.util.HashMap();
map.put("categoryid", categoryid.toString());
pageContext.setAttribute("params", map);
%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/helpdeskCategories/listAuditors" name="params"><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.auditor.list") %></html:link>
