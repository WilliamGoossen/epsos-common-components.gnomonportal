<%@ include file="/html/portlet/ext/epsos/consent/init.jsp" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String loadaction = request.getParameter("loadaction");
String formUrl = "/ext/epsos/consent/updateConsent?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "epsos.consent.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/epsos/consent/deleteConsent?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "epsos.consent.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/epsos/consent/addConsent?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "epsos.consent.add";
}
else if (Validator.isNull(loadaction) || loadaction.equals("view"))
{
	formUrl = "/ext/epsos/consent/loadConsent?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "epsos.consent.view";
}

%>

<h3><%= LanguageUtil.get(pageContext, titleText) %></h3>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="EpsosPatientConsentForm"/>
</tiles:insert>

<div class="button-holder">
<% if (loadaction != null && !loadaction.equals("view")) { %>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>
<% } %>
<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>
</div>

</html:form>
