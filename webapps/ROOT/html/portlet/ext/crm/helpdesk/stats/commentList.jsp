<%@ include file="/html/portlet/ext/crm/helpdesk/stats/init.jsp" %>

<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequest" %>
<%@ page import="gnomon.hibernate.model.crm.CrCheckType" %>
<%@ page import="gnomon.business.GeneralUtils" %>


<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<% boolean popup = false;
   String isPopup = (String)request.getAttribute("isPopup");
   if (isPopup != null && isPopup.equals("true"))
	   popup = true;

%>

<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<display:table id="crmReq" name="itemsList" requestURI="//ext/crm/helpdeskStats/listComments?actionURL=true" pagesize="20" sort="list" export="true" style="font-weight: normal; width: 100%; border-spacing: 0">
<% gnomon.hibernate.model.views.ViewResult gnItem = (gnomon.hibernate.model.views.ViewResult) pageContext.getAttribute("crmReq");
%>

<display:column property="field1" titleKey="crm.helpdesk.request.number" sortable="true" />
<display:column property="field2" titleKey="crm.helpdesk.request.comment.date" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field5" titleKey="crm.helpdesk.request.comment.partyid" sortable="true" />
<display:column property="field3" titleKey="crm.helpdesk.request.comment.title" sortable="true" />
<display:column property="field4" titleKey="crm.helpdesk.request.comment.text" sortable="true" />
</display:table>

<% if (!popup) { %>
<br>
<ul>
<li><img src="<%=  themeDisplay.getPathThemeImage() %>/common/print.png" border="0" align="middle">&nbsp;<a target="_new_window" href="<%= currentURL.replace("p_p_state=normal", "p_p_state=pop_up") %>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.print-view") %></a></li>
<li><img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;<a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "crm.button.back") %></a></li>
</ul>
<% } %>