<%@ include file="/html/portlet/ext/crm/helpdesk/categories/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<h2  ><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.list") %></h2>
<!-- Events List -->
<form name="CRM_Categories_ButtonForm" action="/some/url" method="post">
<display:table id="category" name="categories" requestURI="//ext/crm/helpdeskCategories/list?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">

<% gnomon.hibernate.model.views.ViewResult gnItem = (gnomon.hibernate.model.views.ViewResult) pageContext.getAttribute("category"); %>
<display:column style="width: 1%; white-space:nowrap;">
<c:choose>
	<c:when test="<%=gnItem.getField4() != null && ((Boolean)gnItem.getField4()).booleanValue()%>">
		<img src="<%=themeDisplay.getPathThemeImage()%>/common/enabled.gif" border="0" align="absmiddle" alt="<%=LanguageUtil.get(pageContext, "active")%>" title="<%=LanguageUtil.get(pageContext, "active")%>">
	</c:when>
	<c:otherwise>
		<img src="<%=themeDisplay.getPathThemeImage()%>/common/disabled.gif" border="0" align="absmiddle" alt="<%=LanguageUtil.get(pageContext, "inactive")%>" title="<%=LanguageUtil.get(pageContext, "inactive")%>">
	</c:otherwise>
</c:choose>
<c:if test="<%=gnItem.getField7() != null && ((Boolean)gnItem.getField7()).booleanValue()%>">
	<img src="<%=themeDisplay.getPathThemeImage()%>/common/task.gif" border="0" align="absmiddle" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.defaultcategory")%>" title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.defaultcategory")%>">
</c:if>
<c:if test="<%=gnItem.getField3() != null && ((Boolean)gnItem.getField3()).booleanValue()%>">
	<img src="<%=themeDisplay.getPathThemeImage()%>/common/view_doc.gif" border="0" align="absmiddle" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.needsapproval")%>" title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.needsapproval")%>">
</c:if>
<c:if test="<%=gnItem.getField5() != null && ((Boolean)gnItem.getField5()).booleanValue()%>">
	<img src="<%=themeDisplay.getPathThemeImage()%>/common/asterisk.gif" border="0" align="absmiddle" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.hidden")%>" title="<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.hidden")%>">
</c:if>
</display:column>

<%--<display:column style="width: 1%; white-space:nowrap;" property="field2" titleKey="crm.helpdesk.category.prefix" sortable="true" />--%>
<display:column property="field1" titleKey="crm.helpdesk.category.name" sortable="true" />
<display:column property="field6" titleKey="crm.helpdesk.category.officerid" sortable="true" />
<display:column property="field8" titleKey="crm.helpdesk.category.veveosi" sortable="true"/>
<%--
<display:column titleKey="crm.helpdesk.category.needsapproval" sortable="true">
<% if (gnItem.getField3() != null && ((Boolean)gnItem.getField3()).booleanValue()) { %>
<input type="checkbox" class="gamma1-FormArea" disabled="true" checked="true">
<% } else { %>
<input type="checkbox" class="gamma1-FormArea" disabled="true">
<% } %>
</display:column>
<display:column titleKey="crm.helpdesk.category.active" sortable="true">
<% if (gnItem.getField4() != null && ((Boolean)gnItem.getField4()).booleanValue()) { %>
<input type="checkbox" class="gamma1-FormArea" disabled="true" checked="true">
<% } else { %>
<input type="checkbox" class="gamma1-FormArea" disabled="true">
<% } %>
</display:column>
--%>
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
					<portlet:param name="struts_action" value="/ext/crm/helpdeskCategories/load"/>
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
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/define_permissions.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.auditor.list") %>">
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/helpdeskCategories/listAuditors"/>
					<portlet:param name="categoryid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "crm.helpdesk.category.auditor.list") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/helpdeskCategories/load"/>
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
	  <tiles:put name="action"  value="/ext/crm/helpdeskCategories/load" />
	  <tiles:put name="buttonName" value="addButtonCategory" />
	  <tiles:put name="buttonValue" value="crm.button.add" />
	  <tiles:put name="formName"   value="CRM_Categories_ButtonForm" />
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	</tiles:insert>
</c:if>
</form>