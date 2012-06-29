<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<%
List orgTypesList=(List) request.getAttribute("orgTypesList");
%>
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.list.org") %></h2>

<form name="Parties_Admin_Org_Button_Form" method="post" action="/some/url">
<!-- Organization Types List -->
<display:table id="orgs" name="orgTypesList" requestURI="//ext/parties/admin/viewOrgTypes" pagesize="10" sort="list"  style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("orgs")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.admin.organizationtype.name"
    			 sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.organizationtype.description"/>
</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/loadOrgType" />
  <tiles:put name="buttonName" value="addButtonOrg" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Admin_Org_Button_Form" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_ADMIN"/>
</tiles:insert>

<% if (orgTypesList.size() > 0) { %>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/loadOrgType" />
  <tiles:put name="buttonName" value="editButtonOrg" />
  <tiles:put name="buttonValue" value="parties.button.edit" />
  <tiles:put name="formName"   value="Parties_Admin_Org_Button_Form" />
  <tiles:put name="actionParam" value="mainid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_ADMIN"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/loadOrgType" />
  <tiles:put name="buttonName" value="deleteButtonOrg" />
  <tiles:put name="buttonValue" value="parties.button.delete" />
  <tiles:put name="formName"   value="Parties_Admin_Org_Button_Form" />
  <tiles:put name="actionParam" value="delete"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_ADMIN"/>
</tiles:insert>

<% } %>

</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-admin") %></html:link></TD>
</TR></TABLE>
