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


<c:choose>
<c:when test="<%=paymentCart!=null && !paymentCart.isEmpty() && pmtService!=null %>">

	<%
	submitURL = PaycenterUtil.getOnCreditURL(request);
	List<EcPaymenttype> paymentTypes = (List<EcPaymenttype>)GnPersistenceService.getInstance(null)
	    .listObjects(PortalUtil.getCompanyId(request), EcPaymenttype.class, 
	        "table1.systemCode='" + CommonDefs.PAYMENT_TYPE_ON_CREDIT + "'");
	
	EcPaymenttype paymentType = (paymentTypes!=null && paymentTypes.size()>0) ? paymentTypes.get(0): null;
	BigDecimal paymentCosts = com.ext.portlet.ecommerce.cart.util.CheckoutUtil.calculatePaymentCosts(totalAmount, paymentType);
	BigDecimal finalAmountToPay = totalAmount.add(paymentCosts);
	%>

	<form class="uni-form" action="<%=submitURL%>" method="post" name="fm">
	<input name="cmd" id="cmd" value="pay" type="hidden" /> 
	
	<fieldset>
	
		<legend><%=LanguageUtil.get(pageContext,"confirmation") %></legend>
		
		<div class="ctrl-holder">
			<liferay-util:include page="/html/portlet/ext/paycenter/pay/paymentCartOverview.jsp">
                <liferay-util:param name="paymentCosts" value="<%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(paymentCosts.doubleValue())%>"/>
                <liferay-util:param name="finalAmountToPay" value="<%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(finalAmountToPay.doubleValue())%>"/>
            </liferay-util:include>
		</div>
		
		<div class="button-holder">
            <span class="back-button">
				<input type="button" class="secondaryAction" value="<liferay-ui:message key="back" />" onClick="history.go(-1);"/>
            </span>
            <span class="save-button">
				<input type="submit" class="primaryAction" value="<liferay-ui:message key="confirmation" />"/>
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