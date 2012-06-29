<%@ include file="/html/portlet/ext/crm/dashboard/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.categories.auditors.CrCategoryAuditorForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequest" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestComment" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestAttachment" %>
<%@ page import="gnomon.hibernate.model.crm.CrCategory" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestType" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.model.parties.PaOrganization" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.ext.portlet.crm.devicealerts.CrDeviceAlertForm" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<table width="100%">
<tr>
<td width="50%" rowspan="5" valign="top">
<fieldset>
<legend>
<%= LanguageUtil.get(pageContext, "crm.dashboard.contacts") %>
</legend>




<display:table id="item" name="contactsList" requestURI="//ext/crm/dashboard/list?actionURL=true" pagesize="50" sort="list" defaultsort="3" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">   
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("item"); %>

<display:column titleKey="contacts.search.name" sortable="true" sortProperty="field1">
<a title="<%= partyItem.getField1().toString() %>" href="<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>">
<%= partyItem.getField1().toString() %>
</a>
</display:column>
<display:column property="field5" titleKey="contacts.search.phone" sortable="true" />

<display:column style="white-space:nowrap;">
<% if ((partyItem.getField7() != null && partyItem.getField7().equals("true")) || hasAdmin) { %>
<% if (hasEdit) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.button.edit") %>" href="<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><liferay-portlet:param name="loadaction" value="edit"/></liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.edit") %>"></a>&nbsp;
<% } %>
<% if (hasDelete) { %>
<a title="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>" href="<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><liferay-portlet:param name="loadaction" value="delete"/></liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>"></a>
<% } %>

<% if (hasAdmin) { %>
<a title="<%= LanguageUtil.get(pageContext, "contacts.crm.assign-contact") %>" 
href="<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/listAssignments"/>
<liferay-portlet:param name="partyid" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign.png" alt="<%= LanguageUtil.get(pageContext, "contacts.crm.assign-contact") %>"></a>&nbsp;
<% } %>

<% } %>

<% if (hasEdit) { %>
<%--
<a title="<%= LanguageUtil.get(pageContext, "crm.task.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/tasks/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/Details.gif" alt="<%= LanguageUtil.get(pageContext, "crm.task.list") %>"></a>&nbsp;
--%>
<a title="<%= LanguageUtil.get(pageContext, "crm.message.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_MESSAGES" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/messages/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/email_users.gif" alt="<%= LanguageUtil.get(pageContext, "crm.mesage.list") %>"></a>&nbsp;

<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_MEETINGS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/admin_console.gif" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.list") %>"></a>&nbsp;

<a title="<%= LanguageUtil.get(pageContext, "crm.devicealert.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/list"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/mail/flagged.gif" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.list") %>"></a>&nbsp;


<a title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.list") %>" 
href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/listForCrmParty"/>
<liferay-portlet:param name="crmPartyId" value="<%= partyItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/base/preview.gif" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.list") %>"></a>&nbsp;

<% } %>
</display:column>
</display:table>

</fieldset>
</td>

<td rowspan="5" valign="top">
&nbsp;&nbsp;
</td>

<td width="50%">

<fieldset>
<legend>
<%= LanguageUtil.get(pageContext, "crm.dashboard.devicealerts") %>
</legend>

<display:table id="item" name="deviceAlertsList" requestURI="//ext/crm/devicealerts/list?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<%--
<display:column property="field1" titleKey="crm.devicealert.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
--%>
<display:column>
<% if (Validator.isNotNull(gnItem.getField6())) { 
	if (gnItem.getField6().equals("AF")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/fall.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>">
		<% 
	} else if (gnItem.getField6().equals("AP")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/panic.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>">
		<% 
	} else if (gnItem.getField6().equals("AB")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/battery.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>">
		<% 
	}
}
%>
</display:column>
<display:column property="field2" titleKey="crm.devicealert.alertDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column titleKey="crm.devicealert.status" sortable="true">
<% if (Validator.isNotNull(gnItem.getField3())) { %>
<%= LanguageUtil.get(pageContext, "crm.devicealert.status."+gnItem.getField3()) %>
<% } %>
</display:column>

