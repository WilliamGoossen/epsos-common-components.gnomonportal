<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="gnomon.hibernate.model.parties.PaTelecomAddress" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>


<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String mainid = (String)request.getAttribute("mainid");
List addressesList=(List) request.getAttribute("addressesList");
%>

<!-- Addresses List -->

<form name="Party_Addresses_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-telecom-address") %></h2>

<display:table id="addresses" name="addressesList" requestURI="//ext/parties/manager/listTelecomAddresses?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% PaTelecomAddress addressItem = (PaTelecomAddress) addresses;%>

<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.parties.PaTelecomAddress)pageContext.getAttribute("addresses")).getMainid().toString()%>"></display:column>

<display:column class="gamma1" property="phoneNumber" titleKey="parties.addresses.telecom.phonenumber"/>
<display:column class="gamma1" property="countryCode" titleKey="parties.addresses.telecom.countrycode"/>
<display:column class="gamma1" property="areaCode" titleKey="parties.addresses.telecom.areacode"/>
<display:column class="gamma1" property="number" titleKey="parties.addresses.telecom.number"/>
<display:column class="gamma1" property="extension" titleKey="parties.addresses.telecom.extension"/>
<display:column class="gamma1" property="physicalType" titleKey="parties.addresses.telecom.physicaltype"/>

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Edit
menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
	themeDisplay.getPathThemeImage()+"/common/edit.png", 
	"parties.button.edit", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/loadTelecomAddress");
	menuItem.addParamNameValue("mainid", addressItem.getMainid().toString());
	menuItem.addParamNameValue("partyid", mainid);
	menuItem.addParamNameValue("loadaction", "view");
menuItemsVec.add(menuItem);

// Delete
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true, "parties.manager.addresses.delete-are-you-sure");
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/deleteTelecomAddress");
	menuItem.addParamNameValue("mainid", addressItem.getMainid().toString());
	menuItem.addParamNameValue("partyid", mainid);
menuItemsVec.add(menuItem);


// Related Geographic Addresses
menuItem = new DisplayTableActionMenuItem("parties.button.list-related-geographic", 
	null, 
	"parties.button.list-related-geographic", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listRelatedGeographicAddresses");
	menuItem.addParamNameValue("mainid", addressItem.getMainid().toString());
	menuItem.addParamNameValue("partyid", mainid);
	menuItem.addParamNameValue("listaction", "GeographicAddresses");
	menuItem.addParamNameValue("related", "true");	
menuItemsVec.add(menuItem);

%>
<%=ListViewActionsMenuRenderer.renderMenu(addressItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>
</display:column>

</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/loadTelecomAddress" />
  <tiles:put name="buttonName" value="addTelecomButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Party_Addresses_Button_Form" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<tiles:add value="loadaction"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  	<tiles:add value="add"/>
  </tiles:putList>
</tiles:insert>

</form>

<%@ include file="/html/portlet/ext/parties/manager/addressFooter.jsp" %>