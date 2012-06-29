<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String mainid = (String)request.getAttribute("mainid");
List rolesList=(List) request.getAttribute("rolesList");
%>

<!-- Party Roles List -->

<form name="Parties_Roles_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-roles") %></h2>

<display:table id="roles" name="rolesList" requestURI="//ext/parties/manager/listPartyRoles?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult roleItem = (ViewResult) roles;%>

<display:column class="gamma1" property="field2" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyroletype.description"/>

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Edit Feature Instances
menuItem = new DisplayTableActionMenuItem("parties.button.edit-feature-instances", 
	themeDisplay.getPathThemeImage()+"/common/edit.png", 
	"parties.button.edit-feature-instances", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/loadPartyRoleFeatures");
	menuItem.addParamNameValue("partyroleid", roleItem.getMainid().toString());
menuItemsVec.add(menuItem);

// Delete Party Role
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true, "parties.manager.role.delete-are-you-sure");
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/deletePartyRole");
	menuItem.addParamNameValue("partyid", mainid);
	menuItem.addParamNameValue("roleid", roleItem.getMainid().toString());
	menuItem.setPermissionPortletId("PA_PARTIES_MANAGER");
	menuItem.setActionPermission("admin");
menuItemsVec.add(menuItem);

// Relationships
menuItem = new DisplayTableActionMenuItem("parties.button.rels", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRels");
	menuItem.addParamNameValue("partyid", mainid);
	menuItem.addParamNameValue("roleid", roleItem.getMainid().toString());
menuItemsVec.add(menuItem);

// Related Parties
menuItem = new DisplayTableActionMenuItem("parties.button.relparties", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRelParties");
	menuItem.addParamNameValue("partyid", mainid);
	menuItem.addParamNameValue("roleid", roleItem.getMainid().toString());
menuItemsVec.add(menuItem);

%>
<%=ListViewActionsMenuRenderer.renderMenu(roleItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>
</display:column>

</display:table>

<table><tr><td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listPartyRoleTypes" />
  <tiles:put name="buttonName" value="addRoleButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Roles_Button_Form" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_MANAGER"/>
</tiles:insert>
</td>

</tr></table>
</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>