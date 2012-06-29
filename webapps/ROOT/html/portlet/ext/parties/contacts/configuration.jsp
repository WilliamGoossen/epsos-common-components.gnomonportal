<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>
<%@ page import="gnomon.hibernate.model.parties.PsPartyRoleType" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.ext.portlet.parties.lucene.PartiesLuceneUtilities" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>
<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

String partyRoleIds = GetterUtil.getString(prefs.getValue("partyRoleId", StringPool.BLANK));
Vector<String> selectedRoles = new Vector<String>();
if (Validator.isNotNull(partyRoleIds)) {
	selectedRoles.addAll(Arrays.asList(partyRoleIds.split(",")));
}
String crmRoleIds = GetterUtil.getString(prefs.getValue("crmSupplierRoleId", StringPool.BLANK));
Vector<String> selectedCrmRoles = new Vector<String>();
if (Validator.isNotNull(crmRoleIds)) {
	selectedCrmRoles.addAll(Arrays.asList(crmRoleIds.split(",")));
}
boolean reduceFields = GetterUtil.getBoolean(prefs.getValue("reduceFields", StringPool.BLANK), false);
boolean showSimpleForm = GetterUtil.getBoolean(prefs.getValue("showSimpleForm", StringPool.BLANK), false);
boolean showMultiLingualForm = GetterUtil.getBoolean(prefs.getValue("showMultiLingualForm", StringPool.BLANK), false);
boolean eshopCustomers = GetterUtil.getBoolean(prefs.getValue("eshopCustomers", StringPool.BLANK), false);
boolean crmEnabled = GetterUtil.getBoolean(prefs.getValue("crmEnabled", StringPool.BLANK), false);
boolean onlyCurrentOrgchart = GetterUtil.getBoolean(prefs.getValue("onlyCurrentOrgchart", StringPool.BLANK), false);
boolean rootIsRoleRelated = GetterUtil.getBoolean(prefs.getValue("rootIsRoleRelated", StringPool.BLANK), false);
boolean onlyHighRoles = GetterUtil.getBoolean(prefs.getValue("onlyHighRoles", StringPool.BLANK), false);
boolean alwaysCreateLiferayUser = GetterUtil.getBoolean(prefs.getValue("alwaysCreateLiferayUser", StringPool.BLANK), false);

boolean showIdentifierAuthority = GetterUtil.getBoolean(prefs.getValue("showIdentifierAuthority", StringPool.BLANK), false);
boolean showImageUpload = GetterUtil.getBoolean(prefs.getValue("showImageUpload", StringPool.BLANK), false);
boolean showFileUpload = GetterUtil.getBoolean(prefs.getValue("showFileUpload", StringPool.BLANK), false);

