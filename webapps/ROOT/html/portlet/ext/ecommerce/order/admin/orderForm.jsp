<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ include file="/html/portlet/ext/ecommerce/order/admin/currentURLcomplement.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>
<%@ page import="org.apache.struts.Globals" %>
<%@ page import="org.apache.struts.action.ActionErrors" %>


<%
String state = (String)request.getAttribute("state");
String orderid = (String)request.getAttribute("orderid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/orders/admin/updateOrder?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "ec.admin.order.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/orders/admin/deleteOrder?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "ec.admin.order.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/orders/admin/addOrder?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "ec.admin.order.add";
}

ActionErrors errors = (ActionErrors)request.getSession().getAttribute(Globals.ERROR_KEY);
if (errors != null && !errors.isEmpty())
{
	request.setAttribute(Globals.ERROR_KEY, errors);
	%> <html:errors property="ec.admin.order.state.confirm.inventory-error"/> <br><br> <%
}
%>

<tiles:insert page="/html/portlet/ext/ecommerce/order/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_ORDERS %></tiles:put>
</tiles:insert>

<h3><%= LanguageUtil.get(pageContext, titleText) %></h3>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="EcOrderForm"/>
</tiles:insert>

<%
List orderlines = (List)request.getAttribute("orderlines");
if (orderlines != null && orderlines.size() > 0) {
%>
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "ec.admin.order.orderlines-group") %></legend>

<display:table id="ols" name="orderlines" requestURI="//ext/orders/admin/loadOrder?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("ols"); %>

<% if(state.equals(CommonDefs.ORDER_STATE_NEEDS_APPROVAL)) { %>
<display:column>
<input title="<%= LanguageUtil.get(pageContext, "ec.admin.order.line.inorder") %>" 
        type="checkbox" name="inorder_orderline" 
        value="<%= gnItem.getMainid().toString() %>" <%= gnItem.getField11() != null && ((Boolean)gnItem.getField11()).booleanValue() ? "checked" : "" %>
        onClick="return confirm('<%= LanguageUtil.get(pageContext, "ec.admin.order.state.orlderline.reject-are-you-sure") %>');"
        >
</display:column>
<% } %>

<display:column titleKey="name" sortable="true">
<a title="<%=  gnItem.getField8() %>"
	href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/orders/admin/loadOrderLine"/>
		<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
		<portlet:param name="loadaction" value="view"/>
		<portlet:param name="redirect" value="<%= currentURL2 %>"/></portlet:actionURL>"
>
<%= gnItem.getField8() %>
</a>
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
<display:column titleKey="ec.admin.order.shippingAmount" sortable="true" property="field1" style="text-align:right; white-space: nowrap;"/>
<display:column titleKey="ec.admin.order.totalPrice" sortable="true" property="field2" style="text-align:right; white-space: nowrap;"/>
<%--
<display:column titleKey="ecommerce.product.prManufacturer" sortable="true" property="field6" />
<display:column titleKey="ecommerce.product.prSupplier" sortable="true" property="field7" />
--%>
<display:column titleKey="comments" sortable="true" >
<textarea name="comments_orderline_<%= gnItem.getMainid().toString() %>"><%= Validator.isNotNull(gnItem.getField9()) ? gnItem.getField9() : "" %></textarea>
</display:column>

</display:table>

</fieldset>
<% } %>

<div class="button-holder">
<% if (state == null || (!state.equals(CommonDefs.ORDER_STATE_CANCELLED) && 
		                 !state.equals(CommonDefs.ORDER_STATE_CLOSED) && 
		                 !state.equals(CommonDefs.ORDER_STATE_SENT_OK) )) { %>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>

<% } %>


<%
if (state != null && orderid != null) {
	request.setAttribute("line_orderid", orderid);
	request.setAttribute("line_state",  state);
%>
&nbsp;
<jsp:include page="/html/portlet/ext/ecommerce/order/admin/orderStateChangesTile.jsp"/>
<% } %>

</div>

</html:form>

<br><br>

<a href="<%if (Validator.isNull(redirect)) { 
			out.print("javascript:history.back();");
		  } else { 
			out.println(redirect); 
		   }%>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><%= LanguageUtil.get(pageContext, "back") %></a>









