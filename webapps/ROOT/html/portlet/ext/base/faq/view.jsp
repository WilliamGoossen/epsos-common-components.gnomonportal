<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>
<%@ page import="com.ext.portlet.base.faq.DummyBrokerAction" %>

<%
String tab = ParamUtil.getString(request, "tab", DummyBrokerAction.TAB_FAQS);
%>

<c:if test="<%= PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.VIEW_FAQ_POSTS) %>">
<portlet:actionURL var="dummyURL">
	<portlet:param name="struts_action" value="/ext/faq/dummyBroker" />
</portlet:actionURL>

<%
String tabNames = DummyBrokerAction.TAB_FAQS+","+DummyBrokerAction.TAB_FAQ_CONTACTS;
%>
<liferay-ui:tabs
	names="<%=tabNames %>"
	param="tab"
	url="<%= dummyURL %>"
/>
</c:if>

<c:choose>
	<c:when test='<%= tab.equals(DummyBrokerAction.TAB_FAQS) %>'>
		<!-- Faq List -->
		<%//@ include file="/html/portlet/ext/base/faq/list.jsp" %>
		<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
			<tiles:put name="struts_action" value="/ext/faq/list"/>
			<tiles:put name="contentClass" value="gnomon.hibernate.model.base.faq.BsFaq"/>
			<tiles:put name="commandSpace" value="/html/portlet/ext/base/faq/menu/list_menu.jsp"/>
		</tiles:insert>
		<tiles:insert page="/html/portlet/ext/base/faq/list.jsp" flush="true"/>
	</c:when>
	<c:otherwise>
		<!-- Contacts List -->
		<tiles:insert page="/html/portlet/ext/base/faq/contact/list.jsp" flush="true"/>
	</c:otherwise>
</c:choose>