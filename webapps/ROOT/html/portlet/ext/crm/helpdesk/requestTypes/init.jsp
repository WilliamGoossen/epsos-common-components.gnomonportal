<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrRequestType" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestTypeLanguage" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>