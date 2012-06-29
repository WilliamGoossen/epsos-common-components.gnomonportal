<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.liferay.portal.service.UserLocalServiceUtil" %>
<%@ page import="javax.portlet.PortletURL" %>

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.update-person") %></h3>

<%
try{

StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="PersonForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("nameid","nameid","text",true));
fields.addElement(new StrutsFormFields("langid","langid","text",true));
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
fields.addElement(new StrutsFormFields("mainid","parties.persons.personPin","text",false, true));
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
new_field = new StrutsFormFields("userId","parties.manager.person.userid","select",false);
new_field.setCollectionProperty("userIds");
new_field.setCollectionLabel("userLabels");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/manager/updatePerson?actionURL=true" method="post">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>
<bean:define id="mainid" name="PersonForm" property="mainid"/>
<bean:define id="labels" name="PersonForm" property="genderKeys"/>

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


<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit>
<br><br>
<!-- addresses selection and button -->
<script language="JavaScript">
function <portlet:namespace/>chooseAddressTypeAction()
{
	var languageKey = "TYPESELECTIONKEYHERE";
	var selectedOption = document.PersonForm.typeList.options[document.PersonForm.typeList.selectedIndex].value;
	var actionString = '<portlet:renderURL><portlet:param name="struts_action" value="/ext/parties/manager/listTYPESELECTIONKEYHERE" /><portlet:param name="partyid" value="<%= mainid.toString() %>"/><portlet:param name="listaction" value="TYPESELECTIONKEYHERE"/></portlet:renderURL>';
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
</select><br><br><hr>
<table border=0><tr><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyIdentifiers" />
  <tiles:put name="buttonName" value="listPartyIdentifiersButton" />
  <tiles:put name="buttonValue" value="parties.button.identifiers" />
  <tiles:put name="formName"   value="PersonForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyRoles" />
  <tiles:put name="buttonName" value="listRolesButton" />
  <tiles:put name="buttonValue" value="parties.button.roles" />
  <tiles:put name="formName"   value="PersonForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyRels" />
  <tiles:put name="buttonName" value="listRelsButton" />
  <tiles:put name="buttonValue" value="parties.button.rels" />
  <tiles:put name="formName"   value="PersonForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyRelParties" />
  <tiles:put name="buttonName" value="listRelPartiesButton" />
  <tiles:put name="buttonValue" value="parties.button.relparties" />
  <tiles:put name="formName"   value="PersonForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td>
</html:form>

<bean:define id="personUserId" name="PersonForm" property="userId"/>
<% // in the case of a corresponding liferay user, also offer a link to the user account profile
if (personUserId != null && !personUserId.equals("")) { %>
<td>

<% if (Long.valueOf(personUserId.toString()).equals(user.getUserId())) {
// if it is about the current user, then use the my_account portlet

PortletURL goToMyAccountURL = new com.liferay.portlet.PortletURLImpl(request, "2", plid, false);
goToMyAccountURL.setWindowState(WindowState.MAXIMIZED);
goToMyAccountURL.setPortletMode(PortletMode.VIEW);
goToMyAccountURL.setParameter("struts_action", "/my_account/edit_user");
%>
<form name="liferay_user_profile_form" action="<%= goToMyAccountURL.toString() %>" method="post">
    <%-- <liferay-portlet:renderURL portletName='2' windowState='maximized'>
		<liferay-portlet:param name='struts_action' value='/my_account/edit_profile' />
	</liferay-portlet:renderURL>--%>
	<%
	com.liferay.portal.model.User personUser = UserLocalServiceUtil.getUserById(Long.valueOf(personUserId.toString()));
	String personUserEmailAddress = personUser.getEmailAddress();
	%>
	<input type="hidden" name="p_u_e_a" value="<%= personUserEmailAddress %>">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "parties.button.liferay-account") %>">
</form>
<% } else {
// else use the admin portlet (which will only work for users with admin role)

PortletURL goToMyAccountURL = new com.liferay.portlet.PortletURLImpl(request, PortletKeys.ENTERPRISE_ADMIN, plid, false);
goToMyAccountURL.setWindowState(WindowState.MAXIMIZED);
goToMyAccountURL.setPortletMode(PortletMode.VIEW);
goToMyAccountURL.setParameter("struts_action", "/enterprise_admin/edit_user");
goToMyAccountURL.setParameter("p_u_i_d", personUserId+"");

%>
<form name="liferay_user_profile_form" action="<%= goToMyAccountURL.toString() %>" method="post">
    <%--
    <liferay:renderURL portletName='9' windowState='maximized'>
		<liferay:param name='struts_action' value='/admin/edit_user_profile' />
	</liferay:renderURL>" method="post">
	--%>
	<%
	com.liferay.portal.model.User personUser = UserLocalServiceUtil.getUserById(Long.valueOf(personUserId.toString()));
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

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>

<%}catch(Exception ex){
	ex.printStackTrace(System.err);
}
%>