<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%@ page import="com.ext.portlet.base.events.BsEventForm" %>
<%@ page import="com.ext.portal.context.PortalContext" %>
<%@ page import="com.ext.portal.context.PortalContextRequestUtil" %>

<%
BsEventForm eventForm = (BsEventForm)request.getAttribute("eventForm");
PortalContext portalContext = PortalContextRequestUtil.getPortalContext(request); 
String selectedRoomId = (String)portalContext.getEntry(PortalContext.EVENT_LOCATION_ID);
if (Validator.isNull(selectedRoomId)) selectedRoomId = "";
%>

<table>
<%
for (int i=0; i<eventForm.getRoomIds().length; i++)
{
	String roomid = eventForm.getRoomIds()[i];
	String roomName = eventForm.getRoomNames()[i];
%>
	<tr>
	<td>
	<% if (roomid.equals(selectedRoomId)) { %><strong> <% } %>
	<a href="<portlet:renderURL><portlet:param name="struts_action" value="/ext/eventlocationnav/view"/><portlet:param name="locationid" value="<%= roomid %>"/></portlet:renderURL>"><%= roomName %></a>
	<% if (roomid.equals(selectedRoomId)) { %></strong> <% } %>
	</td>
	</tr>
<%	
}
%>
</table>