<%@ page import="java.sql.*" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.util.servlet.*" %>
<%@ page import="com.ext.portlet.topics.service.permission.*" %>

<%@ include file="/html/portlet/init.jsp" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>