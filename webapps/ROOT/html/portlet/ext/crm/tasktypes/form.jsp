<%@ include file="/html/portlet/ext/crm/tasktypes/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/tasktypes/update?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.tasktype.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/tasktypes/delete?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.tasktype.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/crm/tasktypes/add?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.tasktype.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/crm/tasktypes/add?actionURL=true" ;
	buttonText = "crm.button.add-translation";
	titleText = "crm.tasktype.add-translation";
}
%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="CrTaskTypeForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>
</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="CrTaskTypeForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/crm/tasktypes/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="crm.button.delete-translation" />
		  <tiles:put name="formName"   value="CrTaskTypeForm" />
		  <tiles:put name="confirm" value="crm.button.delete-translation-are-you-sure"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

</html:form>

<br>

<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/tasktypes/list"><%= LanguageUtil.get(pageContext, "crm.tasktype.list") %></html:link>

<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3  >Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/crm/tasktypes/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/crm/tasktypes/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<%
} catch (Exception e) {e.printStackTrace(); } %>