<%@ page import="com.liferay.util.Time" %>
<%@ page import="com.liferay.util.BeanParamUtil" %>
<%@ page import="com.liferay.util.cal.CalendarUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.cal.Recurrence" %>
<%@ page import="com.liferay.portal.kernel.cal.DayAndPosition" %>
<%@ page import="com.liferay.portlet.calendar.model.impl.CalEventImpl" %>
<%@ page import="com.liferay.portlet.calendar.EventEndDateException" %>
<%@ page import="com.ext.portlet.base.events.BsEventForm" %>
<%@ page import="gnomon.hibernate.model.base.events.BsEvent" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%@ page import="com.liferay.portal.kernel.util.Constants" %>


<%

int[] monthIds = CalendarUtil.getMonthIds();
String[] months = CalendarUtil.getMonths(request.getLocale());
String[] days = CalendarUtil.getDays(request.getLocale());
SimpleDateFormat date_format = new SimpleDateFormat(CommonDefs.DATE_FORMAT);



BsEvent event = null;
BsEventForm formBeanRec = (com.ext.portlet.base.events.BsEventForm) request.getAttribute("BsEventForm");

if (formBeanRec != null && formBeanRec.getMainid() != null) {
	event = (BsEvent)GnPersistenceService.getInstance(null).getObject(BsEvent.class, formBeanRec.getMainid());
}

Calendar endDate = Calendar.getInstance();
endDate.add(Calendar.MONTH, 2);
if (event != null) {
	if (event.getEndDate() != null) {
		endDate.setTime(event.getEndDate());
	}
}

boolean repeating = BeanParamUtil.getBoolean(event, request, "repeating");

Recurrence recurrence = null;

int recurrenceType = ParamUtil.getInteger(request, "recurrenceType", Recurrence.NO_RECURRENCE);
String recurrenceTypeParam = ParamUtil.getString(request, "recurrenceType");
if (Validator.isNull(recurrenceTypeParam) && (event != null)) {
	if (event.isRepeating()) {
		recurrence = event.getRecurrenceObject();
		recurrenceType = recurrence.getFrequency();
	}
}

int dailyType = ParamUtil.getInteger(request, "dailyType");
String dailyTypeParam = ParamUtil.getString(request, "dailyType");
if (Validator.isNull(dailyTypeParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByDay() != null) {
			dailyType = 1;
		}
	}
}

int dailyInterval = ParamUtil.getInteger(request, "dailyInterval", 1);
String dailyIntervalParam = ParamUtil.getString(request, "dailyInterval");
if (Validator.isNull(dailyIntervalParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		dailyInterval = recurrence.getInterval();
	}
}

int weeklyInterval = ParamUtil.getInteger(request, "weeklyInterval", 1);
String weeklyIntervalParam = ParamUtil.getString(request, "weeklyInterval");
if (Validator.isNull(weeklyIntervalParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		weeklyInterval = recurrence.getInterval();
	}
}

boolean weeklyPosSu = _getWeeklyDayPos(request, Calendar.SUNDAY, event, recurrence);
boolean weeklyPosMo = _getWeeklyDayPos(request, Calendar.MONDAY, event, recurrence);
boolean weeklyPosTu = _getWeeklyDayPos(request, Calendar.TUESDAY, event, recurrence);
boolean weeklyPosWe = _getWeeklyDayPos(request, Calendar.WEDNESDAY, event, recurrence);
boolean weeklyPosTh = _getWeeklyDayPos(request, Calendar.THURSDAY, event, recurrence);
boolean weeklyPosFr = _getWeeklyDayPos(request, Calendar.FRIDAY, event, recurrence);
boolean weeklyPosSa = _getWeeklyDayPos(request, Calendar.SATURDAY, event, recurrence);

int monthlyType = ParamUtil.getInteger(request, "monthlyType");
String monthlyTypeParam = ParamUtil.getString(request, "monthlyType");
if (Validator.isNull(monthlyTypeParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonthDay() == null) {
			monthlyType = 1;
		}
	}
}

