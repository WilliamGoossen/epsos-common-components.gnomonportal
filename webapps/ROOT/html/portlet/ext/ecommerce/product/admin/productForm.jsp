<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="com.ext.portlet.ecommerce.pricing.*" %>
<%@ page import="com.ext.portlet.ecommerce.product.service.ProductBrowserService" %>
<%@ page import="java.math.BigDecimal" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/products/admin/updateProduct?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "ec.admin.product.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/products/admin/deleteProduct?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "ec.admin.product.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/products/admin/addProduct?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "ec.admin.product.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/products/admin/addProduct?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "ec.admin.product.add-translation";
}
else // in edit case, stay in the same page
	redirect = currentURL;
%>


<%@page import="com.ext.portlet.ecommerce.pricing.EcommercePriceUpdaterUtil"%><tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>

<% if (loadaction != null && !loadaction.equals("add") && !loadaction.equals("delete")) { %>
<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_MAIN %></tiles:put>
	<tiles:put name="productid"><%= request.getParameter("mainid") %></tiles:put>
</tiles:insert>
<% }  %>

<h3><%= LanguageUtil.get(pageContext, titleText) %></h3>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="PrProductAdminForm"/>
</tiles:insert>

<% List<ViewResult> catalogPrices = (List<ViewResult>)request.getAttribute("catalogPrices");
   
   if (catalogPrices != null && EcommercePriceUpdaterUtil.useCatalogs(PortalUtil.getCompanyId(request))) {
	   boolean useDatesCriterion = EcommercePriceUpdaterUtil.getEcommercePriceUpdater(PortalUtil.getCompanyId(request)).useDatesCriterion();
       SimpleDateFormat format = new SimpleDateFormat(CommonDefs.DATE_FORMAT);	   %>
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "ecommerce.product.price-catalog") %></legend>
<br>

<table class="liferay-table" style="width:100%;">
<tr>
<th><%= LanguageUtil.get(pageContext, "ec.admin.catalog.name") %></th>
<% if (useDatesCriterion) { %>
<th><%= LanguageUtil.get(pageContext, "ec.admin.catalog.validFrom") %></th>
<th><%= LanguageUtil.get(pageContext, "ec.admin.catalog.validTo") %></th>
<% } %>
<th><%= LanguageUtil.get(pageContext, "ec.admin.catalog.price") %></th>
</tr>
<% for (ViewResult cp: catalogPrices) { %>
<tr>
<td><%= cp.getField1() %></td>

<% if (useDatesCriterion) { %>
<td>
<% if (cp.getField2() != null && ((Integer)cp.getField2()).intValue() != 0) { %>
<input type="hidden" name="catalog_<%= cp.getMainid().toString() %>_priceId" value="<%= cp.getField2() %>">
<% } %>
<input type="text" name="catalog_<%= cp.getMainid().toString() %>_validFrom" id="catalog_<%= cp.getMainid().toString() %>_validFrom"
       value="<%= cp.getField3() != null? format.format((Date)cp.getField3()) : "" %>" readonly>
       <img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_catalog_<%= cp.getMainid().toString() %>_validFrom" style="cursor: pointer; border: 0px solid red;" title="Date selector" alt="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
       <script type="text/javascript">
				    Calendar.setup({
				        inputField     :    "catalog_<%= cp.getMainid().toString() %>_validFrom",     // id of the input field
				        button         :    "f_catalog_<%= cp.getMainid().toString() %>_validFrom",  // trigger for the calendar (button ID)
				        align          :    "Tl",           // alignment (defaults to "Bl")
						ifFormat       : "%d/%m/%Y",
						daFormat       : "%d/%m/%Y",
						showsTime      :true,
				        singleClick    :    true,
				        firstDay       : "1"
				    });
		 </script>
         <noscript></noscript>
</td>
<td><input type="text" name="catalog_<%= cp.getMainid().toString() %>_validTo" id="catalog_<%= cp.getMainid().toString() %>_validTo"
       value="<%= cp.getField4() != null ? format.format((Date)cp.getField4()) : "" %>" readonly>
       <img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_catalog_<%= cp.getMainid().toString() %>_validTo" style="cursor: pointer; border: 0px solid red;" title="Date selector" alt="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
      <script type="text/javascript">
				    Calendar.setup({
				        inputField     :    "catalog_<%= cp.getMainid().toString() %>_validTo",     // id of the input field
				        button         :    "f_catalog_<%= cp.getMainid().toString() %>_validTo",  // trigger for the calendar (button ID)
				        align          :    "Tl",           // alignment (defaults to "Bl")
						ifFormat       : "%d/%m/%Y",
						daFormat       : "%d/%m/%Y",
						showsTime      :true,
				        singleClick    :    true,
				        firstDay       : "1"
				    });
		 </script>
         <noscript></noscript>
</td>
<% } %>
<td><input type="text" name="catalog_<%= cp.getMainid().toString() %>_price" style="text-align:right;"
      value="<%= cp.getField5() != null ? ProductBrowserService.d2s(((BigDecimal)cp.getField5()).doubleValue()) : "" %>" ></td>
</tr>
<% } %>

</table>
</fieldset>
<% } %>


<div class="button-holder">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="PrProductAdminForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/products/admin/deleteProduct" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="PrProductAdminForm" />
		  <tiles:put name="confirm" value="gn.messages.are-you-sure-you-want-to-delete-this-translation"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>
</div>

</html:form>


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2"><%= LanguageUtil.get(pageContext, "gn.translations" ) %></h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/products/admin/loadProduct" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/products/admin/loadProduct" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>
