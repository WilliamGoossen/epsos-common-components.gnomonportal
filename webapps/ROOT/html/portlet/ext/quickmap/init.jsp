<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

long rootPlid = GetterUtil.getLong(prefs.getValue("root-plid", StringPool.BLANK));
//int displayDepth = GetterUtil.getInteger(prefs.getValue("display-depth", StringPool.BLANK));
boolean showBreadcrumbs = PrefsParamUtil.getBoolean(prefs, request, "showBreadcrumbs", true);
%>