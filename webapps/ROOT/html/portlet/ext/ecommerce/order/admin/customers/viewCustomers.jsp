<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.*" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<tiles:insert page="/html/portlet/ext/ecommerce/order/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_CUSTOMERS %></tiles:put>
</tiles:insert>

<h3><%= LanguageUtil.get(pageContext, "ec.admin.customers") %></h3>

<br>

<h3>!UNDER CONSTRUCTION!</h3>

<%-- 
<display:table id="item" name="items" requestURI="//ext/orders/admin/view?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% EcOrder gnItem = (EcOrder) pageContext.getAttribute("item"); %>
</display:table>
--%>