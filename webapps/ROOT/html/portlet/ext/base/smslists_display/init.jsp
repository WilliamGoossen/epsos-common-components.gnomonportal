<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.smslists_display.*" %>
<%@ page import="com.ext.portlet.base.smslists_display.*" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>