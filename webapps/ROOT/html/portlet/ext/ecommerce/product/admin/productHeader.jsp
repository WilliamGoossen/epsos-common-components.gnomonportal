<%@ include file="/html/common/init.jsp" %>

<%@ page import="com.ext.portlet.ecommerce.product.admin.ViewAction" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.PrProduct" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>


<tiles:useAttribute id="productTab" name="productTab" classname="java.lang.String"/>
<tiles:useAttribute id="productid" name="productid" classname="java.lang.String"/>

<%
Integer productId = Integer.valueOf(productid);
ViewResult prodView = GnPersistenceService.getInstance(null).getObjectWithLanguage(PrProduct.class, productId, GeneralUtils.getLocale(request), new String[]{"langs.name", "table1.productcode", "table1.imagefile"});
String tab = productTab;
if (tab == null)
	tab = request.getParameter("productTab");

if (Validator.isNull(tab)) tab = "";

%>
<div>
<% if (Validator.isNotNull(prodView.getField3())) {
	String imageFilePath = "/FILESYSTEM/" + PortalUtil.getCompanyId(request) + "/" + 
	GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH) + 
	productid + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)prodView.getField3()); %>
<img src="<%= imageFilePath %>" alt="<%= prodView.getField2() %>">&nbsp;
<% } %>
<%= prodView.getField1() + " - " + prodView.getField2() %>
</div>

<br><br>

<ul class="tabs">

<li <% if (Validator.isNull(tab) || tab.equals(ViewAction.PRODUCT_TAB_MAIN)) { %> class="current" <% } %> >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/loadProduct"/>
<portlet:param name="mainid" value="<%= productid %>"/>
<portlet:param name="loadaction"  value="edit"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products.main") %>
</a>
</li>

<li <% if (tab != null && tab.equals(ViewAction.PRODUCT_TAB_IMAGES)) { %> class="current" <% } %> >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/listProductPhotos"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products.images") %>
</a>
</li>

<li <% if (tab != null && tab.equals(ViewAction.PRODUCT_TAB_SPECS)) { %> class="current" <% } %> >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/listProductSpecs"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products.specs") %>
</a>
</li>

<li <% if (tab != null && tab.equals(ViewAction.PRODUCT_TAB_ATTRIBUTES)) { %> class="current" <% } %> >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/listProductAttributes"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products.attributes") %>
</a>
</li>

<li <% if (tab != null && tab.equals(ViewAction.PRODUCT_TAB_COMBINATIONS)) { %> class="current" <% } %> >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/listProductCombinations"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products.combinations") %>
</a>
</li>

<li <% if (tab != null && tab.equals(ViewAction.PRODUCT_TAB_VISIBILITY)) { %> class="current" <% } %> >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/listProductVisibility"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products.visibility") %>
</a>
</li>

<%-- DISABLE DISCOUNTS TILL THEY ARE FULLY IMPLEMENTED --%>
<%--
<li <% if (tab != null && tab.equals(ViewAction.PRODUCT_TAB_DISCOUNTS)) { %> class="current" <% } %> >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/listProductDiscounts"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products.discounts") %>
</a>
</li>
--%>
</ul>

<br>

