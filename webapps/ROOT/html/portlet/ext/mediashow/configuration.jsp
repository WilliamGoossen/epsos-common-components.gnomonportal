<%@ include file="/html/portlet/ext/mediashow/init.jsp" %>
<%
if (flashAttributes.equals(StringPool.BLANK)) {
	flashAttributes =
		"align=left\n" +
		"allowScriptAccess=sameDomain\n" +
		"base=.\n" +
		"bgcolor=#FFFFFF\n" +
		"devicefont=true\n" +
		"height=500\n" +
		"loop=true\n" +
		"menu=false\n" +
		"play=false\n" +
		"quality=best\n" +
		"salign=\n" +
		"scale=showall\n" +
		"swliveconnect=false\n" +
		"width=100%\n" +
		"wmode=opaque";
}
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

<table class="liferay-table">
<tr>
	<td>
		<liferay-ui:message key="folder" />
	</td>
	<td>
		<select name="<portlet:namespace />selFolderId">
			<option <%= (selFolderId == 0) ? "selected" : "" %> value="0">
				<%= "&nbsp;[&nbsp;" + LanguageUtil.get(pageContext, "home-folder") + "&nbsp;]&nbsp"%>
			</option>

			<%
				StringMaker sm = new StringMaker();
	
				_buildFolderTree(null, selFolderId, PortalUtil.getPortletGroupId(layout.getPlid()), 0, sm);
	
				out.print(sm.toString());
			%>

		</select>
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="width" />
	</td>
	<td>
		<input class="liferay-input-text" name="<portlet:namespace />sspWidth" type="text" value="<%= sspWidth %>" />
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="height" />
	</td>
	<td>
		<input class="liferay-input-text" name="<portlet:namespace />sspHeight" type="text" value="<%= sspHeight %>" />
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="flash-attributes" />
	</td>
	<td>
		<textarea class="liferay-textarea" name="<portlet:namespace />flashAttributes" wrap="soft" onKeyDown="Liferay.Util.checkTab(this); disableEsc();"><%= flashAttributes %></textarea>
	</td>
</tr>
<%--
<tr>
	<td>
		<liferay-ui:message key="include-subfolders" />
	</td>
	<td>
		<liferay-ui:input-checkbox param="includeSubfolders" defaultValue="<%//= showBreadcrumbs %>" />
	</td>
</tr>
--%>
</table>

<br />

<input type="button" value="<liferay-ui:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);" />

</form>


<%!
private void _buildFolderTree(IGFolder rootFolder, long selFolderId, long groupId, int depth, StringMaker sm) throws Exception {
	List folderChildren = null;

	if (rootFolder != null) {
		folderChildren = IGFolderLocalServiceUtil.getFolders(groupId, rootFolder.getFolderId());
	}
	else {
		folderChildren = IGFolderLocalServiceUtil.getFolders(groupId, IGFolderImpl.DEFAULT_PARENT_FOLDER_ID);
	}
	
	for (int i=0; folderChildren!=null && i<folderChildren.size(); i++) {
		
		IGFolder iFolder = (IGFolder)folderChildren.get(i);
		
		//it is a direct child of the current rootFolder
		String name = iFolder.getName();

		for (int j = 0; j < depth; j++) {
			name = "-&nbsp;" + name;
		}
			
		sm.append("<option ");
		if (iFolder.getFolderId()==selFolderId)
			sm.append("selected ");
		sm.append("value=").append(iFolder.getFolderId());
		sm.append(">");
			
		sm.append(name);
			
		sm.append("</option>");
		
		_buildFolderTree(iFolder, selFolderId, groupId, depth+1, sm);
		
	}
}
%>