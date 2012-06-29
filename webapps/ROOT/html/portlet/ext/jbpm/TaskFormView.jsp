<%@ include file="/html/portlet/ext/jbpm/init.jsp" %>

<%@ page import="com.liferay.portlet.workflow.service.WorkflowComponentServiceUtil" %>
<%@ page import="com.liferay.portlet.workflow.model.WorkflowTaskFormElement" %>
<%@ page import="com.liferay.portlet.workflow.action.EditTaskAction" %>
<%@ page import="com.liferay.portlet.workflow.jbi.WorkflowXMLUtil" %>
<%@ page import="com.liferay.portlet.workflow.model.WorkflowTask" %>
<%@ page import="com.liferay.portlet.workflow.search.TaskDisplayTerms" %>
<%// @ page import="com.ext.portlet.procure.Definitions" %>
<%@ page import="com.liferay.portlet.PortletURLImpl" %>
<%@page import="com.ext.portlet.jbpm.JbpmServices" %>
<%@page import="gnomon.hibernate.PartiesService"%>
<%@page import="gnomon.hibernate.model.parties.PaPerson"%>


<%
String redirect = ParamUtil.getString(request, "redirect");
String taskIdStr = (String)request.getAttribute("taskId");
String instanceIdStr = (String)request.getAttribute("instanceId");

long taskId = -1;
long instanceId = -1;

if(taskIdStr!=null)
	taskId =new Long(taskIdStr).longValue();
	else
	 taskId = ParamUtil.getLong(request, "taskId");

if(instanceIdStr!=null)
	instanceId=new Long(instanceIdStr).longValue();
	else
	instanceId = ParamUtil.getLong(request, "instanceId");

List taskFormElements = WorkflowComponentServiceUtil.getTaskFormElements(taskId);
List taskTransitions = WorkflowComponentServiceUtil.getTaskTransitions(taskId);
String  taskName = ParamUtil.getString(request, "taskName");
Map errors = (Map)SessionErrors.get(renderRequest, EditTaskAction.class.getName());
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<BR>

<%
String handleActionUrl = (String)request.getAttribute("handleActionUrl");
String reviewUrl = (String)request.getAttribute("reviewUrl");
String reviewParams = (String)request.getAttribute("reviewParams");
String tileParams[]=null;
if(reviewParams!=null)
 tileParams=reviewParams.split(",");
String editUrl = (String)request.getAttribute("editUrl");
	PartiesService partiesServ = PartiesService.getInstance(null);
	PaPerson person = partiesServ.getPaPerson(user.getUserId());
%>



<script language="JavaScript">
	function <portlet:namespace />getDate(displayName) {
		eval("var month = (parseInt(document.<portlet:namespace />fm.<portlet:namespace />" + displayName + "Month.value) + 1);");
		eval("var day = (parseInt(document.<portlet:namespace />fm.<portlet:namespace />" + displayName + "Day.value));");
		eval("var year = (parseInt(document.<portlet:namespace />fm.<portlet:namespace />" + displayName + "Year.value));");

		if (month < 10) {
			month = "0" + month;
		}

		if (day < 10) {
			day = "0" + day;
		}

		return month + "/" + day + "/" + year;
	}


function <portlet:namespace />saveTask(taskTransition) {
		document.<portlet:namespace />fm.<portlet:namespace />taskTransition.value = taskTransition;

		<%
		for (int i = 0; i < taskFormElements.size(); i++) {
			WorkflowTaskFormElement taskFormElement = (WorkflowTaskFormElement)taskFormElements.get(i);

			String type = taskFormElement.getType();
			String displayName = taskFormElement.getDisplayName();

			if (type.equals(WorkflowTaskFormElement.TYPE_DATE) && taskFormElement.isWritable()) {
				displayName = JS.getSafeName(displayName);
		%>

				document.<portlet:namespace />fm.<portlet:namespace /><%= displayName %>.value = <portlet:namespace />getDate("<%= displayName %>");

		<%
			}
		}
		%>

		submitForm(document.<portlet:namespace />fm);
	}



