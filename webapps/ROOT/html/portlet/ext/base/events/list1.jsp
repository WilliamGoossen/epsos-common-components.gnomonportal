<%@ include file="/html/portlet/ext/base/events/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<% 
String filePath = GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH); 
java.text.SimpleDateFormat date_format = new java.text.SimpleDateFormat(com.ext.util.CommonDefs.DATE_FORMAT);
boolean eventsNoRecurrentEventsInList = GetterUtil.getBoolean(prefs.getValue("eventsNoRecurrentEventsInList", StringPool.BLANK), false);
boolean onLineReservations = GetterUtil.getBoolean(PropsUtil.get("bs.events.online.reservations"), false);
%>
<%-- 

fields = new String[] {
		table1.eventType, 
		table1.published,
		table1.publishDateStart, 
		table1.eventDateStart, 
		table1.eventTime,
		table1.eventDateEnd, 
		langs.title, 
		langs.place, 
		langs.image,
		langs.description, 
		table1.repeating, 
		table1.recurrence,
		table1.remindBy, 
		table1.firstReminder,
		table1.secondReminder,
		table1.originalDate, 
		table1.endDate,
		table1.parentid,
		table1.cancelled,
		table1.freeEntry,
		table1.onlineReservations,
		table1.onlineProductsActive
		table1.creatorid
};
--%>
<!-- Events List -->
<% int counter = 0; %>
<display:table id="event" name="events" requestURI="//ext/events/list?actionURL=true" pagesize="5" sort="list" export="false" style="width: 100%;">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("event"); 
	if (gnItem != null) counter++; %>
<display:column titleKey="title" sortable="true" style="width:100%">
<% if (gnItem.getField11() != null && ((Boolean)gnItem.getField11()).booleanValue()) { %>
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/calendar.png" alt="<%= LanguageUtil.get(pageContext, "bs.events.recurrency") %>" title="<%= LanguageUtil.get(pageContext, "bs.events.recurrency") %>">
<% } %>
<a <% if (gnItem.getField19 () != null && ((Boolean)gnItem.getField19()).booleanValue()) { 
	out.print("title=\"" +LanguageUtil.get(pageContext, "bs.events.cancelled") + "\" style=\"text-decoration: line-through\" ");
	} %> href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/events/load"/>
		<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
		<portlet:param name="loadaction" value="view"/>
		<portlet:param name="eventStartDate" value="<%= gnItem.getField4() != null ? date_format.format((Date)gnItem.getField4()) : "" %>"/>
		<portlet:param name="eventEndDate" value="<%= gnItem.getField6() != null ? date_format.format((Date)gnItem.getField6()) : "" %>"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>">
        <%= date_format.format((java.util.Date)gnItem.getField4()) %>&nbsp;-&nbsp; <%= gnItem.getField7().toString() %>
        </a>
</display:column>

<c:if test="<%= (hasAdmin || hasPublish || hasEdit || hasDelete) %>">
<display:column style="text-align: right; white-space:nowrap;">
<c:if test="<%=
	((gnItem.getField22() == null || !((Boolean)gnItem.getField22()).booleanValue()) && hasPublish )  ||
	((gnItem.getField22() == null || !((Boolean)gnItem.getField22()).booleanValue()) && (hasAdmin || (hasEdit 
			&& gnItem.getField23() != null && gnItem.getField23().equals(user.getUserId())))) ||
	((hasAdmin || (hasDelete && gnItem.getField23() != null && gnItem.getField23().equals(user.getUserId()))) &&
            gnItem.getField16() == null && 
            gnItem.getField18() == null) ||
    ((gnItem.getField22() != null && ((Boolean)gnItem.getField22()).booleanValue()))
