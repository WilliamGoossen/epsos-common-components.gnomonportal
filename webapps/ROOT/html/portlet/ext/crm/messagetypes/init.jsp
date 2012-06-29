<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrMessageType" %>
<%@ page import="gnomon.hibernate.model.crm.CrMessageTypeLanguage" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>