<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<br>

<%
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
if (loadaction != null && loadaction.equals("edit")) {
	urlAction = "/ext/parties/contacts/update?actionURL=true";
	buttonText = "parties.button.update";
}
else if (loadaction != null && loadaction.equals("add")) {
	urlAction = "/ext/parties/contacts/add?actionURL=true";
	buttonText = "parties.button.add";
}
else if (loadaction != null && loadaction.equals("delete")) {
	urlAction = "/ext/parties/contacts/delete?actionURL=true";
	buttonText = "parties.button.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	urlAction = "/ext/parties/contacts/add?actionURL=true";
	buttonText = "gn.button.add-translation";
}
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



<% if (buttonText != null) { %>
 <div class="button-holder">
<html:submit><%= LanguageUtil.get(pageContext, buttonText) %></html:submit>

<logic:notEqual name="ContactForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans") && showMultiLingualForm %>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/parties/contacts/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="ContactForm" />
		  <tiles:put name="confirm" value="gn.messages.are-you-sure-you-want-to-delete-this-translation"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>
</div>
<%  } %>

</html:form>


<c:if test="<%=loadaction.equals("edit") && showMultiLingualForm %>">
	<br>
	<p><h3 class="title2"><%= LanguageUtil.get(pageContext, "gn.translations" ) %></h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/parties/contacts/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/parties/contacts/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<br>

<% if (!loadaction.equals("add") && partyType.equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_GROUP)) {
	String groupid = (String)request.getAttribute("groupid"); 
	List groupMembers = (List)request.getAttribute("groupMembers");
	String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";

%>
<h2><%= LanguageUtil.get(pageContext, "contacts.group.member.list") %></h2>
<%@ include file="/html/portlet/ext/parties/contacts/groups/members/memberList.jspf" %>
<% } %>

<% if(!themeDisplay.isStatePopUp()) { %>
<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>
<% } %>