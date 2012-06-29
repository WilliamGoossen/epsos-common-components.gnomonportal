<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrDeviceAlert" %>
<%@ page import="gnomon.hibernate.model.crm.CrDeviceAlertComment" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>