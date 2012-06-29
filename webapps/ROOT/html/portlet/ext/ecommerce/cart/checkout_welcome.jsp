<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>

<%
	ShoppingCart cart = ShoppingCartUtil.getCart(request);
	//ShoppingCart cart = (ShoppingCart)request.getAttribute("shoppingCart");
	CartItem[] cartItems = cart.getItems();
	request.setAttribute("cartItems", cartItems);
	//List cartItemsList = ListUtil.fromArray(cartItems);
	//CartItemArray cartItems = CartUtil.getItems(request);
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
<%--


PortletURL createAccountURL1 = new PortletURLImpl(
				request, PortletKeys.MY_ACCOUNT, plid, true);

			createAccountURL1.setPortletMode(PortletMode.VIEW);

			createAccountURL1.setParameter(
				"struts_action", "/my_account/create_account");


--%>

<script type="text/javascript">
    function <portlet:namespace />updateCart() {
        document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "update";
        submitForm(document.<portlet:namespace />fm);
    }
    function <portlet:namespace />clearCart() {
    	if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-empty-your-shopping-cart") %>')) {
    	    document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "clear";
    	    submitForm(document.<portlet:namespace />fm);
    	}
    }
</script>

<div class="cart-2">
	<c:choose>
	<c:when test="<%= cart.isEmpty()%>">

		<h3>
		<%=LanguageUtil.get(pageContext, "your-shopping-cart-is-empty") %>
        </h3>
		
        <c:if test="<%=Validator.isNotNull(redirect) || Validator.isNotNull(GnPropsUtil.get(PortalUtil.getCompanyId(request),"mainStorePage")) %>">
			<div class="continueshopping-button">
            <a href="<%=Validator.isNull(redirect)? GnPropsUtil.get(PortalUtil.getCompanyId(request),"mainStorePage"): redirect%>"><%=LanguageUtil.get(pageContext, "continue-shopping") %></a>
            </div>
		</c:if>
        
	</c:when>
	<c:otherwise>
	
		<liferay-ui:error exception="<%= InventoryQuantityException.class %>" message="inventory-problem" />
		
		<c:choose>
		<c:when test="<%= cart.getItems().length==1%>">
			<h3><%= LanguageUtil.get(pageContext, "there-is-1-product-in-your-shopping-cart")%><h3>
		</c:when>
		<c:otherwise>
			<h3><%= LanguageUtil.format(pageContext, "there-are-x-products-in-your-shopping-cart", cart.getItems().length) %></h3>
		</c:otherwise>
		</c:choose>
		
		<%
			BigDecimal subTotal = new BigDecimal(0);
			int i=0;
		%>
		
		<form name="<portlet:namespace />fm" method="post" action="<%=updateCartURL%>" class="uni-form">
		<input type="hidden" name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value=""/>
		<input type="hidden" name="<portlet:namespace/>redirect" id="<portlet:namespace/>redirect" value="<%=currentURL %>"/>
		
		<c:if test="<%=cartItems!=null && cartItems.length>0 %>">
		<display:table id="cartItem" name="cartItems" export="false" style="width: 100%;">
			<% 
				CartItem item = (CartItem) pageContext.getAttribute("cartItem");
				BigDecimal linePrice = item.getQuantity().multiply(item.getFinalprice());
				subTotal = subTotal.add(linePrice);
				i++;
			%>
			
			<portlet:actionURL var="deleteItemURL">
				<portlet:param name="struts_action" value="/ext/ecommerce/cart/view"/>
				<portlet:param name="piId" value="<%=item.getProductInstanceId()+"" %>"/>
				<portlet:param name="cmd" value="delete"/>
			</portlet:actionURL>

			<display:column sortable="false" style="width:1%">
				<a href="<%=deleteItemURL%>"><img src="<%=themeDisplay.getPathThemeImages()%>/ecommerce/remove.gif" title="<%=LanguageUtil.get(pageContext, "remove-item") %>" style="vertical-align:middle;" /></a>
			</display:column>
			
			<%--
			<display:column sortable="false" style="width:1%">
				<%=i%>
			</display:column>
			--%>
			
			<display:column titleKey="product" sortable="false" >
				<%=item.getTitle()%>
			</display:column>

			<display:column titleKey="quantity" sortable="false" >
				<input name="<portlet:namespace/>quantity_for_<%=item.getProductInstanceId()%>" size="4" value="<%=item.getQuantity()%>" type="text" class="textInput"/>
			</display:column>
			
			<%--
			<display:column titleKey="item-price" sortable="false" >
				<%=item.getFinalprice()%>
			</display:column>
			--%>

			<c:if test="<%=EShopPropsUtil.isShowPrices(request) %>">
			<% 
				 Long companyId = com.liferay.portal.util.PortalUtil.getCompanyId(request);
				 if (com.ext.portlet.ecommerce.pricing.EcommercePriceUpdaterUtil.useCatalogs(companyId) &&
						 com.ext.portlet.ecommerce.pricing.EcommercePriceUpdaterUtil.getEcommercePriceUpdater(companyId).userCustomerSpecificDiscount()) 
				 {
					%>
					<display:column titleKey="ec.admin.order.line.unitprice" sortable="false" style="text-align:right;">
						&euro;<%=item.getPriceBeforeDiscount()%>
					</display:column>
					<display:column titleKey="discount" sortable="false" style="text-align:right;">
						<%=item.getDiscount()%>%
					</display:column>
					<%	 
				 }
				 
				 %> 
				<display:column titleKey="price" sortable="false" style="text-align:right;">
					&euro; <%=ProductBrowserService.d2s(linePrice.doubleValue())%>
				</display:column>
			</c:if>						
		</display:table>
		</c:if>

		<c:if test="<%=EShopPropsUtil.isShowPrices(request) %>">
			<div class="cart-total" style="text-align:right;">
				<%= LanguageUtil.get(pageContext, "subtotal")%>: &euro; <%=ProductBrowserService.d2s(subTotal.doubleValue()) %>
			</div>
		</c:if>
		
		<div class="update-cart-button" style="text-align:right;">
            <input type="button" value="<liferay-ui:message key="update-shopping-cart" />" onClick="<portlet:namespace />updateCart();" />
		</div>
        <div class="empty-cart-button" style="text-align:right;">
            <input type="button" value="<liferay-ui:message key="empty-shopping-cart" />" onClick="<portlet:namespace />clearCart();" />
		</div>
		</form>
		
		
		<br />
		
		<c:if test="<%=Validator.isNotNull(redirect) || Validator.isNotNull(GnPropsUtil.get(PortalUtil.getCompanyId(request),"mainStorePage")) %>">
			<div class="continueshopping-button">
            <a href="<%=Validator.isNull(redirect)? GnPropsUtil.get(PortalUtil.getCompanyId(request),"mainStorePage"): redirect%>"><%=LanguageUtil.get(pageContext, "continue-shopping") %></a>
            </div>
		</c:if>
				
		<c:choose>
		<c:when test="<%= themeDisplay.isSignedIn() %>">
			<div class="checkout-is-signed-in">
				<%--
				<%
				String signedInAs = user.getFullName();
		
				if (themeDisplay.isShowMyAccountIcon()) {
					signedInAs = "<a href=\"" + themeDisplay.getURLMyAccount().toString() + "\">" + signedInAs + "</a>";
				}
				%>
		
				<%= LanguageUtil.format(pageContext, "you-are-signed-in-as-x", signedInAs) %>
				--%>
				
                <div class="checkout-button">
				<a href="<%=continueOrderURL%>"><%=LanguageUtil.get(pageContext, "continue-checkout") %></a>
                </div>
				<%--<input type="button" value="<liferay-ui:message key="continue-checkout" />" onClick="submitForm(document.<portlet:namespace />fm2);" />--%>
			</div>
		</c:when>
		<c:otherwise>
			<div class="checkout-log-in">
				<%--<a href="<%=themeDisplay.getURLSignIn()%>?redirect=<%=checkoutURL%>"><%=LanguageUtil.get(pageContext, "sign-in") %></a>--%>
				
				<liferay-util:include page="/html/portlet/ext/ecommerce/cart/loginForm.jsp"/>
				
			</div>
			
			<div class="checkout-create-account">
                <a href="<%=createAccountURL%>"><%=LanguageUtil.get(pageContext, "create-account") %></a>
			</div>
			
			
			<c:if test="<%=EShopPropsUtil.isAllowGuestCheckout(request)%>">
				<div class="checkout-continue-guest">
                    <a href="<%=continueOrderURL%>"><%=LanguageUtil.get(pageContext, "just-place-the-order-without-account") %></a>
					<%--
					<input type="button" value="<liferay-ui:message key="just-place-the-order-without-account" />" onClick="submitForm(document.<portlet:namespace />fm2);" />
					--%>
				</div>
			</c:if>
		</c:otherwise>
		</c:choose>
		
		</form>
		
	</c:otherwise>
	</c:choose>
</div>