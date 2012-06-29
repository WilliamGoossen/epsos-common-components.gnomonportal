<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.update-organization") %></h3>


<% try {
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="OrganizationForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("nameid","nameid","text",true));
fields.addElement(new StrutsFormFields("langid","langid","text",true));
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("name","parties.manager.organization.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("typeid","parties.manager.organization.typeid","select",false);
new_field.setCollectionProperty("typeIds");
new_field.setCollectionLabel("typeNames");
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("liferayCompany","parties.manager.organization.liferaycompany","boolean",false));
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/manager/updateOrganization?actionURL=true" method="post">
<bean:define id="mainid" name="OrganizationForm" property="mainid"/>

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
	var selectedOption = document.OrganizationForm.typeList.options[document.OrganizationForm.typeList.selectedIndex].value;
	var actionString = '<portlet:renderURL><portlet:param name="struts_action" value="/ext/parties/manager/listTYPESELECTIONKEYHERE" /><portlet:param name="partyid" value="<%= mainid.toString() %>"/><portlet:param name="listaction" value="TYPESELECTIONKEYHERE"/></portlet:renderURL>';
	// need to do 2 replacements
	actionString = actionString.replace(languageKey, selectedOption);
	actionString = actionString.replace(languageKey, selectedOption);
	document.OrganizationForm.action = actionString;
	document.OrganizationForm.submit();
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
  <tiles:put name="formName"   value="OrganizationForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyRoles" />
  <tiles:put name="buttonName" value="listRolesButton" />
  <tiles:put name="buttonValue" value="parties.button.roles" />
  <tiles:put name="formName"   value="OrganizationForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyRels" />
  <tiles:put name="buttonName" value="listRelsButton" />
  <tiles:put name="buttonValue" value="parties.button.rels" />
  <tiles:put name="formName"   value="OrganizationForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyRelParties" />
  <tiles:put name="buttonName" value="listRelPartiesButton" />
  <tiles:put name="buttonValue" value="parties.button.relparties" />
  <tiles:put name="formName"   value="OrganizationForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td></tr></table>
</html:form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE><% } catch (Exception e) {} %>