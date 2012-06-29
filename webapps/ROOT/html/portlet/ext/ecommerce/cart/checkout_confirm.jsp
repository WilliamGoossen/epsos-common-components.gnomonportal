<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>

<liferay-ui:error exception="<%= CartEmptyException.class %>" message="your-shopping-cart-is-empty" />
<liferay-ui:error exception="<%= BillingInformationEmptyException.class %>" message="there-is-no-billing-information-available" />
<liferay-ui:error exception="<%= ShippingInformationEmptyException.class %>" message="there-is-no-shipping-information-available" />
<liferay-ui:error exception="<%= ShippingMethodEmptyException.class %>" message="there-is-no-shipping-method-selected" />
<liferay-ui:error exception="<%= PaymentMethodEmptyException.class %>" message="there-is-no-payment-method-selected" />
<liferay-ui:error exception="<%= InventoryQuantityException.class %>" message="inventory-problem" />
<liferay-ui:error exception="<%= PaymentMethodNotAvailableException.class %>" message="the-selected-payment-method-is-not-available" />


<c:if test="<%=!SessionErrors.isEmpty(request) %>">
    <span class="portlet-msg-error">
    <%
    Iterator itr2 = SessionErrors.iterator(request);
    while (itr2.hasNext()) {
        out.println(itr2.next());
        out.println("<br/>");
    }
    SessionErrors.clear(request);
    %>
    </span>
    <br /><br />
</c:if>


<liferay-util:include page="/html/portlet/ext/ecommerce/cart/cartSummary.jsp">
	<liferay-util:param name="openPanelIndex" value="0"/>
</liferay-util:include>

<script type="text/javascript">
	function <portlet:namespace />commit() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "confirm";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "update";
		submitForm(document.<portlet:namespace />fm);
	}
	function <portlet:namespace />goPrevious() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "<%=(EShopPropsUtil.isShowPrices(request)?"payment_info":"shipping_method")%>";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "";
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<%
	ShoppingCart cart = ShoppingCartUtil.getCart(request);
	
	CartItem[] cartItems = cart.getItems();
	request.setAttribute("cartItems", cartItems);
	
	String userComment = ParamUtil.getString(request, "userComment");
%>

<%
	BigDecimal subTotal = new BigDecimal(0);
	int i=0;
	BigDecimal discount = new BigDecimal(0);
	BigDecimal shippingCosts = new BigDecimal(0);
	BigDecimal total = new BigDecimal(0);
%>

<%
	/*
	for (CartItem item: cart.getItems()) {
		BigDecimal linePrice = item.getQuantity().multiply(item.getFinalprice());
		subTotal = subTotal.add(linePrice);
		i++;
	}
*/
%>

<portlet:actionURL var="continueOrderURL">
	<portlet:param name="struts_action" value="/ext/ecommerce/cart/checkout"/>
	<portlet:param name="page" value="billing_info"/>
	<portlet:param name="back" value="<%=currentURL %>"/>
</portlet:actionURL>

<liferay-portlet:actionURL portletName="<%=PortletKeys.MY_ACCOUNT%>" 
	windowState="<%=WindowState.MAXIMIZED.toString()%>" var="createAccountURL">
	<portlet:param name="struts_action" value="/my_account/create_account"/>
	<portlet:param name="redirect" value="<%=currentURL%>"/>
</liferay-portlet:actionURL>

<portlet:actionURL var="updateCartURL">
	<portlet:param name="struts_action" value="/ext/ecommerce/cart/view"/>
</portlet:actionURL>

<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="updateCartURL1">
	<portlet:param name="struts_action" value="/ext/ecommerce/cart/view" />
</portlet:actionURL>


<div class="cart-2">

	<c:choose>
	<c:when test="<%= cart.isEmpty()%>">
		
		<h3><%=LanguageUtil.get(pageContext, "your-shopping-cart-is-empty") %></h3>
		
		<a href="<%=Validator.isNotNull(redirect)? redirect: "/web/guest/home"%>"><%=LanguageUtil.get(pageContext, "continue-shopping") %></a>
	</c:when>
	<c:otherwise>
	
		<form name="<portlet:namespace />fm" method="post" action="<%=submitURL%>" class="uni-form">
		<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="" type="hidden" /> 
		<input name="<portlet:namespace/>page" id="<portlet:namespace/>page" value="" type="hidden" />
		<input name="<portlet:namespace/>referer" id="<portlet:namespace/>referer" value="<%=currentURL%>" type="hidden" />
		<c:if test="<%=themeDisplay.isSignedIn() && OrderService.getInstance().getEcPartyProfileForUserId(PortalUtil.getUserId(request))==null%>">
		  <input name="<portlet:namespace/>savePreferences" id="<portlet:namespace/>savePreferences" type="hidden" value="true">
		</c:if>
				
    	<fieldset class="block-labels" style="border:0;">
						
			<div class="ctrl-holder">
				<label for="<portlet:namespace/>userComment"> <liferay-ui:message key="comments" /></label>
				<textarea name="<portlet:namespace/>userComment" id="<portlet:namespace/>userComment" rows="6" cols="80"><%=userComment %></textarea>
			</div>
			
		</fieldset>
        
        <div class="buttonHolder1" style="text-align:right; margin-top:30px;">
				<%--<input type="reset" class="resetButton" value="<liferay-ui:message key="reset" />"/>--%>
				<input type="button" class="resetButton" value="<liferay-ui:message key="back" />" onClick="<portlet:namespace />goPrevious();"/>
				<%
					String commitKey = "confirm-order";
					if (EShopPropsUtil.isShowPrices(request) && !EShopPropsUtil.isOrdersRequireConfirm(request))
						commitKey = "confirm-order-and-pay";
				%>
				
				<input type="button" class="primaryAction" value="<liferay-ui:message key="<%=commitKey %>" />" onClick="<portlet:namespace />commit();"/>
			</div>
		
		</form>
	</c:otherwise>
	</c:choose>
</div>