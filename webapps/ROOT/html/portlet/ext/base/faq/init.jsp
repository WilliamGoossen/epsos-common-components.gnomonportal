<%
/**
Created by Soumelidis Nikolaos, 11:00 @ 3/11/2006, gnomon informatics
 */
%>

<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.faq.*" %>
<%@ page import="gnomon.hibernate.model.base.faq.contact.*" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>