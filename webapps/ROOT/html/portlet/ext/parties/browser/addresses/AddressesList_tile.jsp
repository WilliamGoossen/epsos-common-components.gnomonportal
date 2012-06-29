<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="gnomon.hibernate.model.parties.PaTelecomAddress" %>
<%@ page import="gnomon.hibernate.model.parties.PaEmailAddress" %>
<%@ page import="gnomon.hibernate.model.parties.PaWebpageAddress" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>


<tiles:useAttribute id="partyIdStr" name="partyIdStr" classname="java.lang.String" />
<tiles:useAttribute id="subTabLinkUrl" name="subTabLinkUrl" classname="java.lang.String" ignore="true"/>

<%
try{
	subTabLinkUrl = (subTabLinkUrl == null) ? "/ext/parties/browser/party_addresses_list" : subTabLinkUrl;
	
	String tableRequestUri = "/"+subTabLinkUrl+"?actionURL=true";
	
	String selectedSubTab = (String)request.getAttribute(Definitions.PARTY_ADDRESS_SELECTED_TAB);
	
	String geographicAddressLinkClass = null;
	String telecomAddressLinkClass = null;
	String emailAddressLinkClass = null;
	String webAddressLinkClass = null;
	
	if (selectedSubTab == null || selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_GEOGRAPHIC)) {
		selectedSubTab = Definitions.PARTY_ADDRESS_SUBTAB_GEOGRAPHIC;
		geographicAddressLinkClass = "title1";
	}else if (selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_TELECOM)){
		telecomAddressLinkClass = "title1";
	}else if (selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_EMAIL)){
		emailAddressLinkClass = "title1";
	}else if (selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_WEB)){
		webAddressLinkClass = "title1";
	}
	
	String partyIsPerson = (String)request.getAttribute(Definitions.PARTY_IS_PERSON);
	boolean isPersonFlag = partyIsPerson != null && partyIsPerson.equals(Definitions.C_TRUE);
	
	String windowState = ((RenderRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST)).getWindowState().toString();
	boolean popUpWindowState = windowState != null && windowState.equals(LiferayWindowState.POP_UP.toString());
	
	boolean hasPermissions = false;
	gnomon.hibernate.model.parties.PaPerson person = gnomon.hibernate.PartiesService.getInstance().getPaPerson(user.getUserId());
	if (!popUpWindowState && person != null && person.getMainid().toString().equals(partyIdStr))
		hasPermissions = true;
	if (!popUpWindowState && PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT))
		hasPermissions = true;
%>

<BR>

<form name="PA_PARTIES_BROWSER_PartyAddresses_Form" method="post" action="/some/url">
<!-- ================================================== -->
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <% if (geographicAddressLinkClass != null) {%><tiles:put name="cssClass"><%=geographicAddressLinkClass%></tiles:put><%}%>
  <tiles:put name="action"><%= subTabLinkUrl%></tiles:put>
  <tiles:put name="buttonName" value="ListGeographicAddressesButton" />
  <tiles:put name="buttonValue" value="parties.browser.tab.geographicAddress" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_PartyAddresses_Form" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.SELECTED_MAIN_ID%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SELECTED_TAB%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.PARTY_IS_PERSON%></tiles:add><%}%>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=partyIdStr%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SUBTAB_GEOGRAPHIC%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.C_TRUE%></tiles:add><%}%>
  </tiles:putList>
</tiles:insert>
<!-- ================================================== -->

<!-- ================================================== -->
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <% if (telecomAddressLinkClass != null) {%><tiles:put name="cssClass"><%=telecomAddressLinkClass%></tiles:put><%}%>
  <tiles:put name="action"><%= subTabLinkUrl%></tiles:put>
  <tiles:put name="buttonName" value="ListTelecomAddressesButton" />
  <tiles:put name="buttonValue" value="parties.browser.tab.telecomAddresses" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_PartyAddresses_Form" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.SELECTED_MAIN_ID%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SELECTED_TAB%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.PARTY_IS_PERSON%></tiles:add><%}%>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=partyIdStr%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SUBTAB_TELECOM%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.C_TRUE%></tiles:add><%}%>
  </tiles:putList>
</tiles:insert>
<!-- ================================================== -->

