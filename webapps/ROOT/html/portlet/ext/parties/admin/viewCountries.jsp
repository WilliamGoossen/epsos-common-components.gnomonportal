<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>

<%
List countriesList=(List) request.getAttribute("countriesList");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.list.country") %></h2>
<!-- Countries List -->

<form name="Parties_Admin_Country_Button_Form" method="post" action="/some/url">

<display:table id="countries" name="countriesList" requestURI="//ext/parties/admin/viewCountries" pagesize="10" sort="list"  style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult countryItem = (ViewResult) countries;%>
<display:column class="gamma1" property="field1" titleKey="parties.admin.country.alphabeticcode" sortable="true"/>
<display:column class="gamma1" property="field2" titleKey="parties.admin.country.numericcode" sortable="true"/>
<display:column class="gamma1" property="field3" titleKey="parties.admin.country.name" sortable="true"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.country.officialname" sortable="true"/>

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Edit
menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
	themeDisplay.getPathThemeImage()+"/common/edit.png", 
	"parties.button.edit", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/admin/loadCountry");
	menuItem.addParamNameValue("mainid", countryItem.getMainid().toString());
menuItemsVec.add(menuItem);

// Delete
menuItem = new DisplayTableActionMenuItem("parties.button.delete", 
	themeDisplay.getPathThemeImage()+"/common/delete.png", 
	"parties.button.delete", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/admin/loadCountry");
	menuItem.addParamNameValue("mainid", countryItem.getMainid().toString());
	menuItem.addParamNameValue("delete", countryItem.getMainid().toString());
menuItemsVec.add(menuItem);
%>
<%=ListViewActionsMenuRenderer.renderMenu(countryItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>
</display:column>
</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/loadCountry" />
  <tiles:put name="buttonName" value="addButtonCountry" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Admin_Country_Button_Form" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_ADMIN"/>
</tiles:insert>


</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-admin") %></html:link></TD>
</TR></TABLE>