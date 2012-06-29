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

<%@ include file="/html/portlet/my_account/init.jsp" %>

<%
User user2 = null;
Contact contact2 = null;

Calendar birthday = CalendarFactoryUtil.getCalendar();

birthday.set(Calendar.MONTH, Calendar.JANUARY);
birthday.set(Calendar.DATE, 1);
birthday.set(Calendar.YEAR, 1970);

boolean male = BeanParamUtil.getBoolean(contact2, request, "male", true);
%>
<div id="createaccount">

<form class="uni-form" action="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/my_account/create_account" /></portlet:actionURL>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.ADD %>" />

<liferay-ui:error exception="<%= CaptchaTextException.class %>" message="text-verification-failed" />
<liferay-ui:error exception="<%= ContactFirstNameException.class %>" message="please-enter-a-valid-first-name" />
<liferay-ui:error exception="<%= ContactLastNameException.class %>" message="please-enter-a-valid-last-name" />
<liferay-ui:error exception="<%= DuplicateUserEmailAddressException.class %>" message="the-email-address-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= DuplicateUserIdException.class %>" message="the-user-id-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= DuplicateUserScreenNameException.class %>" message="the-screen-name-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= ReservedUserEmailAddressException.class %>" message="the-email-address-you-requested-is-reserved" />
<liferay-ui:error exception="<%= com.liferay.portlet.myaccount.action.PartyEmailAddressException.class %>" message="the-party-email-address-you-requested-is-reserved" />
<liferay-ui:error exception="<%= ReservedUserIdException.class %>" message="the-user-id-you-requested-is-reserved" />
<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-email-address" />
<liferay-ui:error exception="<%= UserIdException.class %>" message="please-enter-a-valid-user-id" />
<liferay-ui:error exception="<%= UserScreenNameException.class %>" message="please-enter-a-valid-screen-name" />
<liferay-ui:error exception="<%= com.liferay.portlet.myaccount.action.PartyPhoneNumberException.class %>" >
<% com.liferay.portlet.myaccount.action.PartyPhoneNumberException phnEx = (com.liferay.portlet.myaccount.action.PartyPhoneNumberException)errorException;%>
<liferay-ui:message key="<%=phnEx.getMessageKey() %>" />
</liferay-ui:error>


<div class="col block-labels">
	<fieldset class="block-labels">	
	<legend><%=LanguageUtil.get(pageContext,"registration-information") %></legend>
   
	<div class="block-labels">
		<div class="ctrl-holder">
			<label for="<portlet:namespace/>firstName"><liferay-ui:message key="first-name" /><em>*</em></label>
			<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="firstName" />
		</div>
		<c:if test="<%= GetterUtil.getBoolean(PropsUtil.get("registration.ask.middlename"),true) %>">
		<div class="ctrl-holder">
			<label for="<portlet:namespace/>middleName"><liferay-ui:message key="middle-name" /></label>
			<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="middleName" />
		</div>
		</c:if>
		<div class="ctrl-holder">
			<label for="<portlet:namespace/>lastName"><liferay-ui:message key="last-name" /><em>*</em></label>
			<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="lastName" />
		</div>
		
		<c:if test="<%= !GetterUtil.getBoolean(PropsUtil.get(PropsUtil.USERS_SCREEN_NAME_ALWAYS_AUTOGENERATE)) %>" >
		<div class="ctrl-holder">
			<label for="<portlet:namespace/>screenName"><liferay-ui:message key="screen-name" /><em>*</em></label>
			<liferay-ui:input-field model="<%= User.class %>" bean="<%= user2 %>" field="screenName" />
		</div>
		</c:if>
		
		<div class="ctrl-holder">
			<label for="<portlet:namespace/>emailAddress"><liferay-ui:message key="email-address" /><em>*</em></label>
			<liferay-ui:input-field model="<%= User.class %>" bean="<%= user2 %>" field="emailAddress" />
		</div>
		
		<c:choose>
			<c:when test="<%= GetterUtil.getBoolean(PropsUtil.get(PropsUtil.FIELD_ENABLE_COM_LIFERAY_PORTAL_MODEL_CONTACT_BIRTHDAY)) %>">
				<div class="ctrl-holder">
					<label for="<portlet:namespace/>birthday"><liferay-ui:message key="birthday" /></label>
					<liferay-ui:input-field model="<%= Contact.class %>" bean="<%= contact2 %>" field="birthday" defaultValue="<%= birthday %>" />
				</div>
			</c:when>
			<c:otherwise>
				<input name="<portlet:namespace />birthdayMonth" type="hidden" value="<%= Calendar.JANUARY %>" />
				<input name="<portlet:namespace />birthdayDay" type="hidden" value="1" />
				<input name="<portlet:namespace />birthdayYear" type="hidden" value="1970" />
			</c:otherwise>
		</c:choose>
		
		<c:if test="<%= GetterUtil.getBoolean(PropsUtil.get(PropsUtil.FIELD_ENABLE_COM_LIFERAY_PORTAL_MODEL_CONTACT_MALE)) %>">
			<div class="ctrl-holder">
				<label for="<portlet:namespace/>gender"><liferay-ui:message key="gender" /></label>
				<select name="<portlet:namespace />male">
					<option value="1"><liferay-ui:message key="male" /></option>
					<option <%= !male? "selected" : "" %> value="0"><liferay-ui:message key="female" /></option>
				</select>
			</div>
		</c:if>
		
		<c:if test="<%= GetterUtil.getBoolean(PropsUtil.get("registration.ask.phonenumber"),false) %>">
		<%boolean phoneNumReq = GetterUtil.getBoolean(PropsUtil.get("registration.ask.phonenumber.required"),false); %>
			<div class="ctrl-holder">
				<label for="<portlet:namespace/>phonenumber"><liferay-ui:message key="contacts.search.phone" />
				<%if (phoneNumReq){ %><em>*</em><%} %>
				</label>
				<input type="text" name="phonenumber">
			</div>
		</c:if>

		<div class="ctrl-holder">
			<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>" var="captchaURL">
			<portlet:param name="struts_action" value="/my_account/captcha" />
			</portlet:actionURL>
            <liferay-ui:captcha url="<%= captchaURL %>" />
		</div>
	</div>
	</fieldset>
</div>
	
<div class="col block-labels"">
	<fieldset class="block-labels" style="border:0;">
		<tiles:insert page="/html/portlet/my_account/create_account_services_tile.jsp" flush="true">
		</tiles:insert>
	</fieldset>	
</div>


<br />
    <div class="button-holder">
        <%= LanguageUtil.get(pageContext, "my_account.user.signup.intro2.html") %>
        <input type="submit" value="<liferay-ui:message key="save" />" />
    </div>
</form>

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		Liferay.Util.focusFormField(document.<portlet:namespace />fm.<portlet:namespace />firstName);
	</script>
</c:if>

</div>

