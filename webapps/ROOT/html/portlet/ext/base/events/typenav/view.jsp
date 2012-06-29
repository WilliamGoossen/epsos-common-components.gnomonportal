<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%@ page import="com.ext.portlet.base.events.BsEventForm" %>
<%@ page import="com.ext.portal.context.PortalContext" %>
<%@ page import="com.ext.portal.context.PortalContextRequestUtil" %>


<%
BsEventForm eventForm = (BsEventForm)request.getAttribute("eventForm");
PortalContext portalContext = PortalContextRequestUtil.getPortalContext(request); 
String selectedEventType = (String)portalContext.getEntry(PortalContext.EVENT_TYPE);
if (Validator.isNull(selectedEventType)) selectedEventType = "";
%>

<table>
<%
for (int i=0; i<eventForm.getEventTypeValues().length; i++)
{
	String eventValue = eventForm.getEventTypeValues()[i];
	String eventName = eventForm.getEventTypeNames()[i];
%>
	<tr>
	<td>
	<% if (eventValue.equals(selectedEventType)) { %><strong> <% } %>
	<a href="<portlet:renderURL><portlet:param name="struts_action" value="/ext/eventtypenav/view"/><portlet:param name="type" value="<%= eventValue %>"/></portlet:renderURL>"><%= eventName %></a></td>
	<% if (eventValue.equals(selectedEventType)) { %></strong> <% } %>
	</tr>
<%	
}
%>
</table>