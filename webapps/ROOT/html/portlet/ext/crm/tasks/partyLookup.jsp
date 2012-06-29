<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>



<% try {

	String lookupFieldIdHtmlId = request.getParameter("lookupFieldIdHtmlId");
	String lookupFieldDisplHtmlId = request.getParameter("lookupFieldDisplHtmlId");
	String openerFormName = request.getParameter("openerFormName");
%>

<%@ include file="/html/portlet/ext/struts_includes/Lookup_js.jsp" %>

<%
String lookupActionUrl = "/ext/crm/tasks/partyLookupAction?actionURL=true";
%>
<html:form action="<%= lookupActionUrl %>" method="post">
<table>
	<tr><td>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
		<tiles:put name="formName" value="CrmPartyLookupForm"/>
	</tiles:insert>
	</td><td>
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "crm.button.search") %>">
	</td></tr>
</table>
</html:form>
<br>
<%
List itemsList=(List) request.getAttribute("itemsList");
String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
%>
<form name="CRMParty_Lookup_List_Form" method="post" action="/some/url">
<h1><%= LanguageUtil.get(pageContext, "contacts.group.available.list" ) %></h1>
<display:table id="items" name="itemsList" requestURI="//ext/crm/tasks/partyLookupAction" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult partyItem = (ViewResult)pageContext.getAttribute("items"); %>
<display:column class="gamma">
<input type="radio" name="group1" value="<%=partyItem.getMainid() + "&" + partyItem.getField1() %>">
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
<display:column titleKey="contacts.search.name" sortable="true" sortProperty="field1">
<a title="<%= partyItem.getField1().toString() %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/load"/><portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>">
<%= partyItem.getField1().toString() %>
</a>
</display:column>
<display:column property="field2" titleKey="contacts.search.email" sortable="true" />
<display:column property="field5" titleKey="contacts.search.phone" sortable="true" />
<display:column property="field10" titleKey="contacts.search.company" sortable="true" />

</display:table>
<% if (itemsList != null && itemsList.size() > 0) { %>
<input type="button" class="portlet-form-button" name="Select" value="<%= LanguageUtil.get(pageContext, "party.lookup.button.select")%>" onclick="onSelect('CRMParty_Lookup_List_Form', 'group1')">
<% } %>
<input type="button" class="portlet-form-button" name="Clear" value="<%= LanguageUtil.get(pageContext, "party.lookup.button.clearLookup")%>" onclick="onClear()">

</form>


<% } catch (Exception e) {} %>