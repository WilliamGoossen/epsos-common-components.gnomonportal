<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ include file="/html/portlet/ext/ecommerce/order/admin/currentURLcomplement.jsp" %>

<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.ecommerce.EShopPropsUtil"%>

<%
String orderid = (String)request.getAttribute("line_orderid");
String state = (String)request.getAttribute("line_state");

if (state != null) {
	List<String[]> possibleStates = new ArrayList<String[]>();
	if (state.equals(CommonDefs.ORDER_STATE_NEEDS_APPROVAL)) {
		if (EShopPropsUtil.isShowPrices(request)) {
			String[] acceptEntry = new String[] {CommonDefs.ORDER_STATE_WAITS_PAYMENT, "/ecommerce/approve.gif", "ec.admin.order.state.confirm"};
			possibleStates.add(acceptEntry);
		}
		else {
			String[] acceptEntry = new String[] {CommonDefs.ORDER_STATE_WAITS_PAYMENT_CONFIRMATION, "/ecommerce/approve.gif", "ec.admin.order.state.confirm"};
			possibleStates.add(acceptEntry);
		}
		
		String[] rejectEntry = new String[] {CommonDefs.ORDER_STATE_REJECTED, "/ecommerce/reject.gif", "ec.admin.order.state.reject"};
		possibleStates.add(rejectEntry);
	}
	
	if (state.equals(CommonDefs.ORDER_STATE_WAITS_PAYMENT)) {
		String[] nextEntry = new String[] {CommonDefs.ORDER_STATE_NEEDS_SHIPPING, "/ecommerce/approve.gif", "ec.admin.order.state.confirm-payment"};
		possibleStates.add(nextEntry);
	}
	
	if (state.equals(CommonDefs.ORDER_STATE_WAITS_PAYMENT_CONFIRMATION)) {
		String[] nextEntry = new String[] {CommonDefs.ORDER_STATE_NEEDS_SHIPPING, "/ecommerce/approve.gif", "ec.admin.order.state.confirm-payment"};
		possibleStates.add(nextEntry);
	}
	
	if (state.equals(CommonDefs.ORDER_STATE_NEEDS_SHIPPING)) {
		String[] nextEntry = new String[] {CommonDefs.ORDER_STATE_SENT_OK, "/ecommerce/approve.gif", "ec.admin.order.state.ship"};
		possibleStates.add(nextEntry);
	}
	
	if (state.equals(CommonDefs.ORDER_STATE_SENT_OK)) {
		String[] nextEntry = new String[] {CommonDefs.ORDER_STATE_CLOSED, "/ecommerce/approve.gif", "ec.admin.order.state.close"};
		possibleStates.add(nextEntry);
	}
	
	if (!state.equals(CommonDefs.ORDER_STATE_SENT_OK) && 
		!state.equals(CommonDefs.ORDER_STATE_CLOSED) &&
		!state.equals(CommonDefs.ORDER_STATE_CANCELLED))
	{
		String[] cancelEntry = new String[] {CommonDefs.ORDER_STATE_CANCELLED, "/ecommerce/cancel.gif", "ec.admin.order.state.cancel"};
		possibleStates.add(cancelEntry);
	}
	
	if (possibleStates.size() > 0) {
		for (String[] entry: possibleStates) {
%>

<a title="<%= LanguageUtil.get(pageContext, entry[2]) %>" 
   href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/orders/admin/changeOrderState"/>
   <portlet:param name="orderid" value="<%= orderid %>"/>
   <portlet:param name="stateCode" value="<%= entry[0] %>"/>
   <portlet:param name="redirect" value="<%= currentURL2 %>"/>
   </portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, entry[2]+"-are-you-sure") %>');">
   <img src="<%= themeDisplay.getPathThemeImage() + entry[1] %>" alt="<%= LanguageUtil.get(pageContext, entry[2]) %>">
</a>&nbsp;

<% 
		} // end for 
	} // end if states > 0
} // end if state != null
%>