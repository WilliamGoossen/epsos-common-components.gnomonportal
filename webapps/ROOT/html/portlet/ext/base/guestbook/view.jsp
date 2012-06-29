<%@ include file="/html/portlet/ext/base/guestbook/init.jsp" %>

<%
String tab = ParamUtil.getString(request, "tab", "comments");
%>

<c:if test="<%= PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.VIEW_FAQ_POSTS) %>">
<portlet:actionURL var="dummyURL">
	<portlet:param name="struts_action" value="/ext/guestbook/dummyBroker" />
</portlet:actionURL>


<liferay-ui:tabs
	names="comments,pending"
	param="tab"
	url="<%= dummyURL %>"
/>
</c:if>

<c:choose>
	<c:when test='<%= tab.equals("comments") %>'>
		<!-- Faq List -->
		<%//@ include file="/html/portlet/ext/base/guestbook/list.jsp" %>
		<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
			<tiles:put name="struts_action" value="/ext/guestbook/list"/>
			<tiles:put name="contentClass" value="gnomon.hibernate.model.base.guestbook.BsGuestbook"/>
			<tiles:put name="commandSpace" value="/html/portlet/ext/base/guestbook/menu/list_menu.jsp"/>
		</tiles:insert>
		<tiles:insert page="/html/portlet/ext/base/guestbook/list.jsp" flush="true"/>
	</c:when>
	<c:otherwise>
		<!-- Contacts List -->

		<tiles:insert page="/html/portlet/ext/base/guestbook/list_pending.jsp" flush="true"/>
	</c:otherwise>
</c:choose>