<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<%@ page import="com.liferay.portal.model.UserGroup" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% String partyid = (String)request.getAttribute("mainid"); %>

<%
List liferayUserGroups=(List) request.getAttribute("liferayUserGroups");

String redirectLinkUrl = request.getParameter("redirect");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "contacts.user.group.add") %></h2>
<!-- Role Types List -->
<form name="Parties_LiferayUserGroup_Button_Form" method="post" action="/some/url">

<display:table id="group" name="liferayUserGroups" requestURI="//ext/parties/contacts/listLiferayUserGroups?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column><input type="checkbox" name="userGroupId" value="<%=""+((UserGroup)pageContext.getAttribute("group")).getUserGroupId()%>"></display:column>
<display:column property="name" titleKey="contacts.user.group.name" sortable="true" />
</display:table>

<% if (hasAdmin) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/contacts/addLiferayUserGroup" />
  <tiles:put name="buttonName" value="addButtonRole" />
  <tiles:put name="buttonValue" value="parties.button.add-to-party" />
  <tiles:put name="formName"   value="Parties_LiferayUserGroup_Button_Form" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<%if (redirectLinkUrl == null || redirectLinkUrl.equals("")){%>
  	<tiles:add value="redirect"/>
  	<%}%>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%= partyid %></tiles:add>
  	<%if (redirectLinkUrl == null || redirectLinkUrl.equals("")){%>
  	<tiles:add><%=redirectLinkUrl%></tiles:add>
  	<%}%>
  </tiles:putList>
</tiles:insert>
<% } %>
</form>

<br>

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>