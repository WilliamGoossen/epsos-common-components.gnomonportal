<%@ include file="/html/portlet/ext/crm/helpdesk/categories/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrCategoryAuditor" %>
<%@ page import="com.ext.portlet.crm.helpdesk.categories.auditors.CrCategoryAuditorForm" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%
try {
Integer categoryid = (Integer)request.getAttribute("categoryid");
List auditorList=(List) request.getAttribute("auditorList");
GnPersistenceService serv = GnPersistenceService.getInstance(null);
String lang = GeneralUtils.getLocale(request);
String[] partyNameFields = new String[]{"langs.description"};
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2  ><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.auditor.list") %></h2>

<form name="CRM_Category_Auditors_ButtonForm" action="/some/url" method="post">
<display:table id="auditor" name="auditorList" requestURI="//ext/crm/helpdeskCategories/listAuditors" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% CrCategoryAuditor gnItem = (CrCategoryAuditor) pageContext.getAttribute("auditor"); %>
<display:column titleKey="crm.helpdesk.category.auditor" sortable="true">
<%
ViewResult partyView = serv.getObjectWithLanguage(PaParty.class, gnItem.getPaParty().getMainid(), lang, partyNameFields);
out.print(partyView.getField1());
 %>
</display:column>
<display:column titleKey="crm.helpdesk.category.auditor.rights" sortable="true">
<% String auditRights = ""+gnItem.getAuditRights(); %>
<table>
<tr>
<%
for (int i=0; i<CrCategoryAuditorForm.ALL_RIGHTS.length; i++)
{
	%>
	<td valign="top">
	<input type="checkbox" name="<%=  CrCategoryAuditorForm.ALL_RIGHTS_NAMES[i] %>" 
	       value="true" disabled="true"
	       <%= CrCategoryAuditorForm.hasRight(auditRights, CrCategoryAuditorForm.ALL_RIGHTS[i]) ? "checked" : "" %>>
	 <%= LanguageUtil.get(pageContext, CrCategoryAuditorForm.ALL_RIGHTS_LANGUAGE_KEYS[i]) %> </td>	
	<%
}
%>
</tr>
</table>
</display:column>

<% if (PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT)) { %>
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, '<portlet:namespace/>browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
<br>
<div id="<portlet:namespace/>browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/helpdeskCategories/loadAuditor"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="edit"/>
					<portlet:param name="categoryid" value="<%= categoryid.toString() %>"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/helpdeskCategories/loadAuditor"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="delete"/>
					<portlet:param name="categoryid" value="<%= categoryid.toString() %>"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
			</a>
		</td>
	</tr>

	</tbody>
	</table>
</div>
</display:column>
<% } %>

</display:table>

<c:if test="<%= PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADD) %>">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/crm/helpdeskCategories/loadAuditor" />
	  <tiles:put name="buttonName" value="addButtonCategoryAuditor" />
	  <tiles:put name="buttonValue" value="crm.button.add" />
	  <tiles:put name="formName"   value="CRM_Category_Auditors_ButtonForm" />
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="categoryid"/>
	  </tiles:putList>
	  <tiles:putList name="actionParamValueList">
	  	<tiles:add><%= categoryid.toString() %></tiles:add>
	  </tiles:putList>
	</tiles:insert>
</c:if>
</form>
<br>


<%
java.util.HashMap map = new java.util.HashMap();
map.put("mainid", categoryid.toString());
pageContext.setAttribute("params", map);
%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/helpdeskCategories/list" name="params"><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.list") %></html:link>

<% } catch (Exception e) { e.printStackTrace();} %>