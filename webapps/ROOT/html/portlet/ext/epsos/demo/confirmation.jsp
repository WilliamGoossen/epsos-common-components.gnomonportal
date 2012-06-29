<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<%
try {
%>
<%if (Validator.isNotNull(request.getAttribute("exception")))  {%> 
<span class="portlet-msg-error">
<%= request.getAttribute("exception")+"" %>
</span>
<% } %>
<% } catch (Exception e) {} %>
<% String secondTime = (String)request.getAttribute("confirmationFailure"); 
   if (secondTime != null && secondTime.equals("true")) {
	   %>
	   <span class="portlet-msg-error">
	   <%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.error") %>
	   </span>
	   <%
   } else {
	   %>
	   <span class="portlet-msg-alert">
	   <%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.title") %>
	   </span>
	   <%
	}
   %>
<form name="PATIENT_CONSENT_FORM" action="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/demo/checkPatientAccess"/>
</portlet:actionURL>" method="post" class="uni-form">

<input type="hidden" name="redirect" value="<%= request.getParameter("redirect") %>">
<input type="hidden" name="patID" value="<%= request.getParameter("patID") %>">
<input type="hidden" name="country" value="<%= request.getParameter("country") %>">
<input type="hidden" name="docType" value="<%= request.getParameter("docType") %>">
<input type="hidden" name="patIDType" value="<%= request.getParameter("patIDType") %>">
<input type="hidden" name="patids" value="<%= request.getParameter("patids") %>">
<input type="hidden" name="forwardAction" value="<%= request.getParameter("forwardAction") %>">
<input type="hidden" name="accessAction" value="createConfirmation">

<h3><%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.purposeofuse") %></h3>
<input type="radio" name="purpose" value="TREATMENT" CHECKED /> <%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.treatment") %><br />
<input type="radio" name="purpose" value="EMERGENCY" /> <%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.emergency") %>
<br/>
<br/>
<h3><%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.pin.doc") %></h3>
<input type="radio" id="PIN" name="PIN" value="yes" /> <%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.pin.yes") %><br />
<input type="radio" id="PIN" name="PIN" value="no" /> <%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.pin.no") %>

<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.button") %>">
<input type="button" value="<%= LanguageUtil.get(pageContext, "cancel") %>" onClick="location.href='<%= redirect %>';">
</div>

</fieldset>

</form>

