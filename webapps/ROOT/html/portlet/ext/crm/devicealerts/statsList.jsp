<%@ include file="/html/portlet/ext/crm/devicealerts/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.devicealerts.CrDeviceAlertForm" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<%
String search = request.getParameter("search");
%>
<h2>
<%= LanguageUtil.get(pageContext, "crm.devicealert.stats") %>
</h2>
<br>
<html:form action="/ext/crm/devicealerts/stats?actionURL=true" method="post" styleClass="uni-form">
	<input type="hidden" name="search" value="true">
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
		<tiles:put name="formName" value="SearchCrDeviceAlertStatsForm"/>
	</tiles:insert>

	<div class="button-holder">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "crm.devicealert.button.stats") %>">
	</div>
</html:form>
</div>
<br>

<display:table id="item" name="crm_devicealerts" requestURI="//ext/crm/devicealerts/stats?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>

<display:column titleKey="crm.devicealert.crmPartyId" sortable="true" group="1">
<a title="<%= gnItem.getField1().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField1().toString() %>
</a>
</display:column>
<display:column property="field2" titleKey="crm.devicealert.total" sortable="true" group="1"/>
<display:column>
<% if (Validator.isNotNull(gnItem.getField3())) { 
	if (gnItem.getField3().equals("AF")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/fall.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField3()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField3()) %>">
		<% 
	} else if (gnItem.getField3().equals("AP")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/panic.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField3()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField3()) %>">
		<% 
	} else if (gnItem.getField3().equals("AB")) {
		%>
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/battery.gif" title="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField3()) %>" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.alert."+gnItem.getField3()) %>">
		<% 
	}
}
%>
</display:column>
<display:column property="field4" titleKey="crm.devicealert.count" sortable="true" />


</display:table>


<br>


<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/devicealerts/list"/></portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="<%= LanguageUtil.get(pageContext, "crm.devicealert.list") %>"><%= LanguageUtil.get(pageContext, "crm.devicealert.list") %>
</a>