int monthlyDay0 = ParamUtil.getInteger(request, "monthlyDay0", 15);
String monthlyDay0Param = ParamUtil.getString(request, "monthlyDay0");
if (Validator.isNull(monthlyDay0Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonthDay() != null) {
			monthlyDay0 = recurrence.getByMonthDay()[0];
		}
	}
}

int monthlyInterval0 = ParamUtil.getInteger(request, "monthlyInterval0", 1);
String monthlyInterval0Param = ParamUtil.getString(request, "monthlyInterval0");
if (Validator.isNull(monthlyInterval0Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		monthlyInterval0 = recurrence.getInterval();
	}
}

int monthlyPos = ParamUtil.getInteger(request, "monthlyPos", 1);
String monthlyPosParam = ParamUtil.getString(request, "monthlyPos");
if (Validator.isNull(monthlyPosParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonth() != null) {
			monthlyPos = recurrence.getByMonth()[0];
		}
		else if (recurrence.getByDay() != null) {
			monthlyPos = recurrence.getByDay()[0].getDayPosition();
		}
	}
}

int monthlyDay1 = ParamUtil.getInteger(request, "monthlyDay1", Calendar.SUNDAY);
String monthlyDay1Param = ParamUtil.getString(request, "monthlyDay1");
if (Validator.isNull(monthlyDay1Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonth() != null) {
			monthlyDay1 = -1;
		}
		else if (recurrence.getByDay() != null) {
			monthlyDay1 = recurrence.getByDay()[0].getDayOfWeek();
		}
	}
}

int monthlyInterval1 = ParamUtil.getInteger(request, "monthlyInterval1", 1);
String monthlyInterval1Param = ParamUtil.getString(request, "monthlyInterval1");
if (Validator.isNull(monthlyInterval1Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		monthlyInterval1 = recurrence.getInterval();
	}
}

int yearlyType = ParamUtil.getInteger(request, "yearlyType");
String yearlyTypeParam = ParamUtil.getString(request, "yearlyType");
if (Validator.isNull(yearlyTypeParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonthDay() != null) {
			yearlyType = 0;
		}
		else
		{
			yearlyType = 1;
		}
	}
}

int yearlyMonth0 = ParamUtil.getInteger(request, "yearlyMonth0", Calendar.JANUARY);
String yearlyMonth0Param = ParamUtil.getString(request, "yearlyMonth0");
if (Validator.isNull(yearlyMonth0Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonth() == null) {
			yearlyMonth0 = recurrence.getDtStart().get(Calendar.MONTH);
		}
		else
		{
			yearlyMonth0 = recurrence.getByMonth()[0];
		}
	}
}

int yearlyDay0 = ParamUtil.getInteger(request, "yearlyDay0", 15);
String yearlyDay0Param = ParamUtil.getString(request, "yearlyDay0");
if (Validator.isNull(yearlyDay0Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonthDay() == null) {
			yearlyDay0 = recurrence.getDtStart().get(Calendar.DATE);
		}
		else
		{
			yearlyDay0 = recurrence.getByMonthDay()[0];
		}
	}
}

int yearlyInterval0 = ParamUtil.getInteger(request, "yearlyInterval0", 1);
String yearlyInterval0Param = ParamUtil.getString(request, "yearlyInterval0");
if (Validator.isNull(yearlyInterval0Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		yearlyInterval0 = recurrence.getInterval();
	}
}

int yearlyPos = ParamUtil.getInteger(request, "yearlyPos", 1);
String yearlyPosParam = ParamUtil.getString(request, "yearlyPos");
if (Validator.isNull(yearlyPosParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByDay() == null) {
			yearlyPos = -1;
		}
		else if (recurrence.getByDay() != null) {
			yearlyPos = recurrence.getByDay()[0].getDayPosition();
		}
	}
}

