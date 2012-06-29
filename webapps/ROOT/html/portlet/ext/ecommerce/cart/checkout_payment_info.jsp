<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>
<%@ page import="gnomon.hibernate.model.ecommerce.EcPaymenttype" %>
<%@ page import="gnomon.hibernate.model.payment.PmtService" %>
<%@ page import="com.ext.portlet.paycenter.service.PaymentService" %>

<liferay-util:include page="/html/portlet/ext/ecommerce/cart/cartSummary.jsp">
	<liferay-util:param name="openPanelIndex" value="0"/>
</liferay-util:include>

<%
PaymentService paymentSrv = PaymentService.getInstance();

PmtService pmtService = paymentSrv.getOrCreateSystemPmtService(PortalUtil.getCompanyId(request), CommonDefs.PMT_SERVICE_ECOMMERCE);
List<ViewResult> paymentMethods = paymentSrv.listAvailablePaymentTypes(pmtService, lang);
//List paymentMethods = OrderService.getInstance()
//	.listEcPaymenttypesWithLanguage(PortalUtil.getCompanyId(request), lang, "table1.active=1");

String methodId = "";

String cmd = ParamUtil.getString(request, "cmd");
PaymentMethod paymentMethod = CheckoutUtil.getPaymentMethod(request);

if (cmd.equals("update")) {
	
	methodId = ParamUtil.getString(request, "paymentMethod");
	
} else {
	
	if ((paymentMethod==null) && (themeDisplay.isSignedIn())) {
		paymentMethod = OrderService.getInstance().getDefaultPaymentMethodForUser(user, lang);
	}
	if (paymentMethod!=null) {
		methodId = paymentMethod.getMethodId() + ""; 
	}
	
}
%>

<script type="text/javascript">
	function <portlet:namespace />goNext() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "payment_info";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "update";
		submitForm(document.<portlet:namespace />fm);
	}
	function <portlet:namespace />goPrevious() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "shipping_method";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "";
		submitForm(document.<portlet:namespace />fm);
	}

	var PaymentMethodsArray = new Array();
	<% if (paymentMethods != null) {
	    for (int i=0; i<paymentMethods.size(); i++) {
	    	ViewResult method = (ViewResult)paymentMethods.get(i);
		%>
		PaymentMethodsArray['<%= method.getMainid().toString() %>']= '<%= gnomon.business.StringUtils.myreplaceALL(ViewResultUtil.toString(method.getField3()), "'", "\\'")%>';
		<%    	
	    }
	} %>
	
	function <portlet:namespace/>showPaymentMethodDescription() {
		var selectedMethod = document.<portlet:namespace />fm.<portlet:namespace/>paymentMethod.value; 
		var descDiv = document.getElementById('payment_method_description');
		if (PaymentMethodsArray[selectedMethod] != undefined && PaymentMethodsArray[selectedMethod] != null && PaymentMethodsArray[selectedMethod] != '')
		{
			var descTextDiv = document.getElementById('payment_method_description_text');
			descTextDiv.innerHTML = PaymentMethodsArray[selectedMethod];
			descDiv.style.display="inline";
		}
		else
			descDiv.style.display="none";
	}
</script>


<liferay-ui:error exception="<%= PaymentMethodException.class %>" message="please-select-a-valid-payment-method" />
<liferay-ui:error exception="<%= PaymentMethodNotAvailableException.class %>" message="the-selected-payment-method-is-not-available" />

<form class="uni-form" action="<%=submitURL%>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="" type="hidden" /> 
<input name="<portlet:namespace/>page" id="<portlet:namespace/>page" value="" type="hidden" />
<fieldset class="block-labels">
	<legend><%=LanguageUtil.get(pageContext,"payment-method") %></legend>
	
	<div class="ctrl-holder">
		
		<label for="<portlet:namespace/>paymentMethod"> <liferay-ui:message key="payment-method" /></label>
		<select name="<portlet:namespace/>paymentMethod" id="<portlet:namespace/>paymentMethod" class="selectInput"
			onChange="<portlet:namespace/>showPaymentMethodDescription();">
			<option value=""><liferay-ui:message key="please-select" /></option>
			<%--<option value="-1"><liferay-ui:message key="other" /></option>--%>
			<% for (int i=0; paymentMethods!=null && i<paymentMethods.size(); i++) { 
				ViewResult method = (ViewResult)paymentMethods.get(i);
			%>
				<option value="<%=method.getMainid()+""%>" <%=methodId.equals(method.getMainid()+"")? "selected": "" %>>
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



</fieldset>

<div class="block-labels" style="text-align:right;">
	<div class="buttonHolder">
		<%--<input type="reset" class="resetButton" value="<liferay-ui:message key="reset" />"/>--%>
		<input type="button" class="resetButton" value="<liferay-ui:message key="back" />" onClick="<portlet:namespace />goPrevious();"/>
		<input type="button" class="primaryAction" value="<liferay-ui:message key="next" />" onClick="<portlet:namespace />goNext();"/>
	</div>
</div>


</form>

<br /><br />

<script type="text/javascript">
	<portlet:namespace/>showPaymentMethodDescription();
</script>