<!-- ================================================== -->
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <% if (emailAddressLinkClass != null) {%><tiles:put name="cssClass"><%=emailAddressLinkClass%></tiles:put><%}%>
  <tiles:put name="action"><%= subTabLinkUrl%></tiles:put>
  <tiles:put name="buttonName" value="ListEmailAddressesButton" />
  <tiles:put name="buttonValue" value="parties.browser.tab.emailAddresses" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_PartyAddresses_Form" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.SELECTED_MAIN_ID%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SELECTED_TAB%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.PARTY_IS_PERSON%></tiles:add><%}%>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=partyIdStr%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SUBTAB_EMAIL%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.C_TRUE%></tiles:add><%}%>
  </tiles:putList>
</tiles:insert>
<!-- ================================================== -->

<!-- ================================================== -->
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <% if (webAddressLinkClass != null) {%><tiles:put name="cssClass"><%=webAddressLinkClass%></tiles:put><%}%>
  <tiles:put name="action"><%= subTabLinkUrl%></tiles:put>
  <tiles:put name="buttonName" value="ListWebAddressesButton" />
  <tiles:put name="buttonValue" value="parties.browser.tab.webAddresses" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_PartyAddresses_Form" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.SELECTED_MAIN_ID%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SELECTED_TAB%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.PARTY_IS_PERSON%></tiles:add><%}%>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=partyIdStr%></tiles:add>
	<tiles:add><%=Definitions.PARTY_ADDRESS_SUBTAB_WEB%></tiles:add>
	<% if (isPersonFlag){%><tiles:add><%=Definitions.C_TRUE%></tiles:add><%}%>
  </tiles:putList>
</tiles:insert>
<!-- ================================================== -->

</form>

<BR>


<form name="PA_PARTIES_BROWSER_EditAddresses_Form" method="post" action="/some/url">

