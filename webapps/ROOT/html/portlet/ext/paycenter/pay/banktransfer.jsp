<%@ include file="/html/portlet/ext/paycenter/pay/init.jsp" %>

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

<c:if test="<%= SessionErrors.contains(request, InvalidTransactionCodeException.class.getName()) %>">
	<span class="portlet-msg-error">
	<liferay-ui:message key="please-enter-a-valid-transaction-code" />
	</span>
</c:if>
<c:if test="<%= SessionErrors.contains(request, InvalidBankNameException.class.getName()) %>">
	<span class="portlet-msg-error">
	<liferay-ui:message key="please-enter-a-valid-bank-name" />
	</span>
</c:if>


<c:choose>
<c:when test="<%=paymentCart!=null && !paymentCart.isEmpty() && pmtService!=null %>">

	<%
	submitURL = PaycenterUtil.getBankTransferURL(request);
	String transactionCode = ParamUtil.getString(request, "transactionCode");
	String transactionBank = ParamUtil.getString(request, "transactionBank");
	List<EcPaymenttype> paymentTypes = (List<EcPaymenttype>)GnPersistenceService.getInstance(null)
        .listObjects(PortalUtil.getCompanyId(request), EcPaymenttype.class, 
            "table1.systemCode='" + CommonDefs.PAYMENT_TYPE_BANK_TRANSFER + "'");

    EcPaymenttype paymentType = (paymentTypes!=null && paymentTypes.size()>0) ? paymentTypes.get(0): null;
    BigDecimal paymentCosts = com.ext.portlet.ecommerce.cart.util.CheckoutUtil.calculatePaymentCosts(totalAmount, paymentType);
    BigDecimal finalAmountToPay = totalAmount.add(paymentCosts);
	%>

	<form class="uni-form" action="<%=submitURL%>" method="post" name="fm">
	<input name="cmd" id="cmd" value="pay" type="hidden" /> 
	
	<fieldset>
	
		<legend><%=LanguageUtil.get(pageContext,"bank-transfer-information") %></legend>
		
		
		<div class="ctrl-holder">
			<liferay-util:include page="/html/portlet/ext/paycenter/pay/paymentCartOverview.jsp">
                <liferay-util:param name="paymentCosts" value="<%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(paymentCosts.doubleValue())%>"/>
                <liferay-util:param name="finalAmountToPay" value="<%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(finalAmountToPay.doubleValue())%>"/>
            </liferay-util:include>
		</div>
		
		
		<div class="ctrl-holder">
			<label for="transactionCode"> <liferay-ui:message key="transaction-code" /></label>
			<input name="transactionCode" id="transactionCode" value="<%=transactionCode%>" size="35" maxlength="50" type="text" class="textInput" />
			<p class="formHint"><span> <liferay-ui:message key="transaction-code-of-the-bank-transfer" /></span></p>
		</div>

		<div class="ctrl-holder">
			<label for="transactionBank"> <liferay-ui:message key="transaction-bank" /></label>
			<input name="transactionBank" id="transactionBank" value="<%=transactionBank%>" size="35" maxlength="50" type="text" class="textInput" />
			<p class="formHint"><span> <liferay-ui:message key="bank-where-you-deposited-the-amount" /></span></p>
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
            <span class="save-button">
				<input type="submit" class="primaryAction" value="<liferay-ui:message key="save-payment" />"/>
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
