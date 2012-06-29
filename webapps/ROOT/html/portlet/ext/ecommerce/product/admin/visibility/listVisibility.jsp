<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
String productid = request.getParameter("productid");
%>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_VISIBILITY %></tiles:put>
	<tiles:put name="productid"><%= productid %></tiles:put>
</tiles:insert>

<display:table id="item" name="product_items" requestURI="//ext/products/admin/listProductVisibility?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% PrVisibility gnItem = (PrVisibility) pageContext.getAttribute("item"); %>
<display:column property="dateFrom" titleKey="ec.admin.product.visibility.from" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="dateTo" titleKey="ec.admin.product.visibility.to" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column titleKey="ec.admin.product.visibility.type" sortable="true">
<%= LanguageUtil.get(pageContext, "ec.admin.product.visibility.type."+gnItem.getVisibilityType()) %>
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadProductVisibility"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="productid" value="<%= productid %>"/>
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadProductVisibility"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="productid" value="<%= productid %>"/>
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

<div class="add_button">
    <a href="<portlet:actionURL>
    <portlet:param name="struts_action" value="/ext/products/admin/loadProductVisibility"/>
    <portlet:param name="productid" value="<%= productid %>"/>
    <portlet:param name="loadaction" value="add"/>
    <portlet:param name="redirect" value="<%= currentURL %>"/>
    </portlet:actionURL>">
    <img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
    <%= LanguageUtil.get(pageContext, "gn.button.add") %>
    </a>
</div>

<% } %>

