<c:choose>
	<c:when test="<%= portletDisplay.isActive() %>">
		<c:choose>
			<c:when test="<%= themeDisplay.isStateExclusive() %>">
				<%@ include file="/html/common/themes/portlet_content.jspf" %>
			</c:when>
			<c:when test="<%= portletDisplay.isAccess() %>">
				<div>
					<c:if test='<%= !tilesPortletContent.endsWith("/error.jsp") %>'>
						<%@ include file="/html/common/themes/portlet_messages.jspf" %>
					</c:if>
					
					<c:if test="<%= Validator.isNotNull(tilesPortletCmsNav) %>">
						<liferay-util:include page="<%= com.liferay.portal.struts.StrutsUtil.TEXT_HTML_DIR + tilesPortletCmsNav %>" />
					</c:if>
					
					<%@ include file="/html/common/themes/portlet_content.jspf" %>
				</div>
			</c:when>
			<c:otherwise>
				<liferay-util:include page="/html/portal/portlet_access_denied.jsp" />
			</c:otherwise>
		</c:choose>
	</c:when>
	<c:otherwise>
		<liferay-util:include page="/html/portal/portlet_inactive.jsp" />
	</c:otherwise>
</c:choose>