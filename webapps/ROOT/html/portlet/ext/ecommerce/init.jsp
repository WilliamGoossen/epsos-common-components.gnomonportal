<%@ include file="/html/portlet/ext/base/init.jsp" %>

<%@ page import="gnomon.util.*" %>
<%@ page import="gnomon.hibernate.model.ecommerce.*" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.*" %>
<%@ page import="com.ext.portlet.ecommerce.product.service.*" %>
<%@ page import="com.ext.portlet.ecommerce.EShopPropsUtil" %>
<%@ page import="org.apache.commons.lang.time.FastDateFormat" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="gnomon.business.ViewResultUtil" %>

<portlet:defineObjects />

<%
String redirect = (String)request.getParameter("redirect");


long rootPlid1 = GetterUtil.getLong(prefs.getValue("root-plid", StringPool.BLANK));
%>