</script>
<%
if (redirect == null || redirect.equals("")){
	PortletURL portletURL = new PortletURLImpl(
					request, "PRJ_JBPM_TODO_MATRIX", plid, false);

	portletURL.setParameter("struts_action", "/ext/jbpm/listTasks");
	redirect = 	portletURL.toString();
}%>

<form action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/jbpm/edit_task" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm" enctype="multipart/form-data">
<input name="<portlet:namespace />taskCmd" type="hidden" value="<%= Constants.UPDATE %>">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>">
<input name="<portlet:namespace />taskId" type="hidden" value="<%= taskId %>">
<input name="<portlet:namespace />instanceId" type="hidden" value="<%= instanceId %>">
<input name="<portlet:namespace />taskTransition" type="hidden" value="">
<input name="<portlet:namespace />taskName" type="hidden" value="<%=ParamUtil.getString(request, "taskName")%>">



<table border="0" cellpadding="0" cellspacing="0">

<%

if(reviewUrl!=null && !reviewUrl.equals("")){%>
 <%if(tileParams!=null && tileParams.length>0) {
 %>
<liferay-util:include page="<%=reviewUrl%>">
<% for(int j=0; j<tileParams.length; j++) {
  %>
<liferay-util:param name="<%=tileParams[j]%>" value="<%=JbpmServices.getInstance().getParaMeterValue(taskFormElements,tileParams[j])%>"/>
<%}
%>

</liferay-util:include>
<%} else {%>
 <jsp:include page="<%=reviewUrl%>" flush="true"/>
<%}
%>


<input type="hidden" name="currentActor" value="<%=person.getMainid()%>">

<a href="<%=editUrl%>"> edit your item </a>
<%}

else {


for (int i = 0; i < taskFormElements.size(); i++) {
	WorkflowTaskFormElement taskFormElement = (WorkflowTaskFormElement)taskFormElements.get(i);

	String type = taskFormElement.getType();
	String displayName = taskFormElement.getDisplayName();
	String varName = taskFormElement.getVariableName();
	String value = taskFormElement.getValue();
	String inputType = "text";

	boolean taskElRequeired = taskFormElement.isRequired();
	boolean taskElWritable = taskFormElement.isWritable();
	boolean taskElReadable = taskFormElement.isReadable();

	List valueList = taskFormElement.getValueList();

	String errorCode = null;

	if (errors != null) {
		errorCode = (String)errors.get(displayName);
	}

	if (taskElRequeired) {
		if (value == null || value.equals("")) {
			// Show editable control for the form element
		}
	}else{

	}

	request.setAttribute("WorkflowTaskFormElement", taskFormElement);
%>

<tiles:insert page="/html/portlet/ext/jbpm/TaskElementTile.jsp" flush="true"/>

<%
}

}
%>

</table>

<br>

<%
for (int i = 0; i < taskTransitions.size(); i++) {
	String taskTransition = (String)taskTransitions.get(i);
	// customisation for the end task
	if(!taskTransition.equals("endTask")) {
	%>

	<input class="portlet-form-button" type="button"
		name="<%= LanguageUtil.get(pageContext, "jbpm.userTasks."+taskTransition.replaceAll(" ","_")) %>" value="<%= LanguageUtil.get(pageContext, "jbpm.userTasks."+taskTransition.replaceAll(" ","_")) %>" onClick="<portlet:namespace />saveTask('<%= taskTransition %>');">

<%
}
}
%>


</form>
<BR>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD>
<html:link styleClass="beta1" page="/ext/jbpm/listTasks" >
	<img src="<%=themeDisplay.getPathThemeImage()%>/common/back.gif" border="0" align="absmiddle">
	<%= LanguageUtil.get(pageContext, "projectMgmt.button.back") %>
</html:link>
</TD>
</TR>
</TABLE>

