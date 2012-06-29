<%
/**
Created by Soumelidis Nikolaos, 13:30 @ 22/12/2006, gnomon informatics
 */
%>
<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.banners.*" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>
<%@ page import="com.ext.util.CommonDefs" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>


<%
String viewOrientation = prefs.getValue("view-orientation", StringPool.BLANK);
String sourceSchema = prefs.getValue("source-schema", "show-recent");
String numberOfBanners = prefs.getValue("number-of-banners", StringPool.BLANK);
String sourceItemsStr = prefs.getValue("source-items", StringPool.BLANK);
%>