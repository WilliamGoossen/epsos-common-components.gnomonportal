<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrMessage" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>