<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>

<%
//String orderId = ParamUtil.getString(request, "orderId");
/*
try {
	ShoppingCart cart = ShoppingUtil.getCart(renderRequest);

	ShoppingCartLocalServiceUtil.updateCart(cart.getUserId(), cart.getGroupId(), StringPool.BLANK, StringPool.BLANK, 0, false);
}
catch (Exception e) {
}
*/
%>

<span class="portlet-msg-success">
<liferay-ui:message key="thank-you-for-your-purchase" />
</span>

<br /><br />

<liferay-ui:message key="you-will-receive-an-email-shortly-with-your-order-summary-and-further-details" />