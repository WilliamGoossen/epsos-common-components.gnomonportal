<%@ include file="/html/portlet/ext/epsos/info/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.SpiritUserClientDto" %>


<%
SpiritUserClientDto usr = (SpiritUserClientDto)request.getAttribute("EPSOS_USER");
if (usr!=null)
{
String displayName = usr.getDisplayName();
String organizationName = usr.getHomeOrganisation().getOrganisationName();
//byte[] photo = usr.getJpegPhoto().get(0);
String loginRole = usr.getLoginRole();
%>

<table class="liferay-table">

<%--
<tr>
<th colspan="2">
<% session.setAttribute("photo_bytes", photo); %>
<img src="<%= "/FILESYSTEM/" + PortalUtil.getCompanyId(request)+"/epsos/"+usr.getUid().get(0)+".jpg" %>" style="width: 60px; height: 60px; border-style:solid; border-width:1px;">
</th>
</tr>
--%>

<tr>
<th><%= LanguageUtil.get(pageContext, "epsos.user.displayname") %></th> <td><%= displayName %></td>
</tr>


<tr>
<th><%= LanguageUtil.get(pageContext, "epsos.user.organizationname") %></th> <td><%= organizationName %></td>
</tr>


<tr>
<th><%= LanguageUtil.get(pageContext, "epsos.user.loginrole") %></th> <td><%= loginRole %></td>
</tr>

</table>
<% } %>