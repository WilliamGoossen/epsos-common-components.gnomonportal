<%@ include file="/html/portlet/ext/base/bookmarks/init.jsp" %>

<portlet:defineObjects />

<%
String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/bookmarks/list"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.bookmarks.BsBookmark"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/bookmarks/menu/list_menu.jsp"/>
</tiles:insert>