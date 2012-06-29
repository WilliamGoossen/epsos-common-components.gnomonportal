<%@ include file="/html/portlet/ext/crm/helpdesk/stats/init.jsp" %>

<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequest" %>
<%@ page import="gnomon.hibernate.model.crm.CrCategory" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestType" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="com.ext.portlet.crm.helpdesk.stats.CrRequestStatsSearchForm" %>



<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
String searchItem = (String)request.getAttribute("searchItem");
String lang = GeneralUtils.getLocale(request);
String[] nameFields1 = new String[]{"langs.name"};
String[] nameFields2 = new String[]{"langs.description"};
GnPersistenceService serv = GnPersistenceService.getInstance(null);
PartiesService partiesServ = PartiesService.getInstance();
%>

<% boolean popup = false;
   String isPopup = (String)request.getAttribute("isPopup");
   if (isPopup != null && isPopup.equals("true"))
	   popup = true;
%>


<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.list1") %></h2>

<!-- Events List -->
<form name="CRM_Requests_ButtonForm" action="/some/url" method="post">
<display:table id="crmReq" name="itemsList" requestURI="//ext/crm/helpdeskStats/list?actionURL=true" pagesize="20" sort="list" export="true" style="font-weight: normal; width: 100%; border-spacing: 0">
<% CrRequest gnItem = (CrRequest) pageContext.getAttribute("crmReq");
	ViewResult catView = null, assignView = null, reqTypeView=null;
	String timeTaken = "-";
	if (gnItem!=null) {
		catView = serv.getObjectWithLanguage(CrCategory.class, gnItem.getCrCategory().getMainid(), lang, nameFields1);
		if (gnItem.getProAssignedTo() != null)
		{
			PaParty assignedPerson = partiesServ.getPaPerson(gnItem.getProAssignedTo());
			if (assignedPerson != null)
				assignView = serv.getObjectWithLanguage(PaParty.class, assignedPerson.getMainid(), lang, nameFields2);
		}
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
	<display:column titleKey="crm.helpdesk.request.type" sortable="true">

	<% 	reqTypeView = serv.getObjectWithLanguage(CrRequestType.class, gnItem.getReqType().getMainid(), lang, nameFields1);%>

		<%= reqTypeView != null && reqTypeView.getField1() != null? reqTypeView.getField1() : "" %>


	</display:column>
<% } %>
<display:column media="html">
<% if (gnItem.getCrRequest() == null) { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/scenario.gif" border="0" title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.scenario") %>" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.scenario") %>">
<% } else { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/task.gif" border="0" title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.task") %>" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.task") %>">
<% } %>
</display:column>
<display:column property="reqNumber" titleKey="crm.helpdesk.request.number" sortable="true" />
<% //if (CrmService.SHOW_REQUEST_TYPE) { 
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) {
%>
	<display:column property="reqProtocolNumber" titleKey="crm.helpdesk.request.protocolNumber" sortable="true" />
<% } %>
<display:column property="reqDate" titleKey="crm.helpdesk.request.date" sortable="true" decorator="org.displaytag.sample.LongDateWrapper"/>
<display:column titleKey="crm.helpdesk.request.timeTaken" sortable="true">
	<%= timeTaken %>
</display:column>
<display:column titleKey="crm.helpdesk.request.status" sortable="true">
<%= LanguageUtil.get(pageContext, CrRequestForm.translateStatus(gnItem.getStatus())) %>
</display:column>
<display:column titleKey="crm.helpdesk.request.subject" sortable="true">
<%= gnItem.getReqSubject() %>
</display:column>
<display:column  titleKey="crm.helpdesk.request.category" sortable="true">
<%= catView != null && catView.getField1() != null? catView.getField1() : "" %>
</display:column>
<display:column  titleKey="crm.helpdesk.request.assignedto" sortable="true">
<%= assignView != null && assignView.getField1() != null? assignView.getField1() : "" %>
</display:column>
<% if (!popup) { %>
<display:column media="html">
<span style="white-space:nowrap">
<a title="<%=LanguageUtil.get(pageContext, "crm.button.view") %>"
   href="<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>">
	<portlet:param name="struts_action" value="/ext/crm/helpdeskStats/load"/>
	<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
	<portlet:param name="loadaction" value="<%= CrRequestForm.LOADACTION_PRINT_VIEW %>"/>
	<portlet:param name="redirect" value="<%=currentURL%>"/>
	</portlet:actionURL>" target="_new_window">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/print.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.button.print-view") %>">
</a>
&nbsp;
<a title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>"
   href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="<%= LiferayWindowState.MAXIMIZED.toString() %>">
		<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestComments"/>
		<liferay-portlet:param name="requestid" value="<%= gnItem.getMainid().toString() %>"/>
		<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
		</liferay-portlet:actionURL>">
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>">
</a>
&nbsp;
<a title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>"
   href="<liferay-portlet:actionURL portletName="CRM_HELPDESK" windowState="<%= LiferayWindowState.MAXIMIZED.toString() %>">
		<liferay-portlet:param name="struts_action" value="/ext/crm/helpdesk/listFlows"/>
		<liferay-portlet:param name="crrequestid" value="<%= gnItem.getMainid().toString() %>"/>
		<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
		</liferay-portlet:actionURL>">
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/history.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>">
</a>
</span>
</display:column>
<% } %>
</display:table>
</form>

<% if (!popup) { %>
<br><br>
<%
CrRequestStatsSearchForm formBean = (CrRequestStatsSearchForm) request.getAttribute("CrRequestStatsSearchForm");
String extraParams = "&search=true";
if (Validator.isNotNull(formBean.getReqProtocolNumber()))
	extraParams += "&reqProtocolNumber="+formBean.getReqProtocolNumber();
if (Validator.isNotNull(formBean.getReqNumber()))
	extraParams += "&reqNumber="+formBean.getReqNumber();
if (Validator.isNotNull(formBean.getReqSubject()))
	extraParams += "&reqSubject="+formBean.getReqSubject();
if (Validator.isNotNull(formBean.getReqDateFrom()))
	extraParams += "&reqDateFrom="+formBean.getReqDateFrom();
if (Validator.isNotNull(formBean.getReqDateTo()))
	extraParams += "&reqDateTo="+formBean.getReqDateTo();
if (Validator.isNotNull(formBean.getReqType()))
	extraParams += "&reqType="+formBean.getReqType();
if (Validator.isNotNull(formBean.getStatus()))
	extraParams += "&status="+formBean.getStatus();
if (Validator.isNotNull(formBean.getCheckType()))
	extraParams += "&checkType="+formBean.getCheckType();
if (Validator.isNotNull(formBean.getCategoryid()))
	extraParams += "&categoryid="+formBean.getCategoryid();
if (Validator.isNotNull(formBean.getProPriority()))
	extraParams += "&proPriority="+formBean.getProPriority();
if (Validator.isNotNull(formBean.getOfficerid()))
	extraParams += "&officerid="+formBean.getOfficerid();
if (Validator.isNotNull(formBean.getDepartmentid()))
	extraParams += "&departmentid="+formBean.getDepartmentid();
%>
<ul>
<li><img src="<%=  themeDisplay.getPathThemeImage() %>/common/print.png" border="0" align="middle">&nbsp;<a target="_new_window" href="<%= currentURL.replace("p_p_state=normal", "p_p_state=pop_up").replace("p_p_state=maximized", "p_p_state=pop_up")+extraParams %>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.print-view") %></a></li>
<li><img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskStats/list"/><portlet:param name="search" value="false"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.back-to-search1") %></a></li>
</ul>
<% } %>