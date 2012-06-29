<%@ include file="/html/portlet/ext/base/events/wizard/init.jsp" %>

<%
/*
 * MATRIX INFO is a list of ViewResults, one for each distinct room.
 * Each ViewResult contains: roomid, roomName, List of events.
 * Each event lines contains: eventid, eventStartDate, eventTime, eventEndTime, List of zonePrices
 * Each entry in zonePrices contains: zoneid, zoneName, zoneCode, capacity, ticketid, ticketName, price, eventzoneticketid
 */
List<ViewResult> matrixInfo = (List<ViewResult>)request.getAttribute("matrixInfo");
WizardService wiz = WizardService.getInstance();
%>

<h3>2. <%= LanguageUtil.get(pageContext, "bs.events.eshop.step.2") %></h3>
<br>
<span>
<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.help") %>
</span>
<br>
<form name="bs_events_wizard_step_2_form" 
	  action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/events/saveWizard"/></portlet:actionURL>" 
	  method="post" class="uni-form">
<input type="hidden" name="eventid" value="<%= eventid %>">	  
<input type="hidden" name="step" value="2">
<input type="hidden" name="redirect" value="<%= redirect %>">

<% for (ViewResult roomEntry: matrixInfo) { 
	 List<ViewResult> lines = (List<ViewResult>)roomEntry.getField2(); %>
<fieldset class="inline-labels">
<legend><%= roomEntry.getField1() %></legend>

<% List<ViewResult> sampleEventPricing = (List<ViewResult>)lines.get(0).getField4();
   List<ViewResult> uniqueZones = new ArrayList<ViewResult>();
   List<ViewResult> uniqueTickets = new ArrayList<ViewResult>();
   for (ViewResult samplePr: sampleEventPricing) {
	   if (!uniqueZones.contains(samplePr))
	   {
		   uniqueZones.add(new ViewResult(samplePr.getMainid(), samplePr.getField1(), samplePr.getField2(), samplePr.getField3()));
	   }
	   ViewResult sampleTicket = new ViewResult((Integer)samplePr.getField4(), samplePr.getField5(), samplePr.getField6());
	   if(!uniqueTickets.contains(sampleTicket))
	   {
		   uniqueTickets.add(sampleTicket);
	   }
   }
%>

<script language="JavaScript">
function roomTable_<%= roomEntry.getMainid() %>_repeatValueForTimeFields(fieldName, value) {
	<% for (ViewResult line: lines) { %>
	document.bs_events_wizard_step_2_form.elements[fieldName+'<%= line.getMainid().toString() %>'].value = value;
	<% } %>
}
function roomTable_<%= roomEntry.getMainid() %>_repeatValueForPriceFields(fieldName, zone, ticket, value) {
	<% for (ViewResult line: lines) { %>
	document.bs_events_wizard_step_2_form.elements[fieldName+'<%= line.getMainid().toString() %>'+'_'+zone+'_'+ticket].value = value;
	<% } %>
}
</script>

<table width="100%" class="liferay-table">
<tr>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.date-start") %>
</th>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.eventStartTime") %>
<hr>
<input type="text" title="<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.repeat.help") %>" name="repeat_value_field1" size="5" value="" onChange="roomTable_<%= roomEntry.getMainid() %>_repeatValueForTimeFields('eventTime_', value)">
</th>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.eventEndTime") %>
<hr>
<input type="text" title="<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.repeat.help") %>" name="repeat_value_field2" size="5" value="" onChange="roomTable_<%= roomEntry.getMainid() %>_repeatValueForTimeFields('eventEndTime_', value)">
</th>
<% for (ViewResult z: uniqueZones) { %>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= z.getField1() + (Validator.isNotNull(z.getField2()) ? " ("+z.getField2()+")" : "") + "<br>"+LanguageUtil.get(pageContext, "bs.events.zone.capacity") + ":"+z.getField3() %>
<hr>
<table width="100%" style="text-align:center;">
<% for (ViewResult t: uniqueTickets) { %>
<tr>
<td style="text-align:right"><%= t.getField1() + " \u20AC" %></td>
<td>
<input type="text" title="<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.repeat.help") %>" name="repeat_value_field3" size="6" value="" 
       onChange="roomTable_<%= roomEntry.getMainid() %>_repeatValueForPriceFields('price_', '<%= z.getMainid().toString() %>', '<%= t.getMainid().toString() %>',value)">
</td>
</tr>      
<% }  %>
</table>
</th>
<% } %>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
</th>
</tr>

