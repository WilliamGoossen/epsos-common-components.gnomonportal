<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.mlists_display.*" %>
<%@ page import="com.ext.portlet.base.mlists_display.*" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>