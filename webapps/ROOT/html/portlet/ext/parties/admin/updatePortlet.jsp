<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="gnomon.hibernate.model.gn.GnAction" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<%
try{
%>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
List roleTypesList = (List)request.getAttribute("roleTypesList");
List actionsList = (List)request.getAttribute("actionsList");
Hashtable permissionsHash = (Hashtable)request.getAttribute("permissionsHash");
String portletid = (String)request.getAttribute("portletid");
%>

<form action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/updatePortletRolesAndActions"/></portlet:actionURL>" method="post">
<input type="hidden" name="portletid" value="<%= portletid %>">
<table cellpadding=2>
<tr>
<td></td>

<%
	for (int r=0; r<roleTypesList.size(); r++)
	{
	%>
	<td><b><%= ((ViewResult)roleTypesList.get(r)).getField1().toString() %></b></td>
	<%
	} // end for loop on roleTypesList
%>
</tr>

<%
	for (int a=0; a<actionsList.size(); a++)
	{
	%>
	<tr>
	<td align=right><b><%= ((GnAction)actionsList.get(a)).getActionName() %></b></td>
	<%
		for (int r=0; r<roleTypesList.size(); r++)
		{
		%>
		<td align=center>
		<% 	String roleTypeId = ((ViewResult)roleTypesList.get(r)).getMainid().toString();
			String actionId = ((GnAction)actionsList.get(a)).getMainid().toString();
			if (permissionsHash.containsKey(roleTypeId+"X"+actionId)) { %>
			<input type="checkbox" name="<%=roleTypeId%>" value="<%=actionId%>" checked="true">
			<% } else { %>
			<input type="checkbox" name="<%=roleTypeId%>" value="<%=actionId%>">
			<% } %>
		</td>
		<%
		} // end for loop on roleTypesList
	%>
	</tr>
	<%
	} // end for loop on actionsList
%>


<tr><td>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "parties.button.update") %>" >
</td></tr>
</table>
</form>
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewPortlets"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.list.portlets") %></html:link></TD>
</TR></TABLE>

<%
}catch(Exception ex){
	ex.printStackTrace(System.err);
}
%>
