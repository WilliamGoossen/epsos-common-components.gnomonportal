<%
/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portlet/shopping/init.jsp" %>

<%
ShoppingCategory category = (ShoppingCategory)request.getAttribute(WebKeys.SHOPPING_CATEGORY);

long categoryId = BeanParamUtil.getLong(category, request, "categoryId", ShoppingCategoryImpl.DEFAULT_PARENT_CATEGORY_ID);
%>

<form method="post" name="<portlet:namespace />fm">

<liferay-ui:tabs names="categories" />

<c:if test="<%= category != null %>">
	<div class="breadcrumbs">
		<%= ShoppingUtil.getBreadcrumbs(category, pageContext, renderRequest, renderResponse) %>
	</div>
</c:if>

<%
PortletURL portletURL = renderResponse.createRenderURL();

portletURL.setWindowState(LiferayWindowState.POP_UP);

portletURL.setParameter("struts_action", "/shopping/select_category");

List headerNames = new ArrayList();

headerNames.add("category");
headerNames.add("num-of-categories");
headerNames.add("num-of-items");
headerNames.add(StringPool.BLANK);

SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM, SearchContainer.DEFAULT_DELTA, portletURL, headerNames, null);

//GNOMONSA: changed portletGroupId.longValue() to PortalUtil.getPortletGroupId(layout.getPlid()) to ovverride cms group
int total = ShoppingCategoryLocalServiceUtil.getCategoriesCount(PortalUtil.getPortletGroupId(layout.getPlid()), categoryId);

searchContainer.setTotal(total);

//GNOMONSA: changed portletGroupId.longValue() to PortalUtil.getPortletGroupId(layout.getPlid()) to ovverride cms group
List results = ShoppingCategoryLocalServiceUtil.getCategories(PortalUtil.getPortletGroupId(layout.getPlid()), categoryId, searchContainer.getStart(), searchContainer.getEnd());

searchContainer.setResults(results);

List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	ShoppingCategory curCategory = (ShoppingCategory)results.get(i);

	ResultRow row = new ResultRow(curCategory, curCategory.getCategoryId(), i);

	PortletURL rowURL = renderResponse.createRenderURL();

	rowURL.setWindowState(LiferayWindowState.POP_UP);

	rowURL.setParameter("struts_action", "/shopping/select_category");
	rowURL.setParameter("categoryId", String.valueOf(curCategory.getCategoryId()));

	// Name and description

	StringMaker sm = new StringMaker();

	sm.append(curCategory.getName());

	if (Validator.isNotNull(curCategory.getDescription())) {
		sm.append("<br />");
		sm.append("<span style=\"font-size: xx-small;\">");
		sm.append(curCategory.getDescription());
		sm.append("</span>");
	}

	row.addText(sm.toString(), rowURL);

	// Statistics

	List subcategoryIds = new ArrayList();

	subcategoryIds.add(new Long(curCategory.getCategoryId()));

	// GNOMONSA: changed portletGroupId.longValue() to PortalUtil.getPortletGroupId(layout.getPlid()) to ovverride cms group
	ShoppingCategoryLocalServiceUtil.getSubcategoryIds(subcategoryIds, PortalUtil.getPortletGroupId(layout.getPlid()), curCategory.getCategoryId());

	int categoriesCount = subcategoryIds.size() - 1;
	int itemsCount = ShoppingItemLocalServiceUtil.getCategoriesItemsCount(subcategoryIds);

	row.addText(String.valueOf(categoriesCount), rowURL);
	row.addText(String.valueOf(itemsCount), rowURL);

	// Action

	sm = new StringMaker();

	sm.append("opener.");
	sm.append(renderResponse.getNamespace());
	sm.append("selectCategory('");
	sm.append(curCategory.getCategoryId());
	sm.append("', '");
	sm.append(UnicodeFormatter.toString(curCategory.getName()));
	sm.append("'); window.close();");

	row.addButton("right", SearchEntry.DEFAULT_VALIGN, LanguageUtil.get(pageContext, "choose"), sm.toString());

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />

</form>