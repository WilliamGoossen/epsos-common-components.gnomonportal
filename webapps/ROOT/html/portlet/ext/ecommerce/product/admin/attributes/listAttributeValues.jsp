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
<liferay-ui:error key="ec.admin.feature.cannot-delete" message="ec.admin.feature.cannot-delete"/>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_ATTRIBUTES %></tiles:put>
	<tiles:put name="productid"><%= productid %></tiles:put>
</tiles:insert>


<form name="EC_PRODUCT_ADMIN_PRODUCTATTRIBUTES_EDITING_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/deleteProductAttributeValues"/></portlet:actionURL>" method="post">
<input type="hidden" name="productid" value="<%= productid %>">
<input type="hidden" name="prodfeatureid" value="<%= prodfeatureid %>">

<h3><%= LanguageUtil.get(pageContext, "ec.admin.feature.name") %> : <%= featureName %></h3>
<br>
<display:table id="prod_item" name="product_items" requestURI="//ext/products/admin/loadProductAttributeValues?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("prod_item"); %>

<display:column>
<% if (Validator.isNotNull(gnItem.getField3())) { %>
<input type="checkbox" name="valueid" value="<%= gnItem.getField3() %>">
<% }  %>
</display:column>
<display:column titleKey="ec.admin.product.attribute.value" sortable="false">
<% if (Validator.isNotNull(gnItem.getField3())) { %>
	<input type="text" name="specvalue_<%=gnItem.getField4() %>" value="<%= gnItem.getField2() %>">
<% } %>
</display:column>
<display:column titleKey="ec.admin.product.feature.impact" sortable="false">
<% if (Validator.isNotNull(gnItem.getField3())) { %>
	<input type="text" name="specvalue_impact_<%=gnItem.getField3() %>" value="<%= gnItem.getField5() %>">
<% } %>
</display:column>
<display:column titleKey="ec.admin.product.feature.impact.type" sortable="false">
<% if (Validator.isNotNull(gnItem.getField3())) { %>
<select name="specvalue_impact_type_<%= gnItem.getField3() %>">
	<option value="<%= ""+CommonDefs.PRODUCT_IMPACT_EXACT %>" <% if (gnItem.getField6().equals(CommonDefs.PRODUCT_IMPACT_EXACT)) { out.println("selected"); } %>><%= LanguageUtil.get(pageContext, "ec.admin.product.feature.impact.type.exact") %></option>
	<option value="<%= ""+CommonDefs.PRODUCT_IMPACT_PERCENT %>" <% if (gnItem.getField6().equals(CommonDefs.PRODUCT_IMPACT_PERCENT)) { out.println("selected"); } %>><%= LanguageUtil.get(pageContext, "ec.admin.product.feature.impact.type.percent") %></option>
</select>
<% } %>
</display:column>
</display:table>

<% if (hasEdit) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/products/admin/saveProductAttributeValues" />
  <tiles:put name="buttonName" value="saveButton" />
  <tiles:put name="buttonValue" value="gn.button.update" />
  <tiles:put name="formName"   value="EC_PRODUCT_ADMIN_PRODUCTATTRIBUTES_EDITING_FORM" />
  <tiles:put name="windowState" value="normal"/>
</tiles:insert>
&nbsp;
<select name="transLang">
<% String languages= PropsUtil.get(PropsUtil.LOCALES);
   String locales[] = StringUtil.split(languages, StringPool.COMMA); 
   for (String localeString: locales) { %>
   <option value="<%= localeString %>" <% if (GeneralUtils.getLocale(request).equals(localeString)) { out.print("selected"); } %>><%= localeString %></option>
   <% } %>
</select>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/products/admin/loadProductAttributeValueTranslations" />
  <tiles:put name="buttonName" value="translateButton" />
  <tiles:put name="buttonValue" value="ec.admin.product.feature.values.load-translations" />
  <tiles:put name="formName"   value="EC_PRODUCT_ADMIN_PRODUCTATTRIBUTES_EDITING_FORM" />
  <tiles:put name="windowState" value="normal"/>
</tiles:insert>
&nbsp;
<input type="submit" value="<%= LanguageUtil.get(pageContext, "gn.button.delete") %>">
<% } %>
</form>

<br><br><br>

<div id="addition_div_link">
<a href="#" onClick="Liferay.Util.toggle('addition_div', true); Liferay.Util.toggle('addition_div_link', true);">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "ec.admin.product.add-attribute-values") %>
</a>
</div>

<div id="addition_div" style="display:none">
<h3><%= LanguageUtil.get(pageContext, "ec.admin.product.add-attribute-values") %></h3>
<form name="EC_PRODUCT_ADMIN_PRODUCTATTRIBUTEVALUES_ADDITION_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/addProductAttributeValues"/></portlet:actionURL>" method="post">
<input type="hidden" name="productid" value="<%= productid %>">
<input type="hidden" name="prodfeatureid" value="<%= prodfeatureid %>">

<fieldset>
<table class="liferay-table" style="width: 100%; border-spacing: 0; padding:3pt;">
<th></th>
<th style="padding:3pt;"><%= LanguageUtil.get(pageContext, "ec.admin.product.attribute.value") %></th>
<th style="padding:3pt;"><%= LanguageUtil.get(pageContext, "ec.admin.product.feature.impact") %></th>
<th style="padding:3pt;"><%= LanguageUtil.get(pageContext, "ec.admin.product.feature.impact.type") %></th>
</tr>
<% for (int i=0; i<10; i++) { %>
<tr>
<td style="padding:3pt;">&nbsp;&nbsp;&nbsp;</td>
<td style="padding:3pt;">
<input type="text" name="specvalue_<%= ""+i %>" value="">
</td>
<td style="padding:3pt;">
<input type="text" name="specvalue_impact_<%= ""+i %>" value="">
</td>
<td style="padding:3pt;">
<select name="specvalue_impact_type_<%= ""+i %>">
<option value="<%= ""+CommonDefs.PRODUCT_IMPACT_EXACT %>"><%= LanguageUtil.get(pageContext, "ec.admin.product.feature.impact.type.exact") %></option>
<option value="<%= ""+CommonDefs.PRODUCT_IMPACT_PERCENT %>"><%= LanguageUtil.get(pageContext, "ec.admin.product.feature.impact.type.percent") %></option>
</select>
</td>
</tr>
<% } %>
</table>
</fieldset>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "gn.button.add") %>">
</form>
</div>



