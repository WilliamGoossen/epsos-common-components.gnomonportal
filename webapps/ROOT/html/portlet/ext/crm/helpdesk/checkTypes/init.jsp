<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrCheckType" %>
<%@ page import="gnomon.hibernate.model.crm.CrCheckTypeLanguage" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>