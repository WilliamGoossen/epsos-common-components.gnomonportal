<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ page import="gnomon.hibernate.model.ecommerce.EcPaymenttype" %>
<%@ page import="gnomon.hibernate.model.payment.PmtService" %>
<%@ page import="com.ext.portlet.paycenter.service.PaymentService" %>
<%@ page import="com.ext.portlet.ecommerce.cart.util.CheckoutUtil" %>

<%
EcOrder order = (EcOrder)request.getAttribute("order");
BigDecimal orderTotalPrice = order.getTotalprice()!=null? order.getTotalprice(): BigDecimal.ZERO;

String lang = gnomon.business.GeneralUtils.getLocale(request);
PaymentService paymentSrv = PaymentService.getInstance();

PmtService pmtService = paymentSrv.getOrCreateSystemPmtService(PortalUtil.getCompanyId(request), CommonDefs.PMT_SERVICE_ECOMMERCE);
List<ViewResult> paymentMethods = paymentSrv.listAvailablePaymentTypes(pmtService, lang);

ViewResult selectedMethod = null;
Integer methodId = 0;
String cmd = ParamUtil.getString(request, "cmd");
if (cmd.equals("update")) {
    
    methodId = ParamUtil.getInteger(request, "paymentTypeId", 0);
    
} else {
	
	methodId = order.getEcPaymenttype()!=null? order.getEcPaymenttype().getMainid(): 0;
	
}

BigDecimal paymentCosts = CheckoutUtil.calculatePaymentCosts(orderTotalPrice, methodId);
%>

<portlet:actionURL var="payOrderURL">
    <portlet:param name="struts_action" value="/ext/orders/user/payOrder"/>
    <portlet:param name="cmd" value="pay"/>
    <portlet:param name="orderid" value="<%=order.getMainid()+"" %>"/>
    <%--<portlet:param name="paymentTypeId" value="<%=paymentTypeId %>"/>--%>
    <portlet:param name="redirect" value="<%=redirect %>"/>
</portlet:actionURL>

<liferay-ui:error exception="<%= com.ext.portlet.ecommerce.order.exception.OrderNotFoundException.class %>" message="order-not-found" />

<script type="text/javascript">
    var PaymentMethodsArray = new Array();
    var PaymentChargesArray = new Array();
    <% if (paymentMethods != null) {
        for (int i=0; i<paymentMethods.size(); i++) {
            ViewResult method = (ViewResult)paymentMethods.get(i);
            Integer impactType = (Integer)method.getField4();
            BigDecimal priceImpact = (BigDecimal)method.getField5();
			BigDecimal paymentCharge = CheckoutUtil.calculatePaymentCosts(orderTotalPrice, impactType, priceImpact);
			String paymentChargeStr = paymentCharge.setScale(2, BigDecimal.ROUND_HALF_UP).toString();
        %>
        PaymentMethodsArray['<%= method.getMainid().toString() %>']= '<%= gnomon.business.StringUtils.myreplaceALL(ViewResultUtil.toString(method.getField3()), "'", "\\'")%>';
        PaymentChargesArray['<%= method.getMainid().toString() %>']= <%= paymentChargeStr%>;
        <%      
        }
    } %>
    
    function <portlet:namespace/>showPaymentMethodDescription() {
        var selectedMethod = document.<portlet:namespace />fm.<portlet:namespace/>paymentTypeId.value; 
        var descDiv = document.getElementById('payment_method_description');
        if (PaymentMethodsArray[selectedMethod] != undefined && PaymentMethodsArray[selectedMethod] != null && PaymentMethodsArray[selectedMethod] != '')
        {
            var descTextDiv = document.getElementById('payment_method_description_text');
            descTextDiv.innerHTML = PaymentMethodsArray[selectedMethod];
            descDiv.style.display="inline";
        }
        else
            descDiv.style.display="none";
		
		var pPaymentCosts = document.getElementById('<portlet:namespace/>pPaymentCosts');
		var pAmountToPay = document.getElementById('<portlet:namespace/>pAmountToPay');
		if (PaymentChargesArray[selectedMethod] != undefined && PaymentChargesArray[selectedMethod] != null) {
			var paymentCost = parseFloat(PaymentChargesArray[selectedMethod]);
			var totalAmount = <%=orderTotalPrice.setScale(2, BigDecimal.ROUND_HALF_UP).toString()%> + paymentCost;
			pPaymentCosts.innerHTML = '<strong><liferay-ui:message key="payment-costs" /></strong>: ' + paymentCost + '&nbsp; &#8364;';
			pAmountToPay.innerHTML = '<strong><liferay-ui:message key="final-amount-to-pay" /></strong>: ' + totalAmount + '&nbsp; &#8364;';
		} else {
			pPaymentCosts.innerHTML = '<strong><liferay-ui:message key="payment-costs" /></strong>: ' + '';
			pAmountToPay.innerHTML = '<strong><liferay-ui:message key="final-amount-to-pay" /></strong>: ' + '';
		}
    }
