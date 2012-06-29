<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="gnomon.hibernate.model.parties.PaRegisteredIdentifier" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>


<%
try{
	String partyIdStr = (String)request.getAttribute(Definitions.SELECTED_MAIN_ID);
	String partyIdPerson = (String)request.getAttribute(Definitions.PARTY_IS_PERSON);
	boolean isPersonFlag = partyIdPerson != null && partyIdPerson.equals(Definitions.C_TRUE);
	String showTab = (String)request.getAttribute(Definitions.SHOW_TAB);

	String windowState = ((RenderRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST)).getWindowState().toString();
	boolean popUpWindowState = windowState != null && windowState.equals(LiferayWindowState.POP_UP.toString());

	boolean hasPermissions = false;
	gnomon.hibernate.model.parties.PaPerson person = gnomon.hibernate.PartiesService.getInstance().getPaPerson(user.getUserId());
	if (!popUpWindowState && person != null && person.getMainid().toString().equals(partyIdStr))
		hasPermissions = true;
	if (!popUpWindowState && PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT))
		hasPermissions = true;
		
if (showTab == null){	
if (isPersonFlag) {%>

<jsp:include page="../persons/PersonSummaryFormView.jsp" />

<%}else{%>

<jsp:include page="../organizations/OrganizationSummaryFormView.jsp" />

<%}
}
%>


<tiles:insert page="/html/portlet/ext/struts_includes/tabsbar.jsp" flush="true"/>

<TABLE class="ProjectMgmtTabCssClass" width="100%" >

<TR><TD>

<!-- ================================================== -->
<form name="PA_PARTIES_BROWSER_EditPartyIdentifiers_Form" method="post" action="/some/url">
	
<display:table id="identifierItem" name="partyIdentifiersList" 
	requestURI="//ext/parties/browser/partyIdentifiers_list?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">

	<%
		PaRegisteredIdentifier item = (PaRegisteredIdentifier)pageContext.getAttribute("identifierItem");
		String identifierType = "";
		
		try{
			if (item != null){
				
				identifierType = item.getIdentifierType();
				identifierType = "parties.manager.identifier."+identifierType .toLowerCase();
				identifierType = LanguageUtil.get(pageContext, identifierType);
			}
		}catch(Exception ex){}
	%>

<display:column titleKey="parties.manager.identifier.identifiertype">
	<%=identifierType%>
</display:column>

<display:column property="identifier" titleKey="parties.manager.identifier.identifier"/>
<display:column property="registrationAuthority" titleKey="parties.manager.identifier.registrationauthority"/>
<% 	if (hasPermissions) {%>
	<display:column style="text-align: left; white-space:nowrap;">
	<%
		java.util.Vector menuItemsVec = new java.util.Vector();
		DisplayTableActionMenuItem menuItem = null;

		// Edit
		menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
		themeDisplay.getPathThemeImage()+"/common/edit.png", 
		"parties.button.edit", true);
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_identifiers_load");
		menuItem.addParamNameValue("selectedPartyIdentierId", item.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_EDIT);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);

		// Delete
		menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
		themeDisplay.getPathThemeImage()+"/common/delete.png", 
		"parties.button.delete", true, "parties.general.confirm.delete");
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_identifiers_execute");
		menuItem.addParamNameValue("selectedPartyIdentierId", item.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_DELETE);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);
%>
<%= ListViewActionsMenuRenderer.renderMenu(item.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif", "gn.link.actions", menuItemsVec, request)%>
</display:column>
<% } %>
</display:table>

<!-- ================================================== -->
<% if (!popUpWindowState && hasPermissions) {%>
<BR>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_identifiers_load" />
  <tiles:put name="buttonName" value="AddIdentifierButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_EditPartyIdentifiers_Form" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.SELECTED_MAIN_ID%></tiles:add>
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
	<% if (isPersonFlag) {%><tiles:add><%=Definitions.PARTY_IS_PERSON%></tiles:add><%}%>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=partyIdStr%></tiles:add>
	<tiles:add><%=Definitions.LD_ACTION_ADD%></tiles:add>
	<% if (isPersonFlag) {%><tiles:add><%=Definitions.C_TRUE%></tiles:add><%}%>
  </tiles:putList>
</tiles:insert>

<%} // popUpWindowState%>
</form>


</TD></TR>
</TABLE>

<% if (!popUpWindowState) { %>
<br>

<%@ include file="/html/portlet/ext/parties/browser/footer.jsp" %>
<% } %>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>