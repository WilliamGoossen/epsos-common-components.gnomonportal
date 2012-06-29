<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<%@ page import="com.ext.portlet.epsos.*" %>
<%@ page import="com.ext.portlet.epsos.demo.PatientSearchForm" %>
<%@ page import="com.ext.portlet.epsos.consent.PatientConsentObject" %>
<%@ page import="com.spirit.ehr.ws.client.generated.*" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<form name="PATIENT_CONSENT_FORM" action="some/action" method="post" class="uni-form">

<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "epsos.demo.consent.form") %></legend>

<div class="ctrl-holder">
<% 
List<PolicySetGroup> objGroupList = (List<PolicySetGroup>)request.getAttribute("objGroupList");
if (objGroupList != null && objGroupList.size()>0) {
	%><ul><%
	for (PolicySetGroup g: objGroupList) {
		%><li><em><%= g.getDisplay() %></em> 
		<%
		if (g.getDocument() != null)
		{
			%>
			&nbsp;<a title="<%= LanguageUtil.get(pageContext, "download") %>" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
				<portlet:param name="struts_action" value="/ext/epsos/demo/getDocument"/>
				<portlet:param name="patID" value="<%=  request.getParameter("patID")  %>"/>
				<portlet:param name="patIDType" value="<%=  request.getParameter("patIDType")  %>"/>
				<portlet:param name="docType" value="<%=  request.getParameter("docType")  %>"/>
				<portlet:param name="country" value="<%=  request.getParameter("country")  %>"/>
				<portlet:param name="docID" value="<%=  g.getDocument().getUniqueId() %>"/>
				<portlet:param name="redirect" value="<%= currentURL %>"/>
			</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/download.png" alt="download"><%= g.getDocument().getName() %></a>
			&nbsp;
			<a title="<%= LanguageUtil.get(pageContext, "epsos.xsl.view") %>" href="javascript:openDialog('<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
			<portlet:param name="struts_action" value="/ext/epsos/demo/xslTransformDocument"/>
			<portlet:param name="patID" value="<%=  request.getParameter("patID")  %>"/>
			<portlet:param name="patIDType" value="<%=  request.getParameter("patIDType")  %>"/>
			<portlet:param name="docType" value="<%=  request.getParameter("docType")  %>"/>
			<portlet:param name="country" value="<%=  request.getParameter("country")  %>"/>
			<portlet:param name="docID" value="<%=  g.getDocument().getUniqueId() %>"/>
			<portlet:param name="redirect" value="<%= currentURL %>"/>
			</portlet:actionURL>', 900,800);"><img src="<%= themeDisplay.getPathThemeImage() %>/common/view_templates.png" alt="XSL"></a>
			
			<%
		}
		List<PolicySetItem> items = g.getPolicySetItemList();
		if (items != null && items.size() > 0)
		{
			%><ul><%
			for (PolicySetItem i: items) {
				%><li>
				<input type="checkbox" name="policyid" value="<%=g.getCode()+"$$$"+i.getPolicySetId()%>"  disabled="true" <% if (i.isSelected()) { out.print("checked"); } %>>
				<%= i.getDescription() %> 
				<% if (i.getEffectiveDateFrom() != null && i.getEffectiveDateTo() != null) { %>
				[ <%= EpsosHelperService.dateTimeFormat.format(i.getEffectiveDateFrom().toGregorianCalendar().getTime()) %> - 
				<%= EpsosHelperService.dateTimeFormat.format(i.getEffectiveDateTo().toGregorianCalendar().getTime()) %>]
				<% } %>
				</li><%
			}
			%></ul><%
		}
		%></li><%
	}
	%></ul><%
}
%>
</div>

<div class="button-holder" id="buttonDiv">
<input type="button" value="<%= LanguageUtil.get(pageContext, "print") %>" onClick="document.getElementById('buttonDiv').style.display='none'; window.print();">
<input type="button"  value="<%= LanguageUtil.get(pageContext, "cancel") %>" onClick="self.close();">
</div>

</fieldset>

<input value="<%= LanguageUtil.get(pageContext, "print") %>" type="button" onclick="window.open('<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/getConsentPDF"/>
<portlet:param name="patID" value="<%= request.getParameter("patID") %>"/>
</portlet:actionURL>')" />
</form>

