<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.*" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>