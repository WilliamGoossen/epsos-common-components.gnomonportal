<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ include file="/html/portlet/ext/parties/contacts/util/currentURLcomplement.jspf" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>

<%@ page import="com.ext.portlet.parties.lucene.PartiesLuceneUtilities" %>
<%@ page import="com.ext.portlet.parties.contacts.highroles.*" %>

<%
String rootID = request.getParameter("rootID");
if (Validator.isNull(rootID))
	rootID = (String)request.getAttribute("rootID");
if (Validator.isNull(rootID))
	rootID= "";

String selectedID = request.getParameter("selectedID");
if (Validator.isNull(selectedID))
	selectedID = (String)request.getAttribute("selectedID");
if (Validator.isNull(selectedID))
	selectedID = "";

PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}
boolean eshopCustomers = GetterUtil.getBoolean(prefs.getValue("eshopCustomers", StringPool.BLANK), false);
boolean crmEnabled = GetterUtil.getBoolean(prefs.getValue("crmEnabled", StringPool.BLANK), false);
boolean onlyCurrentOrgchart = GetterUtil.getBoolean(prefs.getValue("onlyCurrentOrgchart", StringPool.BLANK), false);
boolean onlyHighRoles = GetterUtil.getBoolean(prefs.getValue("onlyHighRoles", StringPool.BLANK), false);
List<HighRoleDefinition> highRoles = null;

if (onlyHighRoles) {
	highRoles = HighRoleService.getInstance().getOrgChartRoleDefinitions(PortalUtil.getCompanyId(request));
}

// Check if the user has permission for the admin action for the portlet  
boolean partyAdminAction = PermissionUtil.userHasPartyRoleTypeAction(user, "admin", portletID);
%>
<br>
<script language="JavaScript">
var contact_search_tabs = new Array("tab0", "tab1");

function showTab(tabNumber)
{
  var i = 0;
  for ( i=0; i<contact_search_tabs.length; i++) {
      var tabName = contact_search_tabs[i];
      if (tabName==tabNumber)
      {
         document.getElementById(tabName).style.display='inline';
      }
      else
      {
         document.getElementById(tabName).style.display='none';
      }
  }
}


function <portlet:namespace/>forwardToSelection()
{
	var selection = document.PA_CONTACTS_ORGCHART_ADD_FORM.elements["orgChartLoadaction"].value;
	if (selection != null && selection == 'addPerson')
	{
		document.PA_CONTACTS_ORGCHART_ADD_FORM.action = '<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/orgchartSearchToAdd"/><portlet:param name="partyType" value="<%= PartiesLuceneUtilities.PARTY_TYPE_PERSON %>"/></portlet:actionURL>';
	}
	else if (selection != null && selection == 'addDepartment')
	{
		document.PA_CONTACTS_ORGCHART_ADD_FORM.action = '<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/orgchartSearchToAdd"/><portlet:param name="partyType" value="<%= PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION %>"/></portlet:actionURL>';
	}
	else if (selection != null && selection == 'addNewPerson')
	{
		document.PA_CONTACTS_ORGCHART_ADD_FORM.action = '<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/orgchartLoadNewToAdd"/><portlet:param name="partyType" value="<%= PartiesLuceneUtilities.PARTY_TYPE_PERSON %>"/><portlet:param name="addToOrgChart" value="true"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>';
	}
	else if (selection != null && selection == 'addNewDepartment')
	{
		document.PA_CONTACTS_ORGCHART_ADD_FORM.action = '<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/orgchartLoadNewToAdd"/><portlet:param name="partyType" value="<%= PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION %>"/><portlet:param name="addToOrgChart" value="true"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>';
	}
	else if (selection != null && selection.indexOf('highRole_') == 0)
	{
		document.PA_CONTACTS_ORGCHART_ADD_FORM.action = '<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/orgchartLoadNewToAdd"/><portlet:param name="partyType" value="<%= PartiesLuceneUtilities.PARTY_TYPE_PERSON %>"/><portlet:param name="highRoleId" value="REPLACEWITHCHOSENROLEIDHERE"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>';
		var high_role_id = selection.substr(9);
		document.PA_CONTACTS_ORGCHART_ADD_FORM.action = document.PA_CONTACTS_ORGCHART_ADD_FORM.action.replace('REPLACEWITHCHOSENROLEIDHERE', high_role_id);
	}
	submitForm(document.PA_CONTACTS_ORGCHART_ADD_FORM);
}
</script>

