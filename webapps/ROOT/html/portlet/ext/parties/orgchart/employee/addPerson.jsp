<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.parties.PaOrganization" %>

<table>
<tr>
<td valign="top" width="30%">
<%
String chartid = (String) request.getParameter("chartid");
String partyid = (String) request.getParameter("partyid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top">
<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-person") %></h3>


<%
//Get preferences for the topic field
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
String topicFieldName = prefs.getValue("topic-field-name", "TopicFieldName");
String multySelectTopic = prefs.getValue("multy-select-topic", "browse_topics_one");

//--

StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="PersonAddForm";
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("prefix","parties.manager.person.prefix","text",false);
fields.addElement(new_field);
new_field = new StrutsFormFields("firstName","parties.manager.person.firstname","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("familyName","parties.manager.person.familyname","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
/*new_field = new StrutsFormFields("validFrom","parties.manager.person.validfrom","date",false);
new_field.setDateFormat("%d/%m/%Y");
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("validTo","parties.manager.person.validto","date",false);
new_field.setDateFormat("%d/%m/%Y");
new_field.setRequired(true);
fields.addElement(new_field);*/
new_field = new StrutsFormFields("gender","parties.manager.person.gender","select",false);
new_field.setCollectionProperty("genders");
new_field.setCollectionLabel("genderKeys");
fields.addElement(new_field);

if (showTopicField){
	new_field = new StrutsFormFields("occupationTopicIds",topicFieldName, multySelectTopic,false);
	fields.addElement(new_field);
}

new_field = new StrutsFormFields("userId","parties.manager.person.userid","select",false);
new_field.setCollectionProperty("userIds");
new_field.setCollectionLabel("userLabels");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);

String setDepartmentManager = request.getParameter("ADD_DEPARTMENT_MANAGER");

%>

<html:form action="/ext/parties/orgchart/addPerson?actionURL=true" method="post">
<bean:define id="labels" name="PersonAddForm" property="genderKeys"/>
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
<input type="hidden" name="partyid" value="<%=partyid%>">

<% if (setDepartmentManager != null) {%>
<input type="hidden" name="ADD_DEPARTMENT_MANAGER" value="<%=setDepartmentManager%>">
<%}%>

<br>

<hr>


<table>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.manager.person.createuser") %></b></span></td>
 <td><html:checkbox styleClass="gamma1-FormArea" property="createUser" onclick="return disableLiferayFields();"/></td>
 <td><html:errors property="createUser"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.manager.person.newuserid") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="screenName" /></td>
 <td><html:errors property="screenName"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.manager.person.password1") %></b></span></td>
 <td><html:password styleClass="gamma1-FormArea" property="password1" /></td>
 <td><html:errors property="password1"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.manager.person.password2") %></b></span></td>
 <td><html:password styleClass="gamma1-FormArea" property="password2" /></td>
 <td><html:errors property="password2"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.manager.person.emailaddress") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="emailAddress" /></td>
 <td><html:errors property="emailAddress"/></td> 
</tr>
</table>

<script language="JavaScript">
function disableLiferayFields()
{
	if (document.PersonAddForm.elements["createUser"].checked)
	{
		document.PersonAddForm.elements["screenName"].disabled = false;
		document.PersonAddForm.elements["password1"].disabled = false;
		document.PersonAddForm.elements["password2"].disabled = false;
		document.PersonAddForm.elements["emailAddress"].disabled = false;
		document.PersonAddForm.elements["userId"].disabled = true;
	}
	else
	{
		document.PersonAddForm.elements["screenName"].disabled = true;
		document.PersonAddForm.elements["password1"].disabled = true;
		document.PersonAddForm.elements["password2"].disabled = true;
		document.PersonAddForm.elements["emailAddress"].disabled = true;
		document.PersonAddForm.elements["userId"].disabled = false;
	}
	return true;
}

disableLiferayFields();
</script>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.add") %></html:submit> 
 
</html:form>

</td>
</tr>
</table>