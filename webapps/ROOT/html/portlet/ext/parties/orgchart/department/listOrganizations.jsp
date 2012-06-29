<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<table>
<tr>
<td valign="top" width="30%">
<%
String chartid = (String) request.getParameter("chartid");
String partyid = (String) request.getParameter("partyid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top">
<%
List organizationList=(List) request.getAttribute("organizationList");
%>

<form name="OrgChart_Organization_List_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.orgchart.list-departments") %></h2>
<display:table id="organizations" name="organizationList" requestURI="//ext/parties/orgchart/listOrganizations" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="groupOrganization" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("organizations")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.orgchart.department.name" sortable="true"/>
</display:table>
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=partyid%>">


<% if (organizationList.size() > 0) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/chooseOrganization" />
  <tiles:put name="buttonName" value="chooseOrganizationButton" />
  <tiles:put name="buttonValue" value="parties.button.choose" />
  <tiles:put name="formName"   value="OrgChart_Organization_List_Form" />
  <tiles:put name="actionParam" value="mainid"/>
  <tiles:put name="actionParamValue" value="groupOrganization"/>
</tiles:insert>
<% }%>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadNewOrganization" />
  <tiles:put name="buttonName" value="addNewOrganizationButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="OrgChart_Organization_List_Form" />
</tiles:insert>

</form>

</td>
</tr>
</table>