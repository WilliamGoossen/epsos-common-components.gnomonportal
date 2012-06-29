<%@ include file="/html/portal/init.jsp" %>

<%@ page import="java.math.BigDecimal"%>

<%@ page import="gnomon.business.ViewResultUtil" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.model.ecommerce.EcPaymenttype" %>
<%@ page import="gnomon.hibernate.model.payment.PmtService" %>
<%@ page import="gnomon.hibernate.model.payment.PmtSrvPmtType" %>

<%@ page import="com.ext.portlet.paycenter.model.*" %>
<%@ page import="com.ext.portlet.paycenter.util.*" %>
<%@ page import="com.ext.portlet.paycenter.exception.*" %>
<%@ page import="com.ext.portlet.paycenter.service.*" %>
<%@ page import="gnomon.util.GnPropsUtil" %>


<%
	String lang = gnomon.business.GeneralUtils.getLocale(request);
	String redirect = ParamUtil.getString(request, "redirect");
	//String returnURL = ParamUtil.getString(request, "returnURL");
	
	PaymentCart paymentCart = PaycenterUtil.getPaymentCart(request);
	BigDecimal amount = paymentCart.getTotalAmount()!=null? paymentCart.getTotalAmount(): BigDecimal.ZERO;
	BigDecimal extraAmount = paymentCart.getExtraAmount()!=null? paymentCart.getExtraAmount(): BigDecimal.ZERO;
	BigDecimal totalAmount = amount.add(extraAmount);
	String itemName = paymentCart.getItemName()!=null? paymentCart.getItemName(): "";
	String itemDescription = paymentCart.getItemDescription()!=null? paymentCart.getItemDescription(): "";
	String itemNumber = paymentCart.getMainId()!=null? paymentCart.getMainId().toString() :"";
	Integer serviceid = paymentCart.getServiceid();
	String serviceSystemCode = paymentCart.getServiceSystemCode()!=null? paymentCart.getServiceSystemCode(): "";
	PmtService pmtService = null;
	if (Validator.isNotNull(serviceid) || Validator.isNotNull(serviceSystemCode)) {
	    pmtService = PaymentService.getInstance().getPmtServiceByIdOrCode(serviceid, serviceSystemCode, PortalUtil.getCompanyId(request));
	    serviceid = pmtService.getMainid();
	}
	String submitURL = "";
	String landURL = paymentCart.getLandURL();
	String backURL = paymentCart.getBackURL();
%>