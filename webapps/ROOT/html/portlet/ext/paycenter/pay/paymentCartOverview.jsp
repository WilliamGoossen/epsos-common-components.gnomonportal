<%@ include file="/html/portlet/ext/paycenter/pay/init.jsp" %>

<c:if test="<%=paymentCart!=null && !paymentCart.isEmpty() %>">
    <%
    String cartAmount = com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(totalAmount.doubleValue());
    String paymentCosts = ParamUtil.get(request, "paymentCosts", "0");
    String finalAmountToPay = ParamUtil.get(request, "finalAmountToPay", cartAmount);
    %>
	<div class="ctrl-holder">
		<h2><%=itemName%></h2>
	
		<%--<p><liferay-ui:message key="id" />: <%=itemNumber%></p>--%>
		
		<c:if test="<%=Validator.isNotNull(itemDescription)%>">
		<p><strong><liferay-ui:message key="details" /></strong>: <%=itemDescription%></p>
		</c:if>
	
		<p><strong><liferay-ui:message key="pmt.pay_form.amount" /></strong>: <%=cartAmount%>&nbsp; &#8364;</p>
		
        <p id="pPaymentCosts"><strong><liferay-ui:message key="payment-costs" /></strong>: <%=paymentCosts%>&nbsp; &#8364;</p>
        <p id="pAmountToPay"><strong><liferay-ui:message key="final-amount-to-pay" /></strong>: <%=finalAmountToPay%>&nbsp; &#8364;</p>
		
	</div>
</c:if>