<display:column titleKey="crm.devicealert.subject" sortable="true">
<a title="<%=LanguageUtil.get(pageContext, "crm.devicealert.comment.list") %>" 
   href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
		<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/listComments"/>
		<liferay-portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
		<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
		</liferay-portlet:actionURL>">
<%= gnItem.getField4() %>
</a>
</display:column>
<display:column property="field7" titleKey="crm.devicealert.deviceId" sortable="true"/>
<display:column titleKey="crm.devicealert.crmPartyId" sortable="true">
<a title="<%= gnItem.getField5().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField8().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField5().toString() %>
</a>
</display:column>

<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="edit"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
				<c:if test="<%= gnItem.getField3() != null && gnItem.getField3().toString().equals(CrDeviceAlertForm.STATUS_1) %>">
					<tr>
						<td>
							<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.devicealert.dispatch") %>">
						</td>
						<td>
							<a href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
									<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/loadComment"/>
									<liferay-portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
									<liferay-portlet:param name="loadaction" value="add"/>
									<liferay-portlet:param name="newStatus" value="<%=  CrDeviceAlertForm.STATUS_2 %>"/>
									<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
									</liferay-portlet:actionURL>">
							<%=LanguageUtil.get(pageContext, "crm.devicealert.dispatch") %>
							</a>
						</td>
					</tr>
				</c:if>
				<c:if test="<%= gnItem.getField3() != null && gnItem.getField3().toString().equals(CrDeviceAlertForm.STATUS_2) %>">
					<tr>
						<td>
							<img src="<%= themeDisplay.getPathThemeImage() %>/common/signal_instance.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.devicealert.close") %>">
						</td>
						<td>
							<a href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
									<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/loadComment"/>
									<liferay-portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
									<liferay-portlet:param name="loadaction" value="add"/>
									<liferay-portlet:param name="newStatus" value="<%=  CrDeviceAlertForm.STATUS_3 %>"/>
									<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
									</liferay-portlet:actionURL>">
							<%=LanguageUtil.get(pageContext, "crm.devicealert.close") %>
							</a>
						</td>
					</tr>
				</c:if>
				
				
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="delete"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.devicealert.comment.list") %>"></a>
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/listComments"/>
								<liferay-portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "crm.devicealert.comment.list") %>
						</a>
					</td>
				</tr>
			</c:if>
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<liferay-portlet:actionURL portletName="CRM_DEVICE_ALERTS" windowState="maximized" >
<liferay-portlet:param name="struts_action" value="/ext/crm/devicealerts/load"/>
<liferay-portlet:param name="loadaction" value="add"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>





</fieldset>

</td>
</tr>


<tr>
<td width="50%">
<fieldset>
<legend>
<%= LanguageUtil.get(pageContext, "crm.dashboard.meetings") %>
</legend>



<display:table id="item" name="meetingsList" requestURI="//ext/crm/dashboard/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<%--display:column property="field1" titleKey="crm.meeting.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" /--%>
<display:column property="field2" titleKey="crm.meeting.meetingDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field3" titleKey="crm.meeting.subject" sortable="true"/>
<%--display:column property="field4" titleKey="crm.meeting.creatorId" sortable="true"/--%>
<display:column titleKey="crm.meeting.supplierPartyId" sortable="true">
<% if (Validator.isNotNull(gnItem.getField6()) && Validator.isNotNull(gnItem.getField8())) { %>
<a title="<%= gnItem.getField6().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField8().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField6().toString() %>
</a>
<% } %>
</display:column>
<display:column titleKey="crm.meeting.crmPartyId" sortable="true">
<% if (Validator.isNotNull(gnItem.getField5()) && Validator.isNotNull(gnItem.getField7())) { %>
<a title="<%= gnItem.getField5().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField7().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField5().toString() %>
</a>
<% } %>
</display:column>
<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_meeting_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_meeting_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_MEETINGS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="edit"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_MEETINGS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="delete"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>"></a>
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_MEETINGS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/meetings/listComments"/>
								<liferay-portlet:param name="meetingid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>
						</a>
					</td>
				</tr>
			</c:if>
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<liferay-portlet:actionURL portletName="CRM_MEETINGS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
<liferay-portlet:param name="loadaction" value="add"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>


