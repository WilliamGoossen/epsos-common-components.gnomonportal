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

<%@ include file="/html/portlet/enterprise_admin/init.jsp" %>

<%

String redirect = ParamUtil.getString(request, "redirect");

User user2 = PortalUtil.getSelectedUser(request);

boolean editable = false;

if (portletName.equals(PortletKeys.ENTERPRISE_ADMIN) || portletName.equals(PortletKeys.LOCATION_ADMIN) || portletName.equals(PortletKeys.ORGANIZATION_ADMIN) || portletName.equals(PortletKeys.MY_ACCOUNT)) {
	editable = true;

	if ((user2 != null) && !UserPermissionUtil.contains(permissionChecker, user2.getUserId(), user2.getOrganization().getOrganizationId(), user2.getLocation().getOrganizationId(), ActionKeys.UPDATE)) {
		editable = false;
	}
}

Contact contact2 = null;

if (user2 != null) {
	contact2 = user2.getContact();
}

PasswordPolicy passwordPolicy = null;

if (user2 == null) {
	passwordPolicy = PasswordPolicyLocalServiceUtil.getDefaultPasswordPolicy(company.getCompanyId());
}
else {
	passwordPolicy = user2.getPasswordPolicy();
}

String emailAddress = BeanParamUtil.getString(user2, request, "emailAddress");

String openPanel = ParamUtil.getString(request, "openPanel", "update");
//System.out.println(openPanel);
%>

<script src="<%=themeDisplay.getPathJavaScript() %>/SpryAssets/SpryAccordion.js" type="text/javascript"></script>
<link href="<%=themeDisplay.getPathThemeRoot() %>/css/SpryAccordion.css" rel="stylesheet" type="text/css" />




<script type="text/javascript">
	function <portlet:namespace />saveUser(cmd) {
		document.ContactForm.<portlet:namespace /><%= Constants.CMD %>.value = cmd;
		document.ContactForm.<portlet:namespace />openPanel.value = cmd;
		document.ContactForm.<portlet:namespace />redirect.value = "<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_gi9_user" /><portlet:param name="openPanel" value="dummy" /></portlet:renderURL>&<portlet:namespace />redirect=<%= HttpUtil.encodeURL(redirect) %>&<portlet:namespace />p_u_i_d=";
		submitForm(document.ContactForm, "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/enterprise_admin/edit_gi9_user" /></portlet:actionURL>");
	}
</script>

<html:form action="/enterprise_admin/edit_gi9_user?actionURL=true" enctype="multipart/form-data">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="" />
<input name="<portlet:namespace />openPanel" type="hidden" value="" />
<input name="<portlet:namespace />redirect" type="hidden" value="" />
<input name="<portlet:namespace />p_u_i_d" type="hidden" value='<%= (user2 != null) ? user2.getUserId() : 0 %>' />

<liferay-util:include page="/html/portlet/my_account/tabs1.jsp">
	<liferay-util:param name="tabs1" value="profile" />
</liferay-util:include>

<% if (user2 != null)  {%>

	<c:if test="<%= user2.getLockout() %>">
		<liferay-ui:tabs names="lockout" />

		<%@ include file="/html/portlet/enterprise_admin/edit_user_lockout.jspf" %>
	</c:if>

	<c:if test="<%= editable %>">

	<div id="<portlet:namespace/>myAccount" class="Accordion" tabindex="0">
		<div class="AccordionPanel" id="update">
			<div class="AccordionPanelTab"><%=LanguageUtil.get(pageContext, "gn.myaccount.account-information") %></div>
			<div class="AccordionPanelContent">

		 	<%@ include file="/html/portlet/enterprise_admin/gi9_user_profile.jspf" %>

			</div>
		</div>
		<div class="AccordionPanel" id="password">
			<div class="AccordionPanelTab"><%=LanguageUtil.get(pageContext, "gn.myaccount.change-password") %></div>
			<div class="AccordionPanelContent">
			
				<%@ include file="/html/portlet/enterprise_admin/gi9_user_password.jspf" %>
			
			</div>
		</div>
		<div class="AccordionPanel" id="display">
			<div class="AccordionPanelTab"><%=LanguageUtil.get(pageContext, "gn.myaccount.portal-preferences") %></div>
			<div class="AccordionPanelContent">
			
				<%@ include file="/html/portlet/enterprise_admin/edit_user_display.jspf" %>
			
			</div>
		</div>
		<%
		String showContactInfo = PropsUtil.get("portlet.enterprise_admin.edit_user.showContactInfo");
		if (Validator.isNull(showContactInfo) || showContactInfo.equals("true")){ %>
		<div class="AccordionPanel" id="contact">
			<div class="AccordionPanelTab"><%=LanguageUtil.get(pageContext, "gn.myaccount.contact-details") %></div>
			<div class="AccordionPanelContent">
			
				<%@ include file="/html/portlet/enterprise_admin/gi9_user_party_contact.jspf" %>
			
			</div>
		</div>
		<%} %>
		<c:if test="<%=GetterUtil.getBoolean(PropsUtil.get(company.getCompanyId(), "ecommerce.active"), false) %>">
		<div class="AccordionPanel" id="ec_profile">
			<div class="AccordionPanelTab"><%=LanguageUtil.get(pageContext, "gn.myaccount.eshop-preferences") %></div>
			<div class="AccordionPanelContent">
			
				<%@ include file="/html/portlet/enterprise_admin/gi9_user_eshop_profile.jspf" %>
			
			</div>
		</div>
		</c:if>
	</div>
	<script type="text/javascript">
	<!--
	var Accordion1 = new Spry.Widget.Accordion("<portlet:namespace/>myAccount", { useFixedPanelHeights: false, defaultPanel: "<%=openPanel%>" });
	//-->
	</script>

	</c:if>
		
	<%
	PortalUtil.setPageSubtitle(user2.getFullName(), request);
	%>

<% } else { %>

<%@ include file="/html/portlet/enterprise_admin/edit_user_profile.jspf" %>

<% } %>


</html:form>
