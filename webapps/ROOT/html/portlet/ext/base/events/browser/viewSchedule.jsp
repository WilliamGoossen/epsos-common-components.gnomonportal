<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%@ page import="gnomon.hibernate.model.base.events.BsEvent" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="gnomon.hibernate.model.base.events.EvTicketType" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="org.apache.struts.Globals" %>
<%@ page import="org.apache.struts.action.ActionErrors" %>
<%@ page import="java.math.BigDecimal, java.util.Date" %>
<%@ page import="com.ext.portlet.base.events.wizard.WizardService" %>
<%@ page import="com.ext.portlet.base.events.BsEventForm" %>

<% long rootPlid = GetterUtil.getLong(prefs.getValue("show_tickets_rootPlid", StringPool.BLANK)); %>

<div class="event-view">
<% ViewResult view = (ViewResult) request.getAttribute("eventItem"); 
   ViewResult roomView = (ViewResult) request.getAttribute("roomItem");
   ViewResult buildingView = (ViewResult) request.getAttribute("buildingItem");
   String filePath = GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH);
   boolean allowDetailsEditing = true;
   // if it is a recurring event with a valid parent event DO NOT allow details editing
	if (view.getField12()!=null && ((Boolean)view.getField12()).booleanValue() && Validator.isNotNull(view.getField14())) {
		allowDetailsEditing = false;
	}
   /*
    To view periexei ta pedia:
	 	String[] fields = new String[] {
		1 "langs.mainid",
		2 "langs.lang",
		3 "langs.title",
		4 "langs.description",
		5 "langs.place",
		6 "langs.participants",
		7 "table1.eventType",
		8 "table1.eventDateStart",
		9 "table1.eventTime",
		10 "table1.eventDateEnd",
		11 "langs.image",
		12 "table1.repeating",
		13 "table1.cancelled",
		14 "table1.freeEntry",
		15 "table1.onlineReservations",
		16 "table1.mandatoryPayment",
		17 "langs.organizedBy",
		18 "table1.organizationType",
		19 "table1.eventEndTime",
		20 "table1.onlineReservationsHourLimit",
		21 "table1.evRoom.mainid",
		22 "table1.evBuilding.mainid"
		23 "table1.onlineProductsActive"
	    24"table1.evEventType.evEventTypeLanguage.name"}};
	*/
%>

 <c:if test="<%=view.getField3()!=null%>">
		<h1><%=StringUtils.check_null(view.getField3(),"")%></h1>
  	  </c:if>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    
<div class="portlet-section-header">
		<table border="0" align="right" cellpadding="3" cellspacing="3">
		<tr>
        <td align="left" valign="top">
        <c:if test="<%=view.getField11()!=null%>">
	    <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)view.getField11())%>" alt="<%= view.getField3().toString() %>" align="left" style="padding-top:2px; padding-right:5px;" />	  </c:if>
        </td>
        <td><table><tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.pote") %> : </strong></div></td>
		  <td>&nbsp;<c:if test="<%=view.getField8()!=null%>"><%=LanguageUtil.get(pageContext, "bs.events.apo") %> <strong> <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField8())%></strong></c:if>
		  <c:if test="<%=view.getField10()!=null%>"> <%=LanguageUtil.get(pageContext, "bs.events.eos") %> <strong><%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField10())%></strong></c:if><br />
				<c:if test="<%=view.getField9()!=null%>">
				<%=LanguageUtil.get(pageContext, "bs.events.eventStartTime") %> 
				<%=StringUtils.check_null(view.getField9(),"")%>	</c:if><br>
				<c:if test="<%=view.getField19()!=null%>">
				<%=LanguageUtil.get(pageContext, "bs.events.eventEndTime") %> 
				<%=StringUtils.check_null(view.getField19(),"")%>	</c:if>					
				</td>
	  </tr>

	  <c:if test="<%=roomView !=null && buildingView != null %>">
	  <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.place") %> : </strong></div></td>
		  <td>&nbsp;<%= buildingView.getField1() + (Validator.isNotNull(buildingView.getField2()) ? " ("+buildingView.getField2()+")" : "") + "<br>" +
		  				roomView.getField1() + (Validator.isNotNull(roomView.getField2()) ? " ("+roomView.getField2()+")" : "")%>		  </td>
	  </tr>
	  </c:if>

	  <c:if test="<%=view.getField7()!=null%>">
	    <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.type") %> : </strong></div></td>
		  <td>&nbsp;<%=view.getField24()%></td>
	   </tr>
	  </c:if>
	  <c:if test="<%=view.getField13()!=null && ((Boolean)view.getField13()).booleanValue() %>">
	    <tr>
	      <td>&nbsp;</td>
    	  <td valign="top" nowrap="nowrap"><strong><%=LanguageUtil.get(pageContext, "bs.events.cancelled") %></strong></td>
	   </tr>
	  </c:if>
	  <c:if test="<%=view.getField18()!=null%>">
	    <tr>
	      <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.organizationType") %> : </strong></div></td>
    	  <td valign="top" nowrap="nowrap">
    	  <% switch ((Integer)view.getField18()) {
    	  case BsEventForm.ORGANIZATION_INTERNAL: out.print(LanguageUtil.get(pageContext, "bs.events.organizationType.internal")); break;
    	  case BsEventForm.ORGANIZATION_SHARED: out.print(LanguageUtil.get(pageContext, "bs.events.organizationType.shared")); break;
    	  case BsEventForm.ORGANIZATION_EXTERNAL: out.print(LanguageUtil.get(pageContext, "bs.events.organizationType.external")); break;
    	  }
    	  %></td>
	   </tr>
	  </c:if>
	  <c:if test="<%=view.getField17()!=null%>">
	    <tr>
	      <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.organizedBy") %> : </strong></div></td>
    	  <td valign="top" nowrap="nowrap"><%= view.getField17() %></td>
	   </tr>
	  </c:if>
	  </table></td></tr>
	</table>
	</div>	
	
	<c:if test="<%=view.getField14()!=null && ((Boolean)view.getField14()).booleanValue()%>">
	    <div class="event-view-free"><span><%=LanguageUtil.get(pageContext, "bs.events.freeEntry") %></span></div>
	  </c:if>
	  
	<c:if test="<%=view.getField4()!=null%>">
	<br><br>
	<div class="event-view-description"><%=StringUtils.check_null(view.getField4(),"")%></div>
    </c:if>
    
	</td>
  </tr>
