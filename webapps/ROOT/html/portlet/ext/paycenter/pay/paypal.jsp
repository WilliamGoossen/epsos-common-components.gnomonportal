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
	<c:when test="<%=paymentCart!=null && !paymentCart.isEmpty() && pmtService!=null%>">

		<%
		submitURL = PaycenterUtil.getPaypalRedirectURL(request);
	    List<EcPaymenttype> paymentTypes = (List<EcPaymenttype>)GnPersistenceService.getInstance(null)
	        .listObjects(PortalUtil.getCompanyId(request), EcPaymenttype.class, 
	            "table1.systemCode='" + CommonDefs.PAYMENT_TYPE_PAYPAL + "'");
	    
	    EcPaymenttype paymentType = (paymentTypes!=null && paymentTypes.size()>0) ? paymentTypes.get(0): null;
	    BigDecimal paymentCosts = com.ext.portlet.ecommerce.cart.util.CheckoutUtil.calculatePaymentCosts(totalAmount, paymentType);
	    BigDecimal finalAmountToPay = totalAmount.add(paymentCosts);
		%>

		<form class="uni-form" action="<%=submitURL%>" method="post" name="fm">
		
		<fieldset>
		
			<legend><%=LanguageUtil.get(pageContext,"paypal-payment") %></legend>
			
			
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
                <span class="paypal-button">
					<input type="submit" class="primaryAction" value="<liferay-ui:message key="go-to-paypal" />"/>
                </span>
			</div>		
	
		</fieldset>
		</form>
		
	</c:when>
	<c:otherwise>
		<%=LanguageUtil.get(pageContext,"your-payment-cart-is-empty-or-has-expired") %>
	</c:otherwise>
</c:choose>