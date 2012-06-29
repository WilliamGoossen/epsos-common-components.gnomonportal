<%@ include file="/html/portlet/ext/parties/init.jsp" %>


<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>
<%@ page import="com.liferay.portal.model.Layout" %>
<%@ page import="com.liferay.portal.service.LayoutLocalServiceUtil" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

long chosenLayoutid = GetterUtil.getLong(prefs.getValue("partyLayout", StringPool.BLANK), 0);
String linkURL = GetterUtil.getString(prefs.getValue("linkURL", StringPool.BLANK), "");

List<ViewResult> topicsList = (List<ViewResult> )request.getAttribute("topicsList"); 
if (topicsList != null) {
	%>
	<ul>
	<% 
	for (ViewResult gnTopic: topicsList) {
		Layout chosenLayout =  LayoutLocalServiceUtil.getLayout(chosenLayoutid);
		String url = PortalUtil.getPortalURL(request, request.isSecure());
		url += PortalUtil.getLayoutFriendlyURL(chosenLayout, themeDisplay);
		//url += Validator.isNotNull(chosenLayout.getFriendlyURL())? chosenLayout.getFriendlyURL() : chosenLayout.getDefaultFriendlyURL();
		url += Validator.isNotNull(linkURL)? linkURL : "/~/topic/";
		url += gnTopic.getMainid();
	%>
	<li>
	<a href="<%= url %>">
	<%= gnTopic.getField4() %>
	</a>
	</li>
	<%
	}
}
%>