int yearlyDay1 = ParamUtil.getInteger(request, "yearlyDay1", Calendar.SUNDAY);
String yearlyDay1Param = ParamUtil.getString(request, "yearlyDay1");
if (Validator.isNull(yearlyDay1Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByDay() == null) {
			yearlyDay1 = -1;
		}
		else if (recurrence.getByDay() != null) {
			yearlyDay1 = recurrence.getByDay()[0].getDayOfWeek();
		}
	}
}

int yearlyMonth1 = ParamUtil.getInteger(request, "yearlyMonth1", Calendar.JANUARY);
String yearlyMonth1Param = ParamUtil.getString(request, "yearlyMonth1");
if (Validator.isNull(yearlyMonth1Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getByMonth() != null) {
			yearlyMonth1 = recurrence.getByMonth()[0];
		}
	}
}

int yearlyInterval1 = ParamUtil.getInteger(request, "yearlyInterval1", 1);
String yearlyInterval1Param = ParamUtil.getString(request, "yearlyInterval1");
if (Validator.isNull(yearlyInterval1Param) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		yearlyInterval1 = recurrence.getInterval();
	}
}

int endDateType = ParamUtil.getInteger(request, "endDateType", 2);
String endDateTypeParam = ParamUtil.getString(request, "endDateType");
if (Validator.isNull(endDateTypeParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		if (recurrence.getUntil() != null) {
			endDateType = 2;
		}
		else if (recurrence.getOccurrence() > 0) {
			endDateType = 1;
		}
	}
}

int endDateOccurrence = ParamUtil.getInteger(request, "endDateOccurrence", 10);
String endDateOccurrenceParam = ParamUtil.getString(request, "endDateOccurrence");
if (Validator.isNull(endDateOccurrenceParam) && (event != null)) {
	if ((event.isRepeating()) && (recurrence != null)) {
		endDateOccurrence = recurrence.getOccurrence();
	}
}

String remindBy = BeanParamUtil.getString(event, request, "remindBy", CalEventImpl.REMIND_BY_EMAIL);
int firstReminder = BeanParamUtil.getInteger(event, request, "firstReminder", (int)Time.MINUTE * 15);
int secondReminder = BeanParamUtil.getInteger(event, request, "secondReminder", (int)Time.MINUTE * 5);
%>

