<%@ include file="/html/portlet/ext/base/smslists_display/init.jsp" %>
<%@ page import="com.ext.portlet.base.smslists_display.LoadSubscriptionFormAction" %>

<%
String userIsSubscribed = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_USER_IS_SUBSCRIBED);
String activeSubscription = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_ACTIVE_SUBSCRIPTION);
String noSmsListFound = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_NO_SMS_LISTS_FOUND);
String unsubscribe = (String)request.getAttribute(LoadSubscriptionFormAction.ATTR_UNSUBSCRIBE);

boolean userIsSubscribedFlag = (userIsSubscribed != null && userIsSubscribed.equals("true"));
boolean activeSubscriptionFlag = (activeSubscription != null && activeSubscription.equals("true"));
boolean noSmsListFoundFlag = (noSmsListFound != null && noSmsListFound.equals("true"));
boolean unsubscribeFlag = (unsubscribe != null && unsubscribe.equals("true"));

boolean defaultUser = user.isDefaultUser();
%>


<%if(defaultUser){%>

<p>
<%= LanguageUtil.get(pageContext, "bs.smslists.login-required")%>
</p>

<%}else{%>

<%if (noSmsListFoundFlag) {%>
<span class="portlet-msg-error">
<%=LanguageUtil.get(pageContext, "bs.smslists.subscriber.registration-no-list-found")%>
</span>
<%} else {
String tmpMessage = "";

if (unsubscribeFlag){
	tmpMessage = "bs.smslists.subscriber.unsubscribe-message";
}else{
	if (!userIsSubscribedFlag){
		tmpMessage = "bs.smslists.subscriber.registration-message";
	} else{
		if (activeSubscriptionFlag){
			tmpMessage = "bs.smslists.subscriber.activated-message";
		}else{
			tmpMessage = "bs.smslists.subscriber.activation-message";
		}
	}
}
%>

<%=LanguageUtil.get(pageContext, tmpMessage)%>

<%}%>
<BR>
<BR>

<%}%>
