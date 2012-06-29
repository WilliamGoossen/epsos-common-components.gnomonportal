<%@ include file="/html/portlet/ext/permissions/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="gnomon.hibernate.model.gn.GnAction" %>
<%@ page import="com.liferay.portal.model.Role" %>


<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
List rolesList = (List)request.getAttribute("rolesList");
List actionsList = (List)request.getAttribute("actionsList");
Hashtable permissionsHash = (Hashtable)request.getAttribute("permissionsHash");
String portletid = (String)request.getAttribute("portletid");
%>

<form action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/updatePortletActions"/></portlet:actionURL>" method="post">
<input type="hidden" name="portletid" value="<%= portletid %>">
<table cellpadding=2>
<tr>
<td></td>

<%
	for (int r=0; r<rolesList.size(); r++)
	{
	%>
	<td><b><%= ((Role)rolesList.get(r)).getName() %></b></td>
	<%
	} // end for loop on rolesList
%>
</tr>

<%
	for (int a=0; a<actionsList.size(); a++)
	{
		String actionName = ((GnAction)actionsList.get(a)).getActionName();
		if (!((GnAction)actionsList.get(a)).isDeletable())
			actionName += "*";
	%>
	<tr>
	<td align=right><b><%= actionName %></b></td>
	<%
		for (int r=0; r<rolesList.size(); r++)
		{
		%>
		<td align=center>
		<% 	String roleId = ""+((Role)rolesList.get(r)).getRoleId();
			String actionId = ((GnAction)actionsList.get(a)).getMainid().toString();
			if (permissionsHash.containsKey(roleId+"X"+actionId)) { %>
			<input type="checkbox" name="<%=roleId%>" value="<%=actionId%>" checked="true">
			<% } else { %>
			<input type="checkbox" name="<%=roleId%>" value="<%=actionId%>">
			<% } %>
		</td>
		<%
		} // end for loop on rolesList
	%>
	</tr>
	<%
	} // end for loop on actionsList
%>


<tr><td>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "gn.button.update") %>" >
</td></tr>
</table>
</form>
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/permissions/viewPortlets"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.permissions.portlet.list") %></html:link></TD>
</TR></TABLE>