<script type="text/javascript">
	function <portlet:namespace />init() {
		<c:choose>
			<c:when test="<%= recurrenceType == Recurrence.NO_RECURRENCE %>">
				<portlet:namespace />showTable("<portlet:namespace />neverTable");
			</c:when>
			<c:when test="<%= recurrenceType == Recurrence.DAILY %>">
				<portlet:namespace />showTable("<portlet:namespace />dailyTable");
			</c:when>
			<c:when test="<%= recurrenceType == Recurrence.WEEKLY %>">
				<portlet:namespace />showTable("<portlet:namespace />weeklyTable");
			</c:when>
			<c:when test="<%= recurrenceType == Recurrence.MONTHLY %>">
				<portlet:namespace />showTable("<portlet:namespace />monthlyTable");
			</c:when>
			<c:when test="<%= recurrenceType == Recurrence.YEARLY %>">
				<portlet:namespace />showTable("<portlet:namespace />yearlyTable");
			</c:when>
		</c:choose>
	}

	function <portlet:namespace />showTable(id) {
		document.getElementById("<portlet:namespace />neverTable").style.display = "none";
		document.getElementById("<portlet:namespace />dailyTable").style.display = "none";
		document.getElementById("<portlet:namespace />weeklyTable").style.display = "none";
		document.getElementById("<portlet:namespace />monthlyTable").style.display = "none";
		document.getElementById("<portlet:namespace />yearlyTable").style.display = "none";

		document.getElementById(id).style.display = "block";
		if (id == "<portlet:namespace />neverTable" )
			document.getElementById("<portlet:namespace />endDateTable").style.display = "none";
		else
			document.getElementById("<portlet:namespace />endDateTable").style.display = "block";
	}

	function <portlet:namespace />saveEvent() {
		document.<portlet:namespace />fm.<portlet:namespace /><%= Constants.CMD %>.value = "<%= event == null ? Constants.ADD : Constants.UPDATE %>";
		submitForm(document.<portlet:namespace />fm);
	}

	<%--
	function <portlet:namespace />setEventDateEnd() {
		var dateValueStart = document.BsEventForm.elements["eventDateStart"].value;
		var dateValueEnd = document.BsEventForm.elements["eventDateEnd"].value;
	
		if (dateValueStart != dateValueEnd)
		{
			document.BsEventForm.elements["<portlet:namespace />endDateType"].value="2";
			document.BsEventForm.elements["endDate"].value = dateValueEnd;
			var buttonList = document.BsEventForm.elements["<portlet:namespace />endDateType"];
			for(var i=0; i<buttonList.length; i++)
			{
				var button = buttonList[i];
				if (button.value == "2")
					button.checked = true;
				else
					button.checked = false;
			}
		
			buttonList = document.BsEventForm.elements["<portlet:namespace />recurrenceType"];
			for(var i=0; i<buttonList.length; i++)
			{
				var button = buttonList[i];
				if (button.value == "<%= Recurrence.DAILY %>")
					button.checked = true;
				else
					button.checked = false;
			}
			<portlet:namespace />showTable('<portlet:namespace />dailyTable');
		}
		else if (dateValueStart == dateValueEnd)
		{
			var buttonList = document.BsEventForm.elements["<portlet:namespace />endDateType"];
			for(var i=0; i<buttonList.length; i++)
			{
				var button = buttonList[i];
				if (button.value == "2")
					button.checked = false;
				else
					button.checked = true;
			}

			buttonList = document.BsEventForm.elements["<portlet:namespace />recurrenceType"];
			for(var i=0; i<buttonList.length; i++)
			{
				var button = buttonList[i];
				if (button.value == "<%= Recurrence.NO_RECURRENCE %>")
					button.checked = true;
				else
					button.checked = false;
			}
			<portlet:namespace />showTable('<portlet:namespace />neverTable');
		}
	} 
	--%>
</script>

<fieldset class="inline-labels">
<legend>
	<%=LanguageUtil.get(pageContext, "bs.events.dates-tab")%>
</legend>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="BsEventForm"/>
	<tiles:put name="attributeName" value="BS_EVENTS_TIMING_FIELDS"/>
	<tiles:put name="showTopErrors" value="false"/>
</tiles:insert>

<liferay-ui:error exception="<%= EventEndDateException.class %>" message="please-enter-a-valid-end-date" />

<fieldset class="inline-labels">
<legend>
	<%=LanguageUtil.get(pageContext, "bs.events.dates-repeat-tab")%>
</legend>

