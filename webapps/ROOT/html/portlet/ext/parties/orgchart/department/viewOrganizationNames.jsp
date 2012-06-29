<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

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

<%
String organizationid = (String)request.getAttribute("mainid");
List namesList=(List) request.getAttribute("namesList");
%>

<!-- Organization Names List -->

<form name="Organizations_Names_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.orgchart.list-department-names") %></h2>

<display:table id="names" name="namesList" requestURI="//ext/parties/orgchart/listOrganizationNames?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("names")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field4" titleKey="parties.orgchart.department.name"/>
<display:column class="gamma1" property="field1" titleKey="parties.manager.organization.validfrom" sortable="true"  decorator="org.displaytag.sample.LongDateWrapper"/>
<display:column class="gamma1" property="field2" titleKey="parties.manager.organization.validto" sortable="true"  decorator="org.displaytag.sample.LongDateWrapper"/>
</display:table>
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=organizationid%>">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadOrganizationName" />
  <tiles:put name="buttonName" value="addButtonOrganizationName" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Organizations_Names_Button_Form" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
  <tiles:putList name="actionParamList">
   	<tiles:add value="organizationid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
   	<tiles:add><%= organizationid %></tiles:add>
  </tiles:putList>
</tiles:insert>

<% if (namesList.size() > 0) { %>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadOrganizationName" />
  <tiles:put name="buttonName" value="editButtonOrganizationName" />
  <tiles:put name="buttonValue" value="parties.button.edit" />
  <tiles:put name="formName"   value="Organizations_Names_Button_Form" />
  <tiles:put name="actionParam" value="mainid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
   	<tiles:add value="organizationid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
   	<tiles:add><%= organizationid %></tiles:add>
  </tiles:putList>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadOrganizationName" />
  <tiles:put name="buttonName" value="deleteButtonOrganizationName" />
  <tiles:put name="buttonValue" value="parties.button.delete" />
  <tiles:put name="formName"   value="Organizations_Names_Button_Form" />
  <tiles:put name="actionParam" value="delete"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
   	<tiles:add value="organizationid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
   	<tiles:add><%= organizationid %></tiles:add>
  </tiles:putList>
</tiles:insert>

<% } %>

</form>

<%
java.util.HashMap params = new java.util.HashMap();
params.put("mainid", organizationid);
params.put("partyid", organizationid);
params.put("chartid", chartid);
pageContext.setAttribute("paramsName", params);
%>
<br>
<html:link styleClass="beta1" action="/ext/parties/orgchart/loadOrganization" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.orgchart.back-to-department") %></html:link>
</td>
</tr>
</table>