<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<% try { %>
<table>
<tr>
<td valign="top" width="30%">
<%
String chartid = (String) request.getParameter("chartid");
String partyid = (String) request.getParameter("partyid");
String personid = (String) request.getParameter("personid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top">

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
List roleTypeList=(List) request.getAttribute("roleTypeList");
String setDepartmentManager = request.getParameter("ADD_DEPARTMENT_MANAGER");
%>

<form name="OrgChart_Roles_List_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.orgchart.list-roles") %></h2>
<display:table id="roles" name="roleTypeList" requestURI="//ext/parties/orgchart/listRoles" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="groupRole" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("roles")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyroletype.description"/>
</display:table>
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=partyid%>">
<input type="hidden" name="personid" value="<%=personid%>">

<% if (roleTypeList.size() > 0) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/chooseRole" />
  <tiles:put name="buttonName" value="chooseRoleButton" />
  <tiles:put name="buttonValue" value="parties.button.choose" />
  <tiles:put name="formName"   value="OrgChart_Roles_List_Form" />
  <tiles:put name="actionParam" value="mainid"/>
  <tiles:put name="actionParamValue" value="groupRole"/>
<%if(setDepartmentManager != null) {%>
  <tiles:putList name="actionParamList">
  	<tiles:add value="ADD_DEPARTMENT_MANAGER"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=setDepartmentManager%></tiles:add>
  </tiles:putList>
 <%}%>
</tiles:insert>
<% }%>

</form>

</td>
</tr>
</table>
<% } catch (Exception e) {e.printStackTrace(); } %>