<table class="liferay-table">
<tr>
	<td>
		<input <%= (recurrenceType == Recurrence.NO_RECURRENCE) ? "checked" : "" %> name="<portlet:namespace />recurrenceType" type="radio" value="<%= Recurrence.NO_RECURRENCE %>" onClick="<portlet:namespace />showTable('<portlet:namespace />neverTable');"> <liferay-ui:message key="never" /><br />
		<input <%= (recurrenceType == Recurrence.DAILY) ? "checked" : "" %> name="<portlet:namespace />recurrenceType" type="radio" value="<%= Recurrence.DAILY %>" onClick="<portlet:namespace />showTable('<portlet:namespace />dailyTable');"> <liferay-ui:message key="daily" /><br />
		<input <%= (recurrenceType == Recurrence.WEEKLY) ? "checked" : "" %> name="<portlet:namespace />recurrenceType" type="radio" value="<%= Recurrence.WEEKLY %>" onClick="<portlet:namespace />showTable('<portlet:namespace />weeklyTable');"> <liferay-ui:message key="weekly" /><br />
		<input <%= (recurrenceType == Recurrence.MONTHLY) ? "checked" : "" %> name="<portlet:namespace />recurrenceType" type="radio" value="<%= Recurrence.MONTHLY %>" onClick="<portlet:namespace />showTable('<portlet:namespace />monthlyTable');"> <liferay-ui:message key="monthly" /><br />
		<input <%= (recurrenceType == Recurrence.YEARLY) ? "checked" : "" %> name="<portlet:namespace />recurrenceType" type="radio" value="<%= Recurrence.YEARLY %>" onClick="<portlet:namespace />showTable('<portlet:namespace />yearlyTable');"> <liferay-ui:message key="yearly" />
	</td>
	<td valign="top">
		<div id="<portlet:namespace />neverTable" style="display: none;">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<liferay-ui:message key="bs.events.recurrency.do-not-repeat-this-event" />
				</td>
			</tr>
			</table>
		</div>
		
		<div id="<portlet:namespace />endDateTable" style="display: block;">
		<table>
			<tr>
				<td valign="top">
					<liferay-ui:message key="end-date" />
				</td>
				<td valign="top">
					<table class="liferay-table">
					<tr>
						<td>
							<input <%= (endDateType == 2) ? "checked" : "" %> name="<portlet:namespace />endDateType" type="radio" value="2"> <liferay-ui:message key="end-by" />
							<input type="text" name="endDate" id="endDate" readonly="true" value="<%= date_format.format(endDate.getTime()) %>"/>
							<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_endDate" style="cursor: pointer; border: 1px solid red;" title="Date selector"
						    onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
						    <script type="text/javascript">
							    Calendar.setup({
							        inputField     :    "endDate",     // id of the input field
							        button         :    "f_endDate",  // trigger for the calendar (button ID)
							        align          :    "Tl",           // alignment (defaults to "Bl")
											ifFormat    : "%d/%m/%Y",
											daFormat : "%d/%m/%Y",
											showsTime :true,
							        singleClick    :    true,
							        firstDay : "1"
							    });
							</script>
						</td>
						</tr>
						<tr>
						<td>
						<input <%= (endDateType == 0) ? "checked" : "" %> name="<portlet:namespace />endDateType" type="radio" value="0"> <liferay-ui:message key="no-end-date" /><br />
						</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
			<td colspan="2">
			<span class="portlet-msg-info">
			<%= LanguageUtil.get(pageContext, "bs.events.endDate.help-message") %>
			</span>
			</td>
			</tr>
		</table>
		</div>


		<div id="<portlet:namespace />dailyTable" style="display: none;">
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					<input <%= (dailyType == 0) ? "checked" : "" %> name="<portlet:namespace />dailyType" type="radio" value="0"> <liferay-ui:message key="every" /> <input maxlength="3" name="<portlet:namespace />dailyInterval" size="2" type="text" value="<%= dailyInterval %>" /> <liferay-ui:message key="day-s" /><br />
					<input <%= (dailyType == 1) ? "checked" : "" %> name="<portlet:namespace />dailyType" type="radio" value="1"> <liferay-ui:message key="every-weekday" />
				</td>
			</tr>
			</table>
		</div>

		<div id="<portlet:namespace />weeklyTable" style="display: none;">
			<table class="liferay-table">
			<tr>
				<td>
					<liferay-ui:message key="recur-every" /> <input maxlength="2" name="<portlet:namespace />weeklyInterval" size="2" type="text" value="<%= weeklyInterval %>" /> <liferay-ui:message key="weeks-on" />

					<table class="liferay-table">
					<tr>
						<td nowrap>
							<input <%= weeklyPosSu ? "checked" : "" %> name="<portlet:namespace />weeklyDayPos<%= Calendar.SUNDAY %>" type="checkbox"> <%= days[0] %>
						</td>
						<td nowrap>
							<input <%= weeklyPosMo ? "checked" : "" %> name="<portlet:namespace />weeklyDayPos<%= Calendar.MONDAY %>" type="checkbox"> <%= days[1] %>
						</td>
						<td nowrap>
							<input <%= weeklyPosTu ? "checked" : "" %> name="<portlet:namespace />weeklyDayPos<%= Calendar.TUESDAY %>" type="checkbox"> <%= days[2] %>
						</td>
						<td nowrap>
							<input <%= weeklyPosWe ? "checked" : "" %> name="<portlet:namespace />weeklyDayPos<%= Calendar.WEDNESDAY %>" type="checkbox"> <%= days[3] %>
						</td>
					</tr>
					<tr>
						<td nowrap>
							<input <%= weeklyPosTh ? "checked" : "" %> name="<portlet:namespace />weeklyDayPos<%= Calendar.THURSDAY %>" type="checkbox"> <%= days[4] %>
						</td>
						<td nowrap>
							<input <%= weeklyPosFr ? "checked" : "" %> name="<portlet:namespace />weeklyDayPos<%= Calendar.FRIDAY %>" type="checkbox"> <%= days[5] %>
						</td>
						<td colspan="2" nowrap>
							<input <%= weeklyPosSa ? "checked" : "" %> name="<portlet:namespace />weeklyDayPos<%= Calendar.SATURDAY %>" type="checkbox"> <%= days[6] %>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			</table>
		</div>

		<div id="<portlet:namespace />monthlyTable" style="display: none;">
			<table class="liferay-table">
			<tr>
				<td nowrap>
					<input <%= (monthlyType == 0) ? "checked" : "" %> name="<portlet:namespace />monthlyType" type="radio" value="0"> <liferay-ui:message key="day" /> <input maxlength="2" name="<portlet:namespace />monthlyDay0" size="2" type="text" value="<%= monthlyDay0 %>" /> <liferay-ui:message key="bs.events.recurrency.of-every" /> <input maxlength="2" name="<portlet:namespace />monthlyInterval0" size="2" type="text" value="<%= monthlyInterval0 %>" /> <liferay-ui:message key="bs.events.recurrency.month-s" /><br />

					<input <%= (monthlyType == 1) ? "checked" : "" %> name="<portlet:namespace />monthlyType" type="radio" value="1">

					<liferay-ui:message key="the" />

					<select name="<portlet:namespace />monthlyPos">
						<option <%= (monthlyPos == 1) ? "selected" : "" %> value="1"><liferay-ui:message key="bs.events.recurrency.first" /></option>
						<option <%= (monthlyPos == 2) ? "selected" : "" %> value="2"><liferay-ui:message key="bs.events.recurrency.second" /></option>
						<option <%= (monthlyPos == 3) ? "selected" : "" %> value="3"><liferay-ui:message key="bs.events.recurrency.third" /></option>
						<option <%= (monthlyPos == 4) ? "selected" : "" %> value="4"><liferay-ui:message key="bs.events.recurrency.fourth" /></option>
						<option <%= (monthlyPos == -1) ? "selected" : "" %> value="-1"><liferay-ui:message key="bs.events.recurrency.last" /></option>
					</select>

					<select name="<portlet:namespace />monthlyDay1">
						<option <%= (monthlyDay1 == Calendar.SUNDAY) ? "selected" : "" %> value="<%= Calendar.SUNDAY %>"><%= days[0] %></option>
						<option <%= (monthlyDay1 == Calendar.MONDAY) ? "selected" : "" %> value="<%= Calendar.MONDAY %>"><%= days[1] %></option>
						<option <%= (monthlyDay1 == Calendar.TUESDAY) ? "selected" : "" %> value="<%= Calendar.TUESDAY %>"><%= days[2] %></option>
						<option <%= (monthlyDay1 == Calendar.WEDNESDAY) ? "selected" : "" %> value="<%= Calendar.WEDNESDAY %>"><%= days[3] %></option>
						<option <%= (monthlyDay1 == Calendar.THURSDAY) ? "selected" : "" %> value="<%= Calendar.THURSDAY %>"><%= days[4] %></option>
						<option <%= (monthlyDay1 == Calendar.FRIDAY) ? "selected" : "" %> value="<%= Calendar.FRIDAY %>"><%= days[5] %></option>
						<option <%= (monthlyDay1 == Calendar.SATURDAY) ? "selected" : "" %> value="<%= Calendar.SATURDAY %>"><%= days[6] %></option>
					</select>

					<liferay-ui:message key="bs.events.recurrency.of-every" /> <input maxlength="2" name="<portlet:namespace />monthlyInterval1" size="2" type="text" value="<%= monthlyInterval1 %>" /> <liferay-ui:message key="bs.events.recurrency.month-s" />
				</td>
			</tr>
			</table>
		</div>

		<div id="<portlet:namespace />yearlyTable" style="display: none;">
			<table class="liferay-table">
			<tr>
				<td nowrap>
					<input <%= (yearlyType == 0) ? "checked" : "" %> name="<portlet:namespace />yearlyType" type="radio" value="0"> <liferay-ui:message key="every" />

					<select name="<portlet:namespace />yearlyMonth0">

					<%
					for (int i = 0; i < 12; i++) {
					%>

							<option <%= (monthIds[i] == yearlyMonth0) ? "selected" : "" %> value="<%= monthIds[i] %>"><%= months[i] %></option>

					<%
					}
					%>

					</select>

					<input maxlength="2" name="<portlet:namespace />yearlyDay0" size="2" type="text" value="<%= yearlyDay0 %>" /> <liferay-ui:message key="bs.events.recurrency.of-every" /> <input maxlength="2" name="<portlet:namespace />yearlyInterval0" size="2" type="text" value="<%= yearlyInterval0 %>" /> <liferay-ui:message key="bs.events.recurrency.year-s" /><br />

					<input <%= (yearlyType == 1) ? "checked" : "" %> name="<portlet:namespace />yearlyType" type="radio" value="1"> <liferay-ui:message key="the" />

					<select name="<portlet:namespace />yearlyPos">
						<option <%= (yearlyPos == 1) ? "selected" : "" %> value="1"><liferay-ui:message key="bs.events.recurrency.first" /></option>
						<option <%= (yearlyPos == 2) ? "selected" : "" %> value="2"><liferay-ui:message key="bs.events.recurrency.second" /></option>
						<option <%= (yearlyPos == 3) ? "selected" : "" %> value="3"><liferay-ui:message key="bs.events.recurrency.third" /></option>
						<option <%= (yearlyPos == 4) ? "selected" : "" %> value="4"><liferay-ui:message key="bs.events.recurrency.fourth" /></option>
						<option <%= (yearlyPos == -1) ? "selected" : "" %> value="-1"><liferay-ui:message key="bs.events.recurrency.last" /></option>
					</select>

					<select name="<portlet:namespace />yearlyDay1">
						<option <%= (yearlyDay1 == Calendar.MONDAY) ? "selected" : "" %> value="<%= Calendar.MONDAY %>"><liferay-ui:message key="weekday" /></option>
						<option <%= (yearlyDay1 == Calendar.SATURDAY) ? "selected" : "" %> value="<%= Calendar.SATURDAY %>"><liferay-ui:message key="weekend-day" /></option>
						<option <%= (yearlyDay1 == Calendar.SUNDAY) ? "selected" : "" %> value="<%= Calendar.SUNDAY %>"><%= days[0] %></option>
						<option <%= (yearlyDay1 == Calendar.MONDAY) ? "selected" : "" %> value="<%= Calendar.MONDAY %>"><%= days[1] %></option>
						<option <%= (yearlyDay1 == Calendar.TUESDAY) ? "selected" : "" %> value="<%= Calendar.TUESDAY %>"><%= days[2] %></option>
						<option <%= (yearlyDay1 == Calendar.WEDNESDAY) ? "selected" : "" %> value="<%= Calendar.WEDNESDAY %>"><%= days[3] %></option>
						<option <%= (yearlyDay1 == Calendar.THURSDAY) ? "selected" : "" %> value="<%= Calendar.THURSDAY %>"><%= days[4] %></option>
						<option <%= (yearlyDay1 == Calendar.FRIDAY) ? "selected" : "" %> value="<%= Calendar.FRIDAY %>"><%= days[5] %></option>
						<option <%= (yearlyDay1 == Calendar.SATURDAY) ? "selected" : "" %> value="<%= Calendar.SATURDAY %>"><%= days[6] %></option>
					</select>

					<liferay-ui:message key="bs.events.recurrency.of-month" />

					<select name="<portlet:namespace />yearlyMonth1">

						<%
						for (int i = 0; i < 12; i++) {
						%>

								<option <%= (monthIds[i] == yearlyMonth1) ? "selected" : "" %> value="<%= monthIds[i] %>"><%= months[i] %></option>

						<%
						}
						%>

					</select>

					<liferay-ui:message key="bs.events.recurrency.of-every" /> <input maxlength="2" name="<portlet:namespace />yearlyInterval1" size="2" type="text" value="<%= yearlyInterval1 %>" /> <liferay-ui:message key="bs.events.recurrency.year-s" />
				</td>
			</tr>
			</table>
		</div>
	</td>
