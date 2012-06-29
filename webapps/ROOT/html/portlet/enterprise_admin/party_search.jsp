<%@ include file="/html/portlet/enterprise_admin/init.jsp" %>

<%
PartySearch searchContainer = (PartySearch)request.getAttribute("liferay-ui:search:searchContainer");

PartyDisplayTerms displayTerms = (PartyDisplayTerms)searchContainer.getDisplayTerms();
%>

<div>
	<label for="<portlet:namespace /><%= displayTerms.KEYWORDS %>"><liferay-ui:message key="search" /></label>

	<input id="<portlet:namespace /><%= displayTerms.KEYWORDS %>" name="<portlet:namespace /><%= displayTerms.KEYWORDS %>" size="30" type="text" value="<%= displayTerms.getKeywords() %>" />
</div>

<br />

<div>
	<input type="submit" value="<liferay-ui:message key="search-parties" />" />

	<c:if test="<%= portletName.equals(PortletKeys.ENTERPRISE_ADMIN) && PortalPermissionUtil.contains(permissionChecker, ActionKeys.ADD_USER_GROUP) %>">
		<input type="button" value="<liferay-ui:message key="parties.button.add" />" onClick="self.location = '<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_party" /><portlet:param name="redirect" value="<%= currentURL %>" /></portlet:renderURL>';" />
	</c:if>
</div>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		Liferay.Util.focusFormField(document.<portlet:namespace />fm.<portlet:namespace /><%= displayTerms.KEYWORDS %>);
	</script>
</c:if>