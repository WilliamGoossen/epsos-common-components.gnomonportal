<%@ include file="/html/portlet/ext/epsos/consent/init.jsp" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

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
<portlet:param name="struts_action" value="/ext/epsos/consent/checkPatientAccess"/>
</portlet:actionURL>" method="post" class="uni-form">

<input type="hidden" name="redirect" value="<%= request.getParameter("redirect") %>">
<input type="hidden" name="patID" value="<%= request.getParameter("patID") %>">
<input type="hidden" name="country" value="<%= request.getParameter("country") %>">
<input type="hidden" name="forwardAction" value="<%= request.getParameter("forwardAction") %>">
<input type="hidden" name="accessAction" value="createConfirmation">



<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "epsos.demo.confirmation.button") %>">
<input type="button" value="<%= LanguageUtil.get(pageContext, "cancel") %>" onClick="location.href='<%= redirect %>';">
</div>

</fieldset>

</form>
