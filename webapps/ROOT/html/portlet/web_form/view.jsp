<%@ include file="/html/portlet/web_form/init.jsp" %>

<%
String title = prefs.getValue("title", StringPool.BLANK);
String description = prefs.getValue("description", StringPool.BLANK);
boolean requireCaptcha = GetterUtil.getBoolean(prefs.getValue("require-captcha", StringPool.BLANK));
%>

<form class="uni-form" action="<portlet:actionURL><portlet:param name="struts_action" value="/web_form/view" /></portlet:actionURL>" method="post">

<h3><%= title %></h3>

<p class="liferay-web-form-descr"><%= description %></p>

<liferay-ui:success key="emailSent" message="the-email-was-sent-successfuly" />

<liferay-ui:error exception="<%= CaptchaTextException.class %>" message="text-verification-failed" />
<liferay-ui:error key="allFieldsRequired" message="please-complete-all-fields" />
<liferay-ui:error key="emailNotSent" message="the-email-could-not-be-sent" />
<liferay-ui:error key="emailNotValid" message="webform.invalidEmail" />
<liferay-ui:error key="textNotValid" message="webform.textlengthlessthan10" />
<div class="inline-labels">
<%
int i = 1;

String fieldName = "field" + i;
String fieldLabel = prefs.getValue("fieldLabel" + i, "");
boolean fieldOptional = PrefsParamUtil.getBoolean(prefs, request, "fieldOptional" + i, false);
String fieldValue = ParamUtil.getString(request, fieldName);

while ((i == 1) || (fieldLabel.trim().length() > 0)) {
	if (Validator.isNull(fieldLabel)) {
       continue;
    }

	String fieldType = prefs.getValue("fieldType" + i, "text");
	String fieldOptions = prefs.getValue("fieldOptions" + i, "unknown");
%>

	<div class="ctrl-holder">
	<c:choose>
		<c:when test='<%= fieldType.equals("paragraph") %>'>
			<p class="liferay-webform"><%= LanguageUtil.get(pageContext,fieldOptions) %></p>
		</c:when>
		<c:when test='<%= fieldType.equals("email") %>'>
			<label for="<portlet:namespace /><%= fieldName %>"><%= LanguageUtil.get(pageContext,fieldLabel) %></label>

			<input alt="<%= LanguageUtil.get(pageContext,fieldLabel) %>" id="<portlet:namespace /><%= fieldName %>" name="<portlet:namespace /><%= fieldName %>" type="text" size="50" value="<%= fieldValue %>" />
		</c:when>
		<c:when test='<%= fieldType.equals("text") %>'>
			<label for="<portlet:namespace /><%= fieldName %>"><%= LanguageUtil.get(pageContext,fieldLabel) %></label>

			<input id="<portlet:namespace /><%= fieldName %>" name="<portlet:namespace /><%= fieldName %>" type="text" value="<%= fieldValue %>" />
		</c:when>
		<c:when test='<%= fieldType.equals("textarea") %>'>
			<label for="<portlet:namespace /><%= fieldName %>"><%= LanguageUtil.get(pageContext,fieldLabel) %></label>

			<textarea id="<portlet:namespace /><%= fieldName %>" name="<portlet:namespace /><%= fieldName %>" wrap="soft"><%= fieldValue %></textarea>
		</c:when>
		<c:when test='<%= fieldType.equals("checkbox") %>'>
			<label for="<portlet:namespace /><%= fieldName %>"><%= LanguageUtil.get(pageContext,fieldLabel) %></label>

			<div class="liferay-input-checkbox <%= fieldOptional ? "optional" : "" %>">
				<input alt="check" <%= Validator.isNotNull(fieldValue) ? "checked" : "" %> id="<portlet:namespace /><%= fieldName %>" name="<portlet:namespace /><%= fieldName %>" type="checkbox" />
			</div>
		</c:when>
		<c:when test='<%= fieldType.equals("radio") %>'>
			<label for="<portlet:namespace /><%= fieldName %>"><%= LanguageUtil.get(pageContext,fieldLabel) %></label>

			<fieldset class="column-right">

				<%
				String[] options = WebFormUtil.split(fieldOptions);

				for (int j = 0; options!=null && j < options.length; j++) {
				%>

					<div class="ctrl-holder">
						<label>
							<input alt="check" type="radio" name="<portlet:namespace /><%= fieldName %>" <%= fieldValue.equals(options[j]) ? "checked=\"true\"" : "" %> value="<%= options[j] %>" />
							<%= options[j] %>
						</label>
					</div>

				<%
				}
				%>

			</fieldset>
		</c:when>
		<c:when test='<%= fieldType.equals("options") %>'>
			<label for="<portlet:namespace /><%= fieldName %>"><%= LanguageUtil.get(pageContext,fieldLabel) %></label>

				<%
				String[] options = WebFormUtil.split(fieldOptions);
				%>

				<select name="<portlet:namespace /><%= fieldName %>">

					<%
					for (int j = 0; j < options.length; j++) {
					%>

						<option <%= fieldValue.equals(options[j]) ? "selected" : "" %> value="<%= options[j] %>"><%= options[j] %></option>

					<%
					}
					%>

				</select>
		</c:when>
	</c:choose>
	</div> <%-- end div class="ctrl-holder" --%>

	<br />

<%
    i++;

    fieldName = "field" + i;
    fieldLabel = prefs.getValue("fieldLabel" + i, "");
    fieldOptional = PrefsParamUtil.getBoolean(prefs, request, "fieldOptional" + i, false);
    fieldValue = ParamUtil.getString(request, fieldName);
}
%>
<c:if test="<%= requireCaptcha %>">
	<div class="ctrl-holder">
		<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>" var="captchaURL">
			<portlet:param name="struts_action" value="/web_form/captcha" />
		</portlet:actionURL>

		<liferay-ui:captcha url="<%= captchaURL %>" />
	</div>
</c:if>

</div> <%--end div class="inline-labels" --%>

<div class="button-holder">
	<input alt=" " type="submit" value="<liferay-ui:message key="send" />" />
</div>

</form>