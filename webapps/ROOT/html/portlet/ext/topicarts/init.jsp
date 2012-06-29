<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.business.ViewResultUtil" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.ext.portal.context.PortalContext" %>
<%@ page import="com.ext.portal.context.PortalContextRequestUtil" %>
<%@ page import="com.ext.portlet.topics.service.TopicsService" %>
<%@ page import="com.ext.portlet.topicarts.other.*" %>
<%@ page import="com.ext.portlet.topicarts.service.*" %>


<%@ page import="com.liferay.portlet.journal.NoSuchArticleException" %>
<%@ page import="com.liferay.portlet.journal.action.EditArticleAction" %>
<%@ page import="com.liferay.portlet.journal.model.JournalArticle" %>
<%@ page import="com.liferay.portlet.journal.model.JournalArticleDisplay" %>
<%@ page import="com.liferay.portlet.journal.model.JournalTemplate" %>
<%@ page import="com.liferay.portlet.journal.model.impl.JournalArticleImpl" %>
<%@ page import="com.liferay.portlet.journal.search.ArticleSearch" %>
<%@ page import="com.liferay.portlet.journal.search.ArticleSearchTerms" %>
<%@ page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.journal.service.JournalTemplateLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.journal.service.permission.JournalArticlePermission" %>
<%@ page import="com.liferay.portlet.journal.util.JournalUtil" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.RuntimePortletUtil" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.ActionURLLogic" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.PortletLogic" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.RenderURLLogic" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.RuntimeLogic" %>

<%
//topic driven portlet, so read topic context
PortalContext portalContext = PortalContextRequestUtil.getPortalContext(request); 

ViewResult selTopicView = (ViewResult) portalContext.getEntry(PortalContext.PRIMARY_TOPIC_VIEW);
String selTopicId = (String) portalContext.getEntry(PortalContext.PRIMARY_TOPIC_ID);

ViewResult secTopicView = (ViewResult) portalContext.getEntry(PortalContext.SECONDARY_TOPIC_VIEW);
String secTopicId = (String) portalContext.getEntry(PortalContext.SECONDARY_TOPIC_ID);


//read other context variables
String lang = GeneralUtils.getLocale(request);
Long companyId = PortalUtil.getCompanyId(request);
%>

<%
PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

String instancePortletListStyle = ParamUtil.getString(request,"listStyle",prefs.getValue("list-style", StringPool.BLANK));
int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
TopicsService srv = TopicsService.getInstance();

ViewResult globalRootTopicView = null;
ViewResult instanceTopicView = null;
if (instanceTopicId>0) {
	instanceTopicView = srv.getTopic(instanceTopicId+"", lang);
} else {
	List<ViewResult> rootTopics = srv.getRootTopics(companyId, lang);
	if (rootTopics!=null && rootTopics.size()>0) {
		globalRootTopicView = rootTopics.get(0);
		instanceTopicView = rootTopics.get(0);
	}
}

int instanceRecentContentTopicId = GetterUtil.getInteger(prefs.getValue("recent-content-topic-id", StringPool.BLANK));
ViewResult instanceRecentContentTopicView = null;
if (instanceRecentContentTopicId>0) {
	instanceRecentContentTopicView = srv.getTopic(instanceRecentContentTopicId+"", lang);
} else {
	instanceRecentContentTopicView = instanceTopicView;
}
%>