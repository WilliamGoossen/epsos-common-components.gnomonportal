<%@ include file="/html/portlet/init.jsp" %>

<liferay-ui:tabs names="error" backURL="javascript: history.go(-1);" />

<liferay-ui:error exception="<%= PrincipalException.class %>" message="you-do-not-have-the-required-permissions" />
<%
try
{
%>
<span class="portlet-msg-error">
<%= request.getAttribute("exception").toString() %>
</span>
<% }
catch (Exception e)
{
}
%>