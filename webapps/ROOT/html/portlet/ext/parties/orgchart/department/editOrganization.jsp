<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
try{
%>

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


<td width="70%" valign="top" rowspan=2>
<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.orgchart.form.update-department") %></h3>

<% 
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="OrganizationForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("nameid","nameid","text",true));
fields.addElement(new StrutsFormFields("langid","langid","text",true));
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("name","parties.orgchart.department.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("typeid","parties.orgchart.department.typeid","select",false);
new_field.setCollectionProperty("typeIds");
new_field.setCollectionLabel("typeNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<bean:define id="mainid" name="OrganizationForm" property="mainid"/>

<html:form action="/ext/parties/orgchart/updateOrganization?actionURL=true" method="post">
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=mainid%>">
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
	var actionString = '<portlet:renderURL><portlet:param name="struts_action" value="/ext/parties/orgchart/listTYPESELECTIONKEYHERE" /><portlet:param name="partyid" value="<%= mainid.toString() %>"/><portlet:param name="listaction" value="TYPESELECTIONKEYHERE"/></portlet:renderURL>';
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
</html:form>

<table border=0><tr><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listPartyIdentifiers" />
  <tiles:put name="buttonName" value="listPartyIdentifiersButton" />
  <tiles:put name="buttonValue" value="parties.button.identifiers" />
  <tiles:put name="formName"   value="OrganizationForm" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
</tiles:insert>
</td>
</tr></table>

</td>
</tr>
<tr>
<td valign="bottom">


<form name="OrgChart_Organization_Department_Button_Form" action="some/url" method="post">
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=mainid%>">
<input type="hidden" name="parentid" value="<%=parentid%>">

</form>

<table>
<tr><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listOrganizations" />
  <tiles:put name="buttonName" value="addDepartmentButton" />
  <tiles:put name="buttonValue" value="parties.button.add-department" />
  <tiles:put name="formName"   value="OrgChart_Organization_Department_Button_Form" />
</tiles:insert>
</td></tr><tr><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/removeOrganization" />
  <tiles:put name="buttonName" value="removeDepartmentButton" />
  <tiles:put name="buttonValue" value="parties.button.delete-department" />
  <tiles:put name="confirm" value="parties.orgchart.delete-department-are-you-sure"/>
  <tiles:put name="formName"   value="OrgChart_Organization_Department_Button_Form" />
  <tiles:put name="actionParam" value="delete"/>
  <tiles:put name="actionParamValue" value="true"/>
</tiles:insert>
</td></tr><tr><td>

<% if (gnomon.hibernate.OrganizationChartService.getInstance().userBelongsToLiferayCompany(request)) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listPersons" />
  <tiles:put name="buttonName" value="addEmployeeButton" />
  <tiles:put name="buttonValue" value="parties.button.add-employee" />
  <tiles:put name="formName"   value="OrgChart_Organization_Department_Button_Form" />
</tiles:insert>
<% } else { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadNewPerson" />
  <tiles:put name="buttonName" value="addEmployeeButton" />
  <tiles:put name="buttonValue" value="parties.button.add-employee" />
  <tiles:put name="formName"   value="OrgChart_Organization_Department_Button_Form" />
</tiles:insert>	
<% }	%>
</td></tr>

<%
	String setDepManagFlag = (String)request.getAttribute("ADD_DEPARTMENT_MANAGER");
	if (setDepManagFlag != null){
%>
<tr><td>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listPersons" />
  <tiles:put name="buttonName" value="SetDepartmentManagerButton" />
  <tiles:put name="buttonValue" value="parties.button.set-department-manager" />
  <tiles:put name="formName"   value="OrgChart_Organization_Department_Button_Form" />
  <tiles:put name="actionParam" value="ADD_DEPARTMENT_MANAGER"/>
  <tiles:put name="actionParamValue"><%= setDepManagFlag%></tiles:put>
</tiles:insert>
</td></tr>
<%}%>

</table>

</td>

</tr>
</table>

<br>
<hr>
<html:link styleClass="beta1" action="/ext/parties/orgchart/viewCharts"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.orgchart.back-to-orgcharts") %></html:link>

<%}catch(Exception ex){
	ex.printStackTrace();
}
%>
