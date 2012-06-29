<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<h2><%= LanguageUtil.get(pageContext, "contacts.group.member.list") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<% 
   String groupid = request.getParameter("groupid"); 
   List groupMembers = (List)request.getAttribute("groupMembers");
   String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
%>
<form name="PA_CONTACTS_GROUP_MEMBERS_SEARCHFORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/listGroupMembers"/></portlet:actionURL>" method="post">
<input type="hidden" name="groupid" value="<%= groupid %>">
<%= LanguageUtil.get(pageContext, "contacts.search.name") %>
<input type="text" name="nameMatch" value="">
<input type="image" src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get( pageContext, "gn.button.search") %>">
</form>

<!-- Groups List -->

<%@ include file="/html/portlet/ext/parties/contacts/groups/members/memberList.jspf" %>

<br>

<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/listGroups"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "contacts.group.list") %></a>
