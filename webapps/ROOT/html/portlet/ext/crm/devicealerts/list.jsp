<%@ include file="/html/portlet/ext/crm/devicealerts/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.devicealerts.CrDeviceAlertForm" %>

<script type="text/JavaScript">
<!--
function timedRefresh(timeoutPeriod) {
	setTimeout("location.reload(true);",timeoutPeriod);
}
//   -->
</script>
<body onload="JavaScript:timedRefresh(20000);">
<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<%
String crmPartyId = request.getParameter("crmPartyId");
String search = request.getParameter("search");
%>
<a href="#" onClick="Liferay.Util.toggleByIdSpan(this, 'CRM_DEVICE_ALERTS_SEARCH_DIV');">
<%= LanguageUtil.get(pageContext, "crm.button.search") %>...
</a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/devicealerts/stats"/></portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "crm.devicealert.stats") %>...
</a>

<br>

<div id="CRM_DEVICE_ALERTS_SEARCH_DIV"
<% if (search != null && search.equals("true")) { %> 
style="display:inline;"
<% } else { %>
style="display:none;"
<% } %>
>
<html:form action="/ext/crm/devicealerts/list?actionURL=true" method="post" styleClass="uni-form">
	<input type="hidden" name="search" value="true">
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
		<tiles:put name="formName" value="SearchCrDeviceAlertForm"/>
	</tiles:insert>

	<div class="button-holder">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "crm.button.search") %>">
	</div>
</html:form>

<br>

</div>
<br>

<display:table id="item" name="crm_devicealerts" requestURI="//ext/crm/devicealerts/list?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<%--
<display:column property="field1" titleKey="crm.devicealert.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
--%>
<display:column>
<% if (Validator.isNotNull(gnItem.getField6())) { 
	if (gnItem.getField6().equals("AF")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/fall.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>">
		<% 
	} else if (gnItem.getField6().equals("AP")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/panic.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>">
		<% 
	} else if (gnItem.getField6().equals("AB")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/battery.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField6()) %>">
		<% 
	}
}
%>
</display:column>
<display:column property="field2" titleKey="crm.devicealert.alertDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column titleKey="crm.devicealert.status" sortable="true">
<% if (Validator.isNotNull(gnItem.getField3())) { %>
<%= LanguageUtil.get(pageContext, "crm.devicealert.status."+gnItem.getField3()) %>
<% } %>
</display:column>

<display:column titleKey="crm.devicealert.subject" sortable="true">
<a title="<%=LanguageUtil.get(pageContext, "crm.devicealert.comment.list") %>" 
    href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/crm/devicealerts/listComments"/>
			<portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
<%= gnItem.getField4() %>
</a>
</display:column>
<display:column property="field7" titleKey="crm.devicealert.deviceId" sortable="true"/>
<display:column titleKey="crm.devicealert.crmPartyId" sortable="true">
<a title="<%= gnItem.getField5().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField8().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField5().toString() %>
</a>
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
								<portlet:param name="struts_action" value="/ext/crm/devicealerts/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="edit"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
				<c:if test="<%= gnItem.getField3() != null && gnItem.getField3().toString().equals(CrDeviceAlertForm.STATUS_1) %>">
					<tr>
						<td>
							<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.devicealert.dispatch") %>">
						</td>
						<td>
							<a href="<portlet:actionURL>
									<portlet:param name="struts_action" value="/ext/crm/devicealerts/loadComment"/>
									<portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
									<portlet:param name="loadaction" value="add"/>
									<portlet:param name="newStatus" value="<%=  CrDeviceAlertForm.STATUS_2 %>"/>
									<portlet:param name="redirect" value="<%= currentURL %>"/>
									</portlet:actionURL>">
							<%=LanguageUtil.get(pageContext, "crm.devicealert.dispatch") %>
							</a>
						</td>
					</tr>
				</c:if>
				<c:if test="<%= gnItem.getField3() != null && gnItem.getField3().toString().equals(CrDeviceAlertForm.STATUS_2) %>">
					<tr>
						<td>
							<img src="<%= themeDisplay.getPathThemeImage() %>/common/signal_instance.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.devicealert.close") %>">
						</td>
						<td>
							<a href="<portlet:actionURL>
									<portlet:param name="struts_action" value="/ext/crm/devicealerts/loadComment"/>
									<portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
									<portlet:param name="loadaction" value="add"/>
									<portlet:param name="newStatus" value="<%=  CrDeviceAlertForm.STATUS_3 %>"/>
									<portlet:param name="redirect" value="<%= currentURL %>"/>
									</portlet:actionURL>">
							<%=LanguageUtil.get(pageContext, "crm.devicealert.close") %>
							</a>
						</td>
					</tr>
				</c:if>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/devicealerts/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
				
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.devicealert.comment.list") %>"></a>
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/devicealerts/listComments"/>
								<portlet:param name="deviceAlertId" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "crm.devicealert.comment.list") %>
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
<portlet:param name="struts_action" value="/ext/crm/devicealerts/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
<% if (Validator.isNotNull(crmPartyId)) { %>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<% } %>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>

</body>


