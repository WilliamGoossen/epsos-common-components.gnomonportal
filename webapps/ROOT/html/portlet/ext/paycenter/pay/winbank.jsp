<%@ include file="/html/portlet/ext/paycenter/pay/init.jsp" %>
<%@ page import="gnomon.webservices.winbank.TicketRequest" %>
<%@ page import="gnomon.webservices.winbank.TicketResponse" %>
<%@ page import="gnomon.webservices.winbank.TicketingServiceLocator" %>
<%@ page import="gnomon.webservices.winbank.TicketingServiceSoap_BindingStub" %>

<c:if test="<%=!SessionMessages.isEmpty(request) %>">
    <span class="portlet-msg-success">
    <%
    Iterator itr = SessionMessages.iterator(request);
    while (itr.hasNext()) {
        out.println(itr.next());
        out.println("<br/>");
    }
    //SessionMessages.clear(req);
    %>
    </span>
    <br /><br />
</c:if>

<c:if test="<%=!SessionErrors.isEmpty(request) %>">
    <span class="portlet-msg-error">
    <%
    Iterator itr2 = SessionErrors.iterator(request);
    while (itr2.hasNext()) {
        out.println(itr2.next());
        out.println("<br/>");
    }
    //SessionErrors.clear(req);
    %>
    </span>
    <br /><br />
</c:if>

