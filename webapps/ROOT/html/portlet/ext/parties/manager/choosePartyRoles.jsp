<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String mainid = (String)request.getAttribute("mainid");
List rolesList=(List) request.getAttribute("rolesList");
%>

<!-- Party Roles List -->

<form name="Parties_Roles_Button_Form" method="post" action="/some/url">
<h2 class="title2">Choose a Party Role</h2>

<display:table id="roles" name="rolesList" requestURI="//ext/parties/manager/listPartyRoles" pagesize="10" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("roles")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyroletype.description"/>
</display:table>

<% if (rolesList.size() > 0) { %>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listRolesAndRels" />
  <tiles:put name="buttonName" value="addRelSButton" />
  <tiles:put name="buttonValue" value="parties.button.choose" />
  <tiles:put name="formName"   value="Parties_Roles_Button_Form" />
  <tiles:put name="actionParam" value="roleid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  </tiles:putList>
</tiles:insert>
<% } %>
</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>