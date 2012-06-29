<%@ include file="/html/portlet/ext/base/news/init.jsp" %>

<portlet:defineObjects />

<%
String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>


<tiles:insert page="/html/portlet/ext/includes/date_search.jsp" flush="true">
<tiles:put name="struts_action" value="/ext/news/list"/>
<tiles:put name="contentClass" value="gnomon.hibernate.model.base.news.BsNew"/>
</tiles:insert>

<table cellpadding="0" cellspacing="4" width="100%">
<tbody>
<tr>
	<%--
	<td width="32">
		<img id="browse:space-logo" src="<%= themeDisplay.getPathThemeImage() %>/base/space-icon-default.gif" height="32" width="32">
	</td>
	<td>
		<div class="mainTitle">
			<span id="browse:msg2">Security</span>
		</div>
		<div class="mainSubText">
			<span id="browse:msg3">This view allows browsing elements in your space.</span>
		</div>
		<div class="mainSubText">
			<span id="browse:msg4"></span>
		</div>
	</td>
	<td style="background-color: #92A8C0;" width="1"></td>
	--%>
	<td width="300">&nbsp;</td>
	<td valign="middle" width="118">
		<table style="white-space: nowrap;" cellpadding="0" cellspacing="0">
		<tbody>
		<tr>
			<td style="padding-right: 4px;"><img src="<%= themeDisplay.getPathThemeImage() %>/base/Details.gif" align="absmiddle" border="0"></td>
			<td>
				<a href="#" onclick="javascript:_toggleMenu(event, 'browse:viewMode_2');return false;"><span>Show Icons</span><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
			</td>
		</tr>
		</tbody>
		</table>
		<div id="browse:viewMode_2" style="position: absolute; display: none; padding-left: 2px;">
			<table class="moreActionsMenu" cellpadding="0" cellspacing="1">
			<tbody>
			<tr>
				<td>
					<table cellpadding="0" cellspacing="4" width="100%">
					<tbody>
					<tr>
						<td width="20"></td>
						<td><a href="#" onclick="document.forms['browse']['browse:modelist'].value='browse:viewMode:details';document.forms['browse'].submit();return false;">Show Details</a></td>
					</tr>
					</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table class="statusListHighlight" cellpadding="0" cellspacing="4" width="100%">
					<tbody>
					<tr>
						<td width="20"><img src="<%= themeDisplay.getPathThemeImage() %>/base/Details.gif" border="0"></td>
						<td><a href="#" onclick="document.forms['browse']['browse:modelist'].value='browse:viewMode:icons';document.forms['browse'].submit();return false;">Show Icons</a></td>
					</tr>
					</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table cellpadding="0" cellspacing="4" width="100%">
					<tbody>
					<tr>
						<td width="20"></td>
						<td><a href="#" onclick="document.forms['browse']['browse:modelist'].value='browse:viewMode:list';document.forms['browse'].submit();return false;">Show Browsing</a></td>
					</tr>
					</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table cellpadding="0" cellspacing="4" width="100%">
					<tbody>
					<tr>
						<td width="20"></td>
						<td><span class="statusListDisabled">Custom View</span></td>
					</tr>
					</tbody>
					</table>
				</td>
			</tr>
			</tbody>
			</table>
		</div>
	</td>
	<td style="background-color: #92A8C0;" width="1"></td>
	<td style="padding-left: 4px;" align="right">
		<nobr>
			<table cellpadding="0" cellspacing="0">
			<tbody>
			<tr>
				<td width="16"><img src="<%= themeDisplay.getPathThemeImage() %>/base/add.gif" alt="gn.link.add-content" title="gn.link.add-content" align="absmiddle" border="0"></td>
				<td style="padding-left: 4px; padding-top: 2px;">
					<a href="#" onclick="document.forms['browse']['browse:act'].value='browse:link3';document.forms['browse'].submit();return false;" style="white-space: nowrap;">Add Content</a>
				</td>
			</tr>
			<tr>
				<td width="16">&nbsp;</td>
				<td style="padding-left: 4px;">
					<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1');return false;" style="white-space: nowrap;">More...<img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
					<br>
					<div id="browse:actionsMenu_1" style="position: absolute; display: none; padding-left: 2px;">
						<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
						<tbody>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/View_details.gif" alt="Show Details" title="Show Details" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:details_space_id_4154';document.forms['browse']['id'].value='6a577c99-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Show Details</a></td>
						</tr>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/delete.gif" alt="Delete" title="Delete" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:delete_space_id_4157';document.forms['browse']['id'].value='6a577c99-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Delete</a></td>
						</tr>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/cut.gif" alt="Cut" title="Cut" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:cut_node_id_4161';document.forms['browse']['id'].value='6a577c99-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Cut</a></td>
						</tr>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/copy.gif" alt="Copy" title="Copy" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:copy_node_id_4164';document.forms['browse']['id'].value='6a577c99-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Copy</a></td>
						</tr>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/paste.gif" alt="Paste All" title="Paste All" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:paste_all_id_4167';document.forms['browse'].submit();return false;">Paste All</a></td>
						</tr>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/invite.gif" alt="Manage Space Users" title="Manage Space Users" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:manage_space_users_id_4169';document.forms['browse']['id'].value='6a577c99-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Manage Space Users</a></td>
						</tr>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/rule.gif" alt="Manage Content Rules" title="Manage Content Rules" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:manage_space_rules_id_4172';document.forms['browse']['id'].value='6a577c99-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Manage Content Rules</a></td>
						</tr>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/trashcan.gif" alt="Manage Deleted Items" title="Manage Deleted Items" border="0"></td>
							<td><a href="#" onclick="document.forms['browse']['browse:act'].value='browse:manage_deleted_items_id_4175';document.forms['browse'].submit();return false;">Manage Deleted Items</a></td>
						</tr>
						</tbody>
						</table>
					</div>
				</td>
			</tr>
			</tbody>
			</table>
		</nobr>
	</td>

</tr>
<tr>
	<td height="1" colspan="6" style="background-color: #92A8C0;"></td>
</tr>
</tbody>
</table>