<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>
<%@ page import="gnomon.hibernate.model.ecommerce.EcShipping" %>

<liferay-util:include page="/html/portlet/ext/ecommerce/cart/cartSummary.jsp">
	<liferay-util:param name="openPanelIndex" value="0"/>
</liferay-util:include>

<%
	BillingInfo billInfo = CheckoutUtil.getBillingInfo(request);
	String previousPage = billInfo.isShipToBilling()? "billing_info" : "shipping_info";

	List shippingMethods = OrderService.getInstance()
		.listEcShippingWithLanguage(PortalUtil.getCompanyId(request), lang, null);
	
%>

<script type="text/javascript">
	function <portlet:namespace />goNext() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "shipping_method";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "update";
		submitForm(document.<portlet:namespace />fm);
	}
	function <portlet:namespace />goPrevious() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "<%=previousPage%>";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "";
		submitForm(document.<portlet:namespace />fm);
	}

	var ShippingMethodsArray = new Array();
	<% if (shippingMethods != null) {
	    for (int i=0; i<shippingMethods.size(); i++) {
	    	ViewResult method = (ViewResult)shippingMethods.get(i);
		%>
		ShippingMethodsArray['<%= method.getMainid().toString() %>']= '<%= gnomon.business.StringUtils.myreplaceALL(ViewResultUtil.toString(method.getField2()), "'", "\\'")%>';
		<%    	
	    }
	} %>
	
	function <portlet:namespace/>showShippingMethodDescription() {
		var selectedMethod = document.<portlet:namespace />fm.<portlet:namespace/>shippingMethod.value; 
		var descDiv = document.getElementById('shipping_method_description');
		if (ShippingMethodsArray[selectedMethod] != undefined && ShippingMethodsArray[selectedMethod] != null && ShippingMethodsArray[selectedMethod]!='')
		{
			var descTextDiv = document.getElementById('shipping_method_description_text');
			descTextDiv.innerHTML = ShippingMethodsArray[selectedMethod];
			descDiv.style.display="inline";
		}
		else
			descDiv.style.display="none";
	}
</script>

<%
String methodId = "";

String cmd = ParamUtil.getString(request, "cmd");
ShippingMethod shippingMethod = CheckoutUtil.getShippingMethod(request);

if (cmd.equals("update")) {
	methodId = ParamUtil.getString(request, "shippingMethod");
} else {
	if ((shippingMethod==null) && (themeDisplay.isSignedIn())) {
		shippingMethod = OrderService.getInstance().getDefaultShippingMethodForUser(user, lang);
	}
	if (shippingMethod!=null) {
		methodId = shippingMethod.getMethodId() + ""; 
	}
}
%>

<liferay-ui:error exception="<%= ShippingMethodException.class %>" message="please-select-a-valid-shipping-method" />

<form class="uni-form" action="<%=submitURL%>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="" type="hidden" /> 
<input name="<portlet:namespace/>page" id="<portlet:namespace/>page" value="" type="hidden" />
<fieldset class="block-labels">
	<legend><%=LanguageUtil.get(pageContext,"shipping-method") %></legend>
	
	<div class="ctrl-holder">
	
		<label for="<portlet:namespace/>shippingMethod"> <liferay-ui:message key="shipping-method" /></label>
		<select  name="<portlet:namespace/>shippingMethod" id="<portlet:namespace/>shippingMethod" class="selectInput"
		onChange="<portlet:namespace/>showShippingMethodDescription();">
			<option value=""><liferay-ui:message key="please-select" /></option>
			<%--<option value="-1"><liferay-ui:message key="other" /></option>--%>
			<% for (int i=0; shippingMethods!=null && i<shippingMethods.size(); i++) { 
				ViewResult method = (ViewResult)shippingMethods.get(i);
			%>
				<option value="<%=method.getMainid()+""%>" <%=methodId.equals(method.getMainid()+"")? "selected": "" %>>
					<%=ViewResultUtil.toString(method.getField1())%>
				</option>
			<% } %>
			
		</select>
		<br>
		<div id="shipping_method_description" style="display:none;">
		<fieldset>
		<div id="shipping_method_description_text">
		<!-- Shippin Method Description will be loaded here upon user selection DO NOT CHANGE DIV NAMES-->
		</div>
		</fieldset>
		<br>
		</div>
		<%--
		<div class="multiField">
			<label for="<portlet:namespace/>shippingMethodFree" class="blockLabel">
				<input name="<portlet:namespace/>shippingMethod" id="<portlet:namespace/>shippingMethodFree" value="true" <%=(shippingMethod.equals("")? "checked": "")%> type="radio"> 
				<liferay-ui:message key="shipping-method-free" />
			</label>

			<label for="<portlet:namespace/>shippingMethodFlat" class="blockLabel">
				<input name="<portlet:namespace/>shippingMethod" id="<portlet:namespace/>shippingMethodFlat" value="false" <%=(shippingMethod.equals("")? "checked": "")%> type="radio"> 
				<liferay-ui:message key="shipping-method-flat" />
			</label>
		</div>
		--%>
	</div>

	
</fieldset>

<div class="block-labels" style="text-align:right;">
	<div class="buttonHolder1">
		<%--<input type="reset" class="resetButton" value="<liferay-ui:message key="reset" />"/>--%>
		<input type="button" class="resetButton" value="<liferay-ui:message key="back" />" onClick="<portlet:namespace />goPrevious();"/>
		<input type="button" class="primaryAction" value="<liferay-ui:message key="next" />" onClick="<portlet:namespace />goNext();"/>
	</div>
 </div>   
    
</form>

<br /><br />

<script type="text/javascript">
	<portlet:namespace/>showShippingMethodDescription();
</script>