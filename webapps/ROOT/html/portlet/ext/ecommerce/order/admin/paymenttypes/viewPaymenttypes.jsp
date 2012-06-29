<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.*" %>
<%@ page import="java.math.BigDecimal" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<tiles:insert page="/html/portlet/ext/ecommerce/order/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_PAYMENTS %></tiles:put>
</tiles:insert>

<h3><%= LanguageUtil.get(pageContext, "ec.admin.payment") %></h3>

<display:table id="item" name="items" requestURI="//ext/orders/admin/view?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<display:column property="field1" titleKey="ec.admin.paymenttype.name" sortable="true" />
<display:column titleKey="ec.admin.paymenttype.fixedprice" sortable="true">
<%= gnItem.getField2() != null ? com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(((BigDecimal)gnItem.getField2()).doubleValue()) : " - " %>
</display:column>
<display:column titleKey="ec.admin.product.feature.impact.type" sortable="false">
<%= gnItem.getField3() != null && ((Integer)gnItem.getField3()).intValue() == CommonDefs.PRODUCT_IMPACT_EXACT ? LanguageUtil.get(pageContext, "ec.admin.product.feature.impact.type.exact") :  LanguageUtil.get(pageContext, "ec.admin.product.feature.impact.type.percent")%>
</display:column>
<display:column titleKey="ecommerce.product.active" sortable="true">
<% if (gnItem.getField4() != null && ((Boolean)gnItem.getField4()).booleanValue()) { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/activate.png">
<% } else { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/deactivate.png">
<% } %>
</display:column>


<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/orders/admin/loadPaymenttype"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="edit"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/orders/admin/loadPaymenttype"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
			</c:if>
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/orders/admin/loadPaymenttype"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>

