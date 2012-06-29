<%@ include file="/html/portlet/ext/base/events/wizard/init.jsp" %>

<%@ page import="com.ext.portlet.base.events.BsEventForm" %>

<% BsEventForm eventForm = (BsEventForm)request.getAttribute("bsEventForm"); 
   String selectedRoomIds = (String)request.getAttribute("selectedRoomIds");
   if (Validator.isNull(selectedRoomIds)) selectedRoomIds = "";
   String eventTime2 = (String)request.getAttribute("eventTime2");
   if (Validator.isNull(eventTime2)) eventTime2 = "";
   String eventTime3 = (String)request.getAttribute("eventTime3");
   if (Validator.isNull(eventTime3)) eventTime3 = "";
   String eventEndTime2 = (String)request.getAttribute("eventEndTime2");
   if (Validator.isNull(eventEndTime2)) eventEndTime2 = "";
   String eventEndTime3 = (String)request.getAttribute("eventEndTime3");
   if (Validator.isNull(eventEndTime3)) eventEndTime3 = "";
   String selectedTicketTypes = (String)request.getAttribute("selectedTicketTypes");
   if (Validator.isNull(selectedTicketTypes)) selectedTicketTypes = ",";
   List<ViewResult> ticketTypes = GnPersistenceService.getInstance(null).listObjectsWithLanguage(PortalUtil.getCompanyId(request), EvTicketType.class, GeneralUtils.getLocale(request), new String[]{"langs.name"});
   String selectedZones = (String)request.getAttribute("selectedZones");
   if (Validator.isNull(selectedZones)) selectedZones = ",";
   boolean mandatoryPayment = event.isMandatoryPayment();
   String mandatoryPaymentParam = request.getParameter("mandatoryPayment");
   if (Validator.isNotNull(mandatoryPaymentParam))
	   mandatoryPayment = mandatoryPaymentParam.equals("on");
   String eventTime = event.getEventTime();
   String eventEndTime = event.getEventEndTime();
   String eventTimeString = (String)request.getAttribute("eventTime");
   if (Validator.isNotNull(eventTimeString)) eventTime = eventTimeString;
   String eventEndTimeString = (String)request.getAttribute("eventEndTime");
   if (Validator.isNotNull(eventEndTimeString)) eventEndTime = eventEndTimeString;
   
   List<ViewResult> zones = (List<ViewResult>)request.getAttribute("zonesList");
 %>

<h3>1. <%= LanguageUtil.get(pageContext, "bs.events.eshop.step.1") %></h3>

<br>

<form name="bs_events_wizard_step_1_form" 
	  action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/events/saveWizard"/></portlet:actionURL>" 
	  method="post" class="uni-form">
<input type="hidden" name="eventid" value="<%= eventid %>">	  
<input type="hidden" name="step" value="1">
<input type="hidden" name="redirect" value="<%= redirect %>">

<fieldset class="inline-labels">
<div class="ctrl-holder">
<label for="mandatoryPayment"><%= LanguageUtil.get(pageContext, "bs.events.mandatoryPayment") %></label>
	<input type="checkbox" name="mandatoryPayment" value="on" <% if (mandatoryPayment) {out.print("checked");} %>>
</div>	  


<div class="ctrl-holder">
<label for="onlineReservationsHourLimit"><%= LanguageUtil.get(pageContext, "bs.events.onlineReservationsHourLimit") %></label>
	<input type="text" name="onlineReservationsHourLimit" size="4" value="<%= (Validator.isNotNull(event.getOnlineReservationsHourLimit())? event.getOnlineReservationsHourLimit().toString() : "") %>">
</div>	 
</fieldset>

