<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.CommonDefs" %>

<bean:define id="status" name="CrRequestFlowForm" property="status"/>
<bean:define id="showComments" name="CrRequestFlowForm" property="showComments"/>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.form") %></h2>

<%
try {

StrutsFormFields new_field=null;
java.util.Vector<StrutsFormFields> fields=new java.util.Vector<StrutsFormFields>();
String curFormName="CrRequestFlowForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("crRequestid","crRequestid","text",true));
new_field = new StrutsFormFields("sentDate","crm.helpdesk.flow.sentdate","date",false,true);
new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
new_field = new StrutsFormFields("taskFromName","crm.helpdesk.flow.taskfrom","text",false,true);
fields.addElement(new_field);
new_field = new StrutsFormFields("taskToName","crm.helpdesk.flow.taskto","text",false,true);
fields.addElement(new_field);
if (PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT) ||
    (showComments != null && ((Boolean)showComments).booleanValue())) {
	new_field = new StrutsFormFields("comments","crm.helpdesk.request.description","textarea",false,true);
	fields.addElement(new_field);
}
new_field = new StrutsFormFields("expectedResDate","crm.helpdesk.request.expectedresdate","date",false,true);
new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
if (status != null && (status.equals(CrRequestForm.STATUS_CLOSED_SUCCESS) || status.equals(CrRequestForm.STATUS_CLOSED_FAILURE))) {
	new_field = new StrutsFormFields("actualResDate","crm.helpdesk.request.actualresdate","date",false,true);
	new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
	fields.addElement(new_field);
	if (PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT) ||
		(showComments != null && ((Boolean)showComments).booleanValue())) {
			new_field = new StrutsFormFields("delayComments","crm.helpdesk.request.delaycomments", "textarea",false,true);
			fields.addElement(new_field);
	}
}
request.setAttribute("_vector_fields", fields);

%>

<html:form action="/ext/crm/helpdesk/loadFlow?actionURL=true" method="post" enctype="multipart/form-data">

<table width="100%">
<tr>
<td><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.status") %></span></td>
<td><input type="text" name="status" readonly="true" Class="FormAreaDisable" value="<%= LanguageUtil.get(pageContext, CrRequestForm.translateStatus((String)status))%>"></td>
<td></td>
</tr>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName" value="CrRequestFlowForm"/>
	<tiles:put name="attributeName" value="_vector_fields"/>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>
</table>

</html:form>

<br>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;<a href="javascript:history.back();"><%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %></a>

<%
} catch (Exception e) {e.printStackTrace(); } %>