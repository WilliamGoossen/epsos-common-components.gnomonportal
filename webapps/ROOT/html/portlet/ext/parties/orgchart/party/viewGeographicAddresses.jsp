<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<table>
<tr>
<td valign="top">
<%
String chartid = (String) request.getParameter("chartid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td valign="top">
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String mainid = (String)request.getAttribute("mainid");
List addressesList=(List) request.getAttribute("addressesList");
%>

<!-- Addresses List -->

<form name="Party_Addresses_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-geographic-address") %></h2>

<display:table id="addresses" name="addressesList" requestURI="//ext/parties/orgchart/listGeographicAddresses?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("addresses")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.addresses.geographic.addressline"/>
<display:column class="gamma1" property="field2" titleKey="parties.addresses.geographic.region"/>
<display:column class="gamma1" property="field3" titleKey="parties.addresses.geographic.ziporpostcode"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.country.name"/>
</display:table>
<input type="hidden" name="chartid" value="<%=chartid%>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadGeographicAddress" />
  <tiles:put name="buttonName" value="addGeographicButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Party_Addresses_Button_Form" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<tiles:add value="loadaction"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  	<tiles:add value="add"/>
  </tiles:putList>
</tiles:insert>

<% if (addressesList.size()>0) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/loadGeographicAddress" />
  <tiles:put name="buttonName" value="editGeographicButton" />
  <tiles:put name="buttonValue" value="parties.button.edit" />
  <tiles:put name="formName"   value="Party_Addresses_Button_Form" />
  <tiles:put name="actionParam" value="mainid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<tiles:add value="loadaction"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  	<tiles:add value="view"/>
  </tiles:putList>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/deleteGeographicAddress" />
  <tiles:put name="buttonName" value="deleteGeographicButton" />
  <tiles:put name="buttonValue" value="parties.button.delete" />
  <tiles:put name="formName"   value="Party_Addresses_Button_Form" />
  <tiles:put name="confirm" value="parties.manager.addresses.delete-are-you-sure" />
  <tiles:put name="actionParam" value="mainid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  </tiles:putList>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listRelatedTelecomAddresses" />
  <tiles:put name="buttonName" value="listRelatedButton" />
  <tiles:put name="buttonValue" value="parties.button.list-related-telecom" />
  <tiles:put name="formName"   value="Party_Addresses_Button_Form" />
  <tiles:put name="actionParam" value="mainid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyid"/>
  	<tiles:add value="listaction"/>
  	<tiles:add value="related"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%= mainid %></tiles:add>
  	<tiles:add value="TelecomAddresses"/>
  	<tiles:add value="true"/>
  </tiles:putList>
</tiles:insert>

<% } %>

</form>

<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>