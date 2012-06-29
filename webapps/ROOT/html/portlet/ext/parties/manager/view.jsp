<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<%
try{

List personList=(List) request.getAttribute("personList");
List organizationList=(List) request.getAttribute("organizationList");
String searchString = (String) request.getAttribute("searchString");
if (searchString == null) searchString = "*";
%>
<% if (titleData == null) { %>
<!-- only add the search form and button if in general listing view, not when viewing related parties -->
<br>
<form name="parties_search_form" method="post" action="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/parties/manager/viewParties" />
					</portlet:actionURL>" method="post">
<input type="submit" class="portlet-form-button" name="submit" value="<%= LanguageUtil.get(pageContext, "parties.button.search") %>">
<input type="text"  name="searchString" value="<%= searchString %>">
</form>
<br><hr><br>
<% } 


%>

<form name="Parties_Person_List_Form" method="post" action="/some/url">
<h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-persons") %></h2>
<display:table id="persons" name="personList" requestURI="//ext/parties/manager/viewParties?actionURL=true" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0" excludedParams="struts_action">
<% ViewResult personItem = (ViewResult) pageContext.getAttribute("persons");%>
	

<display:column class="gamma1" titleKey="parties.manager.person.name" sortable="true" >
<%= (personItem.getField2() != null ? personItem.getField2().toString() :"")+ " "+ (personItem.getField3() != null? personItem.getField3().toString() :"") + " "+ (personItem.getField1() != null? personItem.getField1().toString() : "")%>
</display:column>

<display:column class="gamma1" property="field4" titleKey="parties.manager.person.gender" sortable="true" />

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Edit
menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
	themeDisplay.getPathThemeImage()+"/common/edit.png", 
	"parties.button.edit", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/loadPerson");
	menuItem.addParamNameValue("mainid", personItem.getMainid().toString());
	menuItem.addParamNameValue("redirect", currentURL);
menuItemsVec.add(menuItem);

// Roles
menuItem = new DisplayTableActionMenuItem("parties.button.roles", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRoles");
	menuItem.addParamNameValue("partyid", personItem.getMainid().toString());
	menuItem.addParamNameValue("redirect", currentURL);
menuItemsVec.add(menuItem);

// Relationships
menuItem = new DisplayTableActionMenuItem("parties.button.rels", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRels");
	menuItem.addParamNameValue("partyid", personItem.getMainid().toString());
	menuItem.addParamNameValue("redirect", currentURL);
menuItemsVec.add(menuItem);

// Related Parties
menuItem = new DisplayTableActionMenuItem("parties.button.relparties", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRelParties");
	menuItem.addParamNameValue("partyid", personItem.getMainid().toString());
	menuItem.addParamNameValue("redirect", currentURL);
menuItemsVec.add(menuItem);

// Delete
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true, "parties.manager.party.delete-are-you-sure");
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/deleteParty");
	menuItem.addParamNameValue("partyid", personItem.getMainid().toString());
	menuItem.addParamNameValue("redirect", currentURL);
	menuItem.setPermissionPortletId("PA_PARTIES_MANAGER");
	menuItem.setActionPermission("admin");
menuItemsVec.add(menuItem);
%>
<%=ListViewActionsMenuRenderer.renderMenu(personItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>
</display:column>
</display:table>

<% if (titleData == null) { %>
<!-- only add the add person button if in general listing view, not when viewing related parties -->
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/loadNewPerson" />
  <tiles:put name="buttonName" value="addPersonButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Person_List_Form" />
</tiles:insert>
<% }

%>
</form>

<br>

<br>

<form name="Parties_Organization_List_Form" method="post" action="/some/url">

<h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-organizations") %></h2>
<display:table id="organizations" name="organizationList" requestURI="//ext/parties/manager/viewParties" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult organizationItem = (ViewResult) organizations;%>
<display:column class="gamma1" property="field1" titleKey="parties.manager.organization.name" sortable="true" href="//ext/parties/manager/loadOrganizationSummary?actionURL=true" paramId="partyid" paramProperty="mainid"/>
<display:column property="field3" titleKey="parties.admin.organizationtype.name" sortable="true"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.organizationtype.description" sortable="true"/>

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Edit
menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
	themeDisplay.getPathThemeImage()+"/common/edit.png", 
	"parties.button.edit", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/loadOrganization");
	menuItem.addParamNameValue("mainid", organizationItem.getMainid().toString());
menuItemsVec.add(menuItem);

// Roles
menuItem = new DisplayTableActionMenuItem("parties.button.roles", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRoles");
	menuItem.addParamNameValue("partyid", organizationItem.getMainid().toString());
menuItemsVec.add(menuItem);

// Relationships
menuItem = new DisplayTableActionMenuItem("parties.button.rels", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRels");
	menuItem.addParamNameValue("partyid", organizationItem.getMainid().toString());
menuItemsVec.add(menuItem);

// Related Parties
menuItem = new DisplayTableActionMenuItem("parties.button.relparties", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRelParties");
	menuItem.addParamNameValue("partyid", organizationItem.getMainid().toString());
menuItemsVec.add(menuItem);

// Delete
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true, "parties.manager.party.delete-are-you-sure");
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/deleteParty");
	menuItem.addParamNameValue("partyid", organizationItem.getMainid().toString());
	menuItem.setPermissionPortletId("PA_PARTIES_MANAGER");
	menuItem.setActionPermission("admin");
menuItemsVec.add(menuItem);
%>
<%=ListViewActionsMenuRenderer.renderMenu(organizationItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>
</display:column>

</display:table>

<% if (titleData == null) { %>
<!-- only add the add organization button if in general listing view, not when viewing related parties -->
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/loadNewOrganization" />
  <tiles:put name="buttonName" value="addOrganizationButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Organization_List_Form" />
</tiles:insert>
<% }%>
</form>

<%
}catch(Exception ex){
ex.printStackTrace();
}
%>