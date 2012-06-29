<%@ include file="/html/portlet/ext/ecommerce/order/user/init.jsp" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
String formUrl = "/ext/orders/user/viewOrder?actionURL=true" ;
String titleText = "ec.admin.order.view";
EcOrder order = (EcOrder)request.getAttribute("order");
boolean showPrices = EShopPropsUtil.isShowPrices(request);
%>

<HR>
<BR>


<a href="<liferay-portlet:actionURL portletName="EC_ORDER_ADMIN" windowState="<%=LiferayWindowState.EXCLUSIVE.toString() %>" >
			<liferay-portlet:param name="struts_action" value="/ext/orders/admin/genericPdfAction"/>
			<liferay-portlet:param name="reportsPathPrefix" value="/com/ext/portlet/ecommerce/order/print/"/>
			<liferay-portlet:param name="reportName" value="<%="Order Document ("+order.getReferenceCode()+").pdf"%>"/>
			<liferay-portlet:param name="reportFileName" value="ec_order.jasper"/>
			<liferay-portlet:param name="param_orderId_Integer" value="<%=order.getMainid()+"" %>"/>
			<liferay-portlet:param name="param_showPrices_String" value="<%=""+showPrices %>"/>
			<liferay-portlet:param name="param_pathToReports_String" value="/com/ext/portlet/ecommerce/order/print/"/>
			
</liferay-portlet:actionURL>" target="_blank">
    <img src="<%= themeDisplay.getPathThemeImage() %>/document_library/pdf.gif" alt="<%= LanguageUtil.get(pageContext, "print.order") %>">
    <%= LanguageUtil.get(pageContext, "print.order") %><BR>		
</a>

<BR><BR>
<HR>

<liferay-ui:error exception="<%= PrincipalException.class %>" message="you-do-not-have-the-rights-to-perform-selected-action" />

