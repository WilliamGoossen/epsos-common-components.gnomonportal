<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<%@ page import="com.ext.portlet.epsos.*" %>
<%@ page import="com.ext.portlet.epsos.demo.PatientSearchForm" %>
<%@ page import="com.ext.portlet.epsos.consent.PatientConsentObject" %>
<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%// if (EpsosHelperService.getInstance().hasCurrentUserPhysicianRole(request)) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<% String secondTime = (String)request.getAttribute("consentFailure"); 
   if (secondTime != null && secondTime.equals("true")) {
	   %>
	   <span class="portlet-msg-error">
	   <%= LanguageUtil.get(pageContext, "epsos.demo.consent.error") %>
	   </span>
	   <%
   } else {
	   %>
	   <span class="portlet-msg-alert">
	   <%= LanguageUtil.get(pageContext, "epsos.demo.consent.title") %>
	   </span>
	   <%
	}
   Calendar cal = Calendar.getInstance();
   Date now = cal.getTime();
   cal.add(Calendar.MONTH, 1);
   Date oneMonthLater = cal.getTime();
   String countryOfOrganization = (String)request.getAttribute("countryOfOrganization");	
%>
<form name="PATIENT_CONSENT_FORM" action="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/demo/checkPatientAccess"/>
</portlet:actionURL>" method="post" class="uni-form">
<% if ("currentURL".equals(request.getAttribute("redirect"))) { %>
<input type="hidden" name="redirect" value="<%= currentURL %>">
<% } else { %>
<input type="hidden" name="redirect" value="<%= request.getParameter("redirect") %>">
<% } %>
<input type="hidden" name="patID" value="<%= request.getParameter("patID") %>">
<input type="hidden" name="forwardAction" value="<%= request.getParameter("forwardAction") %>">
<input type="hidden" name="country" value="<%= request.getParameter("country") %>">
<input type="hidden" name="docType" value="<%= request.getParameter("docType") %>">
<input type="hidden" name="patIDType" value="<%= request.getParameter("patIDType") %>">
<input type="hidden" name="patids" value="<%= request.getParameter("patids") %>">
<input type="hidden" name="accessAction" value="createConsent">

<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "epsos.demo.consent.form") %></legend>

<%--
<div class="ctrl-holder">
<label for="country"><%= LanguageUtil.get(pageContext, "epsos.consent.country") %></label>

<select name="country" id="country">
<% for (String c: PatientSearchForm.COUNTRY_IDS) { %>
	<option value="<%= c %>" <% if (c.equals(countryOfOrganization)) { out.print("selected");} %>><%= c %></option>
<% } %>
</select>
</div>
--%>

<div class="ctrl-holder">
<label for="creationDate"><%= LanguageUtil.get(pageContext, "epsos.consent.creationDate") %></label>

<span>
<%= EpsosHelperService.dateTimeFormat.format(now) %>
</span>
</div>

<div class="ctrl-holder">
<% 
List<PolicySetGroup> objGroupList = (List<PolicySetGroup>)request.getAttribute("objGroupList");
if (objGroupList != null && objGroupList.size()>0) {
	%><table class="liferay-table" width="100%"><%
	for (PolicySetGroup g: objGroupList) {
		%><tr><th><%= g.getDisplay() %></th> 
		<%
		if (g.getDocument() != null)
		{
			%>
			<td><a title="<%= LanguageUtil.get(pageContext, "download") %>" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
				<portlet:param name="struts_action" value="/ext/epsos/demo/getDocument"/>
				<portlet:param name="patID" value="<%=  request.getParameter("patID")  %>"/>
				<portlet:param name="docType" value="<%=  request.getParameter("docType")  %>"/>
				<portlet:param name="docID" value="<%=  g.getDocument().getUniqueId() %>"/>
				<portlet:param name="redirect" value="<%= currentURL %>"/>
			</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/download.png" alt="download"><%= g.getDocument().getName() %></a>
			</td><td></td></tr>
			<%
		}
		List<PolicySetItem> items = g.getPolicySetItemList();
		System.out.println("ITEMS: " + items.size());
		if (items != null && items.size() > 0)
		{
			for (PolicySetItem i: items) {
				%><tr><th>
				<input type="checkbox" name="policyid" value="<%=g.getCode()+"$$$"+i.getPolicySetId()%>" <% if (i.isSelected()) { out.print("checked"); } %>>
				<%= i.getDescription() %></th>
				<td>
				<input type="text" id="<%=g.getCode()+"$$$"+i.getPolicySetId()%>_fromDate" name="<%=g.getCode()+"$$$"+i.getPolicySetId()%>_fromDate" readonly="true" readonly>
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_<%=g.getCode()+"$$$"+i.getPolicySetId()%>_fromDate" style="cursor: pointer; border: 0px solid red;" title="Date selector" alt="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
<script type="text/javascript">
   Calendar.setup({
       inputField     :    "<%=g.getCode()+"$$$"+i.getPolicySetId()%>_fromDate",     // id of the input field
       button         :    "f_<%=g.getCode()+"$$$"+i.getPolicySetId()%>_fromDate",  // trigger for the calendar (button ID)
       align          :    "Tl",           // alignment (defaults to "Bl")
		ifFormat    : "%d/%m/%Y %H:%M",
		daFormat : "%d/%m/%Y %H:%M",
		showsTime :true,
       singleClick    :    true,
       firstDay       : "1"
   });
</script>
            <noscript></noscript> </td>
            <td>
				<input type="text" id="<%=g.getCode()+"$$$"+i.getPolicySetId()%>_toDate" name="<%=g.getCode()+"$$$"+i.getPolicySetId()%>_toDate" readonly="true">
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_<%=g.getCode()+"$$$"+i.getPolicySetId()%>_toDate" style="cursor: pointer; border: 0px solid red;" title="Date selector" alt="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
<script type="text/javascript">
   Calendar.setup({
       inputField     :    "<%=g.getCode()+"$$$"+i.getPolicySetId()%>_toDate",     // id of the input field
       button         :    "f_<%=g.getCode()+"$$$"+i.getPolicySetId()%>_toDate",  // trigger for the calendar (button ID)
       align          :    "Tl",           // alignment (defaults to "Bl")
		ifFormat    : "%d/%m/%Y %H:%M",
		daFormat : "%d/%m/%Y %H:%M",
		showsTime :true,
       singleClick    :    true,
       firstDay       : "1"
   });
</script>
            <noscript></noscript>
				</td></tr><%
			}
		}
	}
	%></table><%
}
%>
</div>

<div class="button-holder">
<input type="hidden" name="createNewConsent" value="true">
<input type="hidden" value="<%= ParamUtil.getString(request,"reason","") %>" name="reason">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "epsos.demo.consent.create.button") %>">
<input value="<%= LanguageUtil.get(pageContext, "print") %>" type="button" onclick="window.open('<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/getConsentPDF"/>
<portlet:param name="patID" value="<%= request.getParameter("patID") %>"/>
</portlet:actionURL>')" />
</div>

</fieldset>

</form>

