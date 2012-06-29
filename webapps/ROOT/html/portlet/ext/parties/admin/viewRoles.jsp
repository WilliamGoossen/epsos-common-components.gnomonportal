<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<%
List roleTypesList=(List) request.getAttribute("roleTypesList");

//boolean actionPermission = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADMINISTRATE);
//boolean partyRoleActionPermission = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADMINISTRATE);
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.list.rol") %></h2>
<!-- Role Types List -->
<form name="Parties_Admin_Role_Button_Form" method="post" action="/some/url">

<display:table id="roles" name="roleTypesList" 
	pagesize="10" sort="list"  style="font-weight: normal; width: 100%; border-spacing: 0">

	<% ViewResult roleItem = (ViewResult) roles;//pageContext.getAttribute("roles"); %>
	
<display:column class="gamma1" property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyroletype.description"/>


<% //if (actionPermission || partyRoleActionPermission) {%>
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=roleItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="middle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=roleItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
		</td>
		<td>
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/loadRoleType"/>
				<portlet:param name="mainid" value="<%= roleItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "parties.button.edit") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
		</td>
		<td>
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/loadRoleType"/>
				<portlet:param name="mainid" value="<%= roleItem.getMainid().toString() %>"/>
				<portlet:param name="delete" value="<%= roleItem.getMainid().toString() %>"/>
				</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "parties.button.delete") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			
		</td>
		<td>
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/viewFeatureTypes"/>
				<portlet:param name="partyroletypeid" value="<%= roleItem.getMainid().toString() %>"/>
				</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "parties.button.list-feature-types") %>
			</a>
		</td>
	</tr>
	</tbody>
	</table>
</div>
</display:column>
<%//} // permissions%>
</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/loadRoleType" />
  <tiles:put name="buttonName" value="addButtonRole" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Admin_Role_Button_Form" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>

  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="partyRoleActionPermission" value="admin"/>

  <tiles:put name="portletId" value="PA_PARTIES_ADMIN"/>
</tiles:insert>


</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-admin") %></html:link></TD>
</TR></TABLE>