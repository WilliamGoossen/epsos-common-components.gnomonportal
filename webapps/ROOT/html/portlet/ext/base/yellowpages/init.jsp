<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.yellowpages.*" %>
<%@ page import="org.apache.commons.lang.time.FastDateFormat" %>
<%@ page import="com.ext.util.CommonDefs" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");

boolean isWebSpaceEnabled = GetterUtil.getBoolean(
        PropsUtil.get(PortalUtil.getCompanyId(request), "bs.yellow.pages.personal.web.space.enabled"), false);
%>
