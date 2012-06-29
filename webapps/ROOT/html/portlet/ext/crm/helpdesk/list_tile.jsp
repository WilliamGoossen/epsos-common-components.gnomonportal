<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>


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

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
String searchItem = (String)request.getAttribute("searchItem");
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
if (hasView) {
%>

<form name="CRM_Requests_SearchForm1" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/></portlet:actionURL>" method="post">
<input type="hidden" name="search" value="search">
<table style="padding:2px" >
<tr valign="center">
		<td valign="center">
			<span><%= LanguageUtil.get(pageContext, "crm.button.search") %></span>
		</td>
		<td valign=center>
			<input type="text" name="searchItem" value="<%= searchItem %>" >
		</td>
		<td valign=center>
			<input type="image" src="<%=  themeDisplay.getPathThemeImage() %>/common/search.png" alt="search" border="0" >
		</td>
		<td>&nbsp;
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/><portlet:param name="search" value="form"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.button.search-advanced") %></a>
		</td>
	</tr>
</table>
</form>
<br>
<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.list") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<!-- Events List -->
<form name="CRM_Requests_ButtonForm" action="/some/url" method="post">
<display:table id="crmReq" name="itemsList" requestURI="//ext/crm/helpdesk/list?actionURL=true" pagesize="20" sort="list" export="false" style="width:100%" >
	<%
		CrRequest gnItem = (CrRequest) pageContext.getAttribute("crmReq");
	    ViewResult catView = null, assignView = null, submitView = null, reqTypeView=null;
	    List comments = null, attachments = null;
		String styleFlag = "";
		boolean isOpen = false;
		boolean assignedToMe = false;
		String timeTaken = "-";
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
			
			timeTaken = "-";
			if (gnItem.getReqDate() != null && gnItem.getResDate() != null)
			{
				long milSecsDiff = gnItem.getResDate().getTime() - gnItem.getReqDate().getTime(); 
				long hoursDiff = milSecsDiff/3600000;
				long daysDiff = hoursDiff/24;
				long hoursMod = hoursDiff%24;
				timeTaken = daysDiff + " "+ LanguageUtil.get(pageContext, "days") + " " + hoursMod +  " " + LanguageUtil.get(pageContext, "hours");
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
	<%--<display:column>
	<% if (gnItem.getCrRequest() == null) { %>
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/scenario.gif" border="0" title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.scenario") %>" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.scenario") %>">
	<% } else { %>
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/task.gif" border="0" title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.task") %>" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.task") %>">
	<% } %>
	</display:column>--%>
<%-- 	<%if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) { %>
		<display:column property="reqProtocolNumber" titleKey="crm.helpdesk.request.protocolNumber" sortable="true" />
	<% } %>
	--%>
	<display:column style="<%=styleFlag%>" property="reqDate" titleKey="crm.helpdesk.request.date" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.timeTaken" sortable="true">
	<%= timeTaken %>
	</display:column>
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
<%-- 	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.category" sortable="true">
	<%= catView != null && catView.getField1() != null? catView.getField1() : "" %>
	</display:column>
--%>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.userid" sortable="true">
		<%= submitView != null && submitView.getField1() != null? submitView.getField1() : "" %>
	</display:column>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.assignedto" sortable="true">
		<% if (assignedToMe) { %><span style="font-weight: bold;"> <% } %>
		<%= assignView != null && assignView.getField1() != null? assignView.getField1() : "" %>
		<% if (assignedToMe) { %></span> <% } %>
	</display:column>
	<display:column style="white-space:nowrap; <%=styleFlag%>" >
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:<portlet:namespace/>actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap; <%=styleFlag%>"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
		<br>

		<div id="browse:<portlet:namespace/>actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; " >
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0" >
			<tbody>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/print.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.print-view") %>">
				</td>
				<td>
					<a href="<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>">
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_PRINT_VIEW %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>" target="_new_window">
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
					<a href="<portlet:actionURL >
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestComments"/>
							<portlet:param name="requestid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>" >
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
					<a href="<portlet:actionURL >
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestAttachments"/>
							<portlet:param name="requestid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>" >
					<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.attachment.list") %>
					<% if (attachments != null) {
						out.print(" ("+ attachments.size() +")");
					} %>
					</a>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/history.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>">
				</td>
				<td>
					<a href="<portlet:actionURL >
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/listFlows"/>
							<portlet:param name="crrequestid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>" >
					<%=LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>
					</a>
				</td>
			</tr>
			<% if (hasEdit && gnItem.getCrRequest() == null && GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-check-type"),false)) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_tasks.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %>">
				</td>
				<td>
					<a href="<portlet:actionURL >
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/listChildren"/>
							<portlet:param name="parentid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>" >
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_OPEN %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.open") %>
					</a>
				</td>
			</tr>
			<% } %>
			<%-- if (CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_EDIT)
					&& (gnItem.getStatus().equals(CrRequestForm.STATUS_NEW) ||
					gnItem.getStatus().equals(CrRequestForm.STATUS_OPEN))) { %>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.edit") %>">
				</td>
				<td>
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_EDIT %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.edit") %>
					</a>
				</td>
			</tr>
			<% } --%>
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_FORWARD %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_RESOLVE_SUCCESS %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.resolve-success") %>
					</a>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/disabled.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.resolve-failure") %>">
				</td>
				<td>
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_RESOLVE_FAILURE %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_CLOSE_SUCCESS %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "crm.button.close-success") %>
					</a>
				</td>
			</tr>
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/minimize.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.close-failure") %>">
				</td>
				<td>
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_CLOSE_FAILURE %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_DELETE %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_REOPEN %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/crm/helpdesk/creatertf"/>
							<portlet:param name="requestId" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
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
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/crm/helpdesk/load" />
	  <tiles:put name="buttonName" value="addButtonRequest" />
	  <tiles:put name="buttonValue" value="crm.button.add" />
	  <tiles:put name="formName"   value="CRM_Requests_ButtonForm" />
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue"><%= CrRequestForm.LOADACTION_ADD %></tiles:put>
	  <tiles:putList name="actionParamList">
		  	<tiles:add value="redirect"/>
		  </tiles:putList>
		  <tiles:putList name="actionParamValueList">
		  	<tiles:add><%= currentURL %></tiles:add>
		  </tiles:putList>
	</tiles:insert>
</c:if>
</form>
<br><br>

<% } %>