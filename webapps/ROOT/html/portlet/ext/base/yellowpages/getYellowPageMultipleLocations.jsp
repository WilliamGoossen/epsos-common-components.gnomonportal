<%@ page import="com.ext.portlet.base.yellowpages.services.YellowPageService" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>

<% 

String xmlOutput ="<markers/>";
String ids = "";
try
{
  ids = request.getParameter("map_points");
}
catch (Exception e) {ids="0";}%>
<%try
{
	xmlOutput = YellowPageService.getInstance().getRequestMarkers(ids, request);
}
catch (Exception e) {xmlOutput="</markers>";}
%>
<%= xmlOutput %>