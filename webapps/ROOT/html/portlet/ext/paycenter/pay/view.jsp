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
<c:when test="<%=paymentCart!=null && !paymentCart.isEmpty() && pmtService!=null %>">

	<%
		submitURL = PaycenterUtil.getPaycenterURL(request);
		String gateway = ParamUtil.getString(request, "gateway");
		
		List<ViewResult> paymentTypes = PaymentService.getInstance().listAvailablePaymentTypes(pmtService, lang);
		
	%>
	
	<script type="text/javascript">
	
		var PaymentMethodsArray = new Array();
		var PaymentChargesArray = new Array();
		<% if (paymentTypes != null) {
		    for (int i=0; i<paymentTypes.size(); i++) {
		    	ViewResult method = (ViewResult)paymentTypes.get(i);
	            Integer impactType = (Integer)method.getField4();
	            BigDecimal priceImpact = (BigDecimal)method.getField5();
	            BigDecimal paymentCharge = com.ext.portlet.ecommerce.cart.util.CheckoutUtil.calculatePaymentCosts(totalAmount, impactType, priceImpact);
	            String paymentChargeStr = paymentCharge.setScale(2, BigDecimal.ROUND_HALF_UP).toString();
			%>
			PaymentMethodsArray['<%= ViewResultUtil.toString(method.getField1())%>']= '<%= gnomon.business.StringUtils.myreplaceALL(ViewResultUtil.toString(method.getField3()), "'", "\\'")%>';
			PaymentChargesArray['<%= ViewResultUtil.toString(method.getField1())%>']= <%= paymentChargeStr%>;
			<%
		    }
		} %>
		
		function showPaymentMethodDescription() {
			var selectedMethod = document.fm.gateway.value;
			var descDiv = document.getElementById('payment_method_description');
			if (PaymentMethodsArray[selectedMethod] != undefined && PaymentMethodsArray[selectedMethod] != '')
			{
				var descTextDiv = document.getElementById('payment_method_description_text');
				descTextDiv.innerHTML = PaymentMethodsArray[selectedMethod];
				descDiv.style.display="inline";
			}
			else {
				descDiv.style.display="none";
			}

			var pPaymentCosts = document.getElementById('pPaymentCosts');
	        var pAmountToPay = document.getElementById('pAmountToPay');
	        if (PaymentChargesArray[selectedMethod] != undefined && PaymentChargesArray[selectedMethod] != null) {
	            var paymentCost = parseFloat(PaymentChargesArray[selectedMethod]);
	            var amountToPay = <%=totalAmount.setScale(2, BigDecimal.ROUND_HALF_UP).toString()%> + paymentCost;
	            pPaymentCosts.innerHTML = '<strong><liferay-ui:message key="payment-costs" /></strong>: ' + paymentCost + '&nbsp; &#8364;';
	            pAmountToPay.innerHTML = '<strong><liferay-ui:message key="final-amount-to-pay" /></strong>: ' + amountToPay + '&nbsp; &#8364;';
	        } else {
	            pPaymentCosts.innerHTML = '<strong><liferay-ui:message key="payment-costs" /></strong>: ' + '';
	            pAmountToPay.innerHTML = '<strong><liferay-ui:message key="final-amount-to-pay" /></strong>: ' + '';
	        }
		}
	</script>

	<form class="uni-form" action="<%=submitURL%>" method="post" name="fm">
	<input name="cmd" id="cmd" value="pay" type="hidden" />
	
	<fieldset class="block-labels">
		<legend><%=LanguageUtil.get(pageContext,"payment-method") %></legend>
		
		<div class="ctrl-holder">
		
			<liferay-util:include page="/html/portlet/ext/paycenter/pay/paymentCartOverview.jsp"/>
	
		</div>
		
	
		<div class="ctrl-holder">
			<label for="gateway" ><em>*</em><liferay-ui:message key="please-select" /></label>
			<select name="gateway" id="gateway" class="selectInput" onChange="showPaymentMethodDescription();">
				<option value=""><%=""%></option>
				<%
				for (int i=0; paymentTypes!=null && i<paymentTypes.size(); i++) {
					ViewResult paymentType = paymentTypes.get(i);
					String paymentCode = ViewResultUtil.getString(paymentType, "field1");
					String paymentName = ViewResultUtil.getString(paymentType, "field2");
				%>
					<option <%= paymentCode.equals(gateway) ? "selected" : "" %> value="<%=paymentCode%>"><%=paymentName%></option>				
				<%
				}
				%>
			</select>
			<br>
			<div id="payment_method_description" style="display:none;">
			<fieldset>
			<div id="payment_method_description_text">
			<!-- Payment Method Description will be loaded here upon user selection DO NOT CHANGE DIV NAMES-->
			</div>
			</fieldset>
			<br>
			</div>
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
            <span class="fwd-button">
				<input type="submit" class="primaryAction" value="<liferay-ui:message key="submit" />"/>
            </span>
		</div>
	
	</fieldset>
	</form>

	<br /><br />
	
	<script type="text/javascript">
	    showPaymentMethodDescription();
    </script>

</c:when>
<c:otherwise>
	<%=LanguageUtil.get(pageContext,"your-payment-cart-is-empty-or-has-expired") %>
</c:otherwise>
</c:choose>