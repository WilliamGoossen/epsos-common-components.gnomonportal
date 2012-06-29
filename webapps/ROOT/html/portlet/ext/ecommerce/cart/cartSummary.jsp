<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>
<%
	ShoppingCart cart = ShoppingCartUtil.getCart(request);
	
	CartItem[] cartItems = cart.getItems();
	request.setAttribute("cartItems", cartItems);

	BigDecimal subTotal = new BigDecimal(0);
	int i=0;
	BigDecimal discount = new BigDecimal(0);
	BigDecimal shippingCosts = new BigDecimal(0);
	BigDecimal total = new BigDecimal(0);
	BigDecimal paymentCosts = new BigDecimal(0);
	
	Integer openPanelIndex = ParamUtil.getInteger(request, "openPanelIndex", 0);
%>


<c:choose>
    <c:when test="<%=cartItems!=null && cartItems.length>0%>">
<script src="<%=themeDisplay.getPathJavaScript() %>/SpryAssets/SpryAccordion.js" type="text/javascript"></script>
<link href="<%=themeDisplay.getPathThemeRoot() %>/css/SpryAccordion.css" rel="stylesheet" type="text/css" />

<div id="<portlet:namespace/>cartSummary" class="Accordion" tabindex="0">
	<div class="AccordionPanel">
		<div class="AccordionPanelTab"><%=LanguageUtil.get(pageContext, "shopping-cart-summary") %></div>
		<div class="AccordionPanelContent">



			<c:choose>
			<c:when test="<%=cartItems.length==1%>">
				<%= LanguageUtil.get(pageContext, "there-is-1-product-in-your-shopping-cart")%>
			</c:when>
			<c:otherwise>
				<%= LanguageUtil.format(pageContext, "there-are-x-products-in-your-shopping-cart", cart.getItems().length) %>
			</c:otherwise>
			</c:choose>
			
			<c:if test="<%=cartItems!=null && cartItems.length>0 %>">
			<display:table id="cartItem" name="cartItems" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
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
					<%=i%>
				</display:column>
				
				<display:column titleKey="product" sortable="false" >
					<%=item.getTitle()%>
				</display:column>
			
				<display:column titleKey="quantity" sortable="false" >
					<%=item.getQuantity()%>
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
						&euro;<%=ProductBrowserService.d2s(linePrice.doubleValue())%>
					</display:column>
				</c:if>
							
			</display:table>
			</c:if>
			
			<%
				//shipping costs are calculated on the subtotal amount (products value + taxes) without any discounts
				ShippingMethod shippingMethod = CheckoutUtil.getShippingMethod(request);
				if (shippingMethod!=null) {
					EcShipping shippingObj = (EcShipping)GnPersistenceService.getInstance(null).getObject(EcShipping.class, shippingMethod.getMethodId());
					if (shippingObj.getImpactType().equals(CommonDefs.PRODUCT_IMPACT_EXACT)) {
						shippingCosts = shippingObj.getPriceImpact();
					} else {
						shippingCosts = subTotal.multiply(shippingObj.getPriceImpact().divide(new BigDecimal(100)));
					}
				}
				
				//total represents the total cost of the shipped order (products value + taxes + shipping)
				total = total.add(subTotal);
				total = total.subtract(discount);
				total = total.add(shippingCosts);
				
                //payment costs are calculated on the total cost of the shipped order
				PaymentMethod paymentMethod = CheckoutUtil.getPaymentMethod(request);
                if (paymentMethod!=null) {
                	paymentCosts = CheckoutUtil.calculatePaymentCosts(total, paymentMethod.getMethodId());
                }
				
			%>
			
			<c:if test="<%=EShopPropsUtil.isShowPrices(request) %>">
				<div style="text-align:right;">
					<%= LanguageUtil.get(pageContext, "subtotal")%>: <strong>&euro; <%=ProductBrowserService.d2s(subTotal.doubleValue()) %></strong> 
				</div>
				<%--
				<div style="text-align:right;">
					<%= LanguageUtil.get(pageContext, "discount")%>: <strong>&euro; <%=discount %></strong> 
				</div>
				--%>
				<c:if test="<%=shippingMethod!=null %>">
				<div class="ctrl-holder" style="text-align:right;">
					<%= LanguageUtil.get(pageContext, "shipping")%>: <strong>&euro; <%=ProductBrowserService.d2s(shippingCosts.doubleValue()) %></strong> 
				</div>
				</c:if>
			
				<div class="ctrl-holder draw-border-top" style="text-align:right;">
					<%= LanguageUtil.get(pageContext, "total")%>: <strong>&euro; <%=ProductBrowserService.d2s(total.doubleValue()) %></strong> 
				</div>
				
                <c:if test="<%=paymentMethod!=null %>">
				<div class="ctrl-holder" style="text-align:right;">
                    <%= LanguageUtil.get(pageContext, "payment-costs")%>: <strong>&euro; <%=ProductBrowserService.d2s(paymentCosts.doubleValue()) %></strong> 
                </div>
                
                <div class="ctrl-holder draw-border-top" style="text-align:right;">
                    <%= LanguageUtil.get(pageContext, "final-amount-to-pay")%>: <strong>&euro; <%=ProductBrowserService.d2s(total.add(paymentCosts).doubleValue()) %></strong> 
				</div>
			</c:if>
			</c:if>


		</div>
	</div>
</div>

<script type="text/javascript">
<!--
var Accordion1 = new Spry.Widget.Accordion("<portlet:namespace/>cartSummary", { useFixedPanelHeights: false, defaultPanel: <%=openPanelIndex%>  });
//-->
</script>

</c:when>
</c:choose>