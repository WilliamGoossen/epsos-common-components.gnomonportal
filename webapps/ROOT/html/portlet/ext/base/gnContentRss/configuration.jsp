<%@ include file="/html/portlet/init.jsp" %>


<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.ext.portlet.base.contentRss.ViewAction" %>



<%
String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");
//PortletPreferences prefs = renderRequest.getPreferences();

PortletPreferences prefs = PortletPreferencesFactoryUtil.getPortletSetup(
		request, ViewAction.PORTLET_GN_CONTENT_RSS, true, true);

String portletResource = ParamUtil.getString(request, "portletResource");

int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));

boolean showTopicSubTree = GetterUtil.getBoolean(prefs.getValue("showTopicSubTree", StringPool.BLANK), false);  
int subTreeExpandLevel = GetterUtil.getInteger(prefs.getValue("subTreeExpandLevel", ViewAction.DEFAULT_EXPAND_LEVEL));

String portletTopicIds = "";
%>
<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm" class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	
	<div class="inline-labels">
	

	<div class="ctrl-holder">
		<label>
			<%= LanguageUtil.get(pageContext, "bs_gnContentRss.config.topic") %>
		</label>			
		<input type="hidden" name="<portlet:namespace />topicId" value="<%=instanceTopicId%>">
			<%
			String topicName = "";
			GnPersistenceService serv = GnPersistenceService.getInstance(null);
     	 	String[] topicNameField = {"langs.name"};
     	 	String lang = gnomon.business.GeneralUtils.getLocale(request);
     	 	if (instanceTopicId>0) {
     	 		ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, new Integer(instanceTopicId), lang, topicNameField);
     	 		topicName = ((topicView==null || topicView.getField1()==null)? "<INVALID>" : (String)topicView.getField1());
     	 		//topicName = (String)topicView.getField1();
     	 	}
     	 	//PortletRequest portletRequest = (PortletRequest)request.getAttribute(WebKeys.JAVAX_PORTLET_REQUEST);
			String portletId = null;
			if (Validator.isNotNull(portletResource)) {
				portletId = portletResource;
			} else {
				if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					portletId = req.getPortletName();
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					portletId = req.getPortletName();
				}
			}
   	   	    
   	   		List<ViewResult> portletTopics = PermissionsService.getInstance().listPortletTopics(PortalUtil.getCompanyId(request),portletId, lang);
   	   		for (int t=0; t<portletTopics.size(); t++)
   	   		{
   	   			portletTopicIds += ((ViewResult)portletTopics.get(t)).getField1();
   	   			if (t<portletTopics.size()-1)
   	   				portletTopicIds += ",";
   	   		}
			%>
			<input type="text" readonly="true" name="<portlet:namespace />topicId_Names" value="<%= topicName %>"> &nbsp;
			<a href="#" class="beta1" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?managetopics=<%=managetopicids%>&multiSelection=false&openerFormName=<portlet:namespace />fm&openerFormFieldName=<portlet:namespace />topicId&rootTopicIds=<%=portletTopicIds%>', 400,350);"><%= LanguageUtil.get(pageContext,"gn.button.choose") %></a>
    			&nbsp;<a href="#" class="beta1" onClick="document.<portlet:namespace />fm.elements['<portlet:namespace />topicId'].value='';document.<portlet:namespace />fm.elements['<portlet:namespace />topicId_Names'].value='';"><%= LanguageUtil.get(pageContext,"gn.button.clear") %></a>
	</div>

	<div class="ctrl-holder">
	<label>
		<%= LanguageUtil.get(pageContext, "bs_gnContentRss.config.showTopicSubTree") %></label>
		<liferay-ui:input-checkbox param="showTopicSubTree" defaultValue="<%= showTopicSubTree%>" />
	</div>
	
	<div class="ctrl-holder">
	<label>
		<%= LanguageUtil.get(pageContext, "bs_gnContentRss.config.subTreeExpandLevel") %></label>
		<input type="text" name="<portlet:namespace />subTreeExpandLevel" value="<%= subTreeExpandLevel%>">
	</div>
	
	</div>
	
	<div class="button-holder">
		<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>