<%@ include file="/html/portlet/ext/base/guestbook/init.jsp" %>
<%@page import="com.ext.portlet.dsth.services.DsthServices"%>
<%

String loadaction = (String)request.getAttribute("loadaction");

if(loadaction!=null && (loadaction.equals("view") || (loadaction.equals("view")))){
	ViewResult gnItem = (ViewResult) pageContext.getAttribute("comment");
	long userid=DsthServices.getInstance().GetCreatorIdFromContent(gnItem.getMainid().toString());
	user = com.liferay.portal.service.UserLocalServiceUtil.getUserById(userid);
	contact = user.getContact();

//String am = PartiesService.getInstance().GetPersonAM(userid);
	String firstName = contact.getFirstName();
	String lastName = contact.getLastName();

%>
<tr>
<td>
Author:
</td>
</tr>

<table>
<tr>
<td>
dsth-FirstName=<%= firstName %>
</td>
</tr>

<tr>
<td>
dsth-LastName=<%= lastName %>
</td>
</tr>

</table>

<%}%>