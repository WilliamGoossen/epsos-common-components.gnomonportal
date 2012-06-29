<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ include file="/html/portlet/ext/parties/contacts/util/currentURLcomplement.jspf" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}
boolean eshopCustomers = GetterUtil.getBoolean(prefs.getValue("eshopCustomers", StringPool.BLANK), false);
boolean crmEnabled = GetterUtil.getBoolean(prefs.getValue("crmEnabled", StringPool.BLANK), false);

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


function <portlet:namespace/>checkSelections()
{
	var buttonList = document.PA_CONTACTS_RESULTS_FORM.elements['contactid'];
	var buttonValue = "";
	if (!buttonList.length)  // just a single row, no list of buttons
	{
		buttonValue = buttonList.value;
	}
	else  // find which radio button or checkbox was checked and use its value
	{
		buttonValue = "";
		for(var i=0; i<buttonList.length; i++)
		{
			if (buttonList[i].checked)
			{
				if (buttonValue.length > 0)
				{
					buttonValue += ","
				}
				buttonValue += buttonList[i].value;
			}
		}
		if (buttonValue.length == 0){ // this means end of list was reached, no button was selected
			return false; // do nothing
		}
	}

	var listObj = document.PA_CONTACTS_RESULTS_FORM.elements['loadaction'];
	if (listObj.selectedIndex == 0)
		return false;

	return true;
}
</script>

<%
String showMoreFields = (String)request.getAttribute("showMoreFields");
boolean showFields = false;
if (showMoreFields != null && showMoreFields.equals("true"))
	showFields = true;
%>

<liferay-ui:error key="crm.message.send.error" message="crm.message.send.error"/>

<html:form action="/ext/parties/contacts/search?actionURL=true" method="post" styleClass="uni-form">
<bean:define id="labels" name="ContactSearchForm" property="contactTypeKeys"/>
<bean:define id="labels1" name="ContactSearchForm" property="activeContactKeys"/>
<% 
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}

String[] labels1List = (String[])labels1;
for (int i=0; i<labels1List.length; i++)
{
 	labels1List[i] = LanguageUtil.get(pageContext, labels1List[i]);
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
<tiles:insert page="/html/portlet/ext/parties/contacts/alphabetTile.jsp" flush="true"/>

<% List itemsList = (List)request.getAttribute("itemsList");
    
   
  String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
   %>

<form name="PA_CONTACTS_RESULTS_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/loadMassContacts"/></portlet:actionURL>" method="post">
<% if (itemsList != null) {  %>
<display:table id="item" name="itemsList" requestURI="//ext/parties/contacts/search?actionURL=true" pagesize="20" sort="list" defaultsort="3" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">   
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("item"); %>

<display:column>
<% if (hasEdit) { %>
<input type="checkbox" name="contactid" value="<%= partyItem.getMainid().toString() %>">
<% } %>
</display:column>

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

<%-- <display:column property="field3" titleKey="contacts.search.address" sortable="true" /> --%>
<%-- <display:column property="field4" titleKey="contacts.search.webpage" sortable="true" /> --%>
<%-- <display:column property="field6" titleKey="contacts.search.identifier" sortable="true" /> --%>
<%-- <display:column property="field7" titleKey="contacts.search.private" sortable="true" /> --%>
<%-- <display:column property="field8" titleKey="contacts.search.modified" sortable="true" /> --%>

<display:column style="white-space:nowrap;">
<% if ((partyItem.getField7() != null && partyItem.getField7().equals("true")) || hasAdmin || partyAdminAction) { %>
<% if (hasEdit) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.button.edit") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/><portlet:param name="redirect" value="<%= currentURL2 %>"/></portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.edit") %>"></a>&nbsp;
<% } %>
<% if (hasDelete) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/><portlet:param name="redirect" value="<%= currentURL2 %>"/></portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>"></a>
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
<% if (hasAdmin 
		&& partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION )	) { %>
<a title="<%= LanguageUtil.get(pageContext, "contacts.orgchart.view") %>" 
href="<liferay-portlet:actionURL ><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/search"/>
<liferay-portlet:param name="rootID" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="selectedID" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="search" value="true"/>
<liferay-portlet:param name="redirect" value="<%= currentURL2 %>"/></liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/orgchart.gif" alt="<%= LanguageUtil.get(pageContext, "contacts.orgchart.view") %>"></a>&nbsp;
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
<%--
<a title="<%= LanguageUtil.get(pageContext, "crm.task.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/tasks/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/Details.gif" alt="<%= LanguageUtil.get(pageContext, "crm.task.list") %>"></a>&nbsp;
--%>
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

<br>
<% if (hasAdd || hasAdmin) { %>
<% if (!eshopCustomers) { %>
<table>
<tr>
<td><%= LanguageUtil.get(pageContext, "contacts.group.select-action") %>&nbsp;&nbsp;</td>
<td>
	<select name="loadaction">
		<option value=""></option>
		<option value="massMembers"><%= LanguageUtil.get(pageContext, "contacts.group.select.mass-add-members") %></option>
		<option value="massDelete"><%= LanguageUtil.get(pageContext, "contacts.group.select.mass-delete") %></option>
		<option value="massEmail"><%= LanguageUtil.get(pageContext, "contacts.group.select.mass-email") %></option>
	</select>&nbsp;&nbsp;
</td>
<td><input type="submit" value="<%= LanguageUtil.get(pageContext, "contacts.group.execute-action") %>" onClick="return <portlet:namespace/>checkSelections();"></td>
</tr>

</table>
<% } %>
<% } %>  
<% } // listItems%>
<br>
<% if (hasAdd || hasAdmin) { %>
<fieldset class="button-holder">
<legend><%= LanguageUtil.get(pageContext, "gn.button.add") %></legend>

<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_user.png" alt="<%= LanguageUtil.get(pageContext, "parties.browser.addPerson") %>" title="<%= LanguageUtil.get(pageContext, "parties.browser.addPerson") %>">
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/parties/contacts/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="partyType" value="<%= com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_PERSON %>"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "parties.browser.addPerson") %></a>
<% if (!eshopCustomers) { %>
&nbsp;&nbsp;&nbsp;
<img src="<%= themeDisplay.getPathThemeImage() %>/common/join.png" alt="<%= LanguageUtil.get(pageContext, "parties.browser.addOrganization") %>" title="<%= LanguageUtil.get(pageContext, "parties.browser.addOrganization") %>">
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/parties/contacts/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="partyType" value="<%= com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION %>"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "parties.browser.addOrganization") %></a>

&nbsp;&nbsp;&nbsp;
<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/add_group.gif" alt="<%= LanguageUtil.get(pageContext, "contacts.group.new") %>" title="<%= LanguageUtil.get(pageContext, "contacts.group.new") %>">
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/parties/contacts/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="partyType" value="<%= com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_GROUP %>"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "contacts.group.new") %></a>

<%--
&nbsp;&nbsp;&nbsp;
<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_users.png" alt="<%= LanguageUtil.get(pageContext, "contacts.group.list") %>" title="<%= LanguageUtil.get(pageContext, "contacts.group.list") %>">
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/parties/contacts/listGroups"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "contacts.group.list") %></a>
--%>
<% } %>
</fieldset>
<% }  %>
</form>

<br>