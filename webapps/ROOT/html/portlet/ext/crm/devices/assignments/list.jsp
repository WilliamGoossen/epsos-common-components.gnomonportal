<%@ include file="/html/portlet/ext/crm/devices/init.jsp" %>

<%@ page import="com.ext.portlet.crm.devices.assignments.CrDeviceAssignmentForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%
try {
Integer crmDeviceId = (Integer)request.getAttribute("crmDeviceId");
List assignmentsList=(List) request.getAttribute("assignmentsList");
GnPersistenceService serv = GnPersistenceService.getInstance(null);
String lang = GeneralUtils.getLocale(request);
String[] partyNameFields = new String[]{"langs.description"};
PaPerson person = PartiesService.getInstance().getPaPerson(user.getUserId());
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h3><%= LanguageUtil.get(pageContext, "crm.device.assignment.list") %></h3>

<form name="CRM_DEVICE_Assignments_ButtonForm" action="/some/url" method="post">
<display:table id="" name="assignmentsList" requestURI="//ext/crm/devices/listAssignments" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% CrDeviceAssignment gnItem = (CrDeviceAssignment) pageContext.getAttribute(""); %>
<display:column titleKey="crm.device.assignment.crmPartyId" sortable="true">
<%
ViewResult partyView = serv.getObjectWithLanguage(PaParty.class, gnItem.getCrmParty().getMainid(), lang, partyNameFields);
out.print(partyView.getField1());
 %>
</display:column>
<display:column titleKey="crm.device.assignment.fromDate" sortable="true">
<%= CrDeviceAssignmentForm.format.format(gnItem.getFromDate()) %>
</display:column>
<display:column titleKey="crm.device.assignment.toDate" sortable="true">
<%= (gnItem.getToDate() != null ? CrDeviceAssignmentForm.format.format(gnItem.getToDate()) : "") %>
</display:column>
<display:column property="deviceId" titleKey="crm.device.deviceId" sortable="true"/>

<% if (hasEdit || hasAdmin) { %>
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, '<portlet:namespace/>browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
<br>
<div id="<portlet:namespace/>browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/devices/loadAssignment"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="edit"/>
					<portlet:param name="crmDeviceId" value="<%= crmDeviceId.toString() %>"/>
					<portlet:param name="redirect" value="<%= currentURL %>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/devices/loadAssignment"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="delete"/>
					<portlet:param name="crmDeviceId" value="<%= crmDeviceId.toString() %>"/>
					<portlet:param name="redirect" value="<%= currentURL %>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
			</a>
		</td>
	</tr>
	</tbody>
	</table>
</div>
</display:column>
<% } %>

</display:table>
<br />

<% if (hasAdd) {%>
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/crm/devices/loadAssignment" />
	  <tiles:put name="buttonName" value="addButtonDeviceAssignment" />
	  <tiles:put name="buttonValue" value="crm.button.add" />
	  <tiles:put name="formName"   value="CRM_DEVICE_Assignments_ButtonForm" />
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="crmDeviceId"/>
	  	<tiles:add value="redirect"/>
	  </tiles:putList>
	  <tiles:putList name="actionParamValueList">
	  	<tiles:add><%= crmDeviceId.toString() %></tiles:add>
	  	<tiles:add><%= currentURL %></tiles:add>
	  </tiles:putList>
	</tiles:insert>
<% } %>

</form>
<br>


<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;
<a href="<portlet:actionURL>
<portlet:param name="redirect" value="<%= redirect %>"/>
</portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "crm.button.back") %></a>


<% } catch (Exception e) { e.printStackTrace();} %>