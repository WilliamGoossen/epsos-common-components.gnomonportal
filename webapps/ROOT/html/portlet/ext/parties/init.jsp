<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.liferay.portal.theme.ThemeDisplay" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<%@ page import="gnomon.business.StringUtils" %>

<% ThemeDisplay _parties_themeDisplay = (ThemeDisplay)request.getAttribute(WebKeys.THEME_DISPLAY);
   String _parties_imgPath = themeDisplay.getPathThemeImage(); %>
   
<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");
%>