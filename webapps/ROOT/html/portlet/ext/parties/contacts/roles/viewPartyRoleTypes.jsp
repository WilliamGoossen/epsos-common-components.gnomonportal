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

String redirectLinkUrl = request.getParameter("redirect");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-available-role-types") %></h2>
<!-- Role Types List -->
<form name="Parties_Manager_Role_Button_Form" method="post" action="/some/url">

<display:table id="roles" name="roleTypesList" requestURI="//ext/parties/contacts/listPartyRoleTypes?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column><input type="checkbox" name="roletypeid" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("roles")).getMainid().toString()%>"></display:column>
<display:column property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column property="field2" titleKey="parties.admin.partyroletype.description"/>
</display:table>

<% if (hasAdmin) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/contacts/addPartyRole" />
  <tiles:put name="buttonName" value="addButtonRole" />
  <tiles:put name="buttonValue" value="parties.button.add-to-party" />
  <tiles:put name="formName"   value="Parties_Manager_Role_Button_Form" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<%if (redirectLinkUrl == null || redirectLinkUrl.equals("")){%>
  	<tiles:add value="redirect"/>
  	<%}%>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=titleData.getValue("partyid").toString()%></tiles:add>
  	<%if (redirectLinkUrl == null || redirectLinkUrl.equals("")){%>
  	<tiles:add><%=redirectLinkUrl%></tiles:add>
  	<%}%>
  </tiles:putList>
</tiles:insert>
<% } %>
</form>

<br>

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>