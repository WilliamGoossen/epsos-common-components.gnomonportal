<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>


<%String instanceProductListType=GetterUtil.getString(prefs.getValue("productListType", StringPool.BLANK));

LayoutLister layoutLister1 = new LayoutLister();

String rootNodeName1 = StringPool.BLANK;
LayoutView layoutView1 = layoutLister1.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName1, locale);

List layoutList1 = layoutView1.getList();
%>
<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">

<tr>
<td>
			<%= LanguageUtil.get(pageContext, "product-listViewType") %>
</td><td style="padding-left: 10px;"></td>
	<td>
<%String listViewType=GetterUtil.getString(prefs.getValue("productListViewType", "1"));%>

<select name="productListViewType">
<option value="1" <%=listViewType.equals("1") ? "selected" : ""%>> <%=LanguageUtil.get(pageContext,"productListView")%></option>
<option value="2" <%=listViewType.equals("2") ? "selected" : ""%>> <%=LanguageUtil.get(pageContext,"productGridView")%></option>
<option value="3" <%=listViewType.equals("3") ? "selected" : ""%>> <%=LanguageUtil.get(pageContext,"productCarouselView")%></option>
</select>
</td>
</tr>


<tr>
			<td>
			<%= LanguageUtil.get(pageContext, "product-visibility") %>
		</td>
		<td style="padding-left: 10px;"></td>
	<td>
<select name="productListType">
<option value="productlist" <%=instanceProductListType.equals("productlist") ? "selected" : ""%>> <%=LanguageUtil.get(pageContext,"productList")%></option>
<option value="featuredlist" <%=instanceProductListType.equals("featuredlist") ? "selected" : ""%>> <%=LanguageUtil.get(pageContext,"featuredlist")%></option>
<option value="newlist" <%=instanceProductListType.equals("newlist") ? "selected" : ""%>> <%=LanguageUtil.get(pageContext,"newlist")%></option>
<option value="promotedlist" <%=instanceProductListType.equals("promotedlist") ? "selected" : "" %>> <%=LanguageUtil.get(pageContext,"promotedlist")%></option>
</select>
</td>
</tr>


<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "portaltab") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
				<select name="<portlet:namespace />rootPlid">
				<option <%= (rootPlid1 == -1) ? "selected" : "" %> value="-1">
					<%= "&nbsp;[&nbsp;" + LanguageUtil.get(pageContext, "root") + "&nbsp;]&nbsp"%>
				</option>

			<%
			for (int i = 0; i < layoutList1.size(); i++) {

				// id | parentId | ls | obj id | name | img | depth

				String layoutDesc = (String)layoutList1.get(i);

				String[] nodeValues = StringUtil.split(layoutDesc, "|");

				long objId = GetterUtil.getLong(nodeValues[3]);
				String layoutName = nodeValues[4];

				int depth = 0;

				if (i != 0) {
					depth = GetterUtil.getInteger(nodeValues[6]);
				}

				for (int j = 0; j < depth; j++) {
					layoutName = "-&nbsp;" + layoutName;
				}
			%>

				<option <%= (rootPlid1 == objId) ? "selected" : "" %> value="<%= objId %>">
					<%= objId!=0?layoutName: "&nbsp;[&nbsp" + LanguageUtil.get(pageContext, "current-page") + "&nbsp;]&nbsp"%>
				</option>

			<%
			}
			%>

		</select>
			
			
		</td>
	</tr>



	<%@ include file="/html/portlet/ext/base/configurationBaseElems.jspf"%>

	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
		
</form>