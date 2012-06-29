<%@ include file="/html/portlet/ext/epsos/consent/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%@ page import="com.ext.portlet.epsos.*" %>
<%@ page import="com.ext.portlet.epsos.consent.PatientConsentObject" %>


<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h3><%= LanguageUtil.get(pageContext, "epsos.consent.list") %></h3>
<%
List<PatientConsentObject> consentsList = (List<PatientConsentObject>)request.getAttribute("consentsList");
if (consentsList != null && consentsList.size() > 0) { %>

<display:table id="consent" name="consentsList" requestURI="//ext/epsos/consent/list?actionURL=true" pagesize="25" sort="list" export="true" style="width: 100%;">

<display:setProperty name="export.excel" value="true" />
<display:setProperty name="export.excel.filename" value="PatientConsents.xls" />
<display:setProperty name="export.pdf" value="true" />
<display:setProperty name="export.pdf.filename" value="PatientConsents.pdf" />
<display:setProperty name="export.csv" value="true" />
<display:setProperty name="export.csv.filename" value="PatientConsents.csv" />
<display:setProperty name="export.xml" value="true" />
<display:setProperty name="export.xml.filename" value="PatientConsents.xml" />


<%  PatientConsentObject con = (PatientConsentObject) pageContext.getAttribute("consent"); %>

<display:column property="country" titleKey="epsos.consent.country" sortable="true"/>
<display:column property="creationDate" titleKey="epsos.consent.creationDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
<display:column property="validFrom" titleKey="epsos.consent.validFrom" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
<display:column property="validTo" titleKey="epsos.consent.validTo" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"/>

<display:column media="html" style="white-space:nowrap;">
<a title="<%= LanguageUtil.get(pageContext, "epsos.consent.view") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/consent/loadConsent"/>
<portlet:param name="loadaction" value="view"/>
<portlet:param name="consentid" value="<%= con.getConsentid() %>"/>
<portlet:param name="patID" value="<%= request.getParameter("patID") %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/view.png" alt="view"></a>
&nbsp;
<% if (hasEdit) { %>
<a title="<%= LanguageUtil.get(pageContext, "epsos.consent.edit") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/consent/loadConsent"/>
<portlet:param name="loadaction" value="edit"/>
<portlet:param name="consentid" value="<%= con.getConsentid() %>"/>
<portlet:param name="patID" value="<%= request.getParameter("patID") %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" alt="edit"></a>
&nbsp;
<% } %>
<% if (hasDelete) { %>
<a title="<%= LanguageUtil.get(pageContext, "epsos.consent.delete") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/consent/loadConsent"/>
<portlet:param name="loadaction" value="delete"/>
<portlet:param name="consentid" value="<%= con.getConsentid() %>"/>
<portlet:param name="patID" value="<%= request.getParameter("patID") %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" alt="delete"></a>
<% } %>
</display:column>


</display:table>

<%} %>

<% if (hasAdd) { %>
<br>
<a title="<%= LanguageUtil.get(pageContext, "gn.link.view") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/consent/loadConsent"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="patID" value="<%= request.getParameter("patID") %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/add_instance.png" alt="add">
<%= LanguageUtil.get(pageContext, "epsos.consent.add") %></a>
<% } %>

<br>
<br>
<a href="<%= redirect %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="back"><%= LanguageUtil.get(pageContext, "back") %></a>