</table>

<br />

<%
List<ViewResult> matrixInfo = (List<ViewResult>)request.getAttribute("matrixInfo");
if (matrixInfo != null && matrixInfo.size() > 0) {
	Date now = new Date();
	SimpleDateFormat completeDateFormat = new SimpleDateFormat(CommonDefs.DATE_TIME_FORMAT);
	int limit = 0;
	if (Validator.isNotNull(view.getField20()))
		limit = (Integer)view.getField20();
	Calendar cal = Calendar.getInstance();
%>
<div class="uni-form">

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
<tr>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.date-start") %>
</th>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.eventStartTime") %>
</th>
<%--th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= LanguageUtil.get(pageContext, "bs.events.eventEndTime") %>
</th --%>
<% for (ViewResult z: uniqueZones) { %>
<th style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; background-color: #dddddd">
<%= z.getField1() + (Validator.isNotNull(z.getField2()) ? " ("+z.getField2()+")" : "") %>
</th>
<% } %>
</tr>

<% for (ViewResult line: lines) {
	boolean mayBook = false;
	Date lineStartDate = (Date) line.getField1();
	String lineStartTime = (String) line.getField2();
	try {
		String lineStartDateString = BsEventForm.date_format.format(lineStartDate);
		lineStartDateString += " "+lineStartTime;
		Date eventOpeningTime = completeDateFormat.parse(lineStartDateString);
		cal.setTime(eventOpeningTime);
		cal.add(Calendar.HOUR_OF_DAY, -limit);
		Date bookingLimitDate = cal.getTime();
		if (now.before(bookingLimitDate))
			mayBook = true;
	} catch (Exception bookingDates) {}
	%>
<tr>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center; white-space:nowrap;">
<%= com.ext.portlet.base.events.BsEventForm.date_format.format((java.util.Date)line.getField1()) %>
</td>
<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
<%= line.getField2() %>
</td>
<%--<td style="border-style:solid; border-width:thin; border-color:#bbbbbb; text-align:center">
<%= line.getField3() %></td>  --%>

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
	<tr>
	<td valign="top" style="text-align:right; white-space:nowrap;">
	<%if (mayBook && zoneP.getField8() != null && zoneP.getField9() != null) { %>
	<strong>
	<% } %>
	<%= zoneP.getField5() + " \u20AC" %>
	<%if (mayBook && zoneP.getField8() != null && zoneP.getField9() != null) { %>
	</strong>
	<% } %>
	</td>
	<td>
	<%if (mayBook && zoneP.getField8() != null && zoneP.getField9() != null) {
		if (rootPlid > 0) {
			PortletURLImpl pURL = new PortletURLImpl(request, "EC_PRODUCT_BROWSER", rootPlid, true);
			pURL.setWindowState(WindowState.NORMAL);
			pURL.setPortletMode(PortletMode.VIEW);
			pURL.setParameter("struts_action",  "/ext/products/browser/loadProduct" );	
			pURL.setParameter("loadaction",  "view" );
			pURL.setParameter("mainid",  zoneP.getField8().toString());
			pURL.setParameter("productinstanceid", zoneP.getField9().toString() );
			%>
			<a title="<%=LanguageUtil.get(pageContext, "bs.events.onlineReservations") %>" 
	   			href="<%= pURL.toString() %>">
	   			<strong>
			<%
		} else {
	%>
	<a title="<%=LanguageUtil.get(pageContext, "bs.events.onlineReservations") %>" 
	   href="<liferay-portlet:actionURL portletName="EC_PRODUCT_BROWSER" windowState="maximized">
	   <liferay-portlet:param name="struts_action" value="/ext/products/browser/loadProduct"/>
	   <liferay-portlet:param name="loadaction" value="view"/>
	   <liferay-portlet:param name="mainid" value="<%= zoneP.getField8().toString() %>"/>
	   <liferay-portlet:param name="productinstanceid" value="<%= zoneP.getField9().toString() %>"/>
	   </liferay-portlet:actionURL>"><strong>
	<% }
	}%>
	<%= zoneP.getField6()!= null ? ((BigDecimal)zoneP.getField6()).setScale(2, BigDecimal.ROUND_HALF_UP).toString() : "" %>
	<%if (mayBook && zoneP.getField8() != null && zoneP.getField9() != null) { %>
	</strong>
	<img src="<%= themeDisplay.getPathThemeImage() %>/ecommerce/tickets.gif">
	</a>
	<% } %>
	</td></tr>
<%	
}
%>
</table></td>
</tr>
<% } %>
</table>

</fieldset>
<% }

}%>



	