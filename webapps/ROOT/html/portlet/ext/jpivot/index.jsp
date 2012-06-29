<%@ include file="/html/portlet/ext/base/init.jsp" %>

<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
		<portlet:param name="struts_action" value="/ext/jpivot/mondrian"/>
		<portlet:param name="query" value="cube8"/>
		</portlet:renderURL>">Mondrian Report Demo</a>