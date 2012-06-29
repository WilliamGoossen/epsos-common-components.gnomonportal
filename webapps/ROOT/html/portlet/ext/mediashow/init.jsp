<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<%@ page import="com.liferay.portlet.imagegallery.service.IGFolderLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.imagegallery.service.IGImageLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.imagegallery.model.IGFolder" %>
<%@ page import="com.liferay.portlet.imagegallery.model.impl.IGFolderImpl" %>
<%//@ page import="com.liferay.portlet.imagegallery.model.impl.IGFolderImpl" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

long selFolderId = GetterUtil.getLong(prefs.getValue("folder-id", StringPool.BLANK),-1);
String sspWidth = prefs.getValue("ssp-width", "500");
String sspHeight = prefs.getValue("ssp-height", "300");

String flashAttributes = prefs.getValue("flash-attributes", StringPool.BLANK);
//String flashVariables = prefs.getValue("flash-variables", StringPool.BLANK);
%>