</fieldset>
</td>
</tr>

<tr>
<td width="50%">
<fieldset>
<legend>
<%= LanguageUtil.get(pageContext, "crm.dashboard.tasks") %>
</legend>


<display:table id="item" name="tasksList" requestURI="//ext/crm/dashboard/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<%--display:column property="field1" titleKey="crm.task.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" /--%>
<display:column property="field2" titleKey="crm.task.taskDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field5" titleKey="crm.task.type" sortable="true"/>
<display:column titleKey="crm.task.status" sortable="true">
<% if (Validator.isNotNull(gnItem.getField3())) { %>
<%= LanguageUtil.get(pageContext, "crm.task.status."+gnItem.getField3()) %>
<% } %>
</display:column>
<display:column property="field4" titleKey="crm.task.subject" sortable="true"/>
<%--display:column property="field6" titleKey="crm.task.creatorId" sortable="true"/--%>
<display:column titleKey="crm.task.crmPartyId" sortable="true">
<a title="<%= gnItem.getField7().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField8().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField7().toString() %>
</a>
</display:column>


<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_task_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_task_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/tasks/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="edit"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/tasks/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="delete"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.task.comment.list") %>"></a>
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/tasks/listComments"/>
								<liferay-portlet:param name="taskid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "crm.task.comment.list") %>
						</a>
					</td>
				</tr>
			</c:if>
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/tasks/load"/>
<liferay-portlet:param name="loadaction" value="add"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>





</fieldset>
</td>
</tr>

<tr>
<td width="50%">
<fieldset>
<legend>
<%= LanguageUtil.get(pageContext, "crm.dashboard.message") %>
</legend>


<display:table id="item" name="messagesList" requestURI="//ext/crm/dashboard/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<%--display:column property="field1" titleKey="crm.message.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" /--%>
<display:column property="field2" titleKey="crm.message.messageDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field5" titleKey="crm.message.type" sortable="true"/>
<display:column property="field4" titleKey="crm.message.subject" sortable="true"/>
<%--display:column property="field6" titleKey="crm.message.creatorId" sortable="true"/--%>
<display:column  titleKey="crm.message.crmPartyId" sortable="true">
<a title="<%= gnItem.getField7().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField12().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField7().toString() %>
</a>
</display:column>
<display:column titleKey="crm.message.attachmentFile" sortable="true">
<%
if (Validator.isNotNull(gnItem.getField8())) {
%>
<a target="_new" href="<%= "/FILESYSTEM/"+ com.liferay.portal.util.PortalUtil.getCompanyId(request)+ "/" + com.ext.portlet.crm.messages.CrMessageForm.UPLOAD_PATH + gnItem.getMainid() + "/"+ gnItem.getField8() %>">
<%= gnItem.getField8() %></a>
<% } %>
</display:column>

<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_msg_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_msg_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_MESSAGES" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/messages/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="edit"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>">
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_MESSAGES" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/messages/load"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="delete"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
			</c:if>
			<% if (hasEdit && 
					(gnItem.getField9() == null || !((Boolean)gnItem.getField9()).booleanValue()) &&
					(gnItem.getField10() == null || !((Boolean)gnItem.getField10()).booleanValue()) &&
					(gnItem.getField11().equals("email"))
					) {%>
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/mail/forward.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "send") %>">
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="CRM_MESSAGES" windowState="maximized">
								<liferay-portlet:param name="struts_action" value="/ext/crm/messages/send"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "send") %>
						</a>
					</td>
				</tr>
			<% } %>
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<liferay-portlet:actionURL portletName="CRM_MESSAGES" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/crm/messages/load"/>
<liferay-portlet:param name="loadaction" value="add"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>

