<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
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

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.update-telecom-address") %></h3>

<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="TelecomAddressForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("partyid","partyid","text",true));
new_field = new StrutsFormFields("countryCode","parties.addresses.telecom.countrycode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("nationalDialingPrefix","parties.addresses.telecom.nationaldialingprefix","text",false));
new_field = new StrutsFormFields("areaCode","parties.addresses.telecom.areacode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("number","parties.addresses.telecom.number","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("extension","parties.addresses.telecom.extension","text",false));
fields.addElement(new StrutsFormFields("physicalType","parties.addresses.telecom.physicaltype","text",false));
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/orgchart/updateTelecomAddress?actionURL=true" method="post">
<bean:define id="addressId" name="TelecomAddressForm" property="mainid"/>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="chartid" value="<%=chartid%>">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 
<br><br>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listRelatedGeographicAddresses" />
  <tiles:put name="buttonName" value="listRelatedButton" />
  <tiles:put name="buttonValue" value="parties.button.list-related-geographic" />
  <tiles:put name="formName"   value="TelecomAddressForm" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="mainid"/>
  	<tiles:add value="partyid"/>
  	<tiles:add value="listaction"/>  	  	
  	<tiles:add value="related"/>  
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%= addressId %></tiles:add>
  	<tiles:add><%= titleData.getValue("partyid").toString() %></tiles:add>  	
  	<tiles:add value="GeographicAddresses"/>
  	<tiles:add value="true"/>  
  </tiles:putList>
</tiles:insert>

</html:form>

<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>