<c:choose>
<c:when test="<%=order!=null %>">
	<%
		String stateCode = order.getEcOrderstate().getSystemCode();
		String paymentTypeId = order.getEcPaymenttype()!=null?order.getEcPaymenttype().getMainid()+"": "";
		String paymentTypeCode = order.getEcPaymenttype()!=null?order.getEcPaymenttype().getSystemCode(): "";
		List orderlines = (List)request.getAttribute("orderlines");
		//order can be cancelled if it is not paid yet (either no payment is registered, or no actual money have been deposited)
		boolean allowsCancelation = 
			stateCode.equals(CommonDefs.ORDER_STATE_NEEDS_APPROVAL)
            || stateCode.equals(CommonDefs.ORDER_STATE_WAITS_PAYMENT) 
            || stateCode.equals(CommonDefs.ORDER_STATE_WAITS_PAYMENT_CONFIRMATION)
            || (stateCode.equals(CommonDefs.ORDER_STATE_NEEDS_SHIPPING)
            	&& (paymentTypeCode.equals(CommonDefs.PAYMENT_TYPE_ON_CREDIT)
            		|| paymentTypeCode.equals(CommonDefs.PAYMENT_TYPE_COD)
            		|| paymentTypeCode.equals(CommonDefs.PAYMENT_TYPE_BANK_TRANSFER)
            		)
            	);
	%>
	
	<h2><%= LanguageUtil.get(pageContext, titleText) %></h2>
	
	<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">	
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
		<tiles:put name="formName" value="EcOrderForm"/>
	</tiles:insert>	
	<c:if test="<%=orderlines != null && orderlines.size() > 0 %>">
	<fieldset>
		<legend><%= LanguageUtil.get(pageContext, "ec.admin.order.orderlines-group") %></legend>
		
		<display:table id="ols" name="orderlines" requestURI="//ext/orders/user/viewOrder?actionURL=true"  sort="list" export="false" style="width: 100%;">
		<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("ols"); %>
		
		<display:column>
		<input title="<%= LanguageUtil.get(pageContext, "ec.admin.order.line.inorder") %>" 
		        type="checkbox" name="inorder_orderline" 
		        value="check" <%= gnItem.getField11() != null && ((Boolean)gnItem.getField11()).booleanValue() ? "checked" : "" %>
		        disabled>
		</display:column>
		
		<display:column titleKey="name" sortable="true">
		   <%= gnItem.getField8() %>
		</display:column>
		
		<display:column titleKey="ecommerce.product.productcode" sortable="true" property="field3"/>
		
		<display:column titleKey="ecommerce.product.imageFile" sortable="true">
			<% 
		    String imageFilePath = "/FILESYSTEM/" + PortalUtil.getCompanyId(request) + "/" + 
		    GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH) + 
		    gnItem.getField10() + "/";
		    
		    if (Validator.isNotNull(gnItem.getField4())) {
		        String thumnailPath = imageFilePath + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField4()); 
		        imageFilePath += (String)gnItem.getField4();
		    %>
		    <a href="<%= imageFilePath %>" class="thickbox"><img src="<%= thumnailPath %>" alt="<%= gnItem.getField4() %>"></a>
		    <%
		    } else if (Validator.isNotNull(gnItem.getField5())) {
		        String thumnailPath = imageFilePath + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField5()); 
		        imageFilePath += (String)gnItem.getField5();
		        %>
		    <a href="<%= imageFilePath %>" class="thickbox"><img src="<%= thumnailPath %>" alt="<%= gnItem.getField5() %>"></a>
		    <% } %>
		</display:column>					
		
		<display:column titleKey="ec.admin.order.shippingAmount" sortable="true" property="field1"/>
		<c:if test="<%=showPrices%>">
		<display:column titleKey="ec.admin.order.totalPrice" sortable="true" property="field2" style="text-align:right; white-space: nowrap;"/>
		</c:if>
		<display:column titleKey="comments" sortable="true" >
			<%= Validator.isNotNull(gnItem.getField9()) ? gnItem.getField9() : "" %>
		</display:column>
		
		</display:table>
		
	</fieldset>
	</c:if>
	</html:form>
	
	<c:if test = "<%=allowsCancelation %>">
		<portlet:actionURL var="cancelURL">
			<portlet:param name="struts_action" value="/ext/orders/user/cancelOrder"/>
		</portlet:actionURL>
		
		<br>
		<form class="uni-form" action="<%=cancelURL %>" method="post" name="<portlet:namespace />fm">
		<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="cancel" type="hidden" />
		<input name="<portlet:namespace/>redirect" value="<%=currentURL %>" type="hidden" />
		<c:choose>
		<c:when test="<%=themeDisplay.isSignedIn() %>">
			<input name="<portlet:namespace/>orderid" id="<portlet:namespace/>orderid" value="<%=order.getMainid().toString() %>" type="hidden" />
		</c:when>
		<c:otherwise>
			<input name="<portlet:namespace/>referenceCode" id="<portlet:namespace/>referenceCode" value="<%= order.getReferenceCode() %>" type="hidden" />
			<input name="<portlet:namespace/>confirmationCode" id="<portlet:namespace/>confirmationCode" value="<%= order.getConfirmationCode() %>" type="hidden" />
		</c:otherwise>
		</c:choose>
			
		<br />
		<div class="button-Holder">
			<input type="submit" class="primaryAction" 
			   value="<liferay-ui:message key="ec.admin.order.state.cancel" />"
			   onClick="return confirm('<%= LanguageUtil.get(pageContext, "ec.admin.order.state.cancel-are-you-sure") %>');"/>
			
			<c:if test="<%= (Validator.isNotNull(paymentTypeId) && stateCode.equals(CommonDefs.ORDER_STATE_WAITS_PAYMENT)) %>">
				<portlet:actionURL var="payOrderURL">
				    <portlet:param name="struts_action" value="/ext/orders/user/payOrder"/>
				    <portlet:param name="cmd" value="pay"/>
				    <portlet:param name="orderid" value="<%=order.getMainid()+"" %>"/>
				    <portlet:param name="paymentTypeId" value="<%=paymentTypeId %>"/>
				    <portlet:param name="redirect" value="<%=currentURL %>"/>
				</portlet:actionURL>
       
			    <input type="button" class="secondaryAction" 
                       value="<liferay-ui:message key="pay-order" />"
                       onClick="javascript: document.location='<%=payOrderURL%>';"/>
            </c:if>
		</div>
		</form>			
	</c:if>
	
	<br />
	<br />
	
	<fieldset>
	    <legend><%= LanguageUtil.get(pageContext, "ec.admin.order.history.list") %></legend>
		<display:table id="item" name="historyItems" requestURI="//ext/orders/admin/viewOrderHistory?actionURL=true"  sort="list" export="false" style="width: 100%;">
			<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
			
			<display:column titleKey="ec.admin.order.history.date" sortable="true" property="field1" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
			<display:column titleKey="ec.admin.order.history.party" sortable="true" property="field2" />
			<display:column titleKey="ec.admin.order.history.state" sortable="true" property="field3" />
		</display:table>
	</fieldset>
	
	</c:when>
<c:otherwise>

</c:otherwise>
</c:choose>

<br>
<c:choose>
<c:when test="<%=Validator.isNotNull(redirect) %>">
	<a href="<%=redirect%>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><%= LanguageUtil.get(pageContext, "back") %></a>
</c:when>
<c:otherwise>
	<a href="<portlet:renderURL>
		<portlet:param name="struts_action" value ="/ext/orders/user/view"/>
		</portlet:renderURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" align="absmiddle"><%= LanguageUtil.get(pageContext, "back") %></a>
</c:otherwise>
</c:choose>

<br /><br />