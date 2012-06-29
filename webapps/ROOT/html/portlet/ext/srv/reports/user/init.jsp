<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.model.srv.SrvService" %>
<%@ page import="gnomon.hibernate.model.srv.SrvServiceLanguage" %>
<%@ page import="gnomon.hibernate.model.srv.SrvServiceReport" %>
<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>
