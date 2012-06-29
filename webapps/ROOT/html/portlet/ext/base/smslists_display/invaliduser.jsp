<%@ include file="/html/portlet/ext/base/smslists_display/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.base.smslists_display.LoadSubscriptionFormAction" %>

<%@ include file="/html/portlet/ext/base/smslists_display/subscription_js.jsp" %>

user = <%= user%><BR>

<%



String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/smslists_display/subscribe?actionURL=true" ;

String buttonText = "bs.smslists.action.subscribe";
String titleText = "bs.smslists.title.subscribe";
String buttonOnClick = "submitFormForLoadSubscribe('BsSmsListSubscriptionForm')";
%>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>

<%
String userIsSubscribed = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_USER_IS_SUBSCRIBED);
String activeSubscription = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_ACTIVE_SUBSCRIPTION);
String noSmsListFound = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_NO_SMS_LISTS_FOUND);
String unsubscribe = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_UNSUBSCRIBE);

boolean userIsSubscribedFlag = (userIsSubscribed != null && userIsSubscribed.equals("true"));
boolean activeSubscriptionFlag = (activeSubscription != null && activeSubscription.equals("true"));
boolean noSmsListFoundFlag = (noSmsListFound != null && noSmsListFound.equals("true"));
boolean unsubscribeFlag = (unsubscribe != null && unsubscribe.equals("true"));
%>


<%
if (!userIsSubscribedFlag){
	buttonText = "bs.smslists.action.subscribe";
	titleText = "bs.smslists.title.subscribe";
	formUrl = "/ext/smslists_display/subscribe?actionURL=true" ;
	buttonOnClick = "submitFormForSubscribe('BsSmsListSubscriptionForm')";
} else {
	if (!activeSubscriptionFlag){
		buttonText = "bs.smslists.action.activate";
		titleText = "bs.smslists.title.activate";
		formUrl = "/ext/smslists_display/subscribe?actionURL=true" ;
		buttonOnClick = "submitFormForActivate('BsSmsListSubscriptionForm')";
	} else {
		if (unsubscribeFlag) {
			buttonText = "bs.smslists.action.unsubscribe";
			titleText = "bs.smslists.title.unsubscribe";
			formUrl = "/ext/smslists_display/unsubscribe?actionURL=true" ;
			buttonOnClick = "submitFormForUnsubscribe('BsSmsListSubscriptionForm')";
		}else {
			buttonText = "bs.smslists.action.unsubscribe";
			titleText = "bs.smslists.title.subscribe";
			formUrl = "/ext/smslists_display/load?actionURL=true" ;
			buttonOnClick = "submitFormForLoadUnsubscribe('BsSmsListSubscriptionForm')";
		}
	}
}
%>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<tiles:insert page="/html/portlet/ext/base/smslists_display/subscriptionMessage_tile.jsp" flush="true">
</tiles:insert>


<html:form action="<%= formUrl %>" method="post">
	<% if (false && loadaction != null) {%><input type="hidden" name="loadaction" value="<%= loadaction %>"><%}%>

	<table border="0px" cellpadding="2px" ><tr><td>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName" value="BsMListSubscriptionForm"/>
	<tiles:put name="noTable" value="true"/>
	</tiles:insert>
	</td></tr></table>
	<BR>
	<div align="left">
	
	<html:submit styleClass="portlet-form-button" onclick="<%=buttonOnClick%>" ><%= LanguageUtil.get(pageContext, buttonText) %>
	</html:submit>
	
	<% if (unsubscribeFlag || userIsSubscribedFlag && !activeSubscriptionFlag) {%>
		<html:submit styleClass="portlet-form-button" onclick="submitFormForRequestActivationCode('BsSmsListSubscriptionForm')" ><%= LanguageUtil.get(pageContext, "bs.smslists.action.requestActivationCode") %>
		</html:submit>
	<%}%>
	
	<% if (unsubscribeFlag) {%>
		<html:submit styleClass="portlet-form-button" onclick="submitFormForLoadSubscribe('BsSmsListSubscriptionForm')" ><%= LanguageUtil.get(pageContext, "cancel") %>
		</html:submit>
	<%}%>
	
	</div>
</html:form>

<br/>
