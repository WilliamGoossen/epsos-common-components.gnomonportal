<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
String orderid = (String)request.getAttribute("orderid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/orders/admin/loadOrderLine?actionURL=true" ;
String titleText = "ec.admin.order.line.view";
%>

<tiles:insert page="/html/portlet/ext/ecommerce/order/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_ORDERS %></tiles:put>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h3><%= LanguageUtil.get(pageContext, titleText) %></h3>

<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="EcOrderlineForm"/>
</tiles:insert>

</html:form>

<br><br>

<a title="<%= LanguageUtil.get(pageContext, "ec.admin.order.edit") %>" 
   href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/orders/admin/loadOrder"/><portlet:param name="loadaction" value="edit"/><portlet:param name="mainid" value="<%= orderid %>"/></portlet:actionURL>">
   <img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="<%= LanguageUtil.get(pageContext, "ec.admin.order.edit") %>">
   <%= LanguageUtil.get(pageContext, "ec.admin.order.edit") %>
</a>