<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.events.ora") %>
</legend>
<div class="ctrl-holder">
<label for="eventTime"><%= LanguageUtil.get(pageContext, "bs.events.eshop.multiple-times.help") %></label>
</div>
<div class="ctrl-holder">
<label for="eventTime"><%= LanguageUtil.get(pageContext, "bs.events.eventStartTime") %></label>
	<input type="text" name="eventTime" size="6" value="<%= (Validator.isNotNull(eventTime)? eventTime: "") %>">
	&nbsp;&nbsp;<input type="text" id="eventTime2" name="eventTime2" size="6" value="<%= eventTime2 %>" >
	&nbsp;&nbsp;<input type="text" id="eventTime3" name="eventTime3" size="6" value="<%= eventTime3 %>" >
</div>
<div class="ctrl-holder">
<label for="eventEndTime"><%= LanguageUtil.get(pageContext, "bs.events.eventEndTime") %></label>
	<input type="text" name="eventEndTime" size="6" value="<%= (Validator.isNotNull(eventEndTime)? eventEndTime: "") %>">
	&nbsp;&nbsp;<input type="text" id="eventEndTime2" name="eventEndTime2" size="6" value="<%= eventEndTime2 %>" >
	&nbsp;&nbsp;<input type="text" id="eventEndTime3" name="eventEndTime3" size="6" value="<%= eventEndTime3 %>" >
</div>	 
</fieldset>


<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.events.eshop.multiple-places") %>
</legend>
<div class="ctrl-holder">
<label for="roomid"><%= LanguageUtil.get(pageContext, "bs.events.eshop.multiple-places.help") %></label>
<script language="JavaScript">
function reSubmitForm() {
	document.bs_events_wizard_step_1_form.action = '<portlet:actionURL><portlet:param name="struts_action" value="/ext/events/loadWizard"/></portlet:actionURL>';
	submitForm(document.bs_events_wizard_step_1_form);
}
</script>
<select name="locations" multiple="true" size="6" onChange="reSubmitForm();">
<% for (int i=0; i<eventForm.getRoomIds().length; i++) { %>
	<option value="<%= eventForm.getRoomIds()[i] %>" <% if(selectedRoomIds.indexOf(","+eventForm.getRoomIds()[i]+",") != -1) { out.print("selected"); } %>><%= eventForm.getRoomNames()[i] %></option>
<% } %>
</select>

</div>
</fieldset>

<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.events.eshop.tickets") %>
</legend>
<div class="ctrl-holder">
<label for="roomid"><%= LanguageUtil.get(pageContext, "bs.events.eshop.tickets.help") %></label>

<div>
<table>
<% for (ViewResult t:ticketTypes) {%>
<tr>
<td><%= t.getField1() %></td>
<td>
<input type="checkbox" name="ticketTypes" value="<%= t.getMainid().toString() %>" <% if (selectedTicketTypes.equals(",") || selectedTicketTypes.indexOf(t.getMainid().toString()) != -1) { out.print("checked");} %>>
</td>
</tr>
<% } %>
</table>
</div>
</div>
</fieldset>


<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.events.eshop.zones") %>
</legend>

<div class="ctrl-holder">
<label for="roomid"><%= LanguageUtil.get(pageContext, "bs.events.eshop.zones.help") %></label>
<div>
<table>
<% for (ViewResult z:zones) {%>
<tr>
<td><%= z.getField1() %></td>
<td style="white-space:nowrap">
<input type="hidden" name="zones" value="<%= z.getMainid().toString() %>">
<input type="checkbox" name="zones" value="<%= z.getMainid().toString() %>" checked disabled="true">
<%-- if (selectedZones.equals(",") || selectedZones.indexOf(z.getMainid().toString()) != -1) { out.print("checked");} --%>
<input type="text" size="4" name="zoneCapacity_<%= z.getMainid().toString() %>" value="<%= z.getField2() %>">
</td>
</tr>
<% } %>
</table>
</div>
</div>
</fieldset>


<div class="button-holder" style="text-align:center">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "bs.events.eshop.next") %>">
</div>
</form>

<br><br>

<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;
<% if (redirect != null) { %>
<a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_events") %></a>
<% } else { %>
<html:link action="/ext/events/list"><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_events") %></html:link>
<% } %>

	