<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.liferay.portal.util.PortalUtil" %>



<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");

PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

String instancePortletShowReadMessages=GetterUtil.getString(prefs.getValue("show-read-messages", "no"));


%>