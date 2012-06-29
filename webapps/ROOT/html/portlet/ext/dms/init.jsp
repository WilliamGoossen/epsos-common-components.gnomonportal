<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.ext.portlet.dms.util.*" %>

<%@ page import="org.alfresco.webservice.types.NamedValue" %>
<%@ page import="org.alfresco.webservice.types.Node" %>
<%@ page import="org.alfresco.webservice.types.ResultSetRow" %>
<%@ page import="org.alfresco.webservice.types.ResultSetRowNode" %>
<%@ page import="org.alfresco.webservice.util.*" %>
<%@ page import="javax.portlet.PortletURL" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

String instanceUuid = ParamUtil.getString(request, "instanceUuid", prefs.getValue("instanceUuid",""));
if (Validator.isNull(instanceUuid)) instanceUuid = GetterUtil.getString(PropsUtil.get("alfresco.uuid"));
String instancePortletListStyle = ParamUtil.getString(request,"listStyle",
		prefs.getValue("list-style", StringPool.BLANK));
//String uuid = prefs.getValue("uuid", StringPool.BLANK);
String uuid = instanceUuid;
boolean maximizeLinks = GetterUtil.getBoolean(prefs.getValue("maximize-links", StringPool.BLANK));

%>