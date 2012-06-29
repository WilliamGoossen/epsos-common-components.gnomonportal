<%@ include file="/html/portlet/ext/base/mlists/init.jsp" %>

<%
String fromName = ParamUtil.getString(request,"fromName",prefs.getValue("from-name", StringPool.BLANK));
String fromAddress = ParamUtil.getString(request,"fromAddress",prefs.getValue("from-address", StringPool.BLANK));
String replyToAddress = ParamUtil.getString(request,"replyToAddress",prefs.getValue("reply-to-address", StringPool.BLANK));
%>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm"  class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<div class="inline-labels">

	<%@ include file="/html/portlet/ext/base/configurationBaseElems.jspf"%>
	
	<fieldset class="inline-labels"><legend><%= LanguageUtil.get(pageContext, "bs.configuration.mlists-specific") %></legend>
	<%@ include file="/html/portlet/ext/base/mlists/configurationCustomElems.jspf"%>
	</fieldset>

	</div>
	<div class="button-holder">
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>