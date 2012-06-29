<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>
<%@ page import="gnomon.hibernate.model.parties.PaRegisteredIdentifier" %>
<table>
<tr>
<td valign="top">
<%
String chartid = (String) request.getParameter("chartid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td valign="top">
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String partyid = (String)request.getAttribute("mainid");
List identifiersList=(List) request.getAttribute("identifiersList");
%>

<!-- Party Identifiers Names List -->

<form name="Parties_Identifiers_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-identifier") %></h2>

<display:table id="identifiers" name="identifiersList" requestURI="//ext/parties/orgchart/listPartyIdentifiers?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% PaRegisteredIdentifier identifierItem = (PaRegisteredIdentifier) identifiers;%>

<display:column class="gamma1" property="identifierType" titleKey="parties.manager.identifier.identifiertype"/>
<display:column class="gamma1" property="identifier" titleKey="parties.manager.identifier.identifier"/>
<display:column class="gamma1" property="registrationAuthority" titleKey="parties.manager.identifier.registrationauthority"/>
<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Edit Identifier
menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
	themeDisplay.getPathThemeImage()+"/common/edit.png", "parties.button.edit", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/orgchart/loadPartyIdentifier");
	menuItem.addParamNameValue("mainid", identifierItem.getMainid().toString());
	menuItem.addParamNameValue("partyid", partyid);
	if (chartid != null) menuItem.addParamNameValue("chartid", chartid);
menuItemsVec.add(menuItem);

// Delete Identifier
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/orgchart/loadPartyIdentifier");
	menuItem.addParamNameValue("mainid", identifierItem.getMainid().toString());
	menuItem.addParamNameValue("delete", identifierItem.getMainid().toString());
	menuItem.addParamNameValue("partyid", partyid);
	if (chartid != null) menuItem.addParamNameValue("chartid", chartid);
menuItemsVec.add(menuItem);

%>

<%=ListViewActionsMenuRenderer.renderMenu(identifierItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>
</display:column>
</display:table>


<input type="hidden" name="chartid" value="<%=chartid%>">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadPartyIdentifier" />
  <tiles:put name="buttonName" value="addButtonPartyIdentifier" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Identifiers_Button_Form" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
  <tiles:putList name="actionParamList">
   	<tiles:add value="partyid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
   	<tiles:add><%= partyid %></tiles:add>
  </tiles:putList>
</tiles:insert>


</form>
<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>