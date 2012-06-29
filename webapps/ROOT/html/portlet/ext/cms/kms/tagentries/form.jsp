<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
Integer groupid = (Integer)request.getAttribute("groupid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/kms/updateTagEntry?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "gn.kms.tagentry.update";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/kms/deleteTagEntry?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "gn.kms.tagentry.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/kms/addTagEntry?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "gn.kms.tagentry.add";
}
%>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="GnKmsTagEntryForm"/>
</tiles:insert>

<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>

<%
java.util.HashMap params = new java.util.HashMap();
params.put("groupid", groupid);
pageContext.setAttribute("paramsName", params);
%>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/kms/viewTagEntry" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.tagentry.list") %></html:link></TD>
</TR></TABLE>

