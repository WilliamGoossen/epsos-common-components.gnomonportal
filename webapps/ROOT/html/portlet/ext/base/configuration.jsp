<%@ include file="/html/portlet/ext/base/init.jsp" %>


<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm" class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	
	<div class="inline-labels">

	<%@ include file="/html/portlet/ext/base/configurationBaseElems.jspf"%>

	</div>
	
	<div class="button-holder">
		<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>