<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="java.util.Vector" %>

<%@ page import="com.liferay.portlet.RenderRequestImpl" %>
<%@ page import="com.liferay.portlet.ActionRequestImpl" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.service.RoleLocalServiceUtil" %>
<%@ page import="com.liferay.portal.model.Role" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnContent" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.permissions.service.PermissionsService" %>
<%@ page import="com.ext.sql.StrutsFormFieldsGroupDelimiter" %>



<% try {

//Get all topics that we are allowed to get

String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");

	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();

	String formFieldName;
	String formFieldKey;
	boolean required;
	String formFieldType;
	String value = null;
	String fieldDateFormat="";
	boolean hidden;
	boolean readonly;
	String collectionName;
	String collectionAttrName;
	String collectionProperty;
	String collectionLabel;
	int field_size;
	int textAreaCols;
	int textAreaRows;
	int popupWidth;
	int popupHeight;
	String helpMessage = null;
	com.ext.sql.StrutsFormFields form_field;

	boolean textAreaHtmlFlag = false;
	String onChange = "";
	String lookupAction = "";
	boolean previous_fieldset = false;
	boolean secretField = false;

	form_field = (com.ext.sql.StrutsFormFields) request.getAttribute(namespace+"_STRUTS_DIV_FIELD");
	String curFormName = (String)request.getAttribute(namespace+"_STRUTS_DIV_curFormName");
	
	formFieldName = form_field.getFormFieldName();
	formFieldKey = form_field.getFormFieldKey();
	formFieldType = form_field.getFormFieldType();
	fieldDateFormat = form_field.getDateFormat();
	if (fieldDateFormat == null || fieldDateFormat.equals(""))
		fieldDateFormat = CommonDefs.DATE_FORMAT_JSCRIPT;
	hidden = form_field.isHidden();
	readonly = form_field.isReadonly();
	required = form_field.isRequired();
	collectionName=form_field.getCollectionName();
	collectionAttrName = form_field.getCollectionAttrName();
	collectionProperty=form_field.getCollectionProperty();
	collectionLabel=form_field.getCollectionLabel();
	field_size = form_field.getField_size();
	textAreaCols = form_field.getTextAreaCols();
	textAreaRows = form_field.getTextAreaRows();
	popupWidth = form_field.getPopupWidth();
	popupHeight = form_field.getPopupHeight();
	secretField = form_field.isSecretTextField();
	helpMessage = form_field.getHelpMessage();

  if (formFieldType.equals("browse_topics_many")) {
		if (hidden) { %>
			<html:hidden property="<%=formFieldName%>"/>
		<% } else { %>
			<div class="ctrl-holder">
			<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<html:hidden property="<%=formFieldName%>"/>
	     	<logic:notEmpty name="<%=curFormName%>" property="<%=formFieldName%>" >
		     	<bean:define name="<%=curFormName%>" property="<%=formFieldName%>" id="bean_Value"/>
		     	<%
		     	 value = (String) bean_Value;
		     	 //end auto topic selection
		     	 if (value != null)
		     	 {
		     	 	// value will contain comma separated list of ids
		     	 	GnPersistenceService serv = GnPersistenceService.getInstance(null);
		     	 	String[] topicIds = value.split(",");
		     	 	String[] topicNameField = {"langs.name"};
		     	 	String lang = gnomon.business.GeneralUtils.getLocale(request);
		     	 	String newValue = "";
		     	 	for (int v=0; v<topicIds.length; v++)
		     	 	{
		     	 		Integer topicId = Integer.valueOf(topicIds[v]);
		     	 		ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, topicId, lang, topicNameField);
		     	 		newValue += (String)topicView.getField1();
		     	 		if (v<topicIds.length-1)
		     	 			newValue += ", ";
		     	 	}
		     	 	value = newValue;
		     	 }
		     	%>
	     	</logic:notEmpty>
	     	<% if (!readonly) { %>
	     		<textarea title="<%=formFieldName%>" id="<%=formFieldName+"_Names"%>" readonly="true" name="<%=formFieldName+"_Names"%>"><%= (value!= null? value : "") %></textarea><% if (required) { %><em>*</em><% } %>
		    <% } else { %>
		    	<div> <%= (value!= null? value : "") %> </div>
		    <% } %>
	     	<%
	     		PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
				String portletId = null;
				PortletPreferences prefs = null;
				if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs= req.getPreferences();
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs = req.getPreferences();
				}
    	   	    String lang = gnomon.business.GeneralUtils.getLocale(request);
    	   	    String portletTopicIds = "";
    	   	    // check first if the current portlet instance has a topic-id set
    	   	    String portletResource = ParamUtil.getString(request, "portletResource");
				if (Validator.isNotNull(portletResource)) {
				    prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
				}
				String topicFoldersAreSelectable = GetterUtil.getString(prefs.getValue("topic-folders-are-selectable", "yes"));
				String portletInstanceTopicId = prefs.getValue("topic-id", StringPool.BLANK);
				if (Validator.isNotNull(portletInstanceTopicId) && !portletInstanceTopicId.equals("0"))
				{
					portletTopicIds = portletInstanceTopicId;
				}
				else // otherwise use the portlet topics set for this portlet
    	   	    {
	    	   		List<ViewResult> portletTopics = PermissionsService.getInstance().listPortletTopics(PortalUtil.getCompanyId(request),portletId, lang);
	    	   		for (int t=0; t<portletTopics.size(); t++)
	    	   		{
	    	   			portletTopicIds += ((ViewResult)portletTopics.get(t)).getField1();
	    	   			if (t<portletTopics.size()-1)
	    	   				portletTopicIds += ",";
	    	   		}
    	   		}
    	   	%>
    	   	<% if (!readonly) { %>
	     	<a href="#" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?managetopics=<%=managetopicids%>&multiSelection=true&openerFormName=<%=curFormName%>&openerFormFieldName=<%=formFieldName%>&rootTopicIds=<%=portletTopicIds%>&topicFoldersAreSelectable=<%=topicFoldersAreSelectable %>', <%= ""+popupWidth%>, <%= ""+popupHeight%>);"><img src="/html/themes/classic/images/arrows/02_plus.gif" alt="<%= LanguageUtil.get(pageContext,"gn.topics.browser.add") %>"></a>
	     	&nbsp;<a href="#" onClick="if (document.<%=curFormName%>.elements['<%= formFieldName %>'].value != null && document.<%=curFormName%>.elements['<%= formFieldName %>'].value != '') { openDialog('/html/portlet/ext/struts_includes/topics/deleteTopics.jsp?openerFormName=<%=curFormName%>&openerFormFieldName=<%=formFieldName%>&topicIds='+document.<%=curFormName%>.elements['<%= formFieldName %>'].value, <%= ""+popupWidth%>, <%= ""+popupHeight%>); } else { return true; } "><img src="/html/themes/classic/images/arrows/02_minus.gif" alt="<%= LanguageUtil.get(pageContext,"gn.topics.browser.delete") %>"></a>
	     	<% } %>
	     	<html:errors property="<%=formFieldName%>"/>
	     	</div>
   		<% }
   		}


   	//---------------------------------------------------
	// Browse Topics (single selection)
	//---------------------------------------------------
	if (formFieldType.equals("browse_topics_one")) {
		if (hidden) { %>
			<html:hidden property="<%=formFieldName%>"/>
		<% } else { %>
			<div class="ctrl-holder">
			<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<html:hidden property="<%=formFieldName%>"/>
	     	<logic:notEmpty name="<%=curFormName%>" property="<%=formFieldName%>" >
		     	<bean:define name="<%=curFormName%>" property="<%=formFieldName%>" id="bean_Value"/>
		     	<%
		     	 value = (String) bean_Value;
		     	 if (value != null)
		     	 {
		     	 	// value will be topicid
		     	 	GnPersistenceService serv = GnPersistenceService.getInstance(null);
		     	 	String[] topicNameField = {"langs.name"};
		     	 	String lang = gnomon.business.GeneralUtils.getLocale(request);
		     	 	String newValue = "";
		     	 	Integer topicId = Integer.valueOf(value);
		     	 	ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, topicId, lang, topicNameField);
		     	 	newValue = ((topicView==null || topicView.getField1()==null)? "" : (String)topicView.getField1());
		     	 	value = newValue;
		     	 }
		     	%>
	     	</logic:notEmpty>
	     	<input alt="<%=formFieldName%>" title="<%=formFieldName%>" type="text" id="<%=formFieldName+"_Names"%>" readonly="true" name="<%=formFieldName+"_Names"%>" value="<%= (value!= null? value : "") %>"><% if (required) { %><em>*</em><% } %>&nbsp;
	     	<%
	     		PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
				String portletId = null;
				PortletPreferences prefs = null;
				if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs= req.getPreferences();
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs = req.getPreferences();
				}
    	   	    String lang = gnomon.business.GeneralUtils.getLocale(request);
    	   	    String portletTopicIds = "";
    	   	    // check first if the current portlet instance has a topic-id set
    	   	    String portletResource = ParamUtil.getString(request, "portletResource");
				if (Validator.isNotNull(portletResource)) {
				    prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
				}
				String topicFoldersAreSelectable = GetterUtil.getString(prefs.getValue("topic-folders-are-selectable", "yes"));
				String portletInstanceTopicId = prefs.getValue("topic-id", StringPool.BLANK);
				if (portletInstanceTopicId != null && !portletInstanceTopicId.equals(""))
				{
					portletTopicIds = portletInstanceTopicId;
				}
				else // otherwise use the portlet topics set for this portlet
    	   	    {
	    	   		List<ViewResult> portletTopics = PermissionsService.getInstance().listPortletTopics(PortalUtil.getCompanyId(request), portletId, lang);
	    	   		for (int t=0; t<portletTopics.size(); t++)
	    	   		{
	    	   			portletTopicIds += ((ViewResult)portletTopics.get(t)).getField1();
	    	   			if (t<portletTopics.size()-1)
	    	   				portletTopicIds += ",";
	    	   		}
    	   		}
    	   	%>
    	   	<% if (!readonly) { %>
	     	<a href="#" class="beta1" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?managetopics=<%=managetopicids%>&multiSelection=false&openerFormName=<%=curFormName%>&openerFormFieldName=<%=formFieldName%>&rootTopicIds=<%=portletTopicIds%>&topicFoldersAreSelectable=<%=topicFoldersAreSelectable %>', <%= ""+popupWidth%>, <%= ""+popupHeight%>);"><%= LanguageUtil.get(pageContext,"gn.button.choose") %></a>
	     	&nbsp;<a href="#" class="beta1" onClick="document.<%=curFormName%>.elements['<%= formFieldName %>'].value='';document.<%=curFormName%>.elements['<%= formFieldName +"_Names"%>'].value='';"><%= LanguageUtil.get(pageContext,"gn.button.clear") %></a>
	     	<% } %>
	     	<html:errors property="<%=formFieldName%>"/>
	     	</div>
   		<% }
   		}
	
} catch (Exception e) { e.printStackTrace(); } %>
