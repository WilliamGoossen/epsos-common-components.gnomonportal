<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="java.math.BigDecimal"%>
<%@ page import="java.util.List"%>

<%@ page import="gnomon.util.GnPropsUtil" %>
<%@ page import="gnomon.business.ViewResultUtil" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.model.ecommerce.*" %>
<%@ page import="gnomon.hibernate.model.parties.PaGeographicAddress" %>
<%@ page import="gnomon.hibernate.model.parties.PaCountryLanguage" %>

<%@ page import="com.ext.portlet.ecommerce.EShopPropsUtil" %>
<%@ page import="com.ext.portlet.ecommerce.cart.util.*"%>
<%@ page import="com.ext.portlet.ecommerce.cart.model.*"%>
<%@ page import="com.ext.portlet.ecommerce.cart.exception.*"%>
<%@ page import="com.ext.portlet.ecommerce.order.service.*"%>
<%@ page import="com.ext.portlet.ecommerce.product.service.ProductBrowserService"%>
<%@ page import="com.ext.portlet.parties.contacts.ContactsService"%>


<%@ page import="com.liferay.portlet.shopping.BillingCityException" %>
<%@ page import="com.liferay.portlet.shopping.BillingCountryException" %>
<%@ page import="com.liferay.portlet.shopping.BillingEmailAddressException" %>
<%@ page import="com.liferay.portlet.shopping.BillingFirstNameException" %>
<%@ page import="com.liferay.portlet.shopping.BillingLastNameException" %>
<%@ page import="com.liferay.portlet.shopping.BillingPhoneException" %>
<%@ page import="com.liferay.portlet.shopping.BillingStateException" %>
<%@ page import="com.liferay.portlet.shopping.BillingStreetException" %>
<%@ page import="com.liferay.portlet.shopping.BillingZipException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingCityException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingCountryException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingEmailAddressException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingFirstNameException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingLastNameException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingPhoneException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingStateException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingStreetException" %>
<%@ page import="com.liferay.portlet.shopping.ShippingZipException" %>


<%
	String lang = gnomon.business.GeneralUtils.getLocale(request);
	String redirect = ParamUtil.getString(request, "redirect");
	String checkoutURL = CartUtil.getCheckoutURL(request);
%>

<portlet:actionURL var="submitURL">
	<portlet:param name="struts_action" value="/ext/ecommerce/cart/checkout"/>
</portlet:actionURL>