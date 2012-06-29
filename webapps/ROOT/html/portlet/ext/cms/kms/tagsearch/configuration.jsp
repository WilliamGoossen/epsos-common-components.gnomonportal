<%@ include file="/html/portlet/ext/cms/kms/tagsearch/init.jsp" %>

<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<%
String value = "";

String portletResource = ParamUtil.getString(request, "portletResource");
if ( portletResource!=null && !portletResource.equals("") ) {
		PortletPreferences portletPrefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
		value = portletPrefs.getValue("searchKeywords", StringPool.BLANK);
		if (value == null) value = " ";
}
%>
<form name="GI9_KMS_TAG_SEARCH_CONFIG" action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
<span class=""><%= LanguageUtil.get(pageContext, "gn.button.search") %></span>
<input type="text" size="60" name="searchKeywords" value="<%= value %>">
<br><br>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "save") %>">
</form>


