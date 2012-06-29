<%@ include file="/html/common/init.jsp" %>

<%@ page import="com.ext.portlet.ecommerce.product.admin.ViewAction" %>

<tiles:useAttribute id="tilesTab" name="tab" classname="java.lang.String" ignore="true"/>

<%
String tab = tilesTab;
if (tab == null)
	tab = request.getParameter("tab");

if (Validator.isNull(tab)) tab = "";

%>
<ul class="tabs">

<li <% if (Validator.isNull(tab) || tab.equals(ViewAction.TAB_PRODUCTS)) { %> class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.products") %>
</a>
</li>

<li <% if (tab.equals(ViewAction.TAB_MANUFACTURERS)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_MANUFACTURERS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.manufacturers") %>
</a>
</li>

<li <% if (tab.equals(ViewAction.TAB_SUPPLIERS)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_SUPPLIERS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.suppliers") %>
</a>
</li>

<li <% if (tab.equals(ViewAction.TAB_PRODUCTTYPES)) { %> class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_PRODUCTTYPES %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.producttypes") %>
</a>
</li>

<li <% if (tab.equals(ViewAction.TAB_FEATURES)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_FEATURES %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.features") %>
</a>

</li>

<li <% if (tab.equals(ViewAction.TAB_METRICS)) { %> class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_METRICS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.metrics") %>
</a>
</li>

<% if (com.ext.portlet.ecommerce.pricing.EcommercePriceUpdaterUtil.useCatalogs(PortalUtil.getCompanyId(request))) { %>
<li <% if (tab.equals(ViewAction.TAB_CATALOGS)) { %> class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_CATALOGS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.catalogs") %>
</a>
</li>
<% } %>


<li <% if (tab.equals(ViewAction.TAB_BULKIMPORT)) { %> class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_BULKIMPORT %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.bulkimport") %>
</a>
</li>
</ul>

<br>


