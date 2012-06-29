<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

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
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<%
String mainid = (String)titleData.getValue("mainid");
String partyid = (String)titleData.getValue("partyid");
List addressesList=(List) request.getAttribute("addressesList");
%>

<!-- Addresses List -->

<form name="Party_Addresses_Button_Form" method="post" action="/some/url">
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.list-related-geographic-address") %></h2>

<display:table id="addresses" name="addressesList" requestURI="//ext/parties/orgchart/listRelatedGeographicAddresses?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:column class="gamma1"><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("addresses")).getMainid().toString()%>"></display:column>
<display:column class="gamma1" property="field1" titleKey="parties.addresses.geographic.addressline"/>
<display:column class="gamma1" property="field2" titleKey="parties.addresses.geographic.region"/>
<display:column class="gamma1" property="field3" titleKey="parties.addresses.geographic.ziporpostcode"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.country.name"/>
</display:table>
<input type="hidden" name="chartid" value="<%=chartid%>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listNotRelatedGeographicAddresses" />
  <tiles:put name="buttonName" value="addGeographicButton" />
  <tiles:put name="buttonValue" value="parties.button.add-related" />
  <tiles:put name="formName"   value="Party_Addresses_Button_Form" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="mainid"/>
  	<tiles:add value="partyid"/>
  	<tiles:add value="listaction"/>
  	<tiles:add value="related"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  	<tiles:add><%=partyid%></tiles:add>
  	<tiles:add value="GeographicAddresses"/>
  	<tiles:add value="false"/>
  </tiles:putList>
</tiles:insert>

<% if (addressesList.size()>0) { %>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/relateToTelecomAddress" />
  <tiles:put name="buttonName" value="removeGeographicButton" />
  <tiles:put name="buttonValue" value="parties.button.remove" />
  <tiles:put name="formName"   value="Party_Addresses_Button_Form" />
  <tiles:put name="confirm" value="parties.manager.addresses.remove-are-you-sure" />
  <tiles:put name="actionParam" value="geographicid"/>
  <tiles:put name="actionParamValue" value="group1"/>
  <tiles:putList name="actionParamList">
  	<tiles:add value="telecomid"/>
  	<tiles:add value="partyid"/>
  	<tiles:add value="listaction"/>
  	<tiles:add value="related"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=mainid%></tiles:add>
  	<tiles:add><%=partyid%></tiles:add>
  	<tiles:add value="GeographicAddresses"/>
  	<tiles:add value="false"/>
  </tiles:putList>
</tiles:insert>

<% } %>

</form>

<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>