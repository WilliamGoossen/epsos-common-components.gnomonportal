<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/kms/updateAspect?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "gn.kms.aspect.update";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/kms/deleteAspect?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "gn.kms.aspect.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/kms/addAspect?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "gn.kms.aspect.add";
}
%>
<h2><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="GnKmsAspectForm"/>
</tiles:insert>

<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/kms/viewAspect"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.aspect.list") %></html:link></TD>
</TR></TABLE>

