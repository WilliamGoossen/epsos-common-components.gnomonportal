<%@ include file="/html/portal/init.jsp" %>

<%@ page import="java.math.BigDecimal"%>

<%@ page import="gnomon.business.ViewResultUtil" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>

<%@ page import="com.ext.portlet.paycenter.model.*" %>
<%@ page import="com.ext.portlet.paycenter.util.*" %>


<%
	String lang = gnomon.business.GeneralUtils.getLocale(request);
	String landURL = (String)request.getAttribute("landURL");
	//String redirect = ParamUtil.getString(request, "redirect");
	//String returnURL = ParamUtil.getString(request, "returnURL");
	
	//PaymentCart paymentCart = PaycenterUtil.getPaymentCart(request);
	//String submitURL = "";
%>

<%
/*
try {
	PaymentCart paymentCart = PaycenterUtil.getPaymentCart(req);
	
	PaycenterUtil.clearPaymentCart(req);
}
catch (Exception e) {
}
*/
%>