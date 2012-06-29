<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.*" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>

<h3><%= LanguageUtil.get(pageContext, "ec.admin.products") %></h3>

<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/products/admin/view"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.ecommerce.product.PrProduct"/>
</tiles:insert>

<display:table id="item" name="items" requestURI="//ext/products/admin/view?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<display:column property="field1" titleKey="name" sortable="true"/>
<display:column property="field2" titleKey="ecommerce.product.productcode" sortable="true"/>
<display:column titleKey="ecommerce.product.imageFile" sortable="true">
<% if (Validator.isNotNull(gnItem.getField3())) { 
	String imageFilePath = "/FILESYSTEM/" + PortalUtil.getCompanyId(request) + "/" + 
	GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH) + 
	gnItem.getMainid() + "/";
	String thumnailPath = imageFilePath + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField3()); 
	imageFilePath += (String)gnItem.getField3();
%>
<a href="<%= imageFilePath %>" class="thickbox"><img src="<%= thumnailPath %>" alt="<%= gnItem.getField3() %>"></a>
<% } %>
</display:column>
<display:column titleKey="ecommerce.product.active" sortable="true">
<% if (gnItem.getField5() != null && ((Boolean)gnItem.getField5()).booleanValue()) { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/activate.png">
<% } else { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/deactivate.png">
<% } %>
</display:column>

<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<% if (gnItem.getField4().equals(CommonDefs.PRODUCT_TYPE_TICKET)) { %>
			<c:if test="<%= hasEdit && gnItem.getField5() != null && ((Boolean)gnItem.getField5()).booleanValue() %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/deactivate.png" border="0" alt="<%=LanguageUtil.get(pageContext, "ec.admin.product.ticket.deactivate") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/products/admin/activateProduct"/>
								<portlet:param name="productid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="activate" value="false"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>"
							onClick="return confirm('<%= LanguageUtil.get(pageContext, "ec.admin.product.ticket.deactivate-are-you-sure") %>');">
						<%=LanguageUtil.get(pageContext, "ec.admin.product.ticket.deactivate") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasEdit && (gnItem.getField5() == null || !((Boolean)gnItem.getField5()).booleanValue()) %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/activate.png" border="0" alt="<%=LanguageUtil.get(pageContext, "ec.admin.product.ticket.activate") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/products/admin/activateProduct"/>
								<portlet:param name="productid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="activate" value="true"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>"
								onClick="return confirm('<%= LanguageUtil.get(pageContext, "ec.admin.product.ticket.activate-are-you-sure") %>');">
						<%=LanguageUtil.get(pageContext, "ec.admin.product.ticket.activate") %>
						</a>
					</td>
				</tr>
			</c:if>
			<% } %>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/products/admin/loadProduct"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="edit"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete  && com.ext.portlet.ecommerce.EShopPropsUtil.isAllowProductDeletion(request) %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/products/admin/loadProduct"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
			</c:if>
			<%-- }  --%>
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
    <portlet:param name="struts_action" value="/ext/products/admin/loadProduct"/>
    <portlet:param name="loadaction" value="add"/>
    <portlet:param name="redirect" value="<%= currentURL %>"/>
    <% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
        <portlet:param name="topicid" value="<%= request.getParameter("topicid") %>"/>
    <% } %>
    </portlet:actionURL>">
    <img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
    <%= LanguageUtil.get(pageContext, "gn.button.add") %>
    </a>
</div>

<% } %>