<%if (selectedSubTab == null || selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_GEOGRAPHIC)) {%>
<display:table id="partyAddressList" name="partyAddressList" sort="list" 
	requestURI="<%=tableRequestUri%>" pagesize="20">
	<%
		gnomon.hibernate.model.views.ViewResult listItem = (gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("partyAddressList");
	%>
	<display:column class="gamma1"  property="field4" titleKey="parties.addresses.geographic.country" sortable="true" headerClass="sortable"/>
	<display:column class="gamma1"  property="field2" titleKey="parties.addresses.geographic.region" sortable="true" headerClass="sortable"/>
 	<display:column class="gamma1"  property="field1" titleKey="parties.addresses.geographic.addressline" sortable="true" headerClass="sortable"/>
	<display:column class="gamma1"  property="field3" titleKey="parties.addresses.geographic.ziporpostcode" sortable="true" headerClass="sortable"/>
	<% 	if (hasPermissions) {%>
	<display:column style="text-align: left; white-space:nowrap;">
	<%
		java.util.Vector menuItemsVec = new java.util.Vector();
		DisplayTableActionMenuItem menuItem = null;

		// Edit
		menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
		themeDisplay.getPathThemeImage()+"/common/edit.png", 
		"parties.button.edit", true);
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_geographic_load");
		menuItem.addParamNameValue("selectedGeogrAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_EDIT);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);

		// Delete
		menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
		themeDisplay.getPathThemeImage()+"/common/delete.png", 
		"parties.button.delete", true, "parties.manager.addresses.delete-are-you-sure");
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_geographic_execute");
		menuItem.addParamNameValue("selectedGeogrAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_DELETE);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);
%>
<%= ListViewActionsMenuRenderer.renderMenu(listItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif", "gn.link.actions", menuItemsVec, request)%>
</display:column>
<% } %>
</display:table>

<% if (!popUpWindowState && hasPermissions) {%>
<BR>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_addresses_geographic_load" />
  <tiles:put name="buttonName" value="AddGeographicAddressButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_EditAddresses_Form" />
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

<%} //popUpWindowState%>

<%} else if (selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_TELECOM)) {%>
<display:table id="partyAddressList" name="partyAddressList" sort="list" 
	requestURI="<%=tableRequestUri%>" pagesize="20">
	<%
		PaTelecomAddress listItem = (PaTelecomAddress)pageContext.getAttribute("partyAddressList");
	%>
	<display:column class="gamma1"  property="physicalType" titleKey="parties.addresses.telecom.physicaltype" sortable="true" headerClass="sortable"/>
	<display:column class="gamma1"  property="phoneNumber" titleKey="parties.addresses.telecom.phonenumber" sortable="true" headerClass="sortable"/>
	<% 	if (hasPermissions) {%>
	<display:column style="text-align: left; white-space:nowrap;">
	<%
		java.util.Vector menuItemsVec = new java.util.Vector();
		DisplayTableActionMenuItem menuItem = null;

		// Edit
		menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
		themeDisplay.getPathThemeImage()+"/common/edit.png", 
		"parties.button.edit", true);
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_telecom_load");
		menuItem.addParamNameValue("selectedTelecomAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_EDIT);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);

		// Delete
		menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
		themeDisplay.getPathThemeImage()+"/common/delete.png", 
		"parties.button.delete", true, "parties.manager.addresses.delete-are-you-sure");
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_telecom_execute");
		menuItem.addParamNameValue("selectedTelecomAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_DELETE);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);
%>
<%= ListViewActionsMenuRenderer.renderMenu(listItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif", "gn.link.actions", menuItemsVec, request)%>
</display:column>
<% } %>
</display:table>

<% if (!popUpWindowState && hasPermissions) {%>
<BR>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_addresses_telecom_load" />
  <tiles:put name="buttonName" value="AddTelecomAddressButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_EditAddresses_Form" />
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

<% } // popUpWindowState%>

<%} else if (selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_EMAIL)) {%>
<display:table id="partyAddressList" name="partyAddressList" sort="list" 
	requestURI="<%=tableRequestUri%>" pagesize="20">
	<%
		PaEmailAddress listItem = (PaEmailAddress)pageContext.getAttribute("partyAddressList");
	%>
	<display:column class="gamma1"  property="emailAddress" titleKey="parties.addresses.email" sortable="true" headerClass="sortable"/>
	<% 	if (hasPermissions) {%>
	<display:column style="text-align: left; white-space:nowrap;">
	<%
		java.util.Vector menuItemsVec = new java.util.Vector();
		DisplayTableActionMenuItem menuItem = null;

		// Edit
		menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
		themeDisplay.getPathThemeImage()+"/common/edit.png", 
		"parties.button.edit", true);
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_email_load");
		menuItem.addParamNameValue("selectedEmailAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_EDIT);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);

		// Delete
		menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
		themeDisplay.getPathThemeImage()+"/common/delete.png", 
		"parties.button.delete", true, "parties.manager.addresses.delete-are-you-sure");
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_email_execute");
		menuItem.addParamNameValue("selectedEmailAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_DELETE);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);
%>
<%= ListViewActionsMenuRenderer.renderMenu(listItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif", "gn.link.actions", menuItemsVec, request)%>
</display:column>
<% } %>
</display:table>
<% if (!popUpWindowState && hasPermissions) {%>
<BR>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_addresses_email_load" />
  <tiles:put name="buttonName" value="AddEmailAddressButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_EditAddresses_Form" />
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

<%} // popUpWindowState)%>

<%} else if (selectedSubTab.equals(Definitions.PARTY_ADDRESS_SUBTAB_WEB)) {%>

<display:table id="partyAddressList" name="partyAddressList" sort="list" 
	requestURI="<%=tableRequestUri%>" pagesize="20">
	<%
		PaWebpageAddress listItem = (PaWebpageAddress)pageContext.getAttribute("partyAddressList");
	%>
	<display:column class="gamma1"  property="url" titleKey="parties.addresses.webpage.url" sortable="true" headerClass="sortable"/>
	<% 	if (hasPermissions) {%>
	<display:column style="text-align: left; white-space:nowrap;">
	<%
		java.util.Vector menuItemsVec = new java.util.Vector();
		DisplayTableActionMenuItem menuItem = null;

		// Edit
		menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
		themeDisplay.getPathThemeImage()+"/common/edit.png", 
		"parties.button.edit", true);
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_webpage_load");
		menuItem.addParamNameValue("selectedWebpageAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_EDIT);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);

		// Delete
		menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
		themeDisplay.getPathThemeImage()+"/common/delete.png", 
		"parties.button.delete", true, "parties.manager.addresses.delete-are-you-sure");
		menuItem.addParamNameValue("struts_action", "/ext/parties/browser/party_addresses_webpage_execute");
		menuItem.addParamNameValue("selectedWebpageAddressId", listItem.getMainid().toString());
		menuItem.addParamNameValue(Definitions.SELECTED_MAIN_ID, partyIdStr);
		menuItem.addParamNameValue(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_DELETE);
		if (isPersonFlag)
			menuItem.addParamNameValue(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		menuItemsVec.add(menuItem);
%>
<%= ListViewActionsMenuRenderer.renderMenu(listItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif", "gn.link.actions", menuItemsVec, request)%>
</display:column>
<% } %>
</display:table>
<% if (!popUpWindowState && hasPermissions) {%>
<BR>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_addresses_webpage_load" />
  <tiles:put name="buttonName" value="AddWebpageAddressButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_EditAddresses_Form" />
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

<%} // popUpWindowState)%>


<%}%>

</form>

<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>