List<ViewResult> partyRoleTypes = GnPersistenceService.getInstance(null).listObjectsWithLanguage(null, PsPartyRoleType.class, GeneralUtils.getLocale(request), new String[]{"langs.name"}, null, "langs.name");
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm" class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<div class="inline-labels">


	<fieldset class="inline-labels">
	<legend>General Settings</legend>
	
	<div class="ctrl-holder">
	<label>
		<%= LanguageUtil.get(pageContext, "contacts.search.reduce-fields") %>
	</label>

		<liferay-ui:input-checkbox param="reduceFields" defaultValue="<%= reduceFields %>" />
	</div>
	
	<div class="ctrl-holder">
	<label>
		<%= LanguageUtil.get(pageContext, "contacts.search.showSimpleForm") %>
	</label>

		<liferay-ui:input-checkbox param="showSimpleForm" defaultValue="<%= showSimpleForm %>" />
	</div>
	
	<div class="ctrl-holder">
	<label>
		<%= LanguageUtil.get(pageContext, "contacts.search.showMultiLingualForm") %>
	</label>

		<liferay-ui:input-checkbox param="showMultiLingualForm" defaultValue="<%= showMultiLingualForm %>" />
	</div>
	
	<div class="ctrl-holder">
	<label>
			<%= LanguageUtil.get(pageContext, "contacts.search.alwaysCreateLiferayUser") %>
			</label>
			<liferay-ui:input-checkbox param="alwaysCreateLiferayUser" defaultValue="<%= alwaysCreateLiferayUser %>" />
	</div>	
	
	<div class="ctrl-holder">
		<label>	<%= LanguageUtil.get(pageContext, "contacts.search.eshop-customers") %></label>
		<liferay-ui:input-checkbox param="eshopCustomers" defaultValue="<%= eshopCustomers %>" />
	</div>
	
	
	<div class="ctrl-holder">
		<label>	<%= LanguageUtil.get(pageContext, "contacts.search.showIdentifierAuthority") %></label>
		<liferay-ui:input-checkbox param="showIdentifierAuthority" defaultValue="<%= showIdentifierAuthority %>" />
	</div>
	
	
	<div class="ctrl-holder">
		<label>	<%= LanguageUtil.get(pageContext, "contacts.search.showImageUpload") %></label>
		<liferay-ui:input-checkbox param="showImageUpload" defaultValue="<%= showImageUpload %>" />
	</div>
	
	<div class="ctrl-holder">
		<label>	<%= LanguageUtil.get(pageContext, "contacts.search.showFileUpload") %></label>
		<liferay-ui:input-checkbox param="showFileUpload" defaultValue="<%= showFileUpload %>" />
	</div>
	</fieldset>
	
	
	<fieldset class="inline-labels">
	<legend>CRM Settings</legend>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "contacts.search.only-in-party-roles") %></label>
	<select name="<portlet:namespace />partyRoleId" size="6" multiple="true">
				<% if(partyRoleTypes == null || partyRoleTypes.size() == 0) { %>
				<option value="">*</option>
				<% } else { 
					for (int p=0; p<partyRoleTypes.size(); p++) {
						ViewResult roleView = partyRoleTypes.get(p);
					%>
					<option value="<%= roleView.getMainid().toString() %>"
						<% if (selectedRoles.contains(roleView.getMainid().toString())) { out.print("selected"); } %> >
						<%= roleView.getField1().toString() %>
					 </option>
					<% } 
				}%>
			</select>
	</div>
	
	<div class="ctrl-holder">
		<label><%= LanguageUtil.get(pageContext, "contacts.search.crm-enabled") %></label>
	<liferay-ui:input-checkbox param="crmEnabled" defaultValue="<%= crmEnabled %>" />
    <liferay-ui:icon-help message="contacts.search.crm-enabled-help"/>
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "contacts.search.crm-supplier-role") %></label>
	<select name="<portlet:namespace />crmSupplierRoleId" size="6" multiple="true">
				<% if(partyRoleTypes == null || partyRoleTypes.size() == 0) { %>
				<option value="">*</option>
				<% } else { 
					for (int p=0; p<partyRoleTypes.size(); p++) {
						ViewResult roleView = partyRoleTypes.get(p);
					%>
					<option value="<%= roleView.getMainid().toString() %>"
						<% if (selectedCrmRoles.contains(roleView.getMainid().toString())) { out.print("selected"); } %> >
						<%= roleView.getField1().toString() %>
					 </option>
					<% } 
				}%>
			</select>
			<liferay-ui:icon-help message="contacts.search.crm-supplier-role-help"/>
	</div>
	
	</fieldset>
	
	
	<fieldset class="inline-labels">
	<legend>Organization Chart Settings</legend>
	
	<div class="ctrl-holder">
	<label>		<%= LanguageUtil.get(pageContext, "contacts.search.onlyCurrentOrgchart") %> </label>
			<liferay-ui:input-checkbox param="onlyCurrentOrgchart" defaultValue="<%= onlyCurrentOrgchart %>" />
	</div>

	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "contacts.search.rootIsRoleRelated") %></label>
			<liferay-ui:input-checkbox param="rootIsRoleRelated" defaultValue="<%= rootIsRoleRelated %>" />
	</div>

	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "contacts.search.onlyHighRoles") %></label>
	<liferay-ui:input-checkbox param="onlyHighRoles" defaultValue="<%= onlyHighRoles %>" />
	</div>
	
	
	</fieldset>
	

	<fieldset class="inline-labels">
	<legend><%=LanguageUtil.get(pageContext, "parties.config.legend") %></legend>
	<%
	int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
	String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");
	String showTopicOnlyInSystemCompany = GetterUtil.getString(prefs.getValue("show-topic-only-in-system-company", "no"));
	String topicFoldersAreSelectable = GetterUtil.getString(prefs.getValue("topic-folders-are-selectable", "yes"));
	String multySelectTopic = GetterUtil.getString(prefs.getValue("multy-select-topic", "browse_topics_one"));
	String topicPartyType = GetterUtil.getString(prefs.getValue("topic-party-type", "all"));
	%>
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext,  "contacts.search.config.topics.party-type") %></label>
	<select name="<portlet:namespace/>topic-party-type">
		<option value="all" <%= ("all".equals(topicPartyType) ? "selected" :"") %>><%= LanguageUtil.get(pageContext, "contacts.search.config.topics.party-type.all") %></option>
		<option value="<%= PartiesLuceneUtilities.PARTY_TYPE_PERSON %>" <%= ( PartiesLuceneUtilities.PARTY_TYPE_PERSON.equals(topicPartyType) ? "selected" :"") %>><%= LanguageUtil.get(pageContext, "contacts.search.config.topics.party-type.person") %></option>
		<option value="<%= PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION %>" <%= ( PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION.equals(topicPartyType) ? "selected" :"") %>><%= LanguageUtil.get(pageContext, "contacts.search.config.topics.party-type.organization") %></option>
	</select>
	</div>
	
	
	
	<div class="ctrl-holder">
	<label>	<%= LanguageUtil.get(pageContext, "parties.orgchart.config.orgChartTopic") %> </label>
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
	</div>

	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "parties.orgchart.config.multySelectTopic") %></label>
			<select name="<portlet:namespace />multy-select-topic">
				<option <%= (multySelectTopic.equals("browse_topics_one")) ? "selected" : "" %> value="browse_topics_one"><%= LanguageUtil.get(pageContext, "browse_topics_one") %></option>
				<option <%= (multySelectTopic.equals("browse_topics_many")) ? "selected" : "" %> value="browse_topics_many"><%= LanguageUtil.get(pageContext, "browse_topics_many") %></option>
				
			</select>
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "parties.orgchart.config.topicFoldersAreSelectable") %></label>
			<select name="<portlet:namespace />topic-folders-are-selectable">
				<option <%= (topicFoldersAreSelectable.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "no") %></option>
				<option <%= (topicFoldersAreSelectable.equals("yes")) ? "selected" : "" %> value="yes"><%= LanguageUtil.get(pageContext, "yes") %></option>
			</select>
	</div>	
	</fieldset>
	</div>
	
	<div class="button-holder">
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>