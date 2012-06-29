<%@ include file="/html/portlet/ext/topicnav/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/topicnav/style-" + prefs.getValue("list-style", "1") + ".jsp";
%>

<c:choose>
	<c:when test="<%= !com.ext.portlet.topicnav.action.ViewAction.isHide(portalContext, renderRequest) %>">
		<jsp:include page="<%=includedPage%>" flush="true"/>
	</c:when>
</c:choose>