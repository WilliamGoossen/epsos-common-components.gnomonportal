<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<h2><%= LanguageUtil.get(pageContext, "contacts.group.available.list") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<% 
  String groupid = request.getParameter("groupid");
  List availableContacts = (List)request.getAttribute("availableContacts");
  String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
%>

<form name="PA_CONTACTS_GROUP_MEMBERS_SEARCHFORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/listAvailableContacts"/></portlet:actionURL>" method="post">
<input type="hidden" name="groupid" value="<%= groupid %>">
<%= LanguageUtil.get(pageContext, "contacts.search.name") %>
<input type="text" name="nameMatch" value="">
<input type="image" src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get( pageContext, "gn.button.search") %>">
</form>

<!-- Groups List -->
<form name="PA_CONTACTS_GROUP_MEMBERS_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/addGroupMembers"/></portlet:actionURL>" method="post">
<input type="hidden" name="groupid" value="<%= groupid %>">
<display:table id="groupMember" name="availableContacts" requestURI="//ext/parties/contacts/listAvailableContacts?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("groupMember"); %>
<display:column>
<input type="checkbox" name="partyid" value="<%= partyItem.getMainid().toString() %>">
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

<c:if test="<%= availableContacts != null && availableContacts.size() > 0 && (hasEdit || hasDelete) %>">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "contacts.group.member.add") %>">
</c:if>
</form>

<br>

<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/listGroups"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "contacts.group.list") %></a>
