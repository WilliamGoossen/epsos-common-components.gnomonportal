<%@ include file="/html/portlet/ext/paycenter/pay/init.jsp" %>

<c:if test="<%=paymentCart!=null && !paymentCart.isEmpty() %>">
	<div class="ctrlHolder">
		<p><liferay-ui:message key="total" />: <%=totalAmount%></p>
		<br/>
		<table border="0">
		<tr>
			<th><liferay-ui:message key="item" /></th>
			<th><liferay-ui:message key="id" /></th>
			<th><liferay-ui:message key="subtotal" /></th>
		</tr>
		<% for (PaymentItem item: paymentCart.getItems()) { %>
		<tr>
			<td><%= item.getClassName()%></td>
			<td><%= item.getMainId() %></td>
			<td><%= item.getAmount().toPlainString() %></td>
		</tr>
		<% } %>
		</table>
	</div>
</c:if>