<%
String showMoreFields = (String)request.getAttribute("showMoreFields");
boolean showFields = false;
if (showMoreFields != null && showMoreFields.equals("true"))
	showFields = true;
%>

<liferay-ui:error key="crm.message.send.error" message="crm.message.send.error"/>




<tiles:insert page="/html/portlet/ext/parties/contacts/orgchart/orgchartTile.jsp" flush="true">
	<tiles:put name="rootID"><%= rootID %></tiles:put>
	<tiles:put name="selectedID"><%= selectedID %></tiles:put>
</tiles:insert>

<br>

<html:form action="/ext/parties/contacts/search?actionURL=true" method="post" styleClass="uni-form">
<input type="hidden" name="rootID" value="<%= rootID %>">
<input type="hidden" name="selectedID" value="<%= selectedID %>">
 
<bean:define id="labels" name="ContactSearchForm" property="contactTypeKeys"/>
<% 
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>
<input type="hidden" name="search" value="true">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="ContactSearchForm"/>
	<tiles:put name="attributeName" value="TOP_FIELDS"/>
</tiles:insert>

<div id="tab0" <% if (showFields) { %>style="display:none" <% } %>>
<div class="inline-labels" style="text-align:right">
<a href="#" onClick="showTab('tab1')"><%= LanguageUtil.get(pageContext, "advanced") %>&nbsp;&gt;&gt;</a>
</div>
</div>

<div id="tab1" <% if (!showFields) { %>style="display:none" <% } %>>
<div class="inline-labels">
<div class="ctrl-holder" style="text-align:right">
<a href="#" onClick="showTab('tab0')">&lt;&lt;&nbsp;<%= LanguageUtil.get(pageContext, "basic") %></a>
</div>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="ContactSearchForm"/>
	<tiles:put name="attributeName" value="BOTTOM_FIELDS"/>
</tiles:insert>
</div>
</div>

<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "contacts.button.search") %>">
</div>

</html:form>

<br/>

<% List itemsList = (List)request.getAttribute("itemsList");
  String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
%>

<% if (itemsList != null) {  %>
<display:table id="item" name="itemsList" requestURI="//ext/parties/contacts/search?actionURL=true" pagesize="20" sort="list" defaultsort="3" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">   
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("item"); %>

<display:column title="<%= htmlTitle %>" sortable="true">
<% if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_PERSON )) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/person.gif">
<%}else if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION)) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/department.gif">
<%} else { %>
	<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/group.gif">
<% } %> 	
</display:column>
<display:column titleKey="contacts.search.name" sortable="true" sortProperty="field1">
<a title="<%= partyItem.getField1().toString() %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/><portlet:param name="redirect" value="<%= currentURL2 %>"/></portlet:actionURL>">
<%= partyItem.getField1().toString() %>
</a>
</display:column>
<display:column property="field2" titleKey="contacts.search.email" sortable="true" />
<display:column property="field5" titleKey="contacts.search.phone" sortable="true" />
<display:column property="field10" titleKey="contacts.search.company" sortable="true" />

<display:column style="white-space:nowrap;">
<% if ((partyItem.getField7() != null && partyItem.getField7().equals("true")) || hasAdmin || partyAdminAction) { %>
<% if (hasEdit) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.button.edit") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/>
<portlet:param name="redirect" value="<%= currentURL2 %>"/></portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.edit") %>"></a>&nbsp;
<% } %>
<% if (hasDelete) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/>
<portlet:param name="redirect" value="<%= currentURL2 %>"/></portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>"></a>

<a title="<%= LanguageUtil.get(pageContext, "contacts.orgchart.delete-only-from-chart") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/orgchartDelete"/>
<portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="rootID" value="<%= rootID %>"/>
<liferay-portlet:param name="selectedID" value="<%= selectedID %>"/>
<portlet:param name="redirect" value="<%= redirect %>"/></portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "contacts.orgchart.delete-only-from-chart-are-you-sure") %>');">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/leave.png" alt="<%= LanguageUtil.get(pageContext, "contacts.orgchart.delete-only-from-chart") %>"></a>
<% } %>
<% if (hasAdmin && hasEdit && !eshopCustomers) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.button.roles") %>" href="<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/listPartyRoles"/><liferay-portlet:param name="partyid" value="<%= partyItem.getMainid().toString() %>"/><liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/></liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign_user_roles.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.roles") %>"></a>&nbsp;
<% } %>
<% if (hasAdmin 
		&& partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_PERSON )	
		&& Validator.isNull(partyItem.getField12())) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.manager.person.createuser") %>" 
