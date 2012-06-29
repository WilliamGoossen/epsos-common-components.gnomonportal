<%@ include file="/html/portlet/ext/base/init.jsp" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<% boolean eventsYellowPagesEnable = GetterUtil.getBoolean(prefs.getValue("eventsYellowPagesEnable", StringPool.BLANK), false);  %>
<% boolean eventsNoRecurrentEventsInList = GetterUtil.getBoolean(prefs.getValue("eventsNoRecurrentEventsInList", StringPool.BLANK), false);  %>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm"  class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<div class="inline-labels">

	<%@ include file="/html/portlet/ext/base/configurationBaseElems.jspf"%>

	<fieldset class="inline-labels"><legend><%= LanguageUtil.get(pageContext, "bs.configuration.events-specific") %></legend>
	<div class="ctrl-holder"><label>
		<%= LanguageUtil.get(pageContext, "bs.events.yellowpages.enable") %></label>
		<liferay-ui:input-checkbox param="eventsYellowPagesEnable" defaultValue="<%= eventsYellowPagesEnable%>" />
	</div>
	
	<div class="ctrl-holder"><label>
		<%= LanguageUtil.get(pageContext, "bs.events.do-not-list-recurrent-events-separately") %>
	</label>
		<liferay-ui:input-checkbox param="eventsNoRecurrentEventsInList" defaultValue="<%= eventsNoRecurrentEventsInList%>" />
	</div>
	</fieldset>
	
	</div>
	<div class="button-holder">
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>