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

<%
PortalPreferences prefs = PortletPreferencesFactoryUtil.getPortalPreferences(request);

String namespace = "_GN_KMS_TAG_SEARCH_";
%>
