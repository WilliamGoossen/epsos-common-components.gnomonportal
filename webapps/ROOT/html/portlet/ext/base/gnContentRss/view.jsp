<%@ include file="/html/portlet/init.jsp" %>

<!-- com.ext.portlet.topics.service.TopicsTreeBuilder -->
<%@ page import="com.ext.portlet.base.contentRss.TopicsTreeBuilder" %>
<%@ page import="com.ext.util.TreeViewDescription" %>
<%@ page import="com.ext.portlet.base.contentRss.ViewAction" %>


<%
ViewResult selectedTopicVr = (ViewResult)request.getAttribute("selectedTopicVr");

String rssContentLength	= (String)request.getAttribute("rssContentLength");
String numOfRssEntries = (String)request.getAttribute("numOfRssEntries");

PortletPreferences prefs = PortletPreferencesFactoryUtil.getPortletSetup(
		request, ViewAction.PORTLET_GN_CONTENT_RSS, true, true);

boolean showTopicSubTree = GetterUtil.getBoolean(prefs.getValue("showTopicSubTree", StringPool.BLANK), false);  
int subTreeExpandLevel = GetterUtil.getInteger(prefs.getValue("subTreeExpandLevel", ViewAction.DEFAULT_EXPAND_LEVEL));
%>

<%if (selectedTopicVr != null){
Integer selTopicId = selectedTopicVr.getMainid();
String topicUrl = themeDisplay.getPathMain() + "/ext/gnContentRss/rss";

%>

<%if (showTopicSubTree){ %>

<%
String rssIcon = "<img src="+themeDisplay.getPathThemeImage()+"/common/rss.png"+">";
String lang = gnomon.business.GeneralUtils.getLocale(request);

TreeViewDescription treeDesc = TopicsTreeBuilder.buildTopicsTree(PortalUtil.getCompanyId(request), selTopicId, lang, rssIcon, topicUrl, new String[]{"p_l_id"}, new String[]{""+plid}, null, "gn.permissions.topics.choose",request);
treeDesc.setDefaultExpandLevel(subTreeExpandLevel);
request.setAttribute("topics_tree_desc", treeDesc);

%>
<!-- 	http://ouc.gnomon.com.gr:8080/html/themes/coldstone/images/common/rss.png 
		http://ouc.gnomon.com.gr:8080/html/portlet/ext/js/tree/ThemeXP/folder1.gif
-->

<tiles:insert page="/html/portlet/ext/base/gnContentRss/topicTreeView.jsp" flush="true">
	<tiles:put name="attributeName" value="topics_tree_desc"/>
</tiles:insert>




<%}else{ %>
<liferay-ui:icon image="rss" url='<%= topicUrl+"?p_l_id=" + plid + "&topicId=" + selTopicId%>' target="_blank" />
<%=selectedTopicVr.getField1() %>

<%} %>

<%} else {%>
<%=LanguageUtil.get(pageContext, "please-configure-portlet") %>
<%} %>