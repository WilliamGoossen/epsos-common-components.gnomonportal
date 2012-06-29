<%@ include file="/html/portlet/ext/crm/helpdesk/requestTypes/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<h2 ><%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.list") %></h2>
<% String searchItem = (String)request.getAttribute("searchItem");
   if (Validator.isNull(searchItem)) { searchItem = ""; }
%>
<br>
<form name="CRM_RequestTypes_SearchForm" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskRequestTypes/list"/></portlet:actionURL>" method="post">
<span class="form-text"><%= LanguageUtil.get(pageContext,"crm.button.search") %></span>
<input type="text" name="searchItem" value="<%= searchItem %>">
<input type="image" src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get(pageContext, "crm.button.search") %>" title="<%= LanguageUtil.get(pageContext, "crm.button.search") %>">
</form>

<!-- Events List -->
<form name="CRM_RequestTypes_ButtonForm" action="/some/url" method="post">
<display:table id="requestType" name="requesttypes" requestURI="//ext/crm/helpdeskRequestTypes/list?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">

<% gnomon.hibernate.model.views.ViewResult gnItem = (gnomon.hibernate.model.views.ViewResult) pageContext.getAttribute("requestType"); %>

<display:column property="field1" titleKey="crm.helpdesk.requesttype.name" sortable="true" />
<display:column property="field2" titleKey="crm.helpdesk.requesttype.isGeneric" sortable="true" />

<% if (PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT)) { %>
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:<portlet:namespace/>actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
<br>
<div id="browse:<portlet:namespace/>actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/helpdeskRequestTypes/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="edit"/>
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
					<portlet:param name="struts_action" value="/ext/crm/helpdeskRequestTypes/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="delete"/>
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
	  <tiles:put name="action"  value="/ext/crm/helpdeskRequestTypes/load" />
	  <tiles:put name="buttonName" value="addButtonRequestType" />
	  <tiles:put name="buttonValue" value="crm.button.add" />
	  <tiles:put name="formName"   value="CRM_RequestTypes_ButtonForm" />
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	</tiles:insert>
</c:if>
</form>