</tr>
<tr>
	<td colspan="2">
		<br />
	</td>
</tr>

</table>
</fieldset>

<%--
<liferay-ui:tabs names="reminders" />

<liferay-ui:message key="remind-me" />

<select name="<portlet:namespace />firstReminder">

	<%
	for (int i = 0; i < CalEventImpl.REMINDERS.length; i++) {
	%>

		<option <%= (firstReminder == CalEventImpl.REMINDERS[i]) ? "selected" : "" %> value="<%= CalEventImpl.REMINDERS[i] %>"><%= LanguageUtil.getTimeDescription(pageContext, CalEventImpl.REMINDERS[i]) %></option>

	<%
	}
	%>

</select>

<liferay-ui:message key="before-and-again" />

<select name="<portlet:namespace />secondReminder">

	<%
	for (int i = 0; i < CalEventImpl.REMINDERS.length; i++) {
	%>

		<option <%= (secondReminder == CalEventImpl.REMINDERS[i]) ? "selected" : "" %> value="<%= CalEventImpl.REMINDERS[i] %>"><%= LanguageUtil.getTimeDescription(pageContext, CalEventImpl.REMINDERS[i]) %></option>

	<%
	}
	%>

</select>

<liferay-ui:message key="before-the-event-by" />

<br /><br />

