<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%
List organizationList=(List) request.getAttribute("organizationList");
%>
<%
String search_item=request.getParameter("searchItem");
if (search_item==null) search_item="";
String imgPath = themeDisplay.getPathThemeImage();
%>
<form action="
<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/parties/orgchart/viewCharts" />
</portlet:actionURL>" method="post">
<table>
<tr valign="center">
<td valign="center">
<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "orgchart.button.search") %></span> 
</td><td valign=center>
<input type="text" name="searchItem" value="<%= search_item %>">
</td><td valign=center>
<input type="image" src="<%=imgPath %>/common/search.png" title="Search" alt="search" border="0" >
</td></tr></table></form>
<br>

<form name="OrgChart_Chart_List_Form" method="post" action="/some/url">

<display:table id="organizations" name="organizationList" requestURI="//ext/parties/orgchart/viewCharts" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult orgItem = (ViewResult) organizations;%>

<display:column class="gamma1" property="field1" titleKey="parties.manager.organization.name" sortable="true"  />

<display:column style="text-align: right; white-space:nowrap;">
<%
java.util.Vector menuItemsVec = new java.util.Vector();
DisplayTableActionMenuItem menuItem = null;

// Edit
menuItem = new DisplayTableActionMenuItem("parties.button.edit", 
	themeDisplay.getPathThemeImage()+"/common/edit.png", 
	"parties.button.edit", true);
	menuItem.addParamNameValue("struts_action", "/ext/parties/orgchart/loadChart");
	menuItem.addParamNameValue("chartid", orgItem.getMainid().toString());
menuItemsVec.add(menuItem);
%>
<%=ListViewActionsMenuRenderer.renderMenu(orgItem.getMainid(), pageContext, 
		themeDisplay.getPathThemeImage() +"/base/menu.gif",
			"gn.link.actions", menuItemsVec, request)%>
</display:column>

</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listRootOrganizations" />
  <tiles:put name="buttonName" value="addChartButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="OrgChart_Chart_List_Form" />
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_ORGANIZATION_CHART"/>
</tiles:insert>

<% if (false && organizationList.size() > 0) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadChart" />
  <tiles:put name="buttonName" value="editChartButton" />
  <tiles:put name="buttonValue" value="parties.button.edit" />
  <tiles:put name="formName"   value="OrgChart_Chart_List_Form" />
  <tiles:put name="actionParam" value="chartid"/>
  <tiles:put name="actionParamValue" value="groupOrganization"/>
</tiles:insert>

<%
/***************************************************************************
 *********** UNCOMMENT THIS TILE, IF PARTY DELETION IS REQUIRED ************
 ***************************************************************************
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/deleteChart" />
  <tiles:put name="buttonName" value="deleteChartButton" />
  <tiles:put name="buttonValue" value="parties.button.delete" />
  <tiles:put name="formName"   value="OrgChart_Chart_List_Form" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue" value="groupOrganization"/>
  <tiles:put name="confirm" value="parties.manager.party.delete-are-you-sure"/>
</tiles:insert>
***************************************************************************/
%>
<% }%>
</form>

