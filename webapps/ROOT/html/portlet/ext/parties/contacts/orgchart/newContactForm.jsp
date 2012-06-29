<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ include file="/html/portlet/ext/parties/contacts/util/currentURLcomplement.jspf" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>
<%@ page import="com.ext.portlet.parties.contacts.highroles.HighRoleDefinition" %>

<%@ page import="com.ext.portlet.parties.lucene.PartiesLuceneUtilities" %>

<%
String rootID = request.getParameter("rootID");
String selectedID = request.getParameter("selectedID");

String partyType = (String)request.getAttribute("partyType");
HighRoleDefinition highRoleDef = (HighRoleDefinition)request.getAttribute("highRoleDefinition");
String urlAction = "/ext/parties/contacts/orgchartAddNew?actionURL=true";
String buttonText = "parties.button.add";
%>

<tiles:insert page="/html/portlet/ext/parties/contacts/orgchart/orgchartTile.jsp" flush="true">
	<tiles:put name="rootID"><%= rootID %></tiles:put>
	<tiles:put name="selectedID"><%= selectedID %></tiles:put>
</tiles:insert>

<br>
<h2>
<% if (partyType.equals(PartiesLuceneUtilities.PARTY_TYPE_PERSON)) { %>
<%= LanguageUtil.get(pageContext, "contacts.orgchart.add-new-person") %>
	<% if (highRoleDef != null) {  %>
		(<%= LanguageUtil.get(pageContext, highRoleDef.getLanguageKey()) %>)
	<% } %>
<% } else { %>
<%= LanguageUtil.get(pageContext, "contacts.orgchart.add-new-department") %>
<% } %>
</h2>

<html:form action="<%= urlAction %>" method="post" styleClass="uni-form">


<bean:define id="labels1" name="ContactForm" property="genderKeys"/>
<bean:define id="labels2" name="ContactForm" property="physicalTypeKeys"/>
<bean:define id="labels3" name="ContactForm" property="addressTypeKeys"/>
<%
// correct the list of keys for translations to be shown properly
String[] labelsList1 = (String[])labels1;
for (int i=0; i<labelsList1.length; i++)
{
 	labelsList1[i] = LanguageUtil.get(pageContext, labelsList1[i]);
}
String[] labelsList2 = (String[])labels2;
for (int i=0; i<labelsList2.length; i++)
{
 	labelsList2[i] = LanguageUtil.get(pageContext, labelsList2[i]);
}
String[] labelsList3 = (String[])labels3;
for (int i=0; i<labelsList3.length; i++)
{
 	labelsList3[i] = LanguageUtil.get(pageContext, labelsList3[i]);
}
%>

<input type="hidden" name="rootID" value="<%= rootID %>">
<input type="hidden" name="selectedID" value="<%= selectedID %>">
<input type="hidden" name="partyType" value="<%= partyType %>">
<input type="hidden" name="loadaction" value="add">
<% if (highRoleDef != null) { %>
	<input type="hidden" name="highRoleId" value="<%= highRoleDef.getId() %>">
<% } else { %>
	<input type="hidden" name="addToOrgChart" value="true">
<% } %>

<tiles:insert page="/html/portlet/ext/struts_includes/metaData_div.jsp" flush="true">
	<tiles:put name="formName" value="ContactForm"/>
	<tiles:put name="attributeName" value="ContactForm_metadata_fields"/>
	<% if (partyType != null && partyType.equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_PERSON)) { %>
		<tiles:put name="className" value="gnomon.hibernate.model.parties.PaPerson"/>
	<% } else if (partyType != null && partyType.equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION)) { %>
		<tiles:put name="className" value="gnomon.hibernate.model.parties.PaOrganization"/>
	<% } else { %>
		<tiles:put name="className" value="gnomon.hibernate.model.parties.PaGroup"/>
	<% } %>
	<% com.ext.portlet.parties.contacts.ContactForm formBean = (com.ext.portlet.parties.contacts.ContactForm) request.getAttribute("ContactForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="ContactForm"/>
	<tiles:put name="useTabs" value="true"/>
</tiles:insert>

<% if (buttonText != null) { %>
 <div class="button-holder">
<html:submit><%= LanguageUtil.get(pageContext, buttonText) %></html:submit>
</div>
<%  } %>

</html:form>

<br>

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>
