<%
/**
 * Copyright (c) 2000-2005 Liferay, LLC. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/common/init.jsp" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.GregorianCalendar" %>
<%@ page import="java.util.HashSet" %>


<tiles:useAttribute id="struts_action" name="struts_action" classname="java.lang.String"/>
<tiles:useAttribute id="action_type" name="action_type" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="monthParam" name="monthParam" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="dayParam" name="dayParam" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="yearParam" name="yearParam" classname="java.lang.String" ignore="true"/>

<%
try{

String crmPartyId = (String) request.getAttribute("crmPartyId");
if (crmPartyId == null) crmPartyId = "";
String supplierPartyId = (String) request.getAttribute("supplierPartyId");
if (supplierPartyId == null) supplierPartyId = "";
	
Calendar selCal = new GregorianCalendar(timeZone, locale);

selCal.set(Calendar.DATE, 1);
try {
	selCal.set(Calendar.YEAR, Integer.parseInt(yearParam));
}
catch (NumberFormatException nfe) {
}
try {
	selCal.set(Calendar.MONTH, Integer.parseInt(monthParam));
}
catch (NumberFormatException nfe) {
}
try {
	int maxDayOfMonth = selCal.getActualMaximum(Calendar.DATE);

	int dayParamInt = Integer.parseInt(dayParam);

	if (dayParamInt > maxDayOfMonth) {
		dayParamInt = maxDayOfMonth;
	}

	selCal.set(Calendar.DATE, dayParamInt);
}
catch (NumberFormatException nfe) {
}

int selMonth = selCal.get(Calendar.MONTH);
int selDay = selCal.get(Calendar.DATE);
int selYear = selCal.get(Calendar.YEAR);

int maxDayOfMonth = selCal.getActualMaximum(Calendar.DATE);

selCal.set(Calendar.DATE, 1);
int dayOfWeek = selCal.get(Calendar.DAY_OF_WEEK);
selCal.set(Calendar.DATE, selDay);
dayOfWeek--;
if (dayOfWeek == 0) {
	dayOfWeek = 7;
}

Calendar curCal = new GregorianCalendar(timeZone, locale);
int curMonth = curCal.get(Calendar.MONTH);
int curDay = curCal.get(Calendar.DATE);
int curYear = curCal.get(Calendar.YEAR);

int[] monthIds = CalendarUtil.getMonthIds();
String[] months = CalendarUtil.getMonths(locale);

HashSet calendarData = (HashSet)request.getAttribute("crm_calendar_data");
if (calendarData == null) calendarData = new HashSet();


int selectedDay = curDay;
try{
	selectedDay = new Integer(dayParam).intValue();
}catch(Exception ex){}
%>

<table border="0" cellpadding="0" cellspacing="0" >
	<tr>
		<td>
			<c:choose>
				<c:when test="<%=action_type!=null && action_type.equals("action")%>">
			    	<form name="<portlet:namespace/>_CALENDAR_MONTH_CHOICE_FORM"
			          method="post"
			          action="<portlet:actionURL><portlet:param name="struts_action" value="<%= struts_action %>"/>
			          <portlet:param name="searchForm" value="calendar"/></portlet:actionURL>">
			    </c:when>
			    <c:otherwise>
			    	<form name="<portlet:namespace/>_CALENDAR_MONTH_CHOICE_FORM"
			          method="post"
			          action="<portlet:renderURL><portlet:param name="struts_action" value="<%= struts_action %>"/>
			          <portlet:param name="searchForm" value="calendar"/></portlet:renderURL>">			    
			    </c:otherwise>
		    </c:choose>
		    
		    <input type="hidden" name="crmPartyId" value="<%= crmPartyId %>">
		    <input type="hidden" name="supplierPartyId" value="<%= supplierPartyId %>">
		    
			<table border="0" cellpadding="0" cellspacing="0">
			
			<tr>
				<td>
					<select name="sel_month" class="FormArea">

						<%
						for (int i = 0; i < months.length; i++) {
						%>

							<option <%= (monthIds[i] == selMonth) ? "selected" : "" %> value="<%= monthIds[i] %>"><%= months[i] %></option>

						<%
						}
						%>

					</select>

					<select name="sel_year" class="FormArea">

						<%
						for (int i = -10; i <= 10; i++) {
						%>

							<option <%= ((curYear - selYear + i) == 0) ? "selected" : "" %> value="<%= curYear + i %>"><%= curYear + i %></option>

						<%
						}
						%>

					</select>
				</td>
				<td>
				<input alt="go" title="go" type="image" src="<%= themeDisplay.getPathThemeImage() %>/common/forward.png">
				</td>
			</tr>
			<tr>
				<td colspan="3"><img alt="spacer" border="0" height="3" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			</tr>
			</table>
			</form>
		</td>
	</tr>
<% if (monthParam != null && !monthParam.equals("") && !monthParam.equals("null") 
	   && yearParam != null && !yearParam.equals("") && !yearParam.equals("null")) {  %>	
<tr>
	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">


		<tr class="portlet-section-header">
			<td><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" width="26">
				<%= LanguageUtil.get(pageContext, "monday-abbreviation") %>
			</td>
			<td><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" width="26">
				<%= LanguageUtil.get(pageContext, "tuesday-abbreviation") %>
			</td>
			<td><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" width="26">
				<%= LanguageUtil.get(pageContext, "wednesday-abbreviation") %>
			</td>
			<td><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" width="26">
				<%= LanguageUtil.get(pageContext, "thursday-abbreviation") %>
			</td>
			<td><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" width="26">
				<%= LanguageUtil.get(pageContext, "friday-abbreviation") %>
			</td>
			<td><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" width="26">
				<%= LanguageUtil.get(pageContext, "saturday-abbreviation") %>
			</td>
			<td><img alt="spacer" border="0" height="22" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" width="26">
				<%= LanguageUtil.get(pageContext, "sunday-abbreviation") %>
			</td>
			<td><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
		</tr>
		<tr>

		<%
		for (int i = 1; i < dayOfWeek; i++) {
			String useClass = "";
		%>

			<td class="portlet-section-header"><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td height="25" width="26">&nbsp;</td>

		<%
		}

		for (int i = 1; i <= maxDayOfMonth; i++) {
			if (dayOfWeek > 7) {
		%>

			<td class="portlet-section-header"><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
		</tr>
		<tr>
			<td class="portlet-section-header" colspan="15"><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
		</tr>
		<tr>

		<%
				dayOfWeek = 1;
			}

			dayOfWeek++;

			boolean hasData = calendarData.contains(i+"/"+selMonth+"/"+selYear);
			
			String className = "";
			
			if (selectedDay == i) {
				className = "portlet-section-header";
			}
			
		%>

			<td class="portlet-section-header"><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td align="center" class="<%= className %>" height="25" valign="top" width="26" >
				<table border="0" cellpadding="0" cellspacing="0" width="24">
				<tr>
					<td align="center" height="20" valign="top">
						
						<c:choose>
							<c:when test="<%=action_type!=null && action_type.equals("action")%>">
								<a class="<%= className %>" href="<portlet:actionURL>
									<portlet:param name="struts_action" value="<%= struts_action %>"/>
									<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
									<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
									<portlet:param name="searchForm" value="calendar"/>
									<portlet:param name="sel_month" value="<%= ""+selMonth %>"/>
									<portlet:param name="sel_day" value="<%= ""+i %>"/>
									<portlet:param name="sel_year" value="<%= ""+selYear %>"/></portlet:actionURL>">
								<%= i %></a>
							</c:when>
						    <c:otherwise>
								<a class="<%= className %>" href="<portlet:renderURL>
									<portlet:param name="struts_action" value="<%= struts_action %>"/>
									<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
									<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
									<portlet:param name="searchForm" value="calendar"/>
									<portlet:param name="sel_month" value="<%= ""+selMonth %>"/>
									<portlet:param name="sel_day" value="<%= ""+i %>"/>
									<portlet:param name="sel_year" value="<%= ""+selYear %>"/></portlet:renderURL>">
								<%= i %></a>
							</c:otherwise>
					    </c:choose>
						
					</td>
				</tr>

				<c:if test="<%= hasData %>">
					<tr>
						<td class="portlet-section-alternate" style="background: #003366;">
							<img alt="spacer" border="0" height="3" hspace="0" src="<%= themeDisplay.getPathThemeImages() %>/spacer.png" vspace="0" width="1" /></td>
					</tr>
				</c:if>

				</table>
			</td>

		<%
		}

		for (int i = 7; i >= dayOfWeek; i--) {
		%>

			<td class="portlet-section-header"><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
			<td height="25" width="26">&nbsp;</td>

		<%
		}
		%>
			<td class="portlet-section-header"><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
		</tr>
		<tr>
			<td class="portlet-section-header" colspan="15"><img alt="spacer" border="0" height="1" hspace="0" src="<%= themeDisplay.getPathThemeImage() %>/spacer.png" vspace="0" width="1"></td>
		</tr>
		</table>
	</td>
</tr>

<% } %>



</table>

<%
}catch(Exception ex){
	ex.printStackTrace();
}%>