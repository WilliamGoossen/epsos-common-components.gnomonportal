<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship") %></h2>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<%
List relTypesList=(List) request.getAttribute("relTypesList");
List partyRolesList = (List) request.getAttribute("partyRolesList");
try {
%>

<!-- Relationship Types List -->
<html:form action="/ext/parties/manager/addPartyRel?actionURL=true" method="post">
<h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship-choose-type") %></h2> <html:errors property="relationshipTypeId"/>
<display:table id="rels" name="relTypesList" requestURI="//ext/parties/manager/listRolesAndRels" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="relationshipTypeId" checked="true"  value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("rels")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.admin.partyrelationshiptype.name"
    			sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyrelationshiptype.description"/>
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyrelationshiptype.clientrolename"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.partyrelationshiptype.supplierrolename"/>
</display:table><br>

<!-- Party Roles List -->
<h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship-choose-role") %></h2><html:errors property="partyRoleId"/>
<display:table id="roles" name="partyRolesList" requestURI="//ext/parties/manager/listRolesAndRels" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="partyRoleId" checked="true" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("roles")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.manager.party.description" sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyroletype.name" sortable="true" />
</display:table><br>

<h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship-choose-allocation") %></h2>
<b> <%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship-party-role") %> </b>
<%= titleData.getValue("parties.manager.for-party-description").toString() %> -
<%= titleData.getValue("parties.manager.for-role-name").toString() %> <br>
<b> <%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship-is-the") %> </b>
<input type="radio" name="supplier" value="0" checked="true"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship-client") %> </input>
<input type="radio" name="supplier" value="1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-party-relationship-supplier") %> </input>
<html:errors property="supplier"/>
<br><br>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/addPartyRel" />
  <tiles:put name="buttonName" value="addButtonRel" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="RolesAndRelsForm" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<tiles:add value="roleid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%= titleData.getValue("mainid").toString() %></tiles:add>
  	<tiles:add><%= titleData.getValue("roleid").toString() %></tiles:add>
  </tiles:putList>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_MANAGER"/>
</tiles:insert>

</html:form>
<% } catch (Exception e) { } %>
<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>