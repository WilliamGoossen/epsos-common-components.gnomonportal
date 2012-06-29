<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.ext.portlet.ecommerce.pricing.*" %>

<%
String productid = request.getParameter("productid");
%>

<liferay-ui:error key="ec.admin.product.instance.add.error" message="ec.admin.product.instance.add.error"/>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_COMBINATIONS %></tiles:put>
	<tiles:put name="productid"><%= productid %></tiles:put>
</tiles:insert>


<% List<ViewResult> prodInstances = (List<ViewResult>)request.getAttribute("prodInstances");
   List<String> columnNames = (List<String>)request.getAttribute("columnNames"); 
   if (prodInstances != null && prodInstances.size() > 0 && columnNames != null && columnNames.size() > 0) {
	   %>
<h3><%= LanguageUtil.get(pageContext, "ec.admin.product.instance.list.active") %></h3>
<br>
<display:table id="prodInst" name="prodInstances" requestURI="//ext/products/admin/listProductCombinations?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("prodInst"); %>

<% for (int i=0; i<columnNames.size() ; i++) { %>
<display:column property="<%= "field"+(7+2*i) %>" title="<%= columnNames.get(i) %>" sortable="false"/>
<% } %>
<display:column property="field2" titleKey="ecommerce.product.productcode" sortable="false"/>
<display:column property="field4" titleKey="ecommerce.product.imageFile" sortable="false">
<%
if (Validator.isNotNull(gnItem.getField4())) {
String thumbnailImageFilePath = "/FILESYSTEM/" + PortalUtil.getCompanyId(request) + "/" + 
GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH) + 
productid + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField4()); 

String realImageFilePath = "/FILESYSTEM/" + PortalUtil.getCompanyId(request) + "/" + 
GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH) + 
productid + "/" + (String)gnItem.getField4(); 
%>

<a href="<%= realImageFilePath %>" class="thickbox">
<img align="left" border="0" src="<%= thumbnailImageFilePath %>">
</a>
<% } %>
</display:column>


<display:column titleKey="ecommerce.product.inventory" sortable="false">
<%= (gnItem.getField6() != null? com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(((BigDecimal)gnItem.getField6()).doubleValue()) : "") %>
</display:column>
<% if (!EcommercePriceUpdaterUtil.useCatalogs(PortalUtil.getCompanyId(request))) { %>
<display:column titleKey="ecommerce.product.price" sortable="false">
<%= (gnItem.getField5() != null? "\u20ac"+com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(((BigDecimal)gnItem.getField5()).doubleValue()) : "") %>
</display:column>
<% }  %>
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadProductCombination"/>
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadProductCombination"/>
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

<% } %>


<% List<ViewResult> inactiveProdInstances = (List<ViewResult>)request.getAttribute("inactiveProdInstances");
   if (inactiveProdInstances != null && inactiveProdInstances.size() > 0 && columnNames != null && columnNames.size() > 0) {
	   %>
<br><br>
<h3><%= LanguageUtil.get(pageContext, "ec.admin.product.instance.list.inactive") %></h3>
<br>
<display:table id="iprodInst" name="inactiveProdInstances" requestURI="//ext/products/admin/listProductCombinations?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("iprodInst"); %>

<% for (int i=0; i<columnNames.size() ; i++) { %>
<display:column property="<%= "field"+(7+2*i) %>" title="<%= columnNames.get(i) %>" sortable="false"/>
<% } %>
<display:column property="field2" titleKey="ecommerce.product.productcode" sortable="false"/>
<display:column property="field4" titleKey="ecommerce.product.imageFile" sortable="false">
<%
if (Validator.isNotNull(gnItem.getField4())) {
String thumbnailImageFilePath = "/FILESYSTEM/" + PortalUtil.getCompanyId(request) + "/" + 
GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH) + 
productid + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField4()); 

String realImageFilePath = "/FILESYSTEM/" + PortalUtil.getCompanyId(request) + "/" + 
GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH) + 
productid + "/" + (String)gnItem.getField4(); 
%>

<a href="<%= realImageFilePath %>" class="thickbox">
<img align="left" border="0" src="<%= thumbnailImageFilePath %>">
</a>
<% } %>
</display:column>


<display:column titleKey="ecommerce.product.inventory" sortable="false">
<%= (gnItem.getField6() != null? com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(((BigDecimal)gnItem.getField6()).doubleValue()) : "") %>
</display:column>
<display:column titleKey="ecommerce.product.price" sortable="false">
<%= (gnItem.getField5() != null? "\u20ac"+com.ext.portlet.ecommerce.product.service.ProductBrowserService.d2s(((BigDecimal)gnItem.getField5()).doubleValue()) : "") %>
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadProductCombination"/>
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
								<portlet:param name="struts_action" value="/ext/products/admin/loadProductCombination"/>
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

<% } %>



<% 
List allFeaturesAndValues = (List)request.getAttribute("allFeaturesAndValues");
Integer combinationsCount = (Integer)request.getAttribute("combinationsCount");
if (hasAdd && 
	prodInstances != null && 
	allFeaturesAndValues != null &&
	combinationsCount != null &&
	prodInstances.size() < combinationsCount.intValue()) { %>

<br/><br/>
<div id="addition_div_link">
<a href="#" onClick="Liferay.Util.toggle('addition_div', true); Liferay.Util.toggle('addition_div_link', true);">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "ec.admin.product.instance.add") %>
</a>
&nbsp;&nbsp;&nbsp;
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/loadRemainingProductCombinations"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/all_pages.png">
<%= LanguageUtil.get(pageContext, "ec.admin.product.instance.add-remaining") %>...
</a>
</div>

<div id="addition_div" style="display:none">
<form name="EC_PRODUCT_ADMIN_COMBINATIONS_ADDITION_FORM" 
	action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/checkProductCombination"/></portlet:actionURL>" 
	method="post" class="uni-form">
	
<input type="hidden" name="productid" value="<%= productid %>">
<input type="hidden" name="redirect" value="<%= currentURL %>">
<input type="hidden" name="loadaction" value="add">
<fieldset>
<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/combinations/combinationsTile.jsp" flush="true">
	<tiles:put name="readOnly" value="false"/>
</tiles:insert>
</fieldset>

<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.product.instance.add") %>">
</div>

</form>

<br><br>

<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/products/admin/loadRemainingProductCombinations"/>
<portlet:param name="productid" value="<%= productid %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/all_pages.png">
<%= LanguageUtil.get(pageContext, "ec.admin.product.instance.add-remaining") %>...
</a>

<% } %>
