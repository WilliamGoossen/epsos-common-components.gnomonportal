<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>

<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.crm.CrCategory" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="java.util.List" %>

<%
String value = "";

String portletResource = ParamUtil.getString(request, "portletResource");
if ( portletResource!=null && !portletResource.equals("") ) {
		PortletPreferences portletPrefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
		value = portletPrefs.getValue("categoryid", StringPool.BLANK);
		if (value == null) value = " ";
}

List cats = GnPersistenceService.getInstance(null).listObjectsWithLanguage(PortalUtil.getCompanyId(request), CrCategory.class, GeneralUtils.getLocale(request), new String[]{"langs.name"}, "table1.veveosi = 1", "langs.name");

%>
<form name="GI9_CRM_HELPDESK_CERTIFICATES_CONFIG" action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
<span class=""><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.name") %></span>

<select name="categoryid">
<% for (int i=0; i<cats.size(); i++)  {
	ViewResult catView = (ViewResult)cats.get(i);
	%>
	<option name="<%= catView.getMainid().toString() %>" value="<%= catView.getMainid().toString() %>"
		<% if (catView.getMainid().toString().equals(value)) { out.print("selected"); } %>
	><%= catView.getField1().toString() %></option>
<% } %>
</select>
<br><br>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "save") %>">
</form>


