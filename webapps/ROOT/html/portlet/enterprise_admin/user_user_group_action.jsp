<%@ include file="/html/portlet/enterprise_admin/init.jsp" %>

<%
ResultRow row = (ResultRow)request.getAttribute(WebKeys.SEARCH_CONTAINER_RESULT_ROW);

Object[] objArray = (Object[])row.getObject();

User user2 = (User)objArray[0];
UserGroup userGroup = (UserGroup)objArray[1];
String redirect = (String)objArray[2];
%>

<c:if test="<%= !portletName.equals(PortletKeys.MY_ACCOUNT) %>">
	<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="portletURL">
		<portlet:param name="struts_action" value="/enterprise_admin/edit_user" />
		<portlet:param name="<%= Constants.CMD %>" value="deleteUserGroup" />
		<portlet:param name="redirect" value="<%= redirect %>" />
		<portlet:param name="p_u_i_d" value="<%= String.valueOf(user2.getUserId()) %>" />
		<portlet:param name="userGroupId" value="<%= String.valueOf(userGroup.getUserGroupId()) %>" />
	</portlet:actionURL>

	<liferay-ui:icon image="unlink" message="remove" url="<%= portletURL %>" />
</c:if>