</fieldset>
</td>
</tr>

<tr>
<td width="50%">
<fieldset>
<legend>
<%= LanguageUtil.get(pageContext, "crm.dashboard.helpdesk") %>
</legend>

<%
String lang = GeneralUtils.getLocale(request);
String[] nameFields1 = new String[]{"langs.name"};
String[] nameFields2 = new String[]{"langs.description"};
GnPersistenceService serv = GnPersistenceService.getInstance(null);
PartiesService partiesServ = PartiesService.getInstance();
boolean hasComment = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.COMMENT);
boolean hasView =  PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.VIEW);


boolean isInOrganizationChart = false;
try{
	Long companyId = com.liferay.portal.util.PortalUtil.getCompanyId(request);
	PaPerson person = partiesServ.getPaPerson(user.getUserId());
	PaOrganization organization = partiesServ.getPaOrganization(companyId);
	if (person != null && organization != null)
	{
		List rootOrgs = gnomon.hibernate.OrganizationChartService.getInstance().getParentRootOrganizations(person.getMainid(), lang);
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
} catch (Exception e) {}

String userDirPath=PropsUtil.get("crm.helpdesk.users.store");
%>


<form name="CRM_Requests_ButtonForm" action="/some/url" method="post">
<display:table id="crmReq" name="itemsList" requestURI="//ext/crm/dashboard/list?actionURL=true" pagesize="5" sort="list" export="false" style="width:100%" >
	<%
		CrRequest gnItem = (CrRequest) pageContext.getAttribute("crmReq");
	    ViewResult catView = null, assignView = null, submitView = null, reqTypeView=null;
	    List comments = null, attachments = null;
		String styleFlag = "";
		boolean isOpen = false;
		boolean assignedToMe = false;
		if (gnItem!=null) {
			catView = serv.getObjectWithLanguage(CrCategory.class, gnItem.getCrCategory().getMainid(), lang, nameFields1);

			reqTypeView = serv.getObjectWithLanguage(CrRequestType.class, gnItem.getReqType().getMainid(), lang, nameFields1);

			comments = serv.listObjects(null, CrRequestComment.class, " table1.crRequest.mainid = "+gnItem.getMainid() +
					(isInOrganizationChart ? "" : " and table1.showComments = 1 ") );
			attachments = serv.listObjects(null, CrRequestAttachment.class, " table1.crRequest.mainid = "+gnItem.getMainid());

			if (gnItem.getProAssignedTo() != null)
			{
				if (gnItem.getProAssignedTo().longValue() == user.getUserId())
					assignedToMe = true;
				PaParty assignedPerson = partiesServ.getPaPerson(gnItem.getProAssignedTo());
				if (assignedPerson != null)
					assignView = serv.getObjectWithLanguage(PaParty.class, assignedPerson.getMainid(), lang, nameFields2);
			}
			isOpen = !( StringUtils.check_null(gnItem.getStatus(),"").equals(CrRequestForm.STATUS_CLOSED_FAILURE)
								|| StringUtils.check_null(gnItem.getStatus(),"").equals(CrRequestForm.STATUS_CLOSED_SUCCESS)
								);
			if (isOpen && (gnItem.getProExpectedResDate()!=null) && (gnItem.getProExpectedResDate().before(new java.util.Date()))) {
				styleFlag = "color: #FF0000;";
			}
			if (gnItem.getReqUserid() != null)
			{
				PaParty submitPerson  = partiesServ.getPaPerson(gnItem.getReqUserid());
				if (submitPerson != null)
					submitView = serv.getObjectWithLanguage(PaParty.class, submitPerson.getMainid(), lang, nameFields2);
			}
		}
	%>
<% //if (CrmService.SHOW_REQUEST_TYPE) { 
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) {
%>
		<display:column style="<%=styleFlag%>" property="mainid" title="A/A" sortable="true" />
		<display:column style="<%=styleFlag%>" property="reqNumber" titleKey="crm.helpdesk.request.number" sortable="true" />
		<display:column titleKey="crm.helpdesk.request.type" sortable="true">
				<%= reqTypeView != null && reqTypeView.getField1() != null? reqTypeView.getField1() : "" %>

		</display:column>
	<% } %>
	<display:column style="<%=styleFlag%>" property="reqDate" titleKey="crm.helpdesk.request.date" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.status" sortable="true">
		<%= LanguageUtil.get(pageContext, CrRequestForm.translateStatus(gnItem.getStatus())) %>
	</display:column>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.subject" sortable="true">
		<a title="<%=LanguageUtil.get(pageContext, "crm.button.view") %>" href="<portlet:actionURL>
				<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
				<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
				<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_VIEW %>"/>
				<portlet:param name="redirect" value="<%=currentURL%>"/>
				</portlet:actionURL>">
		<%= gnItem.getReqSubject() %>
		</a>
	</display:column>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.userid" sortable="true">
		<%= submitView != null && submitView.getField1() != null? submitView.getField1() : "" %>
	</display:column>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.assignedto" sortable="true">
		<% if (assignedToMe) { %><span style="font-weight: bold;"> <% } %>
		<%= assignView != null && assignView.getField1() != null? assignView.getField1() : "" %>
		<% if (assignedToMe) { %></span> <% } %>
	</display:column>
	<display:column style="white-space:nowrap; <%=styleFlag%>" >
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:<portlet:namespace/>actionsMenu_1_helpdesk_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap; <%=styleFlag%>"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
		<br>

		<div id="browse:<portlet:namespace/>actionsMenu_1_helpdesk_<%=gnItem.getMainid().toString()%>" style="display: none; " >
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0" >
			<tbody>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/print.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.print-view") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="<%= LiferayWindowState.POP_UP.toString() %>">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_PRINT_VIEW %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>" target="_new_window">
					<%=LanguageUtil.get(pageContext, "crm.button.print-view") %>
					</a>
				</td>
			</tr>
			<% if (hasComment ||
				   CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_VIEW)) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestComments"/>
							<liferay-portlet:param name="requestid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>" >
					<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>
					<% if (comments != null) {
						out.print(" ("+ comments.size() +")");
					} %>
					</a>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/clip.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.attachment.list") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestAttachments"/>
							<liferay-portlet:param name="requestid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>" >
					<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.attachment.list") %>
					<% if (attachments != null) {
						out.print(" ("+ attachments.size() +")");
					} %>
					</a>
				</td>
			</tr>
			<% if (hasEdit && gnItem.getCrRequest() == null && GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-check-type"),false)) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_tasks.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/listChildren"/>
							<liferay-portlet:param name="parentid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>" >
					<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %>
					</a>
			</td>
			</tr>
				<% } %>
			<% } %>
			<% if (hasEdit && gnItem.getStatus().equals(CrRequestForm.STATUS_NEW) &&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_FORWARD)) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/submit_workflow.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.open") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_OPEN %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.open") %>
					</a>
				</td>
			</tr>
			<% } %>
			<% if ((assignedToMe ||
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER)) &&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_EDIT) &&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_FORWARD)
					&& (gnItem.getStatus().equals(CrRequestForm.STATUS_OPEN) ||
					gnItem.getStatus().equals(CrRequestForm.STATUS_IN_PROGRESS))) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/forward.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.forward") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_FORWARD %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.forward") %>
					</a>
				</td>
			</tr>
			<% } %>
			<% if ((assignedToMe ||
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER))
					&& gnItem.getCrCategory().isNeedsApproval() &&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_EDIT) &&
					(gnItem.getStatus().equals(CrRequestForm.STATUS_IN_PROGRESS) ||
					gnItem.getStatus().equals(CrRequestForm.STATUS_OPEN))) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/enabled.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.resolve-success") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_RESOLVE_SUCCESS %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.resolve-success") %>
					</a>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/disabled.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.resolve-failure") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_RESOLVE_FAILURE %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.resolve-failure") %>
					</a>
				</td>
			</tr>
			<% } %>
			<% if ((assignedToMe ||
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER))
					&&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_CLOSE) &&
					(gnItem.getStatus().equals(CrRequestForm.STATUS_RESOLVED_SUCCESS) || gnItem.getStatus().equals(CrRequestForm.STATUS_RESOLVED_FAILURE) ||
					(!gnItem.getCrCategory().isNeedsApproval()
					 &&	(gnItem.getStatus().equals(CrRequestForm.STATUS_IN_PROGRESS) ||
						gnItem.getStatus().equals(CrRequestForm.STATUS_OPEN))
					))) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/maximize.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.close-success") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_CLOSE_SUCCESS %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.close-success") %>
					</a>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/minimize.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.close-failure") %>">
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_CLOSE_FAILURE %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.close-failure") %>
					</a>
				</td>
			</tr>
			<% } %>
			<% if (hasDelete &&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER)
					&& (gnItem.getStatus().equals(CrRequestForm.STATUS_NEW) ||
					gnItem.getStatus().equals(CrRequestForm.STATUS_OPEN))) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.delete") %>"></a>
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_DELETE %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.delete") %>
					</a>
				</td>
			</tr>
			<% } %>
			<% if (hasEdit &&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER)
					&& !gnItem.getStatus().equals(CrRequestForm.STATUS_NEW) &&
							!gnItem.getStatus().equals(CrRequestForm.STATUS_OPEN) &&
							!gnItem.getStatus().equals(CrRequestForm.STATUS_IN_PROGRESS)) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/submit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.re-open") %>"></a>
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_REOPEN %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.re-open") %>
					</a>
				</td>
			</tr>
			<% } %>

			<% if (hasEdit
				//	&& CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER)
					&& (gnItem.getStatus().equals(CrRequestForm.STATUS_RESOLVED_SUCCESS) || gnItem.getStatus().equals(CrRequestForm.STATUS_CLOSED_SUCCESS)) )
							 {
							 	if(gnItem.getReqType().getFilename()!=null && !gnItem.getReqType().getFilename().equals("") && gnItem.getHasReport()!=1 ) {

							 	%>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/submit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.re-open") %>"></a>
				</td>
				<td>
					<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
							<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/creatertf"/>
							<liferay-portlet:param name="requestId" value="<%= gnItem.getMainid().toString() %>"/>
							<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
							</liferay-portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.create-vevaiosi") %>
					</a>
				</td>
			</tr>
			<% }
		}%>


		<% if (hasEdit )
				//&&	CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER))
				 {
					if(gnItem.getReqType().getFilename()!=null && !gnItem.getReqType().getFilename().equals("") && gnItem.getHasReport()!=1 ) {
				 	String userDir = userDirPath +gnItem.getReqNumber();
				 	%>

				 		<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/submit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.re-open") %>"></a>
				</td>
				<td>
					<a target="new" href="file:///<%=userDir%>">
					<%=LanguageUtil.get(pageContext, "crm.button.open-folder") %>
					</a>
				</td>
			</tr>

<% }
	}%>
			</tbody>
			</table>
		</div>
	</display:column>
</display:table>

<c:if test="<%=hasAdd %>">

<a href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="maximized">
	<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
	<liferay-portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_ADD %>"/>
	<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
	</liferay-portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
	<%= LanguageUtil.get(pageContext, "crm.button.add") %>
</a>


</c:if>
</form>


</fieldset>
</td>
</tr>


</table>



