<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% 
try{

TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<%
String mainid = (String)request.getAttribute("mainid");
String roleid = (String)request.getAttribute("roleid");
String roleName = (String) titleData.getValue("roleName");
String partyDescription = (String) request.getAttribute("partyDescription");
List relsListClient=(List) request.getAttribute("relsListClient");
List relsListSupplier=(List) request.getAttribute("relsListSupplier");
%>

<!-- Party Relationships List Client -->

<form name="Parties_Rels_Client_Button_Form" method="post" action="/some/url">
<h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-rels-for-client") %></h2>

<display:table id="relsClient" name="relsListClient" requestURI="//ext/parties/manager/listPartyRels?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult relsClientItem = (ViewResult) relsClient;
	String group1Value = null;
%>

<% if (relsClientItem != null && roleName == null) { 
	group1Value = relsClientItem.getMainid().toString() + "_" + relsClientItem.getField6().toString();
%>
	<display:column class="gamma1" property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<% } else if (relsClientItem != null) {
	group1Value = relsClientItem.getMainid().toString();
 } %>
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyrelationshiptype.name" sortable="true" />
<display:column class="gamma1" property="field4" titleKey="parties.manager.relatedparty"/>
<display:column class="gamma1" property="field5" titleKey="parties.manager.relatedparty.role"/>

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Related Parties
menuItem = new DisplayTableActionMenuItem("parties.button.relparties", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRelParties");
	menuItem.addParamNameValue("relid", group1Value);
	menuItem.addParamNameValue("partyid", mainid);
	if (roleid != null) menuItem.addParamNameValue("roleid", roleid);
menuItemsVec.add(menuItem);

// Delete Relationship
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true, "parties.manager.rel.delete-are-you-sure");
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/deletePartyRel");
	menuItem.addParamNameValue("relid", group1Value);
	menuItem.addParamNameValue("partyid", mainid);
	if (roleid != null) menuItem.addParamNameValue("roleid", roleid);
menuItemsVec.add(menuItem);

%>
<%=ListViewActionsMenuRenderer.renderMenu(relsClientItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>

</display:column>
</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listRolesAndRels" />
  <tiles:put name="buttonName" value="addRelCButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Rels_Client_Button_Form" />
  <% if (roleName == null) { %>
  <tiles:put name="actionParam" value="relid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <% } %>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<tiles:add value="roleid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  	<tiles:add><%=roleid%></tiles:add>
  </tiles:putList>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
    <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_MANAGER"/>
</tiles:insert>

</form>



<br>



<form name="Parties_Rels_Supplier_Button_Form" method="post" action="/some/url">
<h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-rels-for-supplier") %></h2>

<display:table id="relsSupplier" name="relsListSupplier" requestURI="//ext/parties/manager/listPartyRels" pagesize="10" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult relsSupplierItem = (ViewResult) relsSupplier;
	String group1Value = null;
%>
<% if (relsSupplierItem != null && roleName == null) { 
	group1Value = relsSupplierItem.getMainid().toString() + "_" + relsSupplierItem.getField6().toString();
%>
	<display:column class="gamma1" property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<% } else if (relsSupplierItem != null) {
	group1Value = relsSupplierItem.getMainid().toString();
 } %>
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyrelationshiptype.name" sortable="true" />
<display:column class="gamma1" property="field4" titleKey="parties.manager.relatedparty"/>
<display:column class="gamma1" property="field5" titleKey="parties.manager.relatedparty.role"/>

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Related Parties
menuItem = new DisplayTableActionMenuItem("parties.button.relparties", 
	null, null, true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/listPartyRelParties");
	menuItem.addParamNameValue("relid", group1Value);
	menuItem.addParamNameValue("partyid", mainid);
	if (roleid != null) menuItem.addParamNameValue("roleid", roleid);
menuItemsVec.add(menuItem);

// Delete Relationship
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true, "parties.manager.rel.delete-are-you-sure");
	menuItem.addParamNameValue("struts_action", "/ext/parties/manager/deletePartyRel");
	menuItem.addParamNameValue("relid", group1Value);
	menuItem.addParamNameValue("partyid", mainid);
	if (roleid != null) menuItem.addParamNameValue("roleid", roleid);
menuItemsVec.add(menuItem);

%>
<%=ListViewActionsMenuRenderer.renderMenu(relsSupplierItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>

</display:column>

</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listRolesAndRels" />
  <tiles:put name="buttonName" value="addRelSButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Rels_Supplier_Button_Form" />
  <% if (roleName == null) { %>
  <tiles:put name="actionParam" value="relid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <% } %>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<tiles:add value="roleid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  	<tiles:add><%=roleid%></tiles:add>
  </tiles:putList>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_MANAGER"/>
</tiles:insert>

</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>
<%}catch(Exception ex){
	ex.printStackTrace();
}%>
