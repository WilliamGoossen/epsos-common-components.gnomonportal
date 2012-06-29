<%@ include file="/html/common/init.jsp" %>

<%@ page import="com.ext.portlet.ecommerce.order.admin.ViewAction" %>

<tiles:useAttribute id="tilesTab" name="tab" classname="java.lang.String" ignore="true"/>

<%
String tab = tilesTab;
if (tab == null)
	tab = request.getParameter("tab");

if (Validator.isNull(tab)) tab = "";

%>

<ul class="tabs">

<li <% if (Validator.isNull(tab) || tab.equals(ViewAction.TAB_ORDERS)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/orders/admin/view"/>
	<portlet:param name="tab" value="<%= ViewAction.TAB_ORDERS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.orders") %>
</a>
</li>

<%--
<li <% if (Validator.isNull(tab) || tab.equals(ViewAction.TAB_CUSTOMERS)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/orders/admin/view"/>
	<portlet:param name="tab" value="<%= ViewAction.TAB_CUSTOMERS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.customers") %>
</a>
</li>
--%>

<li <% if (tab.equals(ViewAction.TAB_SHIPPINGS)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/orders/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_SHIPPINGS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.shipping") %>
</a>
</li>

<li <% if (tab.equals(ViewAction.TAB_PAYMENTS)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/orders/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_PAYMENTS %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.payment") %>
</a>
</li>

<li <% if (tab.equals(ViewAction.TAB_ORDERSTATES)) { %> class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/orders/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_ORDERSTATES %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.orderstates") %>
</a>
</li>

<li <% if (tab.equals(ViewAction.TAB_TAXES)) { %>class="current" <% } %>>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/orders/admin/view"/>
<portlet:param name="tab" value="<%= ViewAction.TAB_TAXES %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "ec.admin.taxes") %>
</a>
</li>

</ul>

<br>

