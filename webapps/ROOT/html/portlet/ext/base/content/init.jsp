<%
/**
Created by Soumelidis Nikolaos, 13:30 @ 9/3/2006, gnomon informatics
 */
%>
<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="org.apache.commons.lang.time.FastDateFormat" %>
<%@ page import="java.util.GregorianCalendar" %>

<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>

<%@ page import="gnomon.hibernate.model.gn.*" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.business.StringUtils" %>
<%@ page import="com.ext.util.CommonDefs" %>



<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
String lang = gnomon.business.GeneralUtils.getLocale(request);

List itemsList = (List)request.getAttribute("itemsList");
String contentCriterion = (String)request.getAttribute("contentCriterion");
boolean CONTENT_EXISTS = (itemsList!=null) && (itemsList.size()>0);
%>


<%
String numberOfItems = prefs.getValue("number-of-items", GetterUtil.getString(PropsUtil.get("gn.cms.content.number.in.recent.default"),StringPool.BLANK));
String contentClass = prefs.getValue("content-class", GetterUtil.getString(PropsUtil.get("gn.cms.content.classes.in.recent.default"),StringPool.BLANK));
String loaderClass = prefs.getValue("loader-class", GetterUtil.getString(PropsUtil.get("gn.cms.loader.classes.in.recent.default"),StringPool.BLANK));
String contentParams = prefs.getValue("content-parameters", StringPool.BLANK);
boolean showCalendar = GetterUtil.getBoolean(prefs.getValue("show-calendar", StringPool.BLANK), GetterUtil.getBoolean(PropsUtil.get("gn.cms.content.show.calendar.default"),false));
boolean showCalendarVertical = GetterUtil.getBoolean(prefs.getValue("show-calendar-vertical", StringPool.BLANK), false);
boolean showImages = GetterUtil.getBoolean(prefs.getValue("show-images", StringPool.BLANK), false);
boolean showUpcomingEvents = GetterUtil.getBoolean(prefs.getValue("show-upcoming-events", StringPool.BLANK), false);
boolean eventsNoRecurrentEventsInList = GetterUtil.getBoolean(prefs.getValue("eventsNoRecurrentEventsInList", StringPool.BLANK), false);

String showUpcomingEventsMonthCount = prefs.getValue("showUpcomingEventsMonthCount", "1");
%>