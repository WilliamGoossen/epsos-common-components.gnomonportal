<%@ include file="/html/portlet/ext/permissions/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/permissions/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "gn.permissions.action.update";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/permissions/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "gn.permissions.action.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/permissions/add?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "gn.permissions.action.add";
}
%>
<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="GnActionForm"/>
</tiles:insert>

<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/permissions/view"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.permissions.action.list") %></html:link></TD>
</TR></TABLE>

