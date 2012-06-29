<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.ext.portal.context.PortalContext" %>
<%@ page import="com.ext.portal.context.PortalContextRequestUtil" %>
<%@ page import="com.ext.portlet.topics.service.TopicsService" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<%
String lang = GeneralUtils.getLocale(request);
Long companyId = PortalUtil.getCompanyId(request);

PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

String instanceDepartmentId = GetterUtil.getString(prefs.getValue("departmentId", StringPool.BLANK), "");
HashSet<Integer> allowedTopicIds = new HashSet<Integer>();
if (Validator.isNotNull(instanceDepartmentId)) {
	// find the "allowed" topicids 
	List<GnTopic> relatedTopics = GnPersistenceService.getInstance(null).listObjects(PortalUtil.getCompanyId(request), 
			GnTopic.class, " table1.mainid in (select distinct pt.gnTopic.mainid from gnomon.hibernate.model.parties.PaPartyTopic pt " + 
					" where pt.paParty.mainid = "+instanceDepartmentId+" )");
	if (relatedTopics != null)
	{
		for (GnTopic t: relatedTopics)
		{
			allowedTopicIds.add(t.getMainid());
			String[] allParents = t.getAllParents().split(",");
			if (allParents != null)
			{
				for (String p: allParents)
				{
					if (Validator.isNumber(p))
					{
						allowedTopicIds.add(Integer.valueOf(p));
					}
				}
			}
		}
	}
}

String instancePortletListStyle = ParamUtil.getString(request,"listStyle",prefs.getValue("list-style", StringPool.BLANK));
boolean instanceIsSecondary = GetterUtil.getBoolean(prefs.getValue("is-secondary", StringPool.BLANK),false);
int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
long rootPlid = GetterUtil.getLong(prefs.getValue("portlet-setup-link-to-plid", StringPool.BLANK));
TopicsService srv = TopicsService.getInstance();



ViewResult globalRootTopicView = null;
ViewResult instanceTopicView = null;
if (instanceTopicId>0) {
	instanceTopicView = srv.getTopic(instanceTopicId+"", lang);
} else {
	String[] fields1 = new String[]{"table1.mainid", "langs.name", "langs.description", "table1.allParents", "table1.orderIndex, langs.name"};
	List<ViewResult> rootTopics = srv.getRootTopics(companyId, lang, fields1, "table1.orderIndex");
	if (rootTopics!=null && rootTopics.size()>0) {
		globalRootTopicView = rootTopics.get(0);
		instanceTopicView = rootTopics.get(0);
	}
}


//topic driven portlet, so read topic context
PortalContext portalContext = PortalContextRequestUtil.getPortalContext(request); 

ViewResult primaryTopicView = (ViewResult) portalContext.getEntry(PortalContext.PRIMARY_TOPIC_VIEW);
ViewResult selTopicView = (ViewResult) portalContext.getEntry(
		instanceIsSecondary? PortalContext.SECONDARY_TOPIC_VIEW: PortalContext.PRIMARY_TOPIC_VIEW);
String selTopicId = (String) portalContext.getEntry(
		instanceIsSecondary? PortalContext.SECONDARY_TOPIC_ID: PortalContext.PRIMARY_TOPIC_ID);

//return all the parents of the selected topic (useful to keep selected nav item open)
String selAllParents = (selTopicView==null || selTopicView.getField4()==null)?
		"" : selTopicView.getField4().toString();
		



	
		
		
%>