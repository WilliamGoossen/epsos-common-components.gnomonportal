<%@ include file="/html/taglib/ui/navigation/init.jsp" %>

<c:choose>
	<c:when test="<%=viewOrientation.equals("horizontal") %>">
		<liferay-util:include page="/html/taglib/ui/navigation/horizontal.jsp" />
	</c:when>
	<c:otherwise>
		<liferay-util:include page="/html/taglib/ui/navigation/vertical.jsp" />
	</c:otherwise>
</c:choose>