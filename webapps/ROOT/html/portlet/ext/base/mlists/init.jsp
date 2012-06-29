<%
/**
Created by Soumelidis Nikolaos, 15:00 @ 4/10/2006, gnomon informatics
 */
%>

<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.mlists.*" %>
<%@ page import="gnomon.hibernate.model.base.mlists.posts.*" %>
<%@ page import="gnomon.hibernate.model.base.mlists.subscribers.*" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>