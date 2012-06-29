<%@ include file="/html/portlet/ext/permissions/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String formUrl = "/ext/permissions/updatePortletSettings?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "gn.permissions.settings.edit";
String redirect = (String)request.getParameter("redirect");
%>
<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>
<bean:define id="labels" name="GnPortletSettingForm" property="enabledNames"/>
<%
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>
<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="redirect" value="<%= redirect %>">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="GnPortletSettingForm"/>
</tiles:insert>

<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/permissions/viewPortlets"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.permissions.portlet.list") %></html:link></TD>
</TR></TABLE>

