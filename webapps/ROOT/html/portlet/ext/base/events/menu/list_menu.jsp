<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<portlet:defineObjects />

<%
//String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>

<table cellpadding="0" cellspacing="0" width="100%">
<tbody>
<tr>
	<!--<td style="background-color: #92A8C0;" width="1"></td>-->
	<td style="padding-left: 4px;" align="right">
		<nobr>
			<table cellpadding="0" cellspacing="0">
			<tbody>
			<tr>
				<td>
					<tiles:insert page="/html/portlet/ext/struts_includes/lucene_searchTile.jsp" flush="true">
						<tiles:put name="struts_action" value="/ext/events/list" />
						<tiles:put name="searchStyle" value="<%=instancePortletSearch%>" />
					</tiles:insert>
				</td>
			</tr>
			</tbody>
			</table>
		</nobr>
	</td>
</tr>
</tbody>
</table>







					<%--
					<c:choose>
						<c:when test="<%= !ParamUtil.getString(request,"listFilter", GnPortletSetting.LIST_PUBLISH_TRUE).equals(GnPortletSetting.LIST_PUBLISH_FALSE) %>">
						</c:when>
						<c:otherwise>
							<portlet:renderURL windowState="<%= WindowState.NORMAL.toString() %>" var="portletURL">
								<portlet:param name="struts_action" value="/ext/events/list" />
								<portlet:param name="filter" value="gn.link.view-unpublished" />
								<portlet:param name="topicid" value="<%= ParamUtil.getString(request,"topicid", "") %>" />
							</portlet:renderURL>
							<a href="<%=portletURL%>"><img src="<%= themeDisplay.getPathThemeImage() %>/base/view_details.gif" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.link.view-unpublished") %></a>
						</c:otherwise>
					</c:choose>
					--%>




			<%--
			<c:if test="true">
			<tr>
				<td style="padding-left: 4px;">
					<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1');return false;" style="white-space: nowrap;">More...<img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
					<br>
					<div id="browse:actionsMenu_1" style="position: absolute; display: none; padding-left: 2px;">
						<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
						<tbody>
						<tr>
							<td><img src="<%= themeDisplay.getPathThemeImage() %>/base/View_details.gif" alt="View Unpublished" title="Show Details" border="0"></td>
							<td>
								<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="portletURL">
									<portlet:param name="struts_action" value="/ext/events/list" />
									<portlet:param name="loadaction" value="gn.link.view-unpublished" />
									<portlet:param name="topicid" value="<%= ParamUtil.getString(request,"topicid", "") %>" />
									</portlet:renderURL>"><%= LanguageUtil.get(pageContext, "gn.link.view-unpublished") %></a>
							</td>
						</tr>
						</tbody>
						</table>
					</div>
				</td>
			</tr>
			</c:if>
			--%>