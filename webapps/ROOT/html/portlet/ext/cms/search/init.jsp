<%@ include file="/html/common/init.jsp" %>

<portlet:defineObjects />


<%@ page import="com.liferay.portal.kernel.search.OpenSearch" %>
<%@ page import="com.liferay.portal.kernel.search.SearchException" %>
<%@ page import="com.liferay.portal.kernel.util.InstancePool" %>
<%@ page import="com.liferay.portal.search.OpenSearchUtil" %>
<%@ page import="com.liferay.portal.util.SAXReaderFactory" %>

<%@ page import="org.dom4j.Document" %>
<%@ page import="org.dom4j.Element" %>
<%@ page import="org.dom4j.io.SAXReader" %>

<%@ page import="javax.portlet.PortletRequest"%>
<%@ page import="javax.portlet.RenderRequest"%>
<%@ page import="com.liferay.portlet.ActionRequestImpl"%>
<%@ page import="com.liferay.portlet.RenderRequestImpl"%>
<%@ page import="com.ext.portlet.permissions.service.PermissionsService" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>



<%
PortalPreferences prefs = PortletPreferencesFactoryUtil.getPortalPreferences(request);


String namespace = "_GN_CMS_SEARCH_";

PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);


com.ext.portlet.base.contentrel.ContentRelUtil relUtil = com.ext.portlet.base.contentrel.ContentRelUtil.getInstance();
String[] classNames1 = relUtil.getPortletClassNames();
String[] portletNames1 = relUtil.getPortletNames();
%>