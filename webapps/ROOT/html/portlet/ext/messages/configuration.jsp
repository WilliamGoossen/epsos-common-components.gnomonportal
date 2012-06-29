<%@ include file="/html/portlet/ext/messages/init.jsp" %>


<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">

	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "gn.messages.show-read-messages") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<select name="<portlet:namespace />show-read-messages">
				<option <%= (instancePortletShowReadMessages.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "gn.messages.show-read-messages.no") %></option>
				<option <%= (instancePortletShowReadMessages.equals("1")) ? "selected" : "" %> value="1"><%= LanguageUtil.get(pageContext, "gn.messages.show-read-messages.1") %></option>
				<option <%= (instancePortletShowReadMessages.equals("2")) ? "selected" : "" %> value="2"><%= LanguageUtil.get(pageContext, "gn.messages.show-read-messages.2") %></option>
				<option <%= (instancePortletShowReadMessages.equals("3")) ? "selected" : "" %> value="3"><%= LanguageUtil.get(pageContext, "gn.messages.show-read-messages.3") %></option>
			</select>
		</td>
	</tr>

	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>