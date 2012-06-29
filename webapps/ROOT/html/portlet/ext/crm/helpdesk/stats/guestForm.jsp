<%@ include file="/html/portlet/ext/crm/helpdesk/stats/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.sql.StrutsFormFieldsGroupDelimiter" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>

<bean:define id="status" name="CrRequestForm" property="status"/>
<bean:define id="crrequestid" name="CrRequestForm" property="mainid"/>
<%
try {
String formUrl = "/ext/crm/helpdeskStats/load?actionURL=true" ;
String buttonText = "crm.button.view";
String titleText = "crm.helpdesk.request.view";
boolean isAdd= false;

StrutsFormFields new_field=null;
java.util.Vector<StrutsFormFields> fields=new java.util.Vector<StrutsFormFields>();
String curFormName="CrRequestForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("reqProtocolNumber","reqProtocolNumber","text",true));
//if (CrmService.SHOW_REQUEST_TYPE) {
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) { 
	fields.addElement(new StrutsFormFieldsGroupDelimiter("basic", "crm.helpdesk.request.group.basic", "javascript", true));
	new_field = new StrutsFormFields("reqProtocolNumber","crm.helpdesk.request.protocolNumber","text",false,true);
	fields.addElement(new_field);
}
else
	fields.addElement(new StrutsFormFields("reqType","crm.helpdesk.request.type","text",true, true));	

new_field = new StrutsFormFields("reqNumber","crm.helpdesk.request.number","text",false,true);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqUserid","crm.helpdesk.request.userid","text",true,true);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqUserName","crm.helpdesk.request.userid","text",false,true);
fields.addElement(new_field);

new_field = new StrutsFormFields("reqDate","crm.helpdesk.request.date","date",false,true);
new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
//if (CrmService.SHOW_REQUEST_TYPE) {
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) {
	new_field = new StrutsFormFields("reqType","crm.helpdesk.request.type","select",false,!isAdd);
	new_field.setCollectionLabel("reqTypeKeys");
	new_field.setCollectionProperty("reqTypes");
	fields.addElement(new_field);
}
new_field = new StrutsFormFields("reqCategory","crm.helpdesk.request.category","select",false,!isAdd);
new_field.setCollectionLabel("reqCategoryNames");
new_field.setCollectionProperty("reqCategories");
fields.addElement(new_field);

if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-contact-info"),false)) {
	fields.addElement(new StrutsFormFieldsGroupDelimiter("contact", "crm.helpdesk.request.group.contact", "javascript", true));

	new_field = new StrutsFormFields("reqReplyBy","crm.helpdesk.request.replyby","select",false,!isAdd);
	new_field.setCollectionLabel("reqReplyByKeys");
	new_field.setCollectionProperty("reqReplyBys");
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqReplyTo","crm.helpdesk.request.replyto","text",false,!isAdd);
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqAlreadyContacted","crm.helpdesk.request.alreadycontacted","boolean",false,!isAdd);
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqAlreadyContactedWith","crm.helpdesk.request.alreadycontactedwith","text",false,!isAdd);
	fields.addElement(new_field);
}
new_field = new StrutsFormFields("reqNotifyProgress","crm.helpdesk.request.notifyprogress","boolean",false,!isAdd);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqNotifyFinish","crm.helpdesk.request.notifyfinish","boolean",false,!isAdd);
fields.addElement(new_field);

fields.addElement(new StrutsFormFieldsGroupDelimiter("info", "crm.helpdesk.request.group.info", "javascript", true));
new_field = new StrutsFormFields("reqSubject","crm.helpdesk.request.subject","text",false,!isAdd);
new_field.setRequired(true);
new_field.setField_size(70);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDescription","crm.helpdesk.request.description","textarea",false,!isAdd);
new_field.setField_size(70);
fields.addElement(new_field);
if (!isAdd) {
	new_field = new StrutsFormFields("proAssignedTo","crm.helpdesk.request.assignedto","select",false,true);
	new_field.setCollectionLabel("officerNames");
	new_field.setCollectionProperty("officerIds");
	fields.addElement(new_field);
	new_field = new StrutsFormFields("proExpectedResDate","crm.helpdesk.request.expectedresdate","date",false,true);
	new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
	fields.addElement(new_field);
	if (PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT)) {
		new_field = new StrutsFormFields("proWatchRequest","crm.helpdesk.request.watchrequest","boolean",false,true);
		fields.addElement(new_field);
	}
	if (status != null && 
		(status.equals(CrRequestForm.STATUS_CLOSED_SUCCESS) || status.equals(CrRequestForm.STATUS_CLOSED_FAILURE)))
	{
		//new_field = new StrutsFormFields("resBy","crm.helpdesk.request.resby","select",false,true);
//		new_field.setCollectionLabel("reqReplyByKeys");
//		new_field.setCollectionProperty("reqReplyBys");
//		fields.addElement(new_field);
		new_field = new StrutsFormFields("resDate","crm.helpdesk.request.actualresdate","date",false,true);
		new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
		fields.addElement(new_field);
		//new_field = new StrutsFormFields("proPreviousComment","crm.helpdesk.request.comments","textarea",false,true);
		//fields.addElement(new_field);
	}
}
request.setAttribute("_vector_fields", fields);

%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">

<bean:define id="labels1" name="CrRequestForm" property="reqTypeKeys"/>
<bean:define id="labels2" name="CrRequestForm" property="reqReplyByKeys"/>
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
%>

<table width="100%">

<bean:define id="priority" name="CrRequestForm" property="proPriority"/>
<tr>
<td width="17%"><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.status") %></span></td>
<td width="77%"><input type="text" name="status" readonly="true" Class="FormAreaDisable" value="<%= LanguageUtil.get(pageContext, CrRequestForm.translateStatus((String)status))%>"></td>
<td width="6%"></td>
</tr>
<tr>
<td><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.priority") %></span></td>
<td><input type="text" name="priority" readonly="true" Class="FormAreaDisable" value="<%= LanguageUtil.get(pageContext, com.ext.portlet.crm.helpdesk.categories.CrCategoryForm.translatePriorityType((String)priority))%>"></td>
<td></td>
</tr>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName" value="CrRequestForm"/>
	<tiles:put name="attributeName" value="_vector_fields"/>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>
</table>

</html:form>
<% 
} catch (Exception e) {e.printStackTrace(); } %>