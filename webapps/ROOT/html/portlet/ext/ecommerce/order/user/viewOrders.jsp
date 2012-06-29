<%@ include file="/html/portlet/ext/ecommerce/order/user/init.jsp" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
List<EcOrder> items = (List<EcOrder>)request.getAttribute("items");
boolean showPrices = EShopPropsUtil.isShowPrices(request);
%>

<c:choose>
<c:when test="<%=items!=null && items.size()>0 %>">
	<h3><%= LanguageUtil.get(pageContext, "my-orders") %></h3>
	<br>
	
	<display:table id="item" name="items" requestURI="//ext/orders/admin/view?actionURL=true" pagesize="25" sort="list" export="true" style="font-weight: normal; width: 100%; border-spacing: 0">
		<% 
		EcOrder gnItem = (EcOrder) pageContext.getAttribute("item");
		EcOrderstate ecOrderState = gnItem.getEcOrderstate();
		String[] fields = new String[] {"langs.name, langs.description", "table1.systemCode"};
		ViewResult state = GnPersistenceService.getInstance(null).getObjectWithLanguage(EcOrderstate.class, ecOrderState.getMainid(), gnomon.business.GeneralUtils.getLocale(request), fields);
		String paymentTypeId = gnItem.getEcPaymenttype()!=null?gnItem.getEcPaymenttype().getMainid()+"": "";
		%>
		<display:setProperty name="export.csv" value="false" />
		<display:setProperty name="export.xml" value="false" />
		<display:setProperty name="export.pdf" value="true" />
		<display:setProperty name="export.excel.filename" value="myOrders.xls" />
		<display:setProperty name="export.pdf.filename" value="myOrders.pdf" />
		
		<portlet:actionURL var="viewOrderURL">
			<portlet:param name="struts_action" value="/ext/orders/user/viewOrder"/>
			<portlet:param name="orderid" value="<%=gnItem.getMainid()+"" %>"/>
		</portlet:actionURL>
		
		<portlet:actionURL var="reOrderURL">
			<portlet:param name="struts_action" value="/ext/orders/user/repeatOrder"/>
			<portlet:param name="orderid" value="<%=gnItem.getMainid()+"" %>"/>
		</portlet:actionURL>
		
		<portlet:renderURL var="payOrderURL">
			<portlet:param name="struts_action" value="/ext/orders/user/payOrder"/>
			<portlet:param name="orderid" value="<%=gnItem.getMainid()+"" %>"/>
			<%--<portlet:param name="paymentTypeId" value="<%=paymentTypeId %>"/>--%>
			<portlet:param name="redirect" value="<%=currentURL %>"/>
		</portlet:renderURL>
		
		<display:column titleKey="ec.admin.order.referenceCode" sortable="true" media="html">
			<a href="<%=viewOrderURL %>"><%=gnItem.getReferenceCode() %></a>
		</display:column>
		<display:column titleKey="ec.admin.order.referenceCode" sortable="true" media="excel pdf">
            <%=gnItem.getReferenceCode() %>
		</display:column>
		<display:column titleKey="ec.admin.order.dateCreated" sortable="true" property="datecreated" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
		<%--
		<display:column titleKey="ec.admin.order.deliveryDate" sortable="true" property="deliverydate" decorator="org.displaytag.sample.LongDateWrapper"/>
		<display:column titleKey="ec.admin.order.email" sortable="true" property="email"/> 
		--%>
		<c:if test="<%=showPrices%>">
		<display:column titleKey="ec.admin.order.totalPrice" sortable="true" media="html pdf" style="text-align:right; white-space: nowrap;">
			<%= gnItem.getTotalprice() != null? "\u20ac "+ProductBrowserService.d2s(gnItem.getTotalprice().doubleValue()) : "" %>
		</display:column>
		<display:column titleKey="ec.admin.order.totalPrice" sortable="true" media="excel">
			<%= gnItem.getTotalprice() != null? ProductBrowserService.d2s(gnItem.getTotalprice().doubleValue()) : "" %>
		</display:column>
		</c:if>
		<%--
		<display:column titleKey="total-discount" sortable="true">
			<%= gnItem.getTotaldiscount() != null? gnItem.getTotaldiscount().setScale(2, BigDecimal.ROUND_HALF_UP).toString() : "" %>
		</display:column>
		--%>
		<display:column titleKey="status" sortable="true" >
			<%= ViewResultUtil.getString(state, "field1")%>
		</display:column>
		
		<display:column sortable="false" media="html">
			<a href="#" onClick="<portlet:namespace />repeatOrder(<%=gnItem.getMainid()+"" %>)"><%=LanguageUtil.get(pageContext, "repeat-order") %></a>
		</display:column>
			
		<display:column sortable="false" media="html">
            <c:if test="<%= (ViewResultUtil.getString(state, "field3", "").equals(CommonDefs.ORDER_STATE_WAITS_PAYMENT)) %>">
			     <a href="<%=payOrderURL %>"><%=LanguageUtil.get(pageContext, "pay-order") %></a>
			</c:if>
		</display:column>
		
	</display:table>
	
	<script type="text/javascript">
	function <portlet:namespace />repeatOrder(orderid) {
		if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "repeating-the-selected-order-will-replace-your-current-shopping-cart-are-you-sure-you-want-to-continue") %>')) {
			document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "repeat";
			document.<portlet:namespace />fm.<portlet:namespace />repeatOrderId.value = orderid;
			submitForm(document.<portlet:namespace />fm);
		}
	}
	</script>
	
	<portlet:actionURL var="repeatOrderURL">
		<portlet:param name="struts_action" value="/ext/orders/user/repeatOrder"/>
	</portlet:actionURL>
	
	<form action="<%= repeatOrderURL %>" method="post" name="<portlet:namespace />fm" onSubmit="submitForm(this); return false;">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="" />
	<input name="<portlet:namespace />repeatOrderId" type="hidden" value="" />
	<input name="<portlet:namespace />redirect" type="hidden" value="<%=currentURL %>" />
	
	</form>
	
</c:when>
<c:otherwise>
	<%=LanguageUtil.get(pageContext, "you-do-not-have-any-orders-registered-in-your-account") %>
</c:otherwise>
</c:choose>