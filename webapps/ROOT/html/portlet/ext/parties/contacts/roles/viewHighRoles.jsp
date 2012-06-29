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
List highRoles=(List) request.getAttribute("highRoles");

String redirectLinkUrl = request.getParameter("redirect");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "contacts.highrole.add") %></h2>
<!-- Role Types List -->
<form name="Parties_HighRole_Button_Form" method="post" action="/some/url">

<display:table id="highrole" name="highRoles" requestURI="//ext/parties/contacts/listLiferayUserGroups?actionURL=true" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">

<% ViewResult highRoleItem = (ViewResult)pageContext.getAttribute("highrole"); %>

<display:column><input type="checkbox" name="highroleid" value="<%=""+highRoleItem.getField1()%>"></display:column>

<display:column property="field2" titleKey="contacts.highrole.name" sortable="true" />

<display:column titleKey="contacts.highrole.client.partyroletype">
<% if (highRoleItem.getField3() != null) { 
	List<ViewResult> roles = (List<ViewResult>)highRoleItem.getField3();
	if (roles.size() == 1) {
		%>
		<input type="hidden" name="<%= highRoleItem.getField1() %>_clientpartyroleid" value="<%= roles.get(0).getMainid().toString() %>">
		<%= roles.get(0).getField1() %>
		<%
	} else {
	%>
	<select name="<%= highRoleItem.getField1() %>_clientpartyroleid">
	<%
	for (ViewResult r: roles) {%>
		<option value="<%= r.getMainid().toString() %>"><%= r.getField1() %></option>
	<% } %>
	</select>
<% } }%>
</display:column>

<display:column titleKey="contacts.highrole.supplier.partyroletype">
<% if (highRoleItem.getField4() != null) { 
	List<ViewResult> roles = (List<ViewResult>)highRoleItem.getField4();
	if (roles.size() == 1) {
		%>
		<input type="hidden" name="<%= highRoleItem.getField1() %>_supplierpartyroleid" value="<%= roles.get(0).getMainid().toString() %>">
		<%= roles.get(0).getField1() %>
		<%
	} else {
	%>
	<select name="<%= highRoleItem.getField1() %>_supplierpartyroleid">
	<%
	for (ViewResult r: roles) {%>
		<option value="<%= r.getMainid().toString() %>"><%= r.getField1() %></option>
	<% } %>
	</select>
<% } }%>
</display:column>

<display:column titleKey="contacts.highrole.otherparty">
<% if (highRoleItem.getField5() != null) { 
	List<ViewResult> roles = (List<ViewResult>)highRoleItem.getField5();
	if (roles.size() == 1) {
		%>
		<input type="hidden" name="<%= highRoleItem.getField1() %>_otherpartyid" value="<%= roles.get(0).getMainid().toString() %>">
		<%= roles.get(0).getField1() %>
		<%
	} else {
	%>
	<select name="<%= highRoleItem.getField1() %>_otherpartyid">
	<%
	for (ViewResult r: roles) {%>
		<option value="<%= r.getMainid().toString() %>"><%= r.getField1() %></option>
	<% } %>
	</select>
<% } }%>
</display:column>

</display:table>

<% if (hasAdmin) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/contacts/addHighRole" />
  <tiles:put name="buttonName" value="addButtonHighRole" />
  <tiles:put name="buttonValue" value="parties.button.add-to-party" />
  <tiles:put name="formName"   value="Parties_HighRole_Button_Form" />
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