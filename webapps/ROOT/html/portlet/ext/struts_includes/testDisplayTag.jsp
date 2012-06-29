<%@ include file="/html/portlet/ext/base/mlists/init.jsp" %>

<tiles:useAttribute id="viewStyle" name="viewStyle" classname="java.lang.String" ignore="true"/>


<c:choose>
	<c:when test="<%=viewStyle.equals("list")%>">

	</c:when>

	<c:otherwise>
		<% List my = (List) request.getAttribute("mlists");
		%>
		<table class="recordSet" cellpadding="0" cellspacing="0" width="100%">
		<thead></thead>
		<tbody>
		<tr class="recordSetRow">
			<td width="33%">
				<table border="0" cellpadding="2" cellspacing="0">
				<tbody>
				<tr>
					<td rowspan="10" style="padding: 2px; text-align: left; vertical-align: top;">
						<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:col2-act1';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;"><img src="<%= themeDisplay.getPathThemeImage() %>/base/space-icon-default.gif" alt="Covers_Logos" title="Covers_Logos" align="middle" border="0"></a>
					</td>
					<td style="padding: 2px; text-align: left; vertical-align: top;">
						<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:col2-act2';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;" class="header">Covers_Logos</a>
					</td>
				</tr>
				<tr>
					<td style="text-align: left;"><span id="browse:col4-txt"></span></td>
				</tr>
				<tr>
					<td style="text-align: left;"><span id="browse:col7-txt">16 October 2006 14:00</span></td>
				</tr>
				<tr>
					<td style="text-align: left;">
						<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:preview_space_id_748';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;" class="inlineAction"><img src="<%= themeDisplay.getPathThemeImage() %>/base/preview.gif" alt="Preview" title="Preview" align="middle" border="0"></a>
						<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:cut_node_id_752';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;" class="inlineAction"><img src="<%= themeDisplay.getPathThemeImage() %>/base/cut.gif" alt="Cut" title="Cut" align="middle" border="0"></a>
						<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:copy_node_id_755';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;" class="inlineAction"><img src="<%= themeDisplay.getPathThemeImage() %>/base/copy.gif" alt="Copy" title="Copy" align="middle" border="0"></a>
						<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:details_space_id_757';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;" class="inlineAction"><img src="<%= themeDisplay.getPathThemeImage() %>/base/View_details.gif" alt="Show details" title="Show details" align="middle" border="0"></a>
						<a href="#" onClick="javascript:_toggleMenu(event, 'browse:spaces-more-menu_3');return false;" title="More actions"><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0"></a>
						<br>
						<div id="browse:spaces-more-menu_3" style="position: absolute; display: none; padding-left: 2px;">
						<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
							<tbody>
							<tr>
								<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/delete.gif" alt="Delete" title="Delete" border="0"></td>
								<td>
									<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:delete_space_id_763';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Delete</a>
								</td>
							</tr>
							<tr>
								<td>
									<img src="<%= themeDisplay.getPathThemeImage() %>/base/create_forum.gif" alt="Start Discussion" title="Start Discussion" border="0">
								</td>
								<td>
									<a href="#" onClick="document.forms['browse']['browse:act'].value='browse:create_forum_node_id_773';document.forms['browse']['id'].value='f316a88d-5504-11db-b494-f1da5dbcd4eb';document.forms['browse'].submit();return false;">Start Discussion</a>
								</td>
							</tr>
							</tbody>
						</table>
						</div>
					</td>
				</tr>
				</tbody>
				</table>
			</td>
		</tr>
		</tbody>
		<table>
	</c:otherwise>
</c:choose>