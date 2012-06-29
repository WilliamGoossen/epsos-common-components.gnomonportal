<%@ include file="/html/portlet/ext/base/init.jsp" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<% boolean showOnlyRooms = GetterUtil.getBoolean(prefs.getValue("showOnlyRooms", StringPool.BLANK), false);  %>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">


	<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "bs.events.locations.list-only-rooms") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="showOnlyRooms" defaultValue="<%= showOnlyRooms%>" />
	</td>
	</tr>
	
	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>