<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>

<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="gnomon.hibernate.model.crm.CrFlow" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %></h2>

<!-- Request Flows List -->
<form name="CRM_Request_Flows_Form" action="/some/url" method="post">
<display:table id="crmFlow" name="flowsList" requestURI="//ext/crm/helpdesk/listFlows?actionURL=true" pagesize="20" sort="list" export="false" style="width: 100%;">
<% CrFlow gnItem = (CrFlow) pageContext.getAttribute("crmFlow"); %>
<display:column property="sentDate" titleKey="crm.helpdesk.flow.sentdate" decorator="org.displaytag.sample.LongDateWrapper" sortable="true"/>
<display:column titleKey="crm.helpdesk.flow.taskfrom" sortable="true">
<% gnomon.hibernate.model.parties.PaPerson person = gnomon.hibernate.PartiesService.getInstance().getPaPerson(gnItem.getTaskFrom());
   if (person == null)
	   out.print(gnItem.getTaskFrom());
   else
   {
	   String lang = gnomon.business.GeneralUtils.getLocale(request);
	   gnomon.hibernate.model.views.ViewResult personView  = (gnomon.hibernate.model.views.ViewResult)gnomon.hibernate.GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.parties.PaParty.class, person.getMainid(), lang, new String[]{"langs.description"});
	   if (personView != null)
		   out.print(personView.getField1().toString());
	   else
		   out.print(gnItem.getTaskFrom());
   }
%>
</display:column>
<display:column titleKey="crm.helpdesk.request.status" sortable="true">
<%= LanguageUtil.get(pageContext, CrRequestForm.translateStatus(gnItem.getStatus())) %>
</display:column>
<display:column>
<a title="<%= LanguageUtil.get(pageContext, "crm.button.view") %>" href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/crm/helpdesk/loadFlow"/>
		<portlet:param name="flowid" value="<%= gnItem.getMainid().toString() %>"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_articles.png" border="0" alt="<%= LanguageUtil.get(pageContext, "crm.button.view") %>">
</a>
</display:column>
</display:table>
</form>
<br>