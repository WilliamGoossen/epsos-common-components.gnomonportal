<%
/**
Created by Soumelidis Nikolaos, 11:00 @ 3/11/2006, gnomon informatics
 */
%>

<%@ include file="/html/portlet/ext/base/init.jsp" %>
<%@ page import="org.apache.commons.lang.time.FastDateFormat" %>
<%@ page import="gnomon.hibernate.model.base.events.*" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
// special for events, the default browsing will include the calendar, unless chosen otherwise
instancePortletSearch = GetterUtil.getString(prefs.getValue("portlet-search", "calendar"));
boolean eventsYellowPagesEnable = GetterUtil.getBoolean(prefs.getValue("eventsYellowPagesEnable", StringPool.BLANK), false);  
%>