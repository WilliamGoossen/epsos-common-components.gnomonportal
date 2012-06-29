<%@ include file="/html/portlet/ext/crm/helpdesk/requestTypes/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/helpdeskRequestTypes/update?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.helpdesk.requesttype.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/helpdeskRequestTypes/delete?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.helpdesk.requesttype.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/crm/helpdeskRequestTypes/add?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.helpdesk.requesttype.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/crm/helpdeskRequestTypes/add?actionURL=true" ;
	buttonText = "crm.button.add-translation";
	titleText = "crm.helpdesk.requesttype.add-translation";
}
String categoryid = request.getParameter("categoryid");
if (categoryid == null) categoryid = "";
%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="categoryid" value="<%= categoryid %>">
<input type="hidden" name="redirect" value="<%= redirect %>">

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="CrRequestTypeForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>
</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="CrRequestTypeForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/crm/helpdeskRequestTypes/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="crm.button.delete-translation" />
		  <tiles:put name="formName"   value="CrRequestTypeForm" />
		  <tiles:put name="confirm" value="crm.button.delete-translation-are-you-sure"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

</html:form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta" action="/ext/crm/helpdeskRequestTypes/list"><img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.list") %></html:link></TD>
</TR></TABLE>


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3  >Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/crm/helpdeskRequestTypes/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/crm/helpdeskRequestTypes/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<%
} catch (Exception e) {e.printStackTrace(); } %>