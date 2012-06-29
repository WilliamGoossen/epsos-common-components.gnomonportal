<%@ include file="/html/portlet/ext/jbpm/init.jsp" %>
<%@page import="org.displaytag.decorator.DecoratorFactory"%>
<%@page import="org.displaytag.sample.LongDateWrapper"%>
<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>


<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.kernel.portlet.LiferayWindowState" %>


<%
try{
String lang=GeneralUtils.getLocale(request);
%>


<table border="0" width="100%">
<tr>
<td>
<% if  (request.getAttribute("userTasks_11")!=null && !((List)request.getAttribute("userTasks_11")).isEmpty()) { %>
<%-- <display:table id="aListItem" name="userTasks_11" length="10" class="simple" />  --%>
<table>

<%
//PortletURL portletURL = renderResponse.createRenderURL();
//portletURL.setWindowState(WindowState.MAXIMIZED);
//portletURL.setParameter("struts_action", "/workflow/view");

				PortletURL rowURL = new PortletURLImpl(request, "93", plid, false);
				rowURL.setWindowState(WindowState.MAXIMIZED);
				rowURL.setPortletMode(PortletMode.VIEW);
List results = (List)request.getAttribute("userTasks_11");
DefinitionSearch searchContainer = new DefinitionSearch(renderRequest, rowURL);
searchContainer.setResults(results);
List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
				WorkflowTask task = (WorkflowTask)results.get(i);
				String taskId = String.valueOf(task.getTaskId());
				WorkflowInstance instance = task.getInstance();
				String instanceId = String.valueOf(instance.getInstanceId());
				WorkflowDefinition definition = instance.getDefinition();
				ResultRow row = new ResultRow(task, taskId, i);
/*				PortletURL rowURL = renderResponse.createRenderURL();
				rowURL.setWindowState(WindowState.MAXIMIZED);
				rowURL.setParameter("struts_action", "/workflow/view");
				rowURL.setParameter("struts_action", "/workflow/edit_task");
				rowURL.setParameter("tabs1", "instances");
				rowURL.setParameter("instanceId", instanceId);
				rowURL.setParameter("taskId", taskId);
				row.setParameter("rowHREF", rowURL.toString());

				*/


				rowURL.setParameter("struts_action", "/workflow/edit_task");
				rowURL.setParameter("tabs1", "instances");
				rowURL.setParameter("redirect", currentURL);
				rowURL.setParameter("instanceId", instanceId);
				rowURL.setParameter("taskId", taskId);


				// Task id
//				row.addText(taskId, rowURL);
				// Create date
				row.addText(dateFormatDateTime.format(task.getCreateDate()), rowURL);
				// Task name
				row.addText(LanguageUtil.get(pageContext, task.getName()), rowURL);
				// Instance id
//				row.addText(instanceId, rowURL);
				// Definition name
//				row.addText(LanguageUtil.get(pageContext, definition.getName()), rowURL);
				// Assigned to
//				row.addText(PortalUtil.getUserName(task.getAssignedUserId(), String.valueOf(task.getAssignedUserId()), request), rowURL);
				// Start date
/*
				if (task.getStartDate() == null) {
					row.addText(LanguageUtil.get(pageContext, "not-available"), rowURL);
				}
				else {
					row.addText(dateFormatDateTime.format(task.getStartDate()), rowURL);
				}

				// End date

				if (task.getEndDate() == null) {
					row.addText(LanguageUtil.get(pageContext, "not-available"), rowURL);
				}
				else {
					row.addText(dateFormatDateTime.format(task.getEndDate()), rowURL);
				}
*/
				// Action

				row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/workflow/task_action.jsp");

				// Add result row


				resultRows.add(row);
				%>
				<tr>
				<td><%= dateFormatDateTime.format(task.getCreateDate()) + " - " %></td>
				<td><a href="<%=  rowURL.toString()%>"><%= LanguageUtil.get(pageContext, task.getName()) %></a></td>
				</tr>
				<%
			}
			%>
			</table>
			<% } %>

</td>
<%--
<td bgcolor="#FFFFED" width="20%" align="left">20/1/2008 4:24 create expense</td>
</tr>
<tr>
<td bgcolor="#F8FCED" width="80%" align="left">21/1/2008 4:24	create expense</td>
<td bgcolor="#FFFFF6" width="20%" align="left">19/1/2008 4:24	create expense</td>
--%>
</tr>
</table>


<%}catch(Exception ex){
	ex.printStackTrace();
}%>
