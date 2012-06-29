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

<%
if (product_items == null || product_items.size() == 0) {
	List<PrFeatureset> featuresetList = (List<PrFeatureset>)request.getAttribute("featuresetList");
%>

<form name="EC_PRODUCT_ADMIN_CHOOSE_FEATURESET_FORM" method="post" class="uni-form"
      action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/addProductSpecsFromSet"/></portlet:actionURL>">
 <input type="hidden" name="productid" value="<%= productid %>">
<div class="inline-labels">
<div class="ctrl-holder">
<label for="featuresetid"><%= LanguageUtil.get(pageContext, "ec.admin.product.choose-featureset") %></label>
<select name="featuresetid">
<% for (PrFeatureset fset: featuresetList) { %>
<option value="<%= fset.getMainid().toString() %>"><%= fset.getName() %></option>
<% } %>
</select>
</div>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.product.add-spec") %>">      
</div>
</form>

<%	
} else {
%>
<form name="EC_PRODUCT_ADMIN_PRODUCTSPECS_EDITING_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/deleteProductSpecs"/></portlet:actionURL>" method="post">
<input type="hidden" name="productid" value="<%= productid %>">
<display:table id="prod_item" name="product_items" requestURI="//ext/products/admin/listProductSpecs?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("prod_item"); %>
<display:column>
	<input type="checkbox" name="prodfeatureid" value="<%= gnItem.getMainid().toString() %>">
</display:column>
<display:column property="field1" titleKey="name" sortable="false"/>
<display:column titleKey="ec.admin.featureset.members.mandatory">
<% if ( gnItem.getField7() != null && ((Boolean)gnItem.getField7()).booleanValue() ) {  %>
<img src="<%= themeDisplay.getPathThemeImage() %>/ecommerce/red_tick.gif" alt="true">
<% } %>
</display:column>

<display:column titleKey="ec.admin.product.spec.value" sortable="false">
<% if (gnItem.getField2() != null && gnItem.getField4() != null) {%>
	<input type="hidden" name="specvalue_mainid" value="<%= gnItem.getField4().toString() %>">
	<input type="text" size="30" name="specvalue_mainid_<%= gnItem.getField4().toString() %>" value="<%= gnItem.getField2() != null ? gnItem.getField2() : "" %>">
<% } else { %>
	<input type="hidden" name="specvalue_no_mainid" value="<%= gnItem.getMainid().toString() %>">
	<input type="text" size="30" name="specvalue_no_mainid_<%= gnItem.getMainid().toString() %>" value="">
<% } %>
</display:column>
</display:table>
<% if (hasEdit) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/products/admin/saveProductSpecs" />
  <tiles:put name="buttonName" value="saveButton" />
  <tiles:put name="buttonValue" value="gn.button.update" />
  <tiles:put name="formName"   value="EC_PRODUCT_ADMIN_PRODUCTSPECS_EDITING_FORM" />
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
  <tiles:put name="action"  value="/ext/products/admin/listProductSpecsTranslations" />
  <tiles:put name="buttonName" value="translateButton" />
  <tiles:put name="buttonValue" value="ec.admin.product.feature.values.load-translations" />
  <tiles:put name="formName"   value="EC_PRODUCT_ADMIN_PRODUCTSPECS_EDITING_FORM" />
  <tiles:put name="windowState" value="normal"/>
</tiles:insert>
&nbsp;
<input type="submit" value="<%= LanguageUtil.get(pageContext, "gn.button.delete") %>">
<% } %>
</form>


<% List availableList = (List)request.getAttribute("availableList"); %>
<% if (hasEdit && availableList != null && availableList.size() > 0) { %>

<br><br><br>

<div id="addition_div_link">
<a href="#" onClick="Liferay.Util.toggle('addition_div', true); Liferay.Util.toggle('addition_div_link', true);">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "ec.admin.product.add-spec") %>
</a>
</div>

<div id="addition_div" style="display:none">
<h3><%= LanguageUtil.get(pageContext, "ec.admin.featureset.non-members.list") %></h3>

<form name="EC_PRODUCT_ADMIN_PRODUCTSPECS_ADDITION_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/addProductSpecs"/><portlet:param name="productid" value="<%= productid %>"/></portlet:actionURL>" method="post">
<display:table id="feature2" name="availableList" requestURI="//ext/products/admin/listProductSpecs?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("feature2"); %>
<display:column>
<input type="checkbox" name="featureid" value="<%= gnItem.getMainid().toString() %>" onClick="Liferay.Util.toggle('form_div_for_feature_<%= gnItem.getMainid().toString() %>',true);">
</display:column>
<display:column property="field2" titleKey="ec.admin.feature.name" sortable="true" />
<display:column property="field1" titleKey="ec.admin.feature.code" sortable="true" />

<display:column>
<div id="form_div_for_feature_<%= gnItem.getMainid().toString() %>" name="form_div_for_feature_<%= gnItem.getMainid().toString() %>" style="display:none">
<fieldset>
<table>
<tr>
<td><%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.mandatory") %></td>
<td><input type="checkbox" name="mandatory_<%= gnItem.getMainid().toString() %>" value="true" checked="true"></td>
<td>&nbsp;&nbsp;</td>
<td><%= LanguageUtil.get(pageContext, "ec.admin.product.spec.value") %></td>
<td><input type="text" name="specvalue_<%= gnItem.getMainid().toString() %>" value=""></td>
</tr>
</table>
</fieldset>
</div>
</display:column>

</display:table>
<br>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.product.add-spec") %>">
</form>
</div>

<%	 } %>
<% }  %>
