<%@ include file="/html/portlet/login/init.jsp" %>

<%
String login = LoginAction.getLogin(request, "login", company);
String password = StringPool.BLANK;
boolean rememberMe = ParamUtil.getBoolean(request, "rememberMe");
String redirect = ParamUtil.getString(request, "redirect", StringPool.BLANK);
%>

<portlet:actionURL var="continueOrderURL">
	<portlet:param name="struts_action" value="/ext/ecommerce/cart/checkout"/>
	<portlet:param name="page" value="billing_info"/>
	<portlet:param name="redirect" value="<%=redirect%>"/>
</portlet:actionURL>

<form action="<%= themeDisplay.getPathMain() %>/portal/login" method="post" name="loginfm">
<input name="cmd" type="hidden" value="already-registered" />
<input name="rememberMe" type="hidden" value="<%= rememberMe %>" />
<c:if test="<%=session.getAttribute(WebKeys.LAST_PATH)==null %>">
<input name="redirect" type="hidden" value="<%= continueOrderURL %>" />
</c:if>

<liferay-ui:error exception="<%= AuthException.class %>" message="authentication-failed" />
<liferay-ui:error exception="<%= CookieNotSupportedException.class %>" message="authentication-failed-please-enable-browser-cookies" />
<liferay-ui:error exception="<%= NoSuchUserException.class %>" message="please-enter-a-valid-login" />
<liferay-ui:error exception="<%= PasswordExpiredException.class %>" message="your-password-has-expired" />
<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-login" />
<liferay-ui:error exception="<%= UserLockoutException.class %>" message="this-account-has-been-locked" />
<liferay-ui:error exception="<%= UserPasswordException.class %>" message="please-enter-a-valid-password" />
<liferay-ui:error exception="<%= UserScreenNameException.class %>" message="please-enter-a-valid-screen-name" />

<table class="liferay-table">
<tr>
	<td>
		<liferay-ui:message key="login" />
	</td>
	<td>
		<input name="login" style="width: 120px;" type="text" value="<%= login %>" />
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="password" />
	</td>
	<td>
		<input name="password" style="width: 120px;" type="password" value="<%= password %>" />
	</td>
</tr>

<c:if test="<%= company.isAutoLogin() && !request.isSecure() && !GetterUtil.getBoolean(PropsUtil.get(PropsUtil.SESSION_DISABLED)) %>">
	<tr>
		<td>
			<span style="font-size: xx-small;">
			<liferay-ui:message key="remember-me" />
			</span>
		</td>
		<td>
			<input <%= rememberMe ? "checked" : "" %> type="checkbox"
				onClick="
					if (this.checked) {
						document.loginfm.rememberMe.value = 'on';
					}
					else {
						document.loginfm.rememberMe.value = 'off';
					}"
			>
		</td>
	</tr>
</c:if>

</table>

<br />

<input type="submit" value="<liferay-ui:message key="sign-in" />" />

<c:if test="<%= false && company.isStrangers() %>">
	<input type="button" value="<liferay-ui:message key="create-account" />" onClick="self.location = '<%= themeDisplay.getURLCreateAccount() %>';" />
</c:if>

<c:if test="<%= false && company.isSendPassword() %>">
	<br /><br />

	<a href="<%= themeDisplay.getPathMain() %>/portal/login?tabs1=forgot-password" style="font-size: xx-small;">
	<liferay-ui:message key="forgot-password" />?
	</a>
</c:if>

</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		Liferay.Util.focusFormField(document.loginfm.login);
	</script>
</c:if>