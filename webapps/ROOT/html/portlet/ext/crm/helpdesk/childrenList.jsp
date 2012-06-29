<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>

<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.crm.CrCheckType" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.ext.portlet.crm.helpdesk.categories.auditors.CrCategoryAuditorForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequest" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String lang = GeneralUtils.getLocale(request);
String[] nameFields2 = new String[]{"langs.description"};
GnPersistenceService serv = GnPersistenceService.getInstance(null);
PartiesService partiesServ = PartiesService.getInstance();
%>



<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %></h2>

<display:table id="crmReq" name="itemsList" requestURI="//ext/crm/helpdesk/listChildren?actionURL=true" pagesize="20" sort="list" export="false" style="width: 100%;">
	<% 
	CrRequest gnItem = (CrRequest) pageContext.getAttribute("crmReq"); 
	ViewResult assignView = null;
	String styleFlag = "";
	boolean isOpen = false;
	boolean assignedToMe = false;
	if (gnItem!=null) {
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
	}
	%>
	<display:column style="<%=styleFlag%>" property="reqDate" titleKey="crm.helpdesk.request.date" sortable="true" decorator="org.displaytag.sample.LongDateWrapper"/>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.status" sortable="true">
		<%= LanguageUtil.get(pageContext, CrRequestForm.translateStatus(gnItem.getStatus())) %>
	</display:column>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.checktype.name" sortable="true">
		<a title="<%=LanguageUtil.get(pageContext, "crm.button.view") %>" href="<portlet:actionURL>
				<portlet:param name="struts_action" value="/ext/crm/helpdesk/load"/>
				<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
				<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_VIEW %>"/>
				<portlet:param name="redirect" value="<%=currentURL%>"/>
				</portlet:actionURL>">
		<%  ViewResult checkView = serv.getObjectWithLanguage(CrCheckType.class, gnItem.getCrCheckType().getMainid(), lang, new String[]{"langs.name"});
	    if (checkView != null)
			out.print(checkView.getField1().toString()); 
		%>
		</a>
	</display:column>
	<display:column style="<%=styleFlag%>" titleKey="crm.helpdesk.request.assignedto" sortable="true">
	<% if (assignedToMe) { %><span style="font-weight: bold;"> <% } %>
	<%= assignView != null && assignView.getField1() != null? assignView.getField1() : "" %>
	<% if (assignedToMe) { %></span> <% } %>
	</display:column>
	<display:column style="white-space:nowrap; <%=styleFlag%>" >
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap; <%=styleFlag%>"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
		<br>
		
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;" >
	
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
			<% if (CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_VIEW)) { %>
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
					</a>
				</td>
			</tr>
			<% } %>
			<% if (gnItem.getStatus().equals(CrRequestForm.STATUS_NEW) &&
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_EDIT)) { %>
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
					CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_EDIT)
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
			<% if (CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER)
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
			<% if (CrmService.getInstance().userHasAuditorRight(user.getUserId(), gnItem.getMainid(), CrCategoryAuditorForm.RIGHTS_MANAGER)
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
			</tbody>
			</table>
		</div>
	</display:column>
</display:table>
<br>
<br>
<a class="beta" href="<%= redirect %>"><img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "crm.button.back") %></a>
