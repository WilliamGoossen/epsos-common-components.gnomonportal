<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>

<% 
String xmlOutput ="<markers/>";
String mainid = "";
try
{
mainid = request.getParameter("mainid");
}
catch (Exception e) {mainid="0";}
Integer id1=null;
if (!Validator.isNull(mainid))
{
	id1=java.lang.Integer.valueOf(mainid);
}
try
{
xmlOutput = CrmService.getInstance().getRequestMarkers(id1);
}
catch (Exception e) {xmlOutput="</markers>";}
%>
<%= xmlOutput %>


