<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>

<% try { %>

<h2><%= LanguageUtil.get(pageContext, "contacts.crm.assign-contact.list") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<% 
   String partyid = request.getParameter("partyid");
   String nameMatch = request.getParameter("nameMatch");
   if (nameMatch == null) nameMatch = "";
   List assignments = (List)request.getAttribute("assignments");
   String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
%>
<form name="PA_CONTACTS_ASSIGNMENTS_SEARCHFORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/listAssignments"/></portlet:actionURL>" method="post">
<input type="hidden" name="partyid" value="<%= partyid %>">
<%= LanguageUtil.get(pageContext, "contacts.search.name") %>
<input type="text" name="nameMatch" value="<%= nameMatch %>">
<input type="image" src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get( pageContext, "gn.button.search") %>">
</form>

<br>

<!-- Assignments List -->

<form name="PA_CONTACTS_ASSIGNMENTS_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/saveAssignments"/></portlet:actionURL>" method="post">
<input type="hidden" name="partyid" value="<%= partyid %>">
<input type="hidden" name="nameMatch" value="<%= nameMatch %>">
<display:table id="assigned" name="assignments" requestURI="//ext/parties/contacts/listAssignments?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("assigned"); %>
<display:column titleKey="contacts.crm.assign">
<input type="checkbox" name="assignedid" value="<%= partyItem.getMainid().toString() %>"
<% if (partyItem.getField12() != null && ((Boolean)partyItem.getField12()).booleanValue()) { %>
	checked="true"
<% } %>
>
</display:column>
<display:column title="<%= htmlTitle %>" sortable="true">
<% if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_PERSON )) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/person.gif">
<%}else if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION)) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/department.gif">
<%} else { %>
	<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/group.gif">
<% } %> 	
</display:column>
<display:column titleKey="contacts.search.name" sortable="true" >
<a title="<%= partyItem.getField1().toString() %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>">
<%= partyItem.getField1().toString() %>
</a>
</display:column>
<display:column property="field2" titleKey="contacts.search.email" sortable="true" />
<display:column property="field5" titleKey="contacts.search.phone" sortable="true" />
<display:column property="field10" titleKey="contacts.search.company" sortable="true" />
</display:table>
<br/>

<c:if test="<%= assignments != null && assignments.size() > 0 && (hasAdmin) %>">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "save") %>">
</c:if>
</form>

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>

<% } catch (Exception e) {} %>