%>">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString() + counter%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
</c:if>
<br>
<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString() + counter%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= (gnItem.getField22() == null || !((Boolean)gnItem.getField22()).booleanValue()) && hasPublish %>">
		<c:choose>
		<c:when test="<%=gnItem.getField2().toString().equals("false")%>">
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/plum/iconDocumentApprove.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
				</td>
				<td>
					<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
							<portlet:param name="struts_action" value="/ext/events/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="edit"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "gn.link.approve") %>
					</a>
				</td>
			</tr>
		</c:when>
		<c:when test="<%=gnItem.getField2().toString().equals("true")%>">
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/plum/iconDocumentReject.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.reject") %>">
				</td>
				<td>
					<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
							<portlet:param name="struts_action" value="/ext/events/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="edit"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "gn.link.reject") %>
					</a>
				</td>
			</tr>
		</c:when>
		</c:choose>
	</c:if>
	<c:if test="<%= (gnItem.getField22() == null || !((Boolean)gnItem.getField22()).booleanValue()) && (hasAdmin || (hasEdit 
					&& gnItem.getField23() != null && gnItem.getField23().equals(user.getUserId())))  %>">
		<% if (gnItem.getField11() != null && ((Boolean)gnItem.getField11()).booleanValue() && !eventsNoRecurrentEventsInList)  { %>
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-only-this-instance") %>">
			</td>
			<td>
				<a title="<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-only-this-instance") %>" href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/events/createDerivedEvent"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="derived" value="THIS"/>
						<portlet:param name="eventStartDate" value="<%= gnItem.getField4() != null ? date_format.format((Date)gnItem.getField4()) : "" %>"/>
						<portlet:param name="eventEndDate" value="<%= gnItem.getField6() != null ? date_format.format((Date)gnItem.getField6()) : "" %>"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-only-this-instance.short") %>
				</a>
			</td>
		</tr>
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-complete-series") %>">
			</td>
			<td>
				<a title="<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-complete-series") %>" href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/events/createDerivedEvent"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="derived" value="ALL"/>
						<portlet:param name="eventStartDate" value="<%= gnItem.getField4() != null ? date_format.format((Date)gnItem.getField4()) : "" %>"/>
						<portlet:param name="eventEndDate" value="<%= gnItem.getField6() != null ? date_format.format((Date)gnItem.getField6()) : "" %>"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-complete-series.short") %>
				</a>
			</td>
		</tr>
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-remaining-series") %>">
			</td>
			<td>
				<a title="<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-remaining-series") %>" href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/events/createDerivedEvent"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="derived" value="REMAINING"/>
						<portlet:param name="eventStartDate" value="<%= gnItem.getField4() != null ? date_format.format((Date)gnItem.getField4()) : "" %>"/>
						<portlet:param name="eventEndDate" value="<%= gnItem.getField6() != null ? date_format.format((Date)gnItem.getField6()) : "" %>"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "bs.events.recurrency.edit-remaining-series.short") %>
				</a>
			</td>
		</tr>
		<% } else { %>
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/events/load"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
				</a>
			</td>
		</tr>
		<% if (onLineReservations && (gnItem.getField20()==null || !((Boolean)gnItem.getField20()).booleanValue())) { %>
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/admin_console.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "bs.events.eshop.wizard") %>">
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/events/loadWizard"/>
						<portlet:param name="eventid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="step" value="1"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "bs.events.eshop.wizard") %>
				</a>
			</td>
		</tr>
		<% } %>
		<% } %>
	</c:if>
	<c:if test="<%= (hasAdmin || (hasDelete && gnItem.getField23() != null && gnItem.getField23().equals(user.getUserId()))) &&
	                gnItem.getField16() == null && 
	                gnItem.getField18() == null %>">
		<!--  allow delete only to non-recurrent events, or recurring events which are themselves the parents of recursion -->		   
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/events/load"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="delete"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "ec.admin.event-ticket.delete-warning") %>');">
				<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
				</a>
			</td>
		</tr>
	</c:if>
	<c:if test="<%= (gnItem.getField22() != null && ((Boolean)gnItem.getField22()).booleanValue()) %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/admin_console.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "bs.events.eshop.wizard") %>">
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/events/loadWizard"/>
						<portlet:param name="eventid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="step" value="3"/>
						<portlet:param name="success" value="true"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "bs.events.eshop.wizard") %>
				</a>
			</td>
		</tr>
	</c:if>
	</tbody>
	</table>
</div>
</display:column>
</c:if>


</display:table>
<br/><br/>

<form name="BsEventForm" action="/ext/events/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/events/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsEventForm" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add value="topicid"/>
	  	<% } %>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add><%= request.getParameter("topicid") %></tiles:add>
	  	<% } %>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:put name="actionPermission" value="add"/>
	  <tiles:put name="partyRoleActionPermission" value="add"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</form>