<c:choose>
<c:when test="<%=paymentCart!=null && !paymentCart.isEmpty() && pmtService!=null %>">

	<%
	submitURL = PaycenterUtil.getWinbankRedirectURL(request);
    List<EcPaymenttype> paymentTypes = (List<EcPaymenttype>)GnPersistenceService.getInstance(null)
	    .listObjects(PortalUtil.getCompanyId(request), EcPaymenttype.class, 
	        "table1.systemCode='" + CommonDefs.PAYMENT_TYPE_WINBANK + "'");
	
	EcPaymenttype paymentType = (paymentTypes!=null && paymentTypes.size()>0) ? paymentTypes.get(0): null;
	BigDecimal paymentCosts = com.ext.portlet.ecommerce.cart.util.CheckoutUtil.calculatePaymentCosts(totalAmount, paymentType);
	BigDecimal finalAmountToPay = totalAmount.add(paymentCosts);
	
	PmtSrvPmtType pmtConfig = PaymentService.getInstance().getPmtServiceType(serviceid, CommonDefs.PAYMENT_TYPE_WINBANK, PortalUtil.getCompanyId(request));
	
	String winbankMerchantId = GetterUtil.getString(pmtConfig.getValue1(), GnPropsUtil.get(PortalUtil.getCompanyId(request), "winbankMerchantId"));
	String winbankPosId = GetterUtil.getString(pmtConfig.getValue2(), GnPropsUtil.get(PortalUtil.getCompanyId(request), "winbankPosId"));
	String winbankUser = GetterUtil.getString(pmtConfig.getValue3(), GnPropsUtil.get(PortalUtil.getCompanyId(request), "winbankUser"));
	String winbankPassword = GetterUtil.getString(pmtConfig.getValue4(), GnPropsUtil.get(PortalUtil.getCompanyId(request), "winbankPassword"));
	String encryptedPassword = gnomon.business.EncryptionUtils.toMD5(winbankPassword);
	String winbankAcquirerId = GetterUtil.getString(pmtConfig.getValue5(), GnPropsUtil.get(PortalUtil.getCompanyId(request), "winbankAcquirerId"));
	gnomon.webservices.winbank.TicketingServiceLocator tsl = new gnomon.webservices.winbank.TicketingServiceLocator();
	TicketingServiceSoap_BindingStub stub = (TicketingServiceSoap_BindingStub)tsl.getTicketingServiceSoap();
	TicketRequest tr = new TicketRequest();
	tr.setAcquirerId(GetterUtil.getInteger(winbankAcquirerId));
	tr.setMerchantId(GetterUtil.getInteger(winbankMerchantId));
	tr.setPosId(GetterUtil.getInteger(winbankPosId));
	tr.setUsername(winbankUser);
	tr.setPassword(encryptedPassword);
	tr.setRequestType("02");
	tr.setCurrencyCode(978);
	tr.setMerchantReference(paymentCart.getServiceSystemCode() + paymentCart.getMainId());
	//tr.setAmount(paymentCart.getTotalAmount());
	//tr.setAmount(new BigDecimal(1));
	tr.setAmount(finalAmountToPay);
	tr.setInstallments(new org.apache.axis.types.UnsignedByte(0));
	tr.setExpirePreauth(new org.apache.axis.types.UnsignedByte(0));
	tr.setBnpl(new org.apache.axis.types.UnsignedByte(0));
	tr.setParameters(HttpUtil.encodeURL(paymentCart.getServiceSystemCode()) + "@@" + paymentCart.getMainId());
	TicketResponse tr1 = stub.issueNewTicket(tr);
	System.out.println(tr1.getResultCode());
	System.out.println(tr1.getResultDescription());
	System.out.println(tr1.getTranTicket());
	if (tr1.getResultCode().equals("0"))
	{
	paymentCart.setTranTicket(tr1.getTranTicket());
	}
	%>
	
	<form class="uni-form" action="<%=submitURL%>" method="post" name="fm">
	<input type="hidden" name="acquirerid" value="<%= winbankAcquirerId %>">
	<input type="hidden" name="merchantid" value="<%= winbankMerchantId %>">
	<input type="hidden" name="posid" value="<%= winbankPosId %>">
	<input type="hidden" name="user" value="<%= winbankUser %>">
	<input type="hidden" name="LanguageCode" value="el-GR">
	<input type="hidden" name="merchantreference" value="<%= paymentCart.getServiceSystemCode() + paymentCart.getMainId() %>" readonly>
	<input type="hidden" name="ParamBackLink" value="responsecode=-111">
	<fieldset>
	
		<legend><%=LanguageUtil.get(pageContext,"winbank-payment") %></legend>
		
		
		<div class="ctrl-holder">
			<liferay-util:include page="/html/portlet/ext/paycenter/pay/paymentCartOverview.jsp">
                <liferay-util:param name="paymentCosts" value="<%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(paymentCosts.doubleValue())%>"/>
                <liferay-util:param name="finalAmountToPay" value="<%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(finalAmountToPay.doubleValue())%>"/>
            </liferay-util:include>
		</div>
		
		<div class="button-holder">
			<c:choose>
			<c:when test="<%=Validator.isNull(backURL) %>">
            <span class="back-button">
				<input type="button" class="secondaryAction" value="<liferay-ui:message key="pay-later" />" onClick="history.go(-1);"/>
            </span>
			</c:when>
			<c:otherwise>
            <span class="back-button">
				<input type="button" class="secondaryAction" value="<liferay-ui:message key="pay-later" />" onClick="self.location = '<%= backURL %>';"/>
            </span>
			</c:otherwise>
			</c:choose>
			<span class="winbank-button">
				<input type="submit" class="primaryAction" value="<liferay-ui:message key="go-to-winbank" />"/>
			</span>
		</div>		

	</fieldset>
	</form>

</c:when>
<c:otherwise>
	<%=LanguageUtil.get(pageContext,"your-payment-cart-is-empty-or-has-expired") %>
</c:otherwise>
</c:choose>

<br />
<img src="<%=themeDisplay.getPathThemeImages()%>/shopping/visa2.jpg" width="48" height="32" alt="Visa" />&nbsp; 
<img src="<%=themeDisplay.getPathThemeImages()%>/shopping/mastercard2.jpg" width="48" height="32" alt="Mastercard" />&nbsp; 
<img src="<%=themeDisplay.getPathThemeImages()%>/shopping/electron2.jpg" width="48" height="32" alt="Visa Electron" />&nbsp; 