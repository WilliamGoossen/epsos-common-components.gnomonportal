<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<%
List roleTypesList=(List) request.getAttribute("roleTypesList");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-available-role-types") %></h2>
<!-- Role Types List -->
<form name="Parties_Manager_Role_Button_Form" method="post" action="/some/url">

<display:table id="roles" name="roleTypesList" requestURI="//ext/parties/manager/listPartyRoleTypes?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("roles")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyroletype.description"/>
</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/addPartyRole" />
  <tiles:put name="buttonName" value="addButtonRole" />
  <tiles:put name="buttonValue" value="parties.button.add-to-party" />
  <tiles:put name="formName"   value="Parties_Manager_Role_Button_Form" />
  <tiles:put name="actionParam" value="roletypeid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=titleData.getValue("partyid").toString()%></tiles:add>
  </tiles:putList>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_MANAGER"/>
</tiles:insert>

</form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>