<%@ include file="/html/portlet/ext/crm/helpdesk/stats/init.jsp" %>

<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequest" %>
<%@ page import="gnomon.hibernate.model.crm.CrCheckType" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestType" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="com.ext.portlet.crm.helpdesk.stats.CrRequestXTabStatsForm" %>


<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<% String searchItem = (String)request.getAttribute("searchItem"); %>

<% boolean popup = false;
   String isPopup = (String)request.getAttribute("isPopup");
   if (isPopup != null && isPopup.equals("true"))
	   popup = true;

   String reqDateFrom = (String) request.getAttribute("reqDateFrom");
   String reqDateTo = (String) request.getAttribute("reqDateTo");
   String status = (String) request.getAttribute("status");
   String categoryid = (String)request.getAttribute("categoryid");

%>


<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.list2") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<!-- Events List -->

<display:table id="crmReq" name="itemsList" requestURI="//ext/crm/helpdeskStats/listStats?actionURL=true" pagesize="20" sort="list" export="true" style="font-weight: normal; width: 100%; border-spacing: 0">
<% gnomon.hibernate.model.views.ViewResult gnItem = (gnomon.hibernate.model.views.ViewResult) pageContext.getAttribute("crmReq");
%>
<display:column property="field1" group="1" titleKey="crm.helpdesk.category.officerid" sortable="true" />
<display:column property="field4" titleKey="crm.helpdesk.request.stats.count-total-requests" sortable="true" media="excel pdf csv xml"/>

<% if ( GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-check-type"),false)) { %>
	<display:column property="field3" titleKey="crm.helpdesk.checktype.name"/>
	<display:column  titleKey="crm.helpdesk.request.stats.count-total-requests"  media="html">
	<% if (gnItem.getField5() != null) { %>
	<a title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.list") %>" href="<portlet:actionURL>
	<portlet:param name="struts_action" value="/ext/crm/helpdeskStats/list"/>
	<portlet:param name="checkType" value="<%= gnItem.getField5().toString() %>"/>
	<portlet:param name="reqDateFrom" value="<%= reqDateFrom %>"/>
	<portlet:param name="reqDateTo" value="<%= reqDateTo %>"/>
	<portlet:param name="status" value="<%= status %>"/>
	<portlet:param name="categoryid" value="<%= categoryid %>"/>
	<portlet:param name="officerid" value="<%= gnItem.getMainid().toString() %>"/>
	<portlet:param name="search" value="true"/>
	<portlet:param name="redirect" value="<%= currentURL %>"/>
	</portlet:actionURL>">
	<%= gnItem.getField4() %>
	</a>
	<% } else { %>
	<%= gnItem.getField4() %>
	<% }  %>
	<%	if (!popup && gnItem.getField5() != null) { %>
	<a title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>" href="<portlet:actionURL>
	<portlet:param name="struts_action" value="/ext/crm/helpdeskStats/listComments"/>
	<portlet:param name="checkTypeId" value="<%= gnItem.getField5().toString() %>"/>
	<portlet:param name="reqDateFrom" value="<%= reqDateFrom %>"/>
	<portlet:param name="reqDateTo" value="<%= reqDateTo %>"/>
	<portlet:param name="status" value="<%= status %>"/>
	<portlet:param name="categoryid" value="<%= categoryid %>"/>
	<portlet:param name="officerid" value="<%= gnItem.getMainid().toString() %>"/>
	<portlet:param name="redirect" value="<%= currentURL %>"/>
	</portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>">
	</a>
	<% } %>
	</display:column>
<% } else if ( GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) { %>
	<display:column property="field3" titleKey="crm.helpdesk.requesttype.name"/>
	<display:column  titleKey="crm.helpdesk.request.stats.count-total-requests" sortable="true" media="html">
	<% if (gnItem.getField5() != null) { %>
	<a title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.list") %>" href="<portlet:actionURL>
	<portlet:param name="struts_action" value="/ext/crm/helpdeskStats/list"/>
	<portlet:param name="reqType" value="<%= gnItem.getField5().toString() %>"/>
	<portlet:param name="reqDateFrom" value="<%= reqDateFrom %>"/>
	<portlet:param name="reqDateTo" value="<%= reqDateTo %>"/>
	<portlet:param name="status" value="<%= status %>"/>
	<portlet:param name="categoryid" value="<%= categoryid %>"/>
	<portlet:param name="officerid" value="<%= gnItem.getMainid().toString() %>"/>
	<portlet:param name="search" value="true"/>
	<portlet:param name="redirect" value="<%= currentURL %>"/>
	</portlet:actionURL>">
	<%= gnItem.getField4() %>
	</a>
	<% } else { %>
	<%= gnItem.getField4() %>
	<% } %>
	<%	if (!popup && gnItem.getField5() != null) { %>
	<a title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>" href="<portlet:actionURL>
	<portlet:param name="struts_action" value="/ext/crm/helpdeskStats/listComments"/>
	<portlet:param name="reqType" value="<%= gnItem.getField5().toString()%>"/>
	<portlet:param name="reqDateFrom" value="<%= reqDateFrom %>"/>
	<portlet:param name="reqDateTo" value="<%= reqDateTo %>"/>
	<portlet:param name="status" value="<%= status %>"/>
	<portlet:param name="categoryid" value="<%= categoryid %>"/>
	<portlet:param name="officerid" value="<%= gnItem.getMainid().toString() %>"/>
	<portlet:param name="redirect" value="<%= currentURL %>"/>
	</portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>">
	</a>
	<% } %>
	</display:column>
<% } %>

</display:table>

<% if (!popup) { %>
<br>
<%
String extraParams = "&search=true";
CrRequestXTabStatsForm formBean = (CrRequestXTabStatsForm) request.getAttribute("CrRequestXTabStatsForm");
if (Validator.isNotNull(formBean.getReqDateFrom()))
	extraParams += "&reqDateFrom="+formBean.getReqDateFrom();
if (Validator.isNotNull(formBean.getReqDateTo()))
	extraParams += "&reqDateTo="+formBean.getReqDateTo();
if (Validator.isNotNull(formBean.getStatus()))
	extraParams += "&status="+formBean.getStatus();
if (Validator.isNotNull(formBean.getCategoryid()))
	extraParams += "&categoryid="+formBean.getCategoryid();
if (Validator.isNotNull(formBean.getOfficerid()))
	extraParams += "&officerid="+formBean.getOfficerid();
if (Validator.isNotNull(formBean.getDepartmentid()))
	extraParams += "&departmentid="+formBean.getDepartmentid();
%>
<ul>
<li><img src="<%=  themeDisplay.getPathThemeImage() %>/common/print.png" border="0" align="middle">&nbsp;<a target="_new_window" href="<%= currentURL.replace("p_p_state=normal", "p_p_state=pop_up").replace("p_p_state=maximized", "p_p_state=pop_up")+extraParams %>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.print-view") %></a></li>
<li><img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskStats/listStats"/><portlet:param name="search" value="false"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.back-to-search2") %></a></li>
</ul>
<% } %>