<% for (ViewResult line: lines) { %>
<tr>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; white-space:nowrap;">
<input size="11" type="text" id="eventDateStart_<%= line.getMainid().toString() %>" name="eventDateStart_<%= line.getMainid().toString() %>" readonly="true" value="<%= com.ext.portlet.base.events.BsEventForm.date_format.format((java.util.Date)line.getField1()) %>">
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" 
		id="f_eventDateStart_<%= line.getMainid().toString() %>" 
		style="cursor: pointer; border: 1px solid red;" title="Date selector"
    	onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
    	<script type="text/javascript">
				    Calendar.setup({
				        inputField     :    "eventDateStart_<%= line.getMainid().toString() %>",     // id of the input field
				        button         :    "f_eventDateStart_<%= line.getMainid().toString() %>",  // trigger for the calendar (button ID)
				        align          :    "Tl",           // alignment (defaults to "Bl")
						ifFormat    	:  "%d/%m/%Y",
						daFormat 		:  "%d/%m/%Y",
						showsTime 	  :false,
				        singleClick    :    true,
				        firstDay       : "1"
				    });
		</script>
</td>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
<input type="text" size="5" name="eventTime_<%= line.getMainid().toString() %>" value="<%= line.getField2() %>"></td>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
<input type="text" size="5" name="eventEndTime_<%= line.getMainid().toString() %>" value="<%= line.getField3() %>"></td>
<% List<ViewResult> zonePrices = (List<ViewResult>)line.getField4();
Integer currentZoneId = null;
for (ViewResult zoneP: zonePrices) {
	boolean firstZone = false;
	if (currentZoneId == null) firstZone = true;
	if (currentZoneId == null || !zoneP.getMainid().equals(currentZoneId))
	{
		currentZoneId = zoneP.getMainid();
		if (!firstZone) { out.print("</table></td>"); }
		%>
		<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center"">
		<table style="text-align:center" width="100%">
		<%
	}
	%>
	<tr><td style="text-align:right"><%= zoneP.getField5() + " \u20AC" %></td>
	<td><input type="text" size="6" name="price_<%= line.getMainid()+ "_" + zoneP.getMainid() + "_"+zoneP.getField4() %>" value="<%= zoneP.getField6()!= null ? ((BigDecimal)zoneP.getField6()).setScale(2, BigDecimal.ROUND_HALF_UP).toString() : "" %>">
	</td></tr>
<%	
}
%>
</table></td>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
<a title="<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.delete") %>" 
   href="<portlet:actionURL>
	<portlet:param name="struts_action" value="/ext/events/deleteWizardLine"/>
	<portlet:param name="eventid" value="<%= eventid %>"/>
	<portlet:param name="step" value="2"/>
	<portlet:param name="deleteeventid" value="<%= line.getMainid().toString() %>"/>
	</portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.delete-are-you-sure") %>');">
	<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/deploy_failed.gif" alt="<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.delete") %>"></a>
</td>
</tr>
<% } %>
</table>

<% 
List<ViewResult> cancelledEvents = wiz.listReservationCancelledEvents(event.getMainid(), roomEntry.getMainid());
if (cancelledEvents != null && cancelledEvents.size() > 0) {
	%>
	<br>
	<div align="right">
	<h3><%= LanguageUtil.get(pageContext, "bs.events.cancelled.list") %></h3>
	<table class="liferay-table">
	<tr>
	<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center;">
	<%= LanguageUtil.get(pageContext, "bs.events.date-start") %>
	</th>
	<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center;">
	<%= LanguageUtil.get(pageContext, "bs.events.eventStartTime") %>
	</th>
	<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center;">
	<%= LanguageUtil.get(pageContext, "bs.events.eventEndTime") %>
	</th>
	<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center;">
	</th>
	</tr>
	<% for (ViewResult cancEvent: cancelledEvents) { %>
	<tr>
	<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
	<%= com.ext.portlet.base.events.BsEventForm.date_format.format((java.util.Date)cancEvent.getField1())   %>
	</td>
	<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
	<%= cancEvent.getField2() %>
	</td>
	<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
	<%= cancEvent.getField2() %>
	</td>
	<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
	<a title="<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.restore") %>"
		href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/events/restoreWizardLines"/>
		<portlet:param name="eventid" value="<%= eventid %>"/>
		<portlet:param name="step" value="2"/>
		<portlet:param name="restoreeventid" value="<%= cancEvent.getMainid().toString() %>"/>
		</portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.restore-are-you-sure") %>');">
		<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/deploy_successful.gif" alt="<%= LanguageUtil.get(pageContext, "bs.events.eshop.step2.restore") %>">
	</a>
	</td>
	</tr>
	<% } %>
	</table>
	</div>
	<%
}
%>
</fieldset>
<% } %>

<div class="button-holder" style="text-align:center">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/events/backWizard" />
		  <tiles:put name="buttonName" value="backButton" />
		  <tiles:put name="buttonValue" value="bs.events.eshop.back" />
		  <tiles:put name="formName"   value="bs_events_wizard_step_2_form" />
	</tiles:insert>
	&nbsp;&nbsp;
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