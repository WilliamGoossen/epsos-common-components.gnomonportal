<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>

<portlet:defineObjects />

<%
//String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>

<table cellpadding="0" cellspacing="0" width="100%" >
<tbody>
<tr>
	<!--<td style="background-color: #92A8C0;" width="1"></td>-->
	<td style="padding-left: 4px;" align="right">
		<nobr>
			<table cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADD_FAQ_POST) %>">
			<tr>
				<td>
                <div class="action_link">
                <img src="<%= themeDisplay.getPathThemeImage() %>/base/add.gif" border="0" align="absmiddle">&nbsp;
					<portlet:renderURL var="portletURL">
						<portlet:param name="struts_action" value="/ext/faq/loadContact" />
						<portlet:param name="loadaction" value="add-contact" />
						<portlet:param name="redirect" value="<%= currentURL %>" />
					</portlet:renderURL><a href="<%=portletURL%>" title="<%= LanguageUtil.get(pageContext, "bs.faq.contact.send-a-request") %>"><%= LanguageUtil.get(pageContext, "bs.faq.contact.send-a-request") %></a>
				</div>
				</td>
			</tr>
			</c:if>
		
			<tr>
				<td>
					<tiles:insert page="/html/portlet/ext/struts_includes/lucene_searchTile.jsp" flush="true">
						<tiles:put name="struts_action" value="/ext/faq/list" />
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
