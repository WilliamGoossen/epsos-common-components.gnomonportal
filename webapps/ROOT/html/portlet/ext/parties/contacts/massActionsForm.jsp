<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<h2>
<%
String loadaction = (String)request.getAttribute("loadaction");
if (loadaction.equals("massDelete")) {
	out.print(LanguageUtil.get(pageContext, "contacts.group.select.mass-delete"));
} else if (loadaction.equals("massMembers")) {
	out.print(LanguageUtil.get(pageContext, "contacts.group.select.mass-add-members"));
}
%>
</h2>

<html:errors/>

<% List itemsList = (List)request.getAttribute("itemsList");
   if (itemsList != null) { 
   
  String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
   %>

<form name="PA_CONTACTS_RESULTS_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/executeMassContacts"/></portlet:actionURL>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<display:table id="item" name="itemsList" requestURI="//ext/parties/contacts/loadMassContacts?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">   
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("item"); %>
<% if (hasEdit) { %>
<display:column>
<input type="checkbox" name="contactid" value="<%= partyItem.getMainid().toString() %>" checked="true">
</display:column>
<% } %>
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
<br>
<% } 
	
   List groups = (List)request.getAttribute("groups");
   if (loadaction.equals("massMembers") && groups != null && groups.size()>0) {
	   %>
	   <br>
	   <%= LanguageUtil.get(pageContext, "contacts.group.name") %>&nbsp;&nbsp;
	   <select name="groupid">
	   		<% for (int g=0; g<groups.size(); g++) {  
	   				ViewResult groupView = (ViewResult)groups.get(g); %>
	   				<option value="<%= groupView.getMainid().toString() %>"><%= groupView.getField1().toString() %></option>
	   		<% } %>
	   </select><br>
	   <%
   }
%>   

<br>
<% if (hasAdd || hasAdmin) { %>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "contacts.group.execute-action") %>">
<br>
<% }  %>

</form>

<br>