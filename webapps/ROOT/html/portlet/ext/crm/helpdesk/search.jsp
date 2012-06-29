<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestSearchForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.OrganizationChartService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.model.parties.PaOrganization" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>



<%

Long companyId = PortalUtil.getCompanyId(request);
String lang = GeneralUtils.getLocale(request);
PartiesService partiesServ = PartiesService.getInstance();
PaPerson person = partiesServ.getPaPerson(user.getUserId());
PaOrganization organization = partiesServ.getPaOrganization(companyId);
boolean isInOrganizationChart = false;
if (person != null && organization != null)
{
	List rootOrgs = OrganizationChartService.getInstance().getParentRootOrganizations(person.getMainid(), lang);
	if (rootOrgs != null)
	{
		int i=0;
		while(!isInOrganizationChart && i<rootOrgs.size())
		{
			ViewResult orgView = (ViewResult)rootOrgs.get(i);
			if (orgView.getMainid().equals(organization.getMainid()))
				isInOrganizationChart = true;
			else
				i++;
		}
	}
}

StrutsFormFields new_field=null;
java.util.Vector<StrutsFormFields> fields=new java.util.Vector<StrutsFormFields>();
String curFormName="CrRequestSearchForm";
//if (CrmService.SHOW_REQUEST_TYPE) {
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) {
	new_field = new StrutsFormFields("reqProtocolNumber","crm.helpdesk.request.number","text",false,false);
	fields.addElement(new_field);
}
new_field = new StrutsFormFields("reqNumber","crm.helpdesk.request.mainid","text",false,false);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqSubject","crm.helpdesk.request.subject", "text",false,false);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDescription","crm.helpdesk.request.description", "text",false,false);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqUser","crm.helpdesk.request.userid", "text",false,false);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDateFrom","crm.helpdesk.request.date-from","date",false,false);
new_field.setDateFormat(com.ext.util.CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDateTo","crm.helpdesk.request.date-to","date",false,false);
new_field.setDateFormat(com.ext.util.CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
//if (CrmService.SHOW_REQUEST_TYPE) {
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) {
	new_field = new StrutsFormFields("reqType","crm.helpdesk.request.type","select",false,false);
	new_field.setCollectionProperty("reqTypes");
	new_field.setCollectionLabel("reqTypeKeys");
	fields.addElement(new_field);
}
if (isInOrganizationChart) {
	new_field = new StrutsFormFields("visibilityType","crm.helpdesk.request.visible","select",false,false);
	new_field.setCollectionProperty("visibilityTypes");
	new_field.setCollectionLabel("visibilityTypeKeys");
	fields.addElement(new_field);
}
if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-check-type"),false)) { 
	new_field = new StrutsFormFields("checkType","crm.helpdesk.checktype.name","select",false,false);
	new_field.setCollectionProperty("checkTypes");
	new_field.setCollectionLabel("checkTypeNames");
	fields.addElement(new_field);
}
new_field = new StrutsFormFields("status","crm.helpdesk.request.status","select",false,false);
new_field.setCollectionProperty("statusIds");
new_field.setCollectionLabel("statusKeys");
fields.addElement(new_field);

if (isInOrganizationChart) {
	new_field = new StrutsFormFields("reqCategory","crm.helpdesk.request.category","select",false,false);
	new_field.setCollectionProperty("reqCategories");
	new_field.setCollectionLabel("reqCategoryNames");
	fields.addElement(new_field);
	new_field = new StrutsFormFields("proPriority","crm.helpdesk.request.priority","select",false,false);
	new_field.setCollectionProperty("proPriorities");
	new_field.setCollectionLabel("proPriorityKeys");
	fields.addElement(new_field);
}

request.setAttribute("_vector_fields", fields);
%>

<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.search") %></h2>
<html:form action="/ext/crm/helpdesk/list?actionURL=true" method="post">
<bean:define id="labels1" name="CrRequestSearchForm" property="visibilityTypeKeys"/>
<bean:define id="labels2" name="CrRequestSearchForm" property="statusKeys"/>
<bean:define id="labels3" name="CrRequestSearchForm" property="proPriorityKeys"/>

<% 
// correct the list of keys for translations to be shown properly
String[] labelsList1 = (String[])labels1;
for (int i=0; i<labelsList1.length; i++)
{
 	labelsList1[i] = LanguageUtil.get(pageContext, labelsList1[i]);
}
String[] labelsList2 = (String[])labels2;
for (int i=0; i<labelsList2.length; i++)
{
 	labelsList2[i] = LanguageUtil.get(pageContext, labelsList2[i]);
}
String[] labelsList3 = (String[])labels3;
for (int i=0; i<labelsList3.length; i++)
{
 	labelsList3[i] = LanguageUtil.get(pageContext, labelsList3[i]);
}

%>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="search" value="search">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "crm.button.search") %></html:submit> 

</html:form>

<% if (hasEdit) { %>
<br>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/><portlet:param name="search" value="none"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.back-to-first-page") %></a>
<% } %>