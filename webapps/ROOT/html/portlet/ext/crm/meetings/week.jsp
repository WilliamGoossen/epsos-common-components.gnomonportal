<%@ include file="/html/portlet/ext/crm/meetings/init.jsp" %>

<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.ext.portlet.crm.meetings.CrMeetingForm" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<liferay-ui:error key="crm.meeting.week.error" message="crm.meeting.week.error"/>

<%
try{

String crmPartyId = (String) request.getAttribute("crmPartyId");
if (crmPartyId == null) crmPartyId = "";
String supplierPartyId = (String) request.getAttribute("supplierPartyId");
if (supplierPartyId == null) supplierPartyId = "";

Calendar cal = Calendar.getInstance();

String previousMonday = "";
String nextMonday = "";
String sel_monday = sel_monday = (String)request.getAttribute("sel_monday");
String sel_sunday = (String)request.getAttribute("sel_sunday");

Date currentMonday = null;
cal.setTime(CrMeetingForm.date_format.parse(sel_monday));
currentMonday = cal.getTime();

cal.add(Calendar.DAY_OF_YEAR, 7);
nextMonday = CrMeetingForm.date_format.format(cal.getTime());

cal.add(Calendar.DAY_OF_YEAR, -14);
previousMonday = CrMeetingForm.date_format.format(cal.getTime());

List<ViewResult> crm_meetings = (List<ViewResult>)request.getAttribute("crm_meetings");

boolean isPrintView = ParamUtil.getBoolean(request,"print",false);

%>

<table width="100%" class="liferay-table" style="border: thin solid #9cc3e8;">
<tr>
<th colspan="2" style="text-align: left;">
<% if (!isPrintView) { %>
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.week.previous") %>"
   href="<portlet:actionURL>
   <portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
   <portlet:param name="sel_monday" value="<%= previousMonday %>"/>
   <portlet:param name="searchForm" value="week"/>
   <portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
   <portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
   </portlet:actionURL>"
>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.week.previous") %>">
</a>
<% } %>
</th>
<th colspan="3" style="text-align: center;">

<%= LanguageUtil.get(pageContext, "week") %> : <%= sel_monday %> - <%= sel_sunday %>

</th>
<th colspan="2" style="text-align: right;">
<% if (!isPrintView) { %>
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.week.next") %>"
   href="<portlet:actionURL>
   <portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
   <portlet:param name="searchForm" value="week"/>
   <portlet:param name="sel_monday" value="<%= nextMonday %>"/>
   <portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
   <portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
   </portlet:actionURL>"
>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/forward.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.week.next") %>">
</a>
<% } %>
</th>
</tr>

<tr>

<% for(int d=0; d<7; d++) {  
	cal.setTime(currentMonday); 
	cal.add(Calendar.DAY_OF_YEAR, d); 
%>
<th width="14%" style="text-align: center; border: thin solid #9cc3e8;">
<%= 
	CrMeetingForm.date_format.format(cal.getTime()) + "<br>"+
	LanguageUtil.get(pageContext, "crm.meeting.week."+d) 
 %>
</th>

<% } %>

</tr>

<tr>

<% 
int meetingIndex = 0;
if (crm_meetings != null && crm_meetings.size() > 0) {
for(int i=0; i<7; i++) {  
	cal.setTime(currentMonday); 
	cal.add(Calendar.DAY_OF_YEAR, i);
	cal.set(Calendar.HOUR_OF_DAY, 0);
	cal.set(Calendar.MINUTE, 0);
	cal.set(Calendar.SECOND, 0);
	cal.set(Calendar.MILLISECOND, 0);
	Date firstMinuteOfTheDay = cal.getTime();
	
	cal.set(Calendar.HOUR_OF_DAY, 23);
	cal.set(Calendar.MINUTE, 59);
	cal.set(Calendar.SECOND, 59);
	cal.set(Calendar.MILLISECOND, 999);
	Date lastMinuteOfTheDay = cal.getTime();
	
	List<ViewResult> daysMeetings = new ArrayList<ViewResult>();
	while(meetingIndex < crm_meetings.size())
	{
		ViewResult meetingView = crm_meetings.get(meetingIndex);
		Date meetingDate = (Date)meetingView.getField2();
		if (meetingDate.after(lastMinuteOfTheDay))
			break;
		else if (meetingDate.after(firstMinuteOfTheDay) && meetingDate.before(lastMinuteOfTheDay))
		{
			daysMeetings.add(meetingView);
			meetingIndex ++;
		}
	}
%>
<td width="14%" style="border: thin solid #9cc3e8;" valign="top">
<% if (daysMeetings != null && daysMeetings.size() > 0) {
	for (int m=0; m<daysMeetings.size(); m++) { 
		ViewResult meetingView = daysMeetings.get(m);
		Date meetingDate = (Date)meetingView.getField2();
	%>
	<fieldset>
	<legend><b><%= CrMeetingForm.time_format.format(meetingDate) %></b>
	&nbsp;&nbsp;
	<c:if test="<%= hasEdit && !isPrintView %>">
	<a title="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>" href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
		<portlet:param name="mainid" value="<%= meetingView.getMainid().toString() %>"/>
		<portlet:param name="loadaction" value="edit"/>
		<portlet:param name="searchForm" value="week"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>">
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
	</a>
	</c:if>
	<c:if test="<%= hasDelete && !isPrintView%>">
	<a title="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>" href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
			<portlet:param name="mainid" value="<%= meetingView.getMainid().toString() %>"/>
			<portlet:param name="loadaction" value="delete"/>
			<portlet:param name="searchForm" value="week"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
	</a>
	</c:if>
	<c:if test="<%= !isPrintView%>">
	<a title="<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>" href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/crm/meetings/listComments"/>
			<portlet:param name="meetingid" value="<%= meetingView.getMainid().toString() %>"/>
			<portlet:param name="searchForm" value="week"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
	
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>"></a>
	</a>
	</c:if>
	</legend>
	<table>
	<tr><td><%= LanguageUtil.get(pageContext, "subject") %></td><td><%= meetingView.getField3() %></td></tr>
	<% if (Validator.isNull(supplierPartyId)) { %>
	<tr><td><%= LanguageUtil.get(pageContext, "crm.meeting.supplierPartyId") %></td><td><%= meetingView.getField6() %></td></tr>
	<% } %>
	<% if (Validator.isNull(crmPartyId)) { %>
	<tr><td><%= LanguageUtil.get(pageContext, "crm.meeting.crmPartyId.short") %></td><td><%= meetingView.getField5() != null ? meetingView.getField5().toString() : "-" %></td></tr>
	<% } %>
	</table>
	</fieldset>
	<br>
	<%
	}
}%>

</td>

<% } 
} %>

</tr>

<% if (Validator.isNotNull(supplierPartyId) && hasAdd && !isPrintView) { %>
<tr>
<%
for(int i=0; i<7; i++) {  
	cal.setTime(currentMonday); 
	cal.add(Calendar.DAY_OF_YEAR, i);
	cal.set(Calendar.HOUR_OF_DAY, 0);
	cal.set(Calendar.MINUTE, 0);
	cal.set(Calendar.SECOND, 0);
	cal.set(Calendar.MILLISECOND, 0);
	Date firstMinuteOfTheDay = cal.getTime();
%>
<td width="14%" style="border: thin solid #9cc3e8;" valign="bottom">

<form name="quick_add_form_<%= ""+i %>" method="post" action="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/quickAdd"/>
</portlet:actionURL>" >
<% if (Validator.isNotNull(crmPartyId)) { %>
<input type="hidden" name="crmPartyId" value="<%= crmPartyId %>">
<% } %>
<input type="hidden" name="supplierPartyId" value="<%= supplierPartyId %>">
<input type="hidden" name="meetingDate" value="<%= CrMeetingForm.date_format.format(firstMinuteOfTheDay) %>">
<input type="hidden" name="sel_monday" value="<%= sel_monday %>">
<table>
<tr>
<td>
<%= LanguageUtil.get(pageContext, "time") %>
</td>
<td>
<input type="text" name="meetingTime" size="6"><em>*</em>
</td>
</tr>
<tr>
<td>
<%= LanguageUtil.get(pageContext, "subject") %>
</td><td>
<input type="text" name="subject" size="10"><em>*</em>
</td>
</tr>
<% if (Validator.isNull(crmPartyId)) { %>
<tr>
<td><%= LanguageUtil.get(pageContext, "crm.meeting.crmPartyId.short") %></td>
<td>
<input type="hidden" id="form_crmPartyId" name="form_crmPartyId">
<input type="text" id="crmPartyName" name="crmPartyName" size="10" readonly="true">
<script>
	function crmPartyName<%= ""+i %>_openActionModalLookupWin(){
		var url = '<liferay-portlet:actionURL portletName="CRM_TASKS" windowState="<%= LiferayWindowState.POP_UP.toString() %>"><liferay-portlet:param name="struts_action" value="/ext/crm/tasks/partyLookupAction"/>
			<liferay-portlet:param name="openerFormName" value="<%= "quick_add_form_"+i %>"/>
			<liferay-portlet:param name="lookupFieldIdHtmlId" value="form_crmPartyId"/>
			<liferay-portlet:param name="lookupFieldDisplHtmlId" value="crmPartyName"/>
			actionParameters.put("", curFormName);
		actionParameters.put("", lookupIdFieldName);
		actionParameters.put("", formFieldName);
		</liferay-portlet:actionURL>';
		openDialog(url, 500,500);
	}
</script>
<span id="crmPartyName_LOOKUP_SPAN_ID" onclick="crmPartyName<%= ""+i %>_openActionModalLookupWin()">
	<img src="<%=  themeDisplay.getPathThemeImage() %>/common/search.png" border="0"/>
</span>
</td>
</tr>
<% } %>
<tr>
<td>
<input type="image" src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
</td>
</tr>
</table>
</form>

</td>

<% } %>

</tr>
<% } %>



</table>

<br>
<br>
<% if (!isPrintView) { %>
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.search.calendar") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<portlet:param name="searchForm" value="calendar"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.search.calendar") %>">
<%= LanguageUtil.get(pageContext, "crm.meeting.search.calendar") %></a>
&nbsp;&nbsp;
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.search.form") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<portlet:param name="searchForm" value="form"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.search.form") %>">
<%= LanguageUtil.get(pageContext, "crm.meeting.search.form") %></a>
&nbsp;&nbsp;
<a target="_new" title="<%= LanguageUtil.get(pageContext, "crm.button.print-view") %>" href="<portlet:actionURL windowState="pop_up">
<portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<portlet:param name="searchForm" value="week"/>
<portlet:param name="sel_monday" value="<%= sel_monday %>"/>
<portlet:param name="print" value="true"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/print.png" alt="<%= LanguageUtil.get(pageContext, "crm.button.print-view") %>">
<%= LanguageUtil.get(pageContext, "crm.button.print-view") %></a>
<% } else { %>
<a title="<%= LanguageUtil.get(pageContext, "print") %>"
    href="javascript:print();">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/print.png" alt="<%= LanguageUtil.get(pageContext, "print") %>">
</a>
<% } %>
<br>
<br>

<%
}catch(Exception ex){
	ex.printStackTrace();
}%>