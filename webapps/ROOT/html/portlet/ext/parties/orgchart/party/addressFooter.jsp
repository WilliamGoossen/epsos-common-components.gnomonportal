<%@ page import="com.ext.util.TitleData" %>

<%
try{
TitleData titleDataFoot = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE);

java.util.HashMap params = new java.util.HashMap();
params.put("mainid", titleDataFoot.getValue("partyid").toString());
params.put("partyid", titleDataFoot.getValue("partyid").toString());
String _chartid = (String) request.getParameter("chartid");
params.put("chartid", _chartid);
pageContext.setAttribute("paramsName", params);

if (titleDataFoot.getValue("person").equals("true")) {
%>
<br>
<html:link styleClass="beta1" action="/ext/parties/orgchart/loadPerson" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-person") %></html:link>
<br>
<% } else { %>
<br>
<html:link styleClass="beta1" action="/ext/parties/orgchart/loadOrganization" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-organization") %></html:link>
<br>
<% } %>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>