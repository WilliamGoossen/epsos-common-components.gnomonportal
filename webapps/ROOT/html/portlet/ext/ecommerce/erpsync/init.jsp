<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.portlet.ecommerce.*" %>
<%@ page import="com.ext.portlet.ecommerce.erp.*" %>
<%@ page import="com.ext.portlet.ecommerce.erp.intf.*" %>

<%
ErpConnector erpCon = EShopEventListener.getConnector(request);
%>