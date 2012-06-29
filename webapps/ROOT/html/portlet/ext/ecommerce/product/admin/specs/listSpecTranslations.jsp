<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%
String productid = request.getParameter("productid");
List product_items = (List)request.getAttribute("product_items");
%>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_SPECS %></tiles:put>
	<tiles:put name="productid"><%= productid %></tiles:put>
</tiles:insert>

<% String transLang = request.getParameter("transLang"); %>

<form name="EC_PRODUCT_ADMIN_PRODUCTSPECS_EDITING_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/saveProductSpecs"/></portlet:actionURL>" method="post">
<input type="hidden" name="productid" value="<%= productid %>">
<input type="hidden" name="transLang" value="<%= transLang %>">
<display:table id="prod_item" name="product_items" requestURI="//ext/products/admin/listProductSpecsTranslations?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("prod_item"); %>
<display:column property="field1" titleKey="name" sortable="false"/>
<display:column titleKey="ec.admin.product.spec.value" sortable="false">
<img src="<%= themeDisplay.getPathThemeImage() %>/language/<%= transLang %>.png" alt="<%= transLang %>">
<% if (gnItem.getField2() != null && gnItem.getField4() != null) {%>
	<input type="hidden" name="specvalue_mainid" value="<%= gnItem.getField4().toString() %>">
	<input type="text" size="30" name="specvalue_mainid_<%= gnItem.getField4().toString() %>" value="<%= gnItem.getField2() != null ? gnItem.getField2() : "" %>">
<% } %>
</display:column>
</display:table>
<% if (hasEdit) { %>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.product.feature.values.edit-translations") %>">
<% } %>
</form>


