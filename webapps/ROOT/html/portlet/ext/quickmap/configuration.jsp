<%@ include file="/html/portlet/ext/quickmap/init.jsp" %>

<%
LayoutLister layoutLister = new LayoutLister();

String rootNodeName = StringPool.BLANK;
LayoutView layoutView = layoutLister.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName, locale);

List layoutList = layoutView.getList();
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

<table class="liferay-table">
<tr>
	<td>
		<liferay-ui:message key="root-layout" />
	</td>
	<td>
		<select name="<portlet:namespace />rootPlid">
				<option <%= (rootPlid == -1) ? "selected" : "" %> value="-1">
					<%= "&nbsp;[&nbsp;" + LanguageUtil.get(pageContext, "root") + "&nbsp;]&nbsp"%>
				</option>

			<%
			for (int i = 0; i < layoutList.size(); i++) {

				// id | parentId | ls | obj id | name | img | depth

				String layoutDesc = (String)layoutList.get(i);

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

				<option <%= (rootPlid == objId) ? "selected" : "" %> value="<%= objId %>">
					<%= objId!=0?layoutName: "&nbsp;[&nbsp" + LanguageUtil.get(pageContext, "current-page") + "&nbsp;]&nbsp"%>
				</option>

			<%
			}
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="show-breadcrumbs" />
	</td>
	<td>
		<liferay-ui:input-checkbox param="showBreadcrumbs" defaultValue="<%= showBreadcrumbs %>" />
	</td>
</tr>
<%--
<tr>
	<td>
		<liferay-ui:message key="display-depth" />
	</td>
	<td>
		<select name="<portlet:namespace />displayDepth">
			<option value="0"><liferay-ui:message key="unlimited" /></option>

			<%
			for (int i = 1; i <= 20; i++) {
			%>

				<option <%= (displayDepth == i) ? "selected" : "" %> value="<%= i %>"><%= i %></option>

			<%
			}
			%>

		</select>
	</td>
</tr>
--%>
</table>

<br />

<input type="button" value="<liferay-ui:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);" />

</form>
