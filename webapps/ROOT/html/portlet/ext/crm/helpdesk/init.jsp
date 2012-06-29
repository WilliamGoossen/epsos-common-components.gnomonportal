<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrRequest" %>
<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>