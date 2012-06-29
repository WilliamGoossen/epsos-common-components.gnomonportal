<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.math.BigDecimal" %>

<%
String productid = request.getParameter("productid");
%>

<liferay-ui:error key="ec.admin.product.instance.add.error" message="ec.admin.product.instance.add.error"/>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_COMBINATIONS %></tiles:put>
	<tiles:put name="productid"><%= productid %></tiles:put>
</tiles:insert>

<% List<ViewResult> featureNames = (List<ViewResult>)request.getAttribute("featureNames");
   List<int[]> possibleCombinations = (List<int[]>)request.getAttribute("possibleCombinations");
   List<String[]> possibleCombinationValues = (List<String[]>)request.getAttribute("possibleCombinationValues");
   List<BigDecimal> possiblePrices = (List<BigDecimal>)request.getAttribute("possiblePrices");
   PrProduct product = (PrProduct)request.getAttribute("product");

   if (possibleCombinations != null && possibleCombinations.size() > 0 
		&& featureNames != null && featureNames.size() > 0 
		&& possibleCombinationValues != null && possibleCombinationValues.size() > 0 
		&& possiblePrices != null && possiblePrices.size() > 0) {
	   int c = -1;
  %>
<h3><%= LanguageUtil.get(pageContext, "ec.admin.product.instance.list-remaining") %></h3>
<br>
<form name="EC_PRODUCT_ADMIN_ADD_REMAINING_COMBINATIONS_FORM" method="post"
      action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/addRemainingProductCombinations"/></portlet:actionURL>">
<input type="hidden" name="productid" value="<%= productid %>">        
<input type="hidden" name="combinationsCount" value="<%= ""+possibleCombinations.size() %>">
<display:table id="possComb" name="possibleCombinations" requestURI="//ext/products/admin/loadRemainingProductCombinations?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% 
   int[] gnItem = (int[]) pageContext.getAttribute("possComb"); 
   c ++;
 %>

<% for (int f=0; f<featureNames.size() ; f++) { %>
<display:column title="<%= featureNames.get(f).getField1().toString() %>" sortable="false">
	<input type="hidden" name="featureChoice_<%= ""+c %>" value="<%= gnItem[f] %>">
	<%= possibleCombinationValues.get(c)[f] %>
</display:column>
<% } %>

<display:column titleKey="ecommerce.product.productcode" sortable="false">
<input type="text" name="productcode_<%= ""+c %>" value="<%= product.getProductcode() %>" size="6">
</display:column>
<display:column titleKey="ec.admin.product.instance.erpcode" sortable="false">
<input type="text" name="erpcode_<%= ""+c %>" value="" size="6">
</display:column>
<display:column titleKey="ec.admin.product.instance.barcode" sortable="false">
<input type="text" name="barcode_<%= ""+c %>" value="" size="6">
</display:column>
<display:column titleKey="ecommerce.product.active" sortable="false">
<input type="checkbox" name="active_<%= ""+c%>" value="true" checked="true">
</display:column>
<display:column titleKey="ecommerce.product.inventory" sortable="false" >
<input type="text" name="inventory_<%= ""+c %>" value="0<%//= product.getInventory() %>" size="6">
</display:column>
<display:column titleKey="ecommerce.product.price" sortable="false">
<input type="text" name="price_<%= ""+c%>" size="6" value="<%= com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(possiblePrices.get(c).doubleValue()) %>">
<select name="price_choice<%= ""+c%>">
<option value="notax"><%= LanguageUtil.get(pageContext, "ecommerce.product.price.before-tax") %></option>
<option value="tax"><%= LanguageUtil.get(pageContext, "ecommerce.product.price.after-tax") %></option>
</select>
</display:column>
</display:table>	   
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.product.instance.add-remaining") %>">
</form>
<% } %>


