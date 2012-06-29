<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrDevice" %>
<%@ page import="gnomon.hibernate.model.crm.CrDeviceAssignment" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>