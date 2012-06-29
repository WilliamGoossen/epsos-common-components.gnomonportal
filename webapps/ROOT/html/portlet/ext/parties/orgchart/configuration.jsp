<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));

String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");


String showTopicOnlyInSystemCompany = GetterUtil.getString(prefs.getValue("show-topic-only-in-system-company", "no"));
String topicFoldersAreSelectable = GetterUtil.getString(prefs.getValue("topic-folders-are-selectable", "yes"));
//String topicFieldName = GetterUtil.getString(prefs.getValue("topic-field-name", "TopicFieldName"));
String multySelectTopic = GetterUtil.getString(prefs.getValue("multy-select-topic", "browse_topics_one"));
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">

	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "parties.orgchart.config.orgChartTopic") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
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
   	   	    String portletTopicIds = "";
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
		</td>
	</tr>


	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "parties.orgchart.config.multySelectTopic") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<select name="<portlet:namespace />multy-select-topic">
				<option <%= (multySelectTopic.equals("browse_topics_one")) ? "selected" : "" %> value="browse_topics_one"><%= LanguageUtil.get(pageContext, "browse_topics_one") %></option>
				<option <%= (multySelectTopic.equals("browse_topics_many")) ? "selected" : "" %> value="browse_topics_many"><%= LanguageUtil.get(pageContext, "browse_topics_many") %></option>
				
			</select>
		</td>
	</tr>

	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "parties.orgchart.config.showTopicOnlyInSystemCompany") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<select name="<portlet:namespace />show-topic-only-in-system-company">
				<option <%= (showTopicOnlyInSystemCompany.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "no") %></option>
				<option <%= (showTopicOnlyInSystemCompany.equals("yes")) ? "selected" : "" %> value="yes"><%= LanguageUtil.get(pageContext, "yes") %></option>
				
			</select>
		</td>
		</tr>
	
	<tr>
			<td>
			<%= LanguageUtil.get(pageContext, "parties.orgchart.config.topicFoldersAreSelectable") %>
		</td>
		<td style="padding-left: 10px;"></td>
	<td>
			<select name="<portlet:namespace />topic-folders-are-selectable">
				<option <%= (topicFoldersAreSelectable.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "no") %></option>
				<option <%= (topicFoldersAreSelectable.equals("yes")) ? "selected" : "" %> value="yes"><%= LanguageUtil.get(pageContext, "yes") %></option>
				
			</select>
		</td>
		</tr>
	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>