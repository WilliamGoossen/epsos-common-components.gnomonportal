<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.PrFeatureset" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%
String productid = request.getParameter("productid");
String prodfeatureid = request.getParameter("prodfeatureid");
List product_items = (List)request.getAttribute("product_items");
String featureName = "";
if (product_items != null && product_items.size()>0)
	featureName = ((ViewResult)product_items.get(0)).getField1().toString();
%>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_ATTRIBUTES %></tiles:put>
	<tiles:put name="productid"><%= productid %></tiles:put>
</tiles:insert>

<% String transLang = request.getParameter("transLang"); %>

<form name="EC_PRODUCT_ADMIN_PRODUCTATTRIBUTES_EDITING_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/saveProductAttributeValues"/></portlet:actionURL>" method="post">
<input type="hidden" name="productid" value="<%= productid %>">
<input type="hidden" name="prodfeatureid" value="<%= prodfeatureid %>">
<input type="hidden" name="transLang" value="<%= transLang %>">

<h3><%= LanguageUtil.get(pageContext, "ec.admin.feature.name") %> : <%= featureName %></h3>
<br>
<display:table id="prod_item" name="product_items" requestURI="//ext/products/admin/loadProductAttributeValueTranslations?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("prod_item"); %>

<display:column titleKey="ec.admin.product.attribute.value" sortable="false">
<% if (Validator.isNotNull(gnItem.getField3())) { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/language/<%= transLang %>.png" alt="<%= transLang %>">
	<input type="text" name="specvalue_<%=gnItem.getField4() %>" value="<%= gnItem.getField2() %>">
<% } %>
</display:column>

</display:table>

<% if (hasEdit) { %>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.product.feature.values.edit-translations") %>">
<% } %>
</form>




