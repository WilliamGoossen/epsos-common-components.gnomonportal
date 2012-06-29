<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ include file="/html/portlet/ext/parties/contacts/util/currentURLcomplement.jspf" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>

<%@ page import="com.ext.portlet.parties.lucene.PartiesLuceneUtilities" %>

<%
String rootID = request.getParameter("rootID");
String selectedID = request.getParameter("selectedID");
String partyType = request.getParameter("partyType");

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
</script>

<%
String showMoreFields = (String)request.getAttribute("showMoreFields");
boolean showFields = false;
if (showMoreFields != null && showMoreFields.equals("true"))
	showFields = true;
%>

<tiles:insert page="/html/portlet/ext/parties/contacts/orgchart/orgchartTile.jsp" flush="true">
	<tiles:put name="rootID"><%= rootID %></tiles:put>
	<tiles:put name="selectedID"><%= selectedID %></tiles:put>
</tiles:insert>

<br>
<h2>
<% if (partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON)) { %>
<%= LanguageUtil.get(pageContext, "contacts.orgchart.add-person-from-existing-contacts") %>
<% } else { %>
<%= LanguageUtil.get(pageContext, "contacts.orgchart.add-department-from-existing-contacts") %>
<% } %>
</h2>

<html:form action="/ext/parties/contacts/orgchartSearchToAdd?actionURL=true" method="post" styleClass="uni-form">
<input type="hidden" name="rootID" value="<%= rootID %>">
<input type="hidden" name="selectedID" value="<%= selectedID %>">
<input type="hidden" name="partyType" value="<%= partyType %>">
 
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
<fieldset class="inline-labels">
<legend><a href="#" onClick="showTab('tab1')"><%= LanguageUtil.get(pageContext, "contacts.button.more") %></a></legend>
</fieldset>
</div>

<div id="tab1" <% if (!showFields) { %>style="display:none" <% } %>>
<fieldset class="inline-labels">
<legend><a href="#" onClick="showTab('tab0')"><%= LanguageUtil.get(pageContext, "contacts.button.less") %></a></legend>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="ContactSearchForm"/>
	<tiles:put name="attributeName" value="BOTTOM_FIELDS"/>
</tiles:insert>
</fieldset>
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
<form name="PA_CONTACTS_ORGCHART_ADD_PERSON_FORM" method="post" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/orgchartAddExisting"/></portlet:actionURL>">
<input type="hidden" name="rootID" value="<%= rootID %>">
<input type="hidden" name="selectedID" value="<%= selectedID %>">
<input type="hidden" name="partyType" value="<%= partyType %>">

<display:table id="item" name="itemsList" requestURI="//ext/parties/contacts/search?actionURL=true" pagesize="20" sort="list" defaultsort="3" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">   
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("item"); %>

<display:column title="<%= htmlTitle %>" sortable="true" style="white-space:nowrap;">
<% if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_PERSON )) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/person.gif">
<%}else if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION)) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/department.gif">
<%} else { %>
	<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/group.gif">
<% } %> 	
<input type="checkbox" name="partyid" value="<%= partyItem.getMainid().toString() %>">
</display:column>
<display:column titleKey="contacts.search.name" sortable="true" sortProperty="field1">
<a title="<%= partyItem.getField1().toString() %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/><portlet:param name="redirect" value="<%= currentURL2 %>"/></portlet:actionURL>">
<%= partyItem.getField1().toString() %>
</a>
</display:column>
<display:column property="field2" titleKey="contacts.search.email" sortable="true" />
<display:column property="field5" titleKey="contacts.search.phone" sortable="true" />
<display:column property="field10" titleKey="contacts.search.company" sortable="true" />

</display:table>

<br>
<% if (partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON)) { %>
<span><%= LanguageUtil.get(pageContext, "parties.manager.relatedparty.role") %></span>&nbsp;
<select name="partyRoleTypeId">
<option value=""></option>
<% List<ViewResult> partyRoleTypes = (List)request.getAttribute("partyRoleTypes");
   for(ViewResult prt: partyRoleTypes) { %>
   <option value="<%= prt.getMainid().toString() %>"><%= prt.getField1().toString() %></option>
   <% } %>
</select>
<br>
<% } %>

<input type="submit" value="<%= LanguageUtil.get(pageContext, "gn.button.add") %>">

</form>
<% } // listItems%>

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>