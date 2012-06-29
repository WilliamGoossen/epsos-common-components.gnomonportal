<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrCategory" %>
<%@ page import="gnomon.hibernate.model.crm.CrCategoryLanguage" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>