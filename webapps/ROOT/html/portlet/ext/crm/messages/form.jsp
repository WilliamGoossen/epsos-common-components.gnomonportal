<%@ include file="/html/portlet/ext/crm/messages/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>

<%

String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/messages/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "crm.message.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/messages/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "crm.message.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/crm/messages/add?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "crm.message.add";
}

Boolean sent = (Boolean)request.getAttribute("message_sent");

%>

<h3><%= LanguageUtil.get(pageContext, titleText) %></h3>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="CrMessageForm"/>
</tiles:insert>

<div class="button-holder">
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>

<%--if (sent == null || sent.equals(Boolean.FALSE)) { %>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/crm/messages/send" />
		  <tiles:put name="buttonName" value="sendButton" />
		  <tiles:put name="buttonValue" value="send" />
		  <tiles:put name="formName"   value="CrMessageForm" />
</tiles:insert>

<% } --%>
</div>
</html:form>


