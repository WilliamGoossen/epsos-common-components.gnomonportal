<%@ include file="/html/portlet/ext/crm/devices/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.devices.CrDeviceForm" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<%
String search = request.getParameter("search");
%>
<a href="#" onClick="Liferay.Util.toggleByIdSpan(this, 'CRM_DEVICES_SEARCH_DIV');">
<%= LanguageUtil.get(pageContext, "crm.button.search") %>...
</a>

<br>

<div id="CRM_DEVICES_SEARCH_DIV"
<% if (search != null && search.equals("true")) { %> 
style="display:inline;"
<% } else { %>
style="display:none;"
<% } %>
>
<html:form action="/ext/crm/devices/list?actionURL=true" method="post" styleClass="uni-form">
	<input type="hidden" name="search" value="true">
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
		<tiles:put name="formName" value="SearchCrDeviceForm"/>
	</tiles:insert>

	<div class="button-holder">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "crm.button.search") %>">
	</div>
</html:form>

<br>

</div>
<br>

<display:table id="item" name="crm_devices" requestURI="//ext/crm/devices/list?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>

<display:column property="field3" titleKey="crm.device.deviceId" sortable="true"/>
<display:column property="field1" titleKey="crm.device.name" sortable="true"  />
<display:column property="field2" titleKey="crm.device.manufacturer" sortable="true"  />
<display:column titleKey="crm.device.currentPartyId" sortable="true">
<% if (gnItem.getField4() != null) { %>
<a title="<%= gnItem.getField4().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField5().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField4().toString() %>
</a>
<% }  %>
</display:column>

<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/devices/load"/>
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
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.device.assignment.list") %>">
					</td>
					<td>
						<a title="<%=LanguageUtil.get(pageContext, "crm.device.assignment.list") %>" 
						    href="<portlet:actionURL>
									<portlet:param name="struts_action" value="/ext/crm/devices/listAssignments"/>
									<portlet:param name="crmDeviceId" value="<%= gnItem.getMainid().toString() %>"/>
									<portlet:param name="redirect" value="<%=currentURL%>"/>
									</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "crm.device.assignment.list.short") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/devices/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
			</c:if>
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/devices/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>


