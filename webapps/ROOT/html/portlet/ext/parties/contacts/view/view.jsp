<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<br>

<%
String companySpecificFile = "/html/portlet/ext/parties/contacts/view/view_"+com.liferay.portal.util.PortalUtil.getCompanyId(request)+".jsp";
boolean exists = (new java.io.File(CommonUtil.getRootPath(request) + companySpecificFile)).exists();
if (exists) { %>
	<jsp:include page="<%= companySpecificFile %>" flush="true"/>
<% } else {

PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}
boolean showMultiLingualForm = GetterUtil.getBoolean(prefs.getValue("showMultiLingualForm", StringPool.BLANK), false);

String partyType = (String)request.getAttribute("partyType");
String loadaction = (String)request.getAttribute("loadaction");
String urlAction = "/ext/parties/contacts/load?actionURL=true";
String buttonText = null;
%>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>

<html:form action="<%= urlAction %>" method="post" styleClass="uni-form" enctype="multipart/form-data">


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


<input type="hidden" name="partyType" value="<%= partyType %>">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="redirect" value="<%= redirect %>">

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
	<% if (loadaction == null || loadaction.equals("view") ||  loadaction.equals("delete")) { %>
		<tiles:put name="readOnly" value="true" />
	<% } %>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="ContactForm"/>
	<tiles:put name="useTabs" value="true"/>
</tiles:insert>


</html:form>


<br>

<% if (!loadaction.equals("add") && partyType.equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_GROUP)) {
	String groupid = (String)request.getAttribute("groupid"); 
	List groupMembers = (List)request.getAttribute("groupMembers");
	String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";

%>
<h3><%= LanguageUtil.get(pageContext, "contacts.group.member.list") %></h3>
<%@ include file="/html/portlet/ext/parties/contacts/groups/members/memberList.jspf" %>
<% } %>

<% if(!themeDisplay.isStatePopUp() && !themeDisplay.isStateMaximized()) { %>
<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>
<% } %>

<% } // if !exists company-specific page %> 