<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.parties.PaOrganization" %>

<table>
<tr>
<td valign="top" width="30%">
<%
String chartid = (String) request.getParameter("chartid");
String parentid = (String) request.getParameter("parentid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top" rowspan="2">
<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.update-person") %></h3>

<%
// Get preferences for the topic field
PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
    prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}
boolean showTopicOnlyInSysComp = false;
PaOrganization currOrgObj = (PaOrganization)GnPersistenceService.getInstance(null).getObject(PaOrganization.class, new Integer(chartid));
// Check if the curr org chart is system company
boolean isSystemCompany = (currOrgObj.getPortalCompanyId() != null);

int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
String prefShowTopicOnlyIsSysComp = prefs.getValue("show-topic-only-in-system-company", "no");

showTopicOnlyInSysComp = (prefShowTopicOnlyIsSysComp != null && prefShowTopicOnlyIsSysComp.equals("yes"));
boolean showTopicField = (instanceTopicId > 0) && (isSystemCompany || !showTopicOnlyInSysComp);
//String topicFieldName = prefs.getValue("topic-field-name", "TopicFieldName");
String multySelectTopic = prefs.getValue("multy-select-topic", "browse_topics_one");

StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="PersonForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("nameid","nameid","text",true));
fields.addElement(new StrutsFormFields("langid","langid","text",true));
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("prefix","parties.manager.person.prefix","text",false);
fields.addElement(new_field);
new_field = new StrutsFormFields("firstName","parties.manager.person.firstname","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("familyName","parties.manager.person.familyname","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("gender","parties.manager.person.gender","select",false);
new_field.setCollectionProperty("genders");
new_field.setCollectionLabel("genderKeys");
fields.addElement(new_field);

if (showTopicField){
	new_field = new StrutsFormFields("occupationTopicIds","parties.manager.person.occupation", multySelectTopic,false);
	fields.addElement(new_field);
}

new_field = new StrutsFormFields("userId","parties.manager.person.userid","select",false);
new_field.setCollectionProperty("userIds");
new_field.setCollectionLabel("userLabels");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<bean:define id="mainid" name="PersonForm" property="mainid"/>
<bean:define id="labels" name="PersonForm" property="genderKeys"/>

<html:form action="/ext/parties/orgchart/updatePerson?actionURL=true" method="post">

<%
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=mainid%>">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit>
<br><br>
<!-- addresses selection and button -->
<script language="JavaScript">
function <portlet:namespace/>chooseAddressTypeAction()
{
	var languageKey = "TYPESELECTIONKEYHERE";
	var selectedOption = document.PersonForm.typeList.options[document.PersonForm.typeList.selectedIndex].value;
	var actionString = '<portlet:renderURL><portlet:param name="struts_action" value="/ext/parties/orgchart/listTYPESELECTIONKEYHERE" /><portlet:param name="partyid" value="<%= mainid.toString() %>"/><portlet:param name="listaction" value="TYPESELECTIONKEYHERE"/></portlet:renderURL>';
	// need to do 2 replacements
	actionString = actionString.replace(languageKey, selectedOption);
	actionString = actionString.replace(languageKey, selectedOption);
	document.PersonForm.action = actionString;
	document.PersonForm.submit();
}
</script>

<input type="button" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "parties.button.addresses") %>" onClick="<portlet:namespace/>chooseAddressTypeAction();"/>

<select name="typeList" class="gamma1-FormArea">
<option name="email" value="EmailAddresses" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.addresses.email") %></option>
<option name="webpage" value="WebpageAddresses" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.addresses.webpage") %></option>
<option name="geographical" value="GeographicAddresses" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.addresses.geographic") %></option>
<option name="telecom" value="TelecomAddresses" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.addresses.telecom") %></option>
</select><br><br>
<hr>

</html:form>


<table border=0><tr><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listPartyIdentifiers" />
  <tiles:put name="buttonName" value="listPartyIdentifiersButton" />
  <tiles:put name="buttonValue" value="parties.button.identifiers" />
  <tiles:put name="formName"   value="PersonForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td>

<bean:define id="personUserId" name="PersonForm" property="userId"/>



<% // in the case of a corresponding liferay user, also offer a link to the user account profile
if (personUserId != null && !personUserId.equals("")) { %>
<td>
<% if (Long.valueOf(personUserId.toString()).equals(user.getUserId())) {
// if it is about the current user, then use the my_account portlet
PortletURL goToMyAccountURL = new com.liferay.portlet.PortletURLImpl(request, "2", plid, false);
goToMyAccountURL.setWindowState(WindowState.MAXIMIZED);
goToMyAccountURL.setPortletMode(PortletMode.VIEW);
goToMyAccountURL.setParameter("struts_action", "/my_account/edit_profile");
%>
<form name="liferay_user_profile_form" action=action="<%= goToMyAccountURL.toString() %>"  method="post">
   <%--
   <liferay-portlet:renderURL portletName='2' windowState='maximized'>
		<liferay-portlet:param name='struts_action' value='/my_account/edit_profile' />
	</liferay-portlet:renderURL>
	--%>
	<%
	com.liferay.portal.model.User personUser = com.liferay.portal.service.UserLocalServiceUtil.getUserById(Long.valueOf(personUserId.toString()));
	String personUserEmailAddress = personUser.getEmailAddress();
	%>
	<input type="hidden" name="p_u_e_a" value="<%= personUserEmailAddress %>">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "parties.button.liferay-account") %>">
</form>
<% } else {
// else use the admin portlet (which will only work for users with admin role)
PortletURL goToMyAccountURL = new com.liferay.portlet.PortletURLImpl(request, "9", plid, false);
goToMyAccountURL.setWindowState(WindowState.MAXIMIZED);
goToMyAccountURL.setPortletMode(PortletMode.VIEW);
goToMyAccountURL.setParameter("struts_action", "/admin/edit_user_profile");
%>
<form name="liferay_user_profile_form" action="<%= goToMyAccountURL.toString() %>" method="post">
    <%--<liferay:renderURL portletName='9' windowState='maximized'>
		<liferay:param name='struts_action' value='/admin/edit_user_profile' />
	</liferay:renderURL>--%>
	<%
	com.liferay.portal.model.User personUser = com.liferay.portal.service.UserLocalServiceUtil.getUserById(Long.valueOf(personUserId.toString()));
	String personUserEmailAddress = personUser.getEmailAddress();
	%>
	<input type="hidden" name="p_u_e_a" value="<%= personUserEmailAddress %>">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "parties.button.liferay-account") %>">
</form>
<% } %>
</td>
<% } %>

</tr>
</table>


</td>
</tr>
<tr>
<td valign="bottom">

<form name="OrgChart_Department_Employee_Button_Form" action="some/url" method="post">
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=mainid%>">
<input type="hidden" name="parentid" value="<%=parentid%>">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/removeEmployee" />
  <tiles:put name="buttonName" value="removeEmployeeButton" />
  <tiles:put name="buttonValue" value="parties.button.delete-employee" />
  <tiles:put name="confirm" value="parties.orgchart.delete-employee-are-you-sure"/>
  <tiles:put name="formName"   value="OrgChart_Department_Employee_Button_Form" />
  <tiles:put name="actionParam" value="delete"/>
  <tiles:put name="actionParamValue" value="true"/>
</tiles:insert>
</form>

</td>
</tr>
</table>

<br>
<hr>
<html:link styleClass="beta1" action="/ext/parties/orgchart/viewCharts"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.orgchart.back-to-orgcharts") %></html:link>

