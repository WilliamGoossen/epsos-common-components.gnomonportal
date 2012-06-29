<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.portlet.parties.utilis.DisplayTableActionMenuItem" %>
<%@ page import="com.ext.portlet.parties.utilis.ListViewActionsMenuRenderer" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<%@ page import="com.liferay.portal.model.UserGroup" %>

<liferay-ui:error key="contacts.highrole.delete-error" message="contacts.highrole.delete-error"/>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}
boolean onlyCurrentOrgchart = GetterUtil.getBoolean(prefs.getValue("onlyCurrentOrgchart", StringPool.BLANK), false);
boolean onlyHighRoles = GetterUtil.getBoolean(prefs.getValue("onlyHighRoles", StringPool.BLANK), false);

String mainid = (String)request.getAttribute("mainid");
Integer partyId = Integer.valueOf(mainid);
boolean isPerson = gnomon.hibernate.PartiesService.getInstance(null).isPerson(partyId);

List rolesList=(List) request.getAttribute("rolesList");

String redirectLinkUrl = request.getParameter("redirect");

if (!onlyHighRoles || !isPerson) { %>


<!-- Party Roles List -->

<form name="Parties_Roles_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-roles") %></h2>

<display:table id="roles" name="rolesList" requestURI="//ext/parties/contacts/listPartyRoles?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult roleItem = (ViewResult) roles;%>

<display:column property="field2" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column property="field3" titleKey="parties.admin.partyroletype.description"/>


<display:column style="text-align: right; white-space:nowrap;">

<a title="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>" 
href="<liferay-portlet:actionURL >
<liferay-portlet:param name="struts_action" value="/ext/parties/contacts/deletePartyRole"/>
<liferay-portlet:param name="partyid" value="<%= mainid.toString() %>"/>
<liferay-portlet:param name="roleid" value="<%= roleItem.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "parties.manager.role.delete-are-you-sure") %>');">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>"></a>&nbsp;
</display:column>
</display:table>


<% if (hasAdmin && hasAdd) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/contacts/listPartyRoleTypes" />
  <tiles:put name="buttonName" value="addRoleButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Roles_Button_Form" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
  <%if (redirectLinkUrl == null || redirectLinkUrl.equals("")) {%>
  <tiles:putList name="actionParamList">
	<tiles:add value="redirect" />
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%= redirectLinkUrl%></tiles:add>
  </tiles:putList>
  <%}%>
</tiles:insert>

<% }  %>

</form>
<br>

<br>



<!-- Liferay User Groups List -->
<% if (isPerson) {
Boolean showLiferayUserGroups = (Boolean)request.getAttribute("showLiferayUserGroups");
if (showLiferayUserGroups != null && showLiferayUserGroups.booleanValue()) { %>

<form name="Party_Liferay_User_Groups_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "contacts.user.group.list") %></h2>

<display:table id="group" name="liferayUserGroups" requestURI="//ext/parties/contacts/listPartyRoles?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% UserGroup groupItem = (UserGroup) group; %>

<display:column property="name" titleKey="contacts.user.group.name" sortable="true" />

<display:column style="text-align: right; white-space:nowrap;">

<a title="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>" 
href="<liferay-portlet:actionURL >
<liferay-portlet:param name="struts_action" value="/ext/parties/contacts/deleteLiferayUserGroup"/>
<liferay-portlet:param name="partyid" value="<%= mainid.toString() %>"/>
<liferay-portlet:param name="userGroupId" value="<%= ""+groupItem.getUserGroupId() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "contacts.user.group.delete-are-you-sure") %>');">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>"></a>&nbsp;
</display:column>
</display:table>

<% if (hasAdmin && hasAdd) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/contacts/listLiferayUserGroups" />
  <tiles:put name="buttonName" value="addUserGroupButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Party_Liferay_User_Groups_Button_Form" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
  <%if (redirectLinkUrl == null || redirectLinkUrl.equals("")) {%>
  <tiles:putList name="actionParamList">
	<tiles:add value="redirect" />
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%= redirectLinkUrl%></tiles:add>
  </tiles:putList>
  <%}%>
</tiles:insert>
<% }  %>

</form>

<% } %>

<br>
<br>
<% } %>

<% } %>

<% if (isPerson) { %>
<form name="Party_HighRoles_Button_Form" method="post" action="/some/url">
<h2 class="title1">
<%= LanguageUtil.get(pageContext, "contacts.highrole.list") %>
</h2>

<display:table id="highrole" name="highRoles" requestURI="//ext/parties/contacts/listPartyRoles?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult highRole = (ViewResult) highrole; %>

<display:column property="field2" titleKey="contacts.highrole.name" sortable="true" />

<% if (!onlyCurrentOrgchart && !onlyHighRoles) { %>
<display:column property="field3" titleKey="contacts.highrole.client.partyroletype" sortable="true" />
<display:column property="field4" titleKey="contacts.highrole.supplier.partyroletype" sortable="true" />
<% } %>
<display:column property="field5" titleKey="contacts.highrole.otherparty" sortable="true" />

<display:column style="text-align: right; white-space:nowrap;">

<a title="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>" 
href="<liferay-portlet:actionURL >
<liferay-portlet:param name="struts_action" value="/ext/parties/contacts/deleteHighRole"/>
<liferay-portlet:param name="partyid" value="<%= mainid.toString() %>"/>
<liferay-portlet:param name="partyHighRoleId" value="<%= ""+highRole.getMainid().toString() %>"/>
<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
</liferay-portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "contacts.highrole.delete-are-you-sure") %>');">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" alt="<%= LanguageUtil.get(pageContext, "parties.button.delete") %>"></a>&nbsp;
</display:column>
</display:table>

<% if (hasAdmin && hasAdd) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/contacts/listHighRoles" />
  <tiles:put name="buttonName" value="addHighRoleButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Party_HighRoles_Button_Form" />
  <tiles:put name="actionParam" value="partyid"/>
  <tiles:put name="actionParamValue"><%=mainid%></tiles:put>
  <%if (redirectLinkUrl == null || redirectLinkUrl.equals("")) {%>
  <tiles:putList name="actionParamList">
	<tiles:add value="redirect" />
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%= redirectLinkUrl%></tiles:add>
  </tiles:putList>
  <%}%>
</tiles:insert>
<% }  %>

</form>

<% } %>
<br>
<br>


<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>