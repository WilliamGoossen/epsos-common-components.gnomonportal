<%@ include file="/html/portlet/ext/cms/search/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>

<%
boolean showTopics = false;
int instanceTopicId = 0;
PortletPreferences portletPrefs=null;
String instanceEmbedMedia= GetterUtil.getString(prefs.getValue("embed_media", "no"));
String portletResource = ParamUtil.getString(request, "portletResource");
if ( portletResource!=null && !portletResource.equals("") ) {
		 portletPrefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
		showTopics = GetterUtil.getBoolean(portletPrefs.getValue("show-topics", StringPool.BLANK), false);
		instanceTopicId = GetterUtil.getInteger(portletPrefs.getValue("topic-id", StringPool.BLANK));
		instanceEmbedMedia= GetterUtil.getString(portletPrefs.getValue("embed_media", "no"));
}		



//Get all topics that we are allowed to get

String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");

LayoutLister layoutLister = new LayoutLister();

String rootNodeName = StringPool.BLANK;
LayoutView layoutView = layoutLister.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName, locale);

List layoutList = layoutView.getList();
%>



<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">

<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "cms.search.show-topics") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="showTopics" defaultValue="<%= showTopics %>" />
	</td>
</tr>

	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "topic") %>
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
			<%= LanguageUtil.get(pageContext, "embed-related-audio-video-img") %>
		</td>
		<td style="padding-left: 10px;"></td>
		
			<td>
			<select name="<portlet:namespace />embed_media">
				<option <%= (instanceEmbedMedia.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "no") %></option>
				<option <%= (instanceEmbedMedia.equals("yes")) ? "selected" : "" %> value="yes"><%= LanguageUtil.get(pageContext, "yes") %></option>
				
			</select>
		</td>
		
	</tr>
	
	
		<%
		if(portletPrefs!=null) {
		for (int i=0; i<classNames1.length; i++) {
				String pName = portletNames1[i];
				String pClassName = classNames1[i];
			%>
			<tr align="center">
				<td align="center"><%= LanguageUtil.get(pageContext, "javax.portlet.title."+pName) %></td>
				
					<td>
						
								<% long rootPlid = GetterUtil.getLong(portletPrefs.getValue("show_rel_content_rootPlid_"+pClassName, StringPool.BLANK));%>
								
				<select name="<portlet:namespace />show_rel_content_rootPlid_<%= pClassName %>">
				<option <%= (rootPlid == -1) ? "selected" : "" %> value="-1">
					<%= "&nbsp;[&nbsp;" + LanguageUtil.get(pageContext, "root") + "&nbsp;]&nbsp"%>
				</option>

			<%
			for (int j = 0; j < layoutList.size(); j++) {

				// id | parentId | ls | obj id | name | img | depth

				String layoutDesc = (String)layoutList.get(j);

				String[] nodeValues = StringUtil.split(layoutDesc, "|");

				long objId = GetterUtil.getLong(nodeValues[3]);
				String layoutName = nodeValues[4];

				int depth = 0;

				if (j != 0) {
					depth = GetterUtil.getInteger(nodeValues[6]);
				}

				for (int k = 0; k < depth; k++) {
					layoutName = "-&nbsp;" + layoutName;
				}
			%>

				<option <%= (rootPlid == objId) ? "selected" : "" %> value="<%= objId %>">
					<%= objId!=0?layoutName: "&nbsp;[&nbsp" + LanguageUtil.get(pageContext, "current-page") + "&nbsp;]&nbsp"%>
				</option>

			<%
			}
			%>

		</select>
			
			
		</td>
				
				
				
			</tr>
			<%
		   } 
		   }
		%>
	
	
</table>
<br>
<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />numOfItems.focus();
</script>
