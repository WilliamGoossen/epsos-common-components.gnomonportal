<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
String instancePortletSearch = GetterUtil.getString(prefs.getValue("portlet-search", StringPool.BLANK));
String instancePortletBrowseType=GetterUtil.getString(prefs.getValue("browse-type", StringPool.BLANK));
String instancePortletListStyle = ParamUtil.getString(request,"listStyle",prefs.getValue("list-style", StringPool.BLANK));
String instancePortletTopicStyle = ParamUtil.getString(request,"topicStyle",prefs.getValue("topic-style", StringPool.BLANK));





String instancePortletShowRelContent = prefs.getValue("showRelContent", StringPool.BLANK);
String instancePortletShowRelContentDescription = prefs.getValue("showRelContentDescription", StringPool.BLANK);
com.ext.portlet.base.contentrel.ContentRelUtil relUtil = com.ext.portlet.base.contentrel.ContentRelUtil.getInstance();
String[] classNames = relUtil.getPortletClassNames();
String[] portletNames = relUtil.getPortletNames();



String instanceYearsStartYear = GetterUtil.getString(prefs.getValue("years_startYear", StringPool.BLANK));
boolean instanceYearsShowFuture = GetterUtil.getBoolean(prefs.getValue("years_showFuture", "true"), true);
boolean instanceYearsShowEmptyYears = GetterUtil.getBoolean(prefs.getValue("years_showEmptyYears", "true"), true);

boolean topicsOnOff = GetterUtil.getBoolean(prefs.getValue("topicsOnOff", "false"), false);
String topicFieldSetkey = GetterUtil.getString(prefs.getValue("topicFieldSetkey", StringPool.BLANK));

String instanceUseTopicNav = GetterUtil.getString(prefs.getValue("use-topic-nav", "no"));

boolean enableRatings = GetterUtil.getBoolean(prefs.getValue("enableRatings", StringPool.BLANK), false);  
boolean enableComments = GetterUtil.getBoolean(prefs.getValue("enableComments", StringPool.BLANK), false);  

String instanceEmbedMedia= GetterUtil.getString(prefs.getValue("embed_media", "no"));
String instanceRelEmbedMedia= GetterUtil.getString(prefs.getValue("embed_rel_media", "no"));

boolean showOnlyMine = GetterUtil.getBoolean(prefs.getValue("showOnlyMine", StringPool.BLANK), false);
boolean notifyPublisher = GetterUtil.getBoolean(prefs.getValue("notifyPublisher", StringPool.BLANK), false);

boolean crossPublishingEnabled = GetterUtil.getBoolean(prefs.getValue("crossPublishingEnabled", StringPool.BLANK), false);
boolean crossPublishingAuto = GetterUtil.getBoolean(prefs.getValue("crossPublishingAuto", StringPool.BLANK), false);
String crossPublishingTopics= GetterUtil.getString(prefs.getValue("crossPublishingTopics", ""));
%>