<%@ include file="/html/portlet/ext/parties/init.jsp" %>


<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();
String portletResource = ParamUtil.getString(request, "portletResource");
if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}
long partyLayoutid = GetterUtil.getLong(prefs.getValue("partyLayout", StringPool.BLANK), 0);


List<ViewResult> partiesList = (List<ViewResult> )request.getAttribute("partiesList"); 
if (partiesList != null) {
	%>
	<ul>
	<% 
	for (ViewResult p: partiesList) {
	%>
	<li>
	
	<tiles:insert page="/html/portlet/ext/parties/contacts/view/partyViewLinkTile.jsp" flush="true">
		  <tiles:put name="mainid"  value="<%= p.getMainid() %>" />
		  <tiles:put name="partyName"  value="<%= p.getField1().toString() %>" />
		  <tiles:put name="partyLayoutid"  value="<%= partyLayoutid %>" />
		  <tiles:put name="imageFileName"  value="<%= p.getField2() %>" />
	</tiles:insert>
	
	</li>
	<%
	}
}
%>