<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ include file="/html/portlet/ext/ecommerce/order/admin/currentURLcomplement.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.*" %>
<%@ page import="java.math.BigDecimal" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<tiles:insert page="/html/portlet/ext/ecommerce/order/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_ORDERS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true" />


<h3><%= LanguageUtil.get(pageContext, "ec.admin.order.history.list") %></h3>
<br>
<display:table id="item" name="historyItems" requestURI="//ext/orders/admin/viewOrderHistory?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>

<display:column titleKey="ec.admin.order.history.date" sortable="true" property="field1" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
<display:column titleKey="ec.admin.order.history.state" sortable="true" property="field3" />
<display:column titleKey="ec.admin.order.history.party" sortable="true" property="field2" />

</display:table>

<br><br>

<a href="<%if (Validator.isNull(redirect)) { 
			out.print("javascript:history.back();");
		  } else { 
			out.println(redirect); 
		   }%>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><%= LanguageUtil.get(pageContext, "back") %></a>