</script>

<%-- Form to search for a guest order --%>
<form class="uni-form" action="<%=payOrderURL %>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="search" type="hidden" /> 
<fieldset class="block-labels">
	<legend><%=LanguageUtil.get(pageContext,"payment-method") %></legend>
	
	<div class="ctrl-holder">
        <p><strong><liferay-ui:message key="reference-code" /></strong>: <%=order.getReferenceCode()%></p>
        <p><strong><liferay-ui:message key="date" /></strong>: <%=order.getDatecreated().toString()%></p>
        <p><strong><liferay-ui:message key="pmt.pay_form.amount" /></strong>: <%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(order.getTotalprice().doubleValue())%>&nbsp; &#8364;</p>
        <p id="<portlet:namespace/>pPaymentCosts"><strong><liferay-ui:message key="payment-costs" /></strong>: <%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(paymentCosts.doubleValue())%>&nbsp; &#8364;</p>
        <p>&nbsp;</p>
        <p id="<portlet:namespace/>pAmountToPay"><strong><liferay-ui:message key="final-amount-to-pay" /></strong>: <%=com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(orderTotalPrice.add(paymentCosts).doubleValue())%>&nbsp; &#8364;</p>
    </div>
	
	<div class="ctrl-holder">
        <label for="<portlet:namespace/>paymentTypeId"> <liferay-ui:message key="payment-method" /></label>
        <select name="<portlet:namespace/>paymentTypeId" id="<portlet:namespace/>paymentTypeId" class="selectInput"
            onChange="<portlet:namespace/>showPaymentMethodDescription();">
            <%--<option value=""><liferay-ui:message key="please-select" /></option>--%>
            <%--<option value="-1"><liferay-ui:message key="other" /></option>--%>
            <% for (int i=0; paymentMethods!=null && i<paymentMethods.size(); i++) { 
                ViewResult method = (ViewResult)paymentMethods.get(i);
            %>
                <option value="<%=method.getMainid()+""%>" <%=methodId.equals(method.getMainid())? "selected": "" %>>
                    <%=ViewResultUtil.getString(method, "field2")%>
                </option>
            <% } %>
            
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
        <c:when test="<%=Validator.isNull(redirect) %>">
            <input type="button" class="secondaryAction" value="<liferay-ui:message key="back" />" onClick="history.go(-1);"/>
        </c:when>
        <c:otherwise>
            <input type="button" class="secondaryAction" value="<liferay-ui:message key="back" />" onClick="self.location = '<%= redirect %>';"/>
        </c:otherwise>
        </c:choose>
        
		<input type="submit" class="primaryAction" value="<liferay-ui:message key="pay-order" />"/>
	</div>

</fieldset>
</form>

<script type="text/javascript">
    <portlet:namespace/>showPaymentMethodDescription();
</script>