href="<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/loadAddLiferayUser"/><liferay-portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/></liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign_user_permissions.png" alt="<%= LanguageUtil.get(pageContext, "parties.manager.person.createuser") %>"></a>&nbsp;
<% } %>
<% if (hasEdit && eshopCustomers) { %>
<a title="<%= LanguageUtil.get(pageContext, "ec.admin.orders") %>" href="<liferay-portlet:actionURL portletName="EC_ORDER_ADMIN" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/orders/admin/view"/><liferay-portlet:param name="partyid" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="tab" value="<%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_ORDERS %>"/>
<liferay-portlet:param name="search" value="true"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/pages.png" alt="<%= LanguageUtil.get(pageContext, "ec.admin.orders") %>"></a>&nbsp;
<% } %>
<% if (hasAdmin && !eshopCustomers && crmEnabled) { %>
<a title="<%= LanguageUtil.get(pageContext, "contacts.crm.assign-contact") %>" 
href="<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/listAssignments"/>
<liferay-portlet:param name="partyid" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign.png" alt="<%= LanguageUtil.get(pageContext, "contacts.crm.assign-contact") %>"></a>&nbsp;
<% } %>

<% } %>

<% if (hasEdit && !eshopCustomers && crmEnabled) { %>
<a title="<%= LanguageUtil.get(pageContext, "crm.task.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/tasks/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/Details.gif" alt="<%= LanguageUtil.get(pageContext, "crm.task.list") %>"></a>&nbsp;

<a title="<%= LanguageUtil.get(pageContext, "crm.message.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_MESSAGES" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/messages/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/email_users.gif" alt="<%= LanguageUtil.get(pageContext, "crm.mesage.list") %>"></a>&nbsp;

<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_MEETINGS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/admin_console.gif" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.list") %>"></a>&nbsp;

<a title="<%= LanguageUtil.get(pageContext, "crm.devicealert.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/mail/flagged.gif" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.list") %>"></a>&nbsp;


<a title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/listForCrmParty"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/preview.gif" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.list") %>"></a>&nbsp;

<% } %>
</display:column>
</display:table>
<% } // listItems%>

<br>
<% if ((hasAdd || hasAdmin) && !eshopCustomers) { %>

<form name="PA_CONTACTS_ORGCHART_ADD_FORM" method="post" action="/some/url">
<input type="hidden" name="rootID" value="<%= rootID %>">
<input type="hidden" name="selectedID" value="<%= selectedID %>">
<input type="hidden" name="redirect" value="<%= currentURL2 %>">
<table>
<tr>
<td><%= LanguageUtil.get(pageContext, "contacts.group.select-action") %>&nbsp;&nbsp;</td>
<td>
	<select name="orgChartLoadaction">
		<option value=""></option>
		<% if (!onlyCurrentOrgchart) { %>
		<option value="addPerson"><%= LanguageUtil.get(pageContext, "contacts.orgchart.add-person-from-existing-contacts") %></option>
		<% } %>
		<% if (onlyHighRoles && highRoles != null && highRoles.size() > 0) { 
				for (HighRoleDefinition hRole: highRoles) { %>
				<option value="highRole_<%= hRole.getId() %>"><%= LanguageUtil.get(pageContext, "contacts.orgchart.add-new-person") + " ("+LanguageUtil.get(pageContext, hRole.getLanguageKey())+")"%></option>
		<% 		}
			} else { %>
			<option value="addNewPerson"><%= LanguageUtil.get(pageContext, "contacts.orgchart.add-new-person") %></option>
		<% } %>
		<% if (!onlyCurrentOrgchart) { %>
		<option value="addDepartment"><%= LanguageUtil.get(pageContext, "contacts.orgchart.add-department-from-existing-contacts") %></option>
		<% } %>
		<option value="addNewDepartment"><%= LanguageUtil.get(pageContext, "contacts.orgchart.add-new-department") %></option>
	</select>&nbsp;&nbsp;
</td>
<td><input type="button" value="<%= LanguageUtil.get(pageContext, "contacts.group.execute-action") %>" onClick="return <portlet:namespace/>forwardToSelection();"></td>
</tr>
</table>
</form>

<% } %>  

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>