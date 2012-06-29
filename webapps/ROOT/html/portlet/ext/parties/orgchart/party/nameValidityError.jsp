<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<table>
<tr>
<td valign="top" width="30%">
<%
String chartid = (String) request.getParameter("chartid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top">
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<% String actionValue = (String)titleData.getValue("action");
   String partyName = (String) titleData.getValue("partyName");
   String partyid = titleData.getValue("partyid").toString();
   Boolean isPerson = new Boolean(titleData.getValue("person").toString());
%>

<% if (isPerson.booleanValue()) { %>
<h2 class="title1"> Could not <%= LanguageUtil.get(pageContext,actionValue) %> the current name of this Person! </h2>
<br>
<span class="bg1" >
<%= LanguageUtil.get(pageContext, "parties.manager.person.name.validity.error") %> : <%= partyName %></th>
</span>
<br>
<hr>
<br>
<%
java.util.HashMap params = new java.util.HashMap();
params.put("personid", partyid);
params.put("partyid", partyid);
params.put("chartid", chartid);
pageContext.setAttribute("paramsName", params);
%>
<html:link styleClass="beta1" action="/ext/parties/orgchart/listPersonNames" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-person-names") %></html:link>

<% } else { %>

<h2 class="title1"> Could not <%= LanguageUtil.get(pageContext,actionValue) %> the current name of this Organization! </h2>
<br>
<span class="bg1" >
<%= LanguageUtil.get(pageContext, "parties.manager.org.name.validity.error") %> : <%= partyName %></th>
</span>
<br>
<hr>
<br>
<%
java.util.HashMap params = new java.util.HashMap();
params.put("organizationid", partyid);
params.put("partyid", partyid);
params.put("chartid", chartid);
pageContext.setAttribute("paramsName", params);
%>
<html:link styleClass="beta1" action="/ext/parties/orgchart/listOrganizationNames" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-organization-names") %></html:link>

<% } %>
</td>
</tr>
</table>
