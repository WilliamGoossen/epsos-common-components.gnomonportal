<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
Integer aspectid = (Integer)request.getAttribute("aspectid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/kms/updateProperty?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "gn.kms.property.update";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/kms/deleteProperty?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "gn.kms.property.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/kms/addProperty?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "gn.kms.property.add";
}
else if (loadaction.equals("trans"))
{
	formUrl = "/ext/kms/addProperty?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "gn.kms.property.add-translation";
}
%>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<bean:define id="labels1" name="GnKmsPropertyForm" property="possLabelsForFieldType"/>
<bean:define id="labels2" name="GnKmsPropertyForm" property="possLabelsForUIType"/>
<% 
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels1;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}

labelsList = (String[])labels2;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="GnKmsPropertyForm"/>
</tiles:insert>

<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">

<logic:notEqual name="GnKmsPropertyForm" property="lang" value="<%= defLang %>">
<% if (!loadaction.equals("trans")) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/kms/deleteProperty" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
  <tiles:put name="formName"   value="GnKmsPropertyForm" />
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
	<tiles:put name="editAction"  value="/ext/kms/loadProperty" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="edit"/>
    <tiles:put name="addAction"  value="/ext/kms/loadProperty" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
</tiles:insert>

<% } %>


<br>


<%
java.util.HashMap params = new java.util.HashMap();
params.put("aspectid", aspectid);
pageContext.setAttribute("paramsName", params);
%>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/kms/listProperty" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.property.list") %></html:link></TD>
</TR></TABLE>

