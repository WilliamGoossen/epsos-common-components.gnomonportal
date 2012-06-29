<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
Integer propertyid = (Integer)request.getAttribute("propertyid");
String parentid = (String)request.getAttribute("parentid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/kms/updateOption?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "gn.kms.option.update";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/kms/deleteOption?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "gn.kms.option.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/kms/addOption?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "gn.kms.option.add";
}
else if (loadaction.equals("trans"))
{
	formUrl = "/ext/kms/addOption?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "gn.kms.option.add-translation";
}
%>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="GnKmsOptionForm"/>
</tiles:insert>

<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">

<logic:notEqual name="GnKmsOptionForm" property="lang" value="<%= defLang %>">
<% if (!loadaction.equals("trans")) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/kms/deleteOption" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
  <tiles:put name="formName"   value="GnKmsOptionForm" />
  <tiles:put name="confirm" value="gn.topics.are-you-sure-you-want-to-delete-this-translation"/>
  <tiles:put name="actionParam" value="deleteDetail"/>
  <tiles:put name="actionParamValue" value="1"/>
</tiles:insert>
<% } %>
</logic:notEqual>

</html:form>

<br>
<% if (loadaction != null && loadaction.equals("edit")) { %>
<p>
<h3 class="title2">Translations</h3>
<p>

<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
	<tiles:put name="editAction"  value="/ext/kms/loadOption" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="edit"/>
    <tiles:put name="addAction"  value="/ext/kms/loadOption" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
</tiles:insert>

<% } %>

<br>

<%
java.util.HashMap params = new java.util.HashMap();
params.put("propertyid", propertyid);
if (parentid != null)
	params.put("parentid", parentid);
pageContext.setAttribute("paramsName", params);
%>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/kms/listOption" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.option.list") %></html:link></TD>
</TR></TABLE>

