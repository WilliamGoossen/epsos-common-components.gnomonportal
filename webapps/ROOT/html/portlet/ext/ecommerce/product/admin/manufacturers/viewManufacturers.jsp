<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.*" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_MANUFACTURERS %></tiles:put>
</tiles:insert>

<h3><%= LanguageUtil.get(pageContext, "ec.admin.manufacturers") %></h3>

<display:table id="item" name="items" requestURI="//ext/products/admin/view?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% PrManufacturer gnItem = (PrManufacturer) pageContext.getAttribute("item"); %>
<display:column property="name" titleKey="name" sortable="true" style="width:100%">
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadManufacturer"/>
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadManufacturer"/>
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
<div class="add_button">
    <a href="<portlet:actionURL>
    <portlet:param name="struts_action" value="/ext/products/admin/loadManufacturer"/>
    <portlet:param name="loadaction" value="add"/>
    <portlet:param name="redirect" value="<%= currentURL %>"/>
    </portlet:actionURL>">
    <img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
    <%= LanguageUtil.get(pageContext, "gn.button.add") %>
    </a>
</div>

<% } %>