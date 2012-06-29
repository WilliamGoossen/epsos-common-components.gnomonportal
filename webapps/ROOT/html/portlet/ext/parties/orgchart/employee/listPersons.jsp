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
String searchString = (String) request.getAttribute("searchString");

String setDepartmentManager = request.getParameter("ADD_DEPARTMENT_MANAGER");

if (searchString == null) searchString = "*";
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top">
<br>
<form name="OrgChart_Persons_Search_Form" method="post" action="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/parties/orgchart/listPersons" />
					</portlet:actionURL>" method="post">
<input type="submit" class="portlet-form-button" name="submit" value="<%= LanguageUtil.get(pageContext, "parties.button.search") %>">
<input type="text" name="searchString" value="<%= searchString %>">
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=partyid%>">

</form>
<br><hr><br>
<%
List personList=(List) request.getAttribute("personList");
%>

<form name="OrgChart_Person_List_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.orgchart.list-persons") %></h2>
<display:table id="persons" name="personList" requestURI="//ext/parties/orgchart/listPersons" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="groupPerson" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("persons")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field2" titleKey="parties.manager.person.prefix" sortable="true" />
<display:column class="gamma1" property="field1" titleKey="parties.manager.person.firstname" sortable="true" />
<display:column class="gamma1" property="field3" titleKey="parties.manager.person.familyname" sortable="true"  href="//ext/parties/manager/loadPersonSummary?actionURL=true" paramId="partyid" paramProperty="mainid"/>
<display:column class="gamma1" property="field4" titleKey="parties.manager.person.gender" sortable="true" />
</display:table>
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=partyid%>">


<% if (personList.size() > 0) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listRoles" />
  <tiles:put name="buttonName" value="choosePersonButton" />
  <tiles:put name="buttonValue" value="parties.button.choose" />
  <tiles:put name="formName"   value="OrgChart_Person_List_Form" />
  <tiles:put name="actionParam" value="personid"/>
  <tiles:put name="actionParamValue" value="groupPerson"/>
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

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadNewPerson" />
  <tiles:put name="buttonName" value="addNewPersonButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="OrgChart_Person_List_Form" />
<%if(setDepartmentManager != null) {%>
  <tiles:putList name="actionParamList">
  	<tiles:add value="ADD_DEPARTMENT_MANAGER"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=setDepartmentManager%></tiles:add>
  </tiles:putList>
 <%}%>
</tiles:insert>

</form>

</td>
</tr>
</table>