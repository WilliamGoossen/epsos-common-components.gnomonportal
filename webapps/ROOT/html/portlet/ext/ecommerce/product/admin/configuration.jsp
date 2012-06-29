<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>

<%
String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");
%>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">

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

	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>