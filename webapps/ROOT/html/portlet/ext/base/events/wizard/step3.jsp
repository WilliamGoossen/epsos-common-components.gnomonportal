<%@ include file="/html/portlet/ext/base/events/wizard/init.jsp" %>

<h3>3. <%= LanguageUtil.get(pageContext, "bs.events.eshop.step.3") %></h3>

<%
/*
 * MATRIX INFO is a list of ViewResults, one for each distinct room.
 * Each ViewResult contains: roomid, roomName, List of events.
 * Each event lines contains: eventid, eventStartDate, eventTime, eventEndTime, List of zonePrices
 * Each entry in zonePrices contains: zoneid, zoneName, zoneCode, capacity, ticketid, ticketName, price, eventzoneticketid
 */
List<ViewResult> matrixInfo = (List<ViewResult>)request.getAttribute("matrixInfo");
%>
<br>
<form name="bs_events_wizard_step_3_form" 
	  action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/events/saveWizard"/></portlet:actionURL>" 
	  method="post" class="uni-form">
<input type="hidden" name="eventid" value="<%= eventid %>">	  
<input type="hidden" name="step" value="3">
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

<table width="100%" class="liferay-table">
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
<tr>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.date-start") %>
</th>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.eventStartTime") %>
</th>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.eventEndTime") %>
</th>
<% for (ViewResult z: uniqueZones) { %>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= z.getField1() + (Validator.isNotNull(z.getField2()) ? " ("+z.getField2()+")" : "") + "<br>"+LanguageUtil.get(pageContext, "bs.events.zone.capacity") + ":"+z.getField3() %>
</th>
<% } %>
</tr>

<% for (ViewResult line: lines) { %>
<tr>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; white-space:nowrap;">
<%= com.ext.portlet.base.events.BsEventForm.date_format.format((java.util.Date)line.getField1()) %>
</td>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
<%= line.getField2() %>
</td>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
<%= line.getField3() %></td>
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
	<td><%= zoneP.getField6()!= null ? ((BigDecimal)zoneP.getField6()).setScale(2, BigDecimal.ROUND_HALF_UP).toString() : "" %>
	</td></tr>
<%	
}
%>
</table></td>
</tr>
<% } %>
</table>

</fieldset>
<% } %>

<% String success = request.getParameter("success");
   if ((success != null && success.equals("true")) || event.isOnlineProductsActive()) { %>
   <br><br>
   <div class="portlet-msg-success">
   	<%= LanguageUtil.get(pageContext, "bs.events.eshop.activate.success") %>
   </div>
   
 <% } else { %>
<div class="button-holder" style="text-align:center">
	<% if (!event.isOnlineProductsActive()) { %>
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/events/backWizard" />
		  <tiles:put name="buttonName" value="backButton" />
		  <tiles:put name="buttonValue" value="bs.events.eshop.back" />
		  <tiles:put name="formName"   value="bs_events_wizard_step_3_form" />
	</tiles:insert>
	&nbsp;&nbsp;
	<% } %>
	<input type="submit" value="<%= LanguageUtil.get(pageContext, "bs.events.eshop.activate") %>">
</div>
<% } %>
</form>

<br><br>

<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;
<% if (redirect != null) { %>
<a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_events") %></a>
<% } else { %>
<html:link action="/ext/events/list"><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_events") %></html:link>
<% } %>


		