<input <%= remindBy.equals(CalEventImpl.REMIND_BY_NONE) ? "checked" : "" %> name="<portlet:namespace />remindBy" type="radio" value="<%= CalEventImpl.REMIND_BY_NONE %>"> <liferay-ui:message key="do-not-send-a-reminder" /><br />
<input <%= remindBy.equals(CalEventImpl.REMIND_BY_EMAIL) ? "checked" : "" %> name="<portlet:namespace />remindBy" type="radio" value="<%= CalEventImpl.REMIND_BY_EMAIL %>"> <liferay-ui:message key="email-address" /> (<%= user.getEmailAddress() %>)<br />
--%>

</fieldset>

<script type="text/javascript">
	<portlet:namespace />init();
</script>

<%!
private boolean _getWeeklyDayPos(HttpServletRequest req, int day, BsEvent event, Recurrence recurrence) {
	boolean weeklyPos = ParamUtil.getBoolean(req, "weeklyDayPos" + day);

	String weeklyPosParam = ParamUtil.getString(req, "weeklyDayPos" + day);

	if (Validator.isNull(weeklyPosParam) && (event != null)) {
		if ((event.isRepeating()) && (recurrence != null)) {
			DayAndPosition[] dayPositions = recurrence.getByDay();

			if (dayPositions != null) {
				for (int i = 0; i < dayPositions.length; i++) {
					if (dayPositions[i].getDayOfWeek() == day) {
						return true;
					}
				}
			}
		}
	}

	return weeklyPos;
}
%>

