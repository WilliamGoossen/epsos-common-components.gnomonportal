<%@ page import="com.ext.portlet.base.yellowpages.services.YellowPageService" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

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
xmlOutput = YellowPageService.getInstance().getRequestMarker(id1);
}
catch (Exception e) {xmlOutput="</markers>";}
%>
<%= xmlOutput %>


