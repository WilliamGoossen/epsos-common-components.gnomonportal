<%
/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portlet/login/init.jsp" %>
<c:if test="<%=!SessionErrors.isEmpty(request) %>">
	<span class="portlet-msg-error">
	<%
	Iterator itr2 = SessionErrors.iterator(request);
	while (itr2.hasNext()) {
		out.println(itr2.next());
		out.println("<br/>");
	}
	%>
	</span>
</c:if>
<c:choose>
	<c:when test="<%= themeDisplay.isSignedIn() %>">

		<%
		String signedInAs = user.getFullName();

		if (themeDisplay.isShowMyAccountIcon()) {
			signedInAs = "<a href=\"" + themeDisplay.getURLMyAccount().toString() + "\">" + signedInAs + "</a>";
		}
		%>
	<div class="lfr-dock-login">
    
		<ul class="lfr-dock-login-list">
        
			<li class="message">
				<%= LanguageUtil.format(pageContext, "you-are-signed-in-as-x", signedInAs) %>
			</li>
			
			<c:if test="<%=showShortcuts %>">
				
				<li class="home">
					<a href="<%=themeDisplay.getURLHome()%>"><%=LanguageUtil.get(pageContext, "home") %></a>
				</li>
				
				<li class="my-account">
					<a href="<%=themeDisplay.getURLMyAccount()%>"><%=LanguageUtil.get(pageContext, "my-account") %></a>
				</li>
				
				<li class="sign-out">
					<a href="<%=themeDisplay.getURLSignOut()%>"><%=LanguageUtil.get(pageContext, "sign-out") %></a>
				</li>
				
				<c:if test="<%=themeDisplay.isShowAddContentIcon()%>">
					<li class="add-content">
						<a href="<%=themeDisplay.getURLAddContent()%>"><%=LanguageUtil.get(pageContext, "add-content") %></a>
					</li>
					<li class="layout">
						<a href="javascript: void(0);" onclick="<%=themeDisplay.getURLLayoutTemplates()%>"><%=LanguageUtil.get(pageContext, "layout") %></a>
					</li>
				</c:if>
				
				<c:if test="<%=themeDisplay.isShowPageSettingsIcon()%>">
					<li class="page-settings">
						<a href="<%=themeDisplay.getURLPageSettings()%>"><%=LanguageUtil.get(pageContext, "page-settings") %></a>
					</li>
				</c:if>
			</c:if>
		
		</ul>
       </div>
	</c:when>
	<c:otherwise>

		<%
		String login = LoginAction.getLogin(request, "login", company);
		String password = StringPool.BLANK;
		boolean rememberMe = ParamUtil.getBoolean(request, "rememberMe");
		String redirect = ParamUtil.getString(request, "redirect", StringPool.BLANK);
		%>
		<form id="login-form" class="uni-form" action="<portlet:actionURL><portlet:param name="struts_action" value="/login/view" /><portlet:param name="<%= Constants.CMD %>" value="<%= Constants.UPDATE %>" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
        
        <input alt=" " name="<portlet:namespace />rememberMe" type="hidden" value="<%= rememberMe %>" />
		<c:if test="<%=session.getAttribute(WebKeys.LAST_PATH)==null %>">
		<input alt=" " name="<portlet:namespace />redirect" type="hidden" value="<%= redirect %>" />
		</c:if>
        
        <liferay-ui:error exception="<%= AuthException.class %>" message="authentication-failed" />
		<liferay-ui:error exception="<%= CookieNotSupportedException.class %>" message="authentication-failed-please-enable-browser-cookies" />
		<liferay-ui:error exception="<%= NoSuchUserException.class %>" message="please-enter-a-valid-login" />
		<liferay-ui:error exception="<%= PasswordExpiredException.class %>" message="your-password-has-expired" />
		<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-login" />
		<liferay-ui:error exception="<%= UserLockoutException.class %>" message="this-account-has-been-locked" />
		<liferay-ui:error exception="<%= UserPasswordException.class %>" message="please-enter-a-valid-password" />
		<liferay-ui:error exception="<%= UserScreenNameException.class %>" message="please-enter-a-valid-screen-name" />

            <fieldset class="inline-labels" id="login-fieldset">
              <!--USERNAME-->
              <div class="ctrl-holder" id="username">
                <label for="username-input"><liferay-ui:message key="login" /></label>
                <input alt="<%= login %>" name="<portlet:namespace />login" id="username-input" value="<%= login %>"  class="textInput" type="text">
              </div>
              <!--PASSWORD-->
              <div class="ctrl-holder" id="password">
                <label for="password-input"><liferay-ui:message key="password" /></label>
                <input alt="<%= password %>" name="<portlet:namespace />password" id="password-input" value="<%= password %>"  class="textInput" type="password">
              </div>
           	<%
					boolean useotp=GetterUtil.getBoolean(PropsUtil.get("use.yubicoauthentication"),false);
					if (useotp) {
					%>	
				<!--OTP-->
              <div class="ctrl-holder" id="otp">
                <label for="otp-input"><liferay-ui:message key="otp" /></label>
                <input name="<portlet:namespace />otp" id="otp-input" value=""  class="textInput" type="password">
              </div>
              <% } %>
			<%
					if (!useotp) {
					%>	
              <!--REMEMBER ME-->
             <div class="ctrl-holder" id="remember-me">        
             <label for="remember-me-checkbox" ><liferay-ui:message key="remember-me" /></label>
               	<input name="remember-me" id="remember-me-checkbox" value="0"  type="checkbox"
                onClick="if (this.checked) {
								document.<portlet:namespace />fm.<portlet:namespace />rememberMe.value = 'on';
							}
							else {
								document.<portlet:namespace />fm.<portlet:namespace />rememberMe.value = 'off';
							}"
					>
              </div>
				<% } %>   
              
               <!--LOGIN BTN-->
              <div class="buttonHolder" id="login-btn">
                 <button title="Submit" type="submit" class="primaryAction"><span><liferay-ui:message key="sign-in" /></span></button>
              </div>
              
               <!--PASSWORD BTN-->
               <% if (GetterUtil.getBoolean(PropsUtil.get(PortalUtil.getCompanyId(request), "company.security.strangers"), false)) { %>
              <div class="buttonHolder" id="password-btn">
                 <button title="Create Account" type="button" onclick="self.location = '<%= themeDisplay.getURLCreateAccount() %>';"><span><liferay-ui:message key="create-account" /></span></button>
              </div>
              <% } %>

			  <!--FORGOT PASSWORD-->
          	  <div class="ctrl-holder" id="forgot-password">
              	 <p class="formHint"><a href="<%= themeDisplay.getPathMain() %>/portal/login?tabs1=forgot-password">
						<liferay-ui:message key="forgot-password" />?</a>
                 </p>
              </div>
              
              
              <!--FORGOT PASSWORD-->
          	  <div class="ctrl-holder" id="additional-info">
              	 <p class="formHint">
						<liferay-ui:message key="additional-info" /></a>
                 </p>
              </div>
            </fieldset>
            
        </form>
		<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
			<script type="text/javascript">
				Liferay.Util.focusFormField(document.<portlet:namespace />fm.<portlet:namespace />login);
			</script>
            <noscript></noscript>
		</c:if>

	</c:otherwise>
</c:choose>