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

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.update-geographic-address") %></h3>


<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="GeographicAddressForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("partyid","partyid","text",true));
fields.addElement(new StrutsFormFields("langid","langid","text",true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true));
new_field = new StrutsFormFields("addressLine","parties.addresses.geographic.addressline","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("region","parties.addresses.geographic.region","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("zipOrPostCode","parties.addresses.geographic.ziporpostcode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("countryid","parties.addresses.geographic.country","select",false);
new_field.setCollectionProperty("countryIds");
new_field.setCollectionLabel("countryNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/orgchart/updateGeographicAddress?actionURL=true" method="post">
<bean:define id="addressId" name="GeographicAddressForm" property="mainid"/>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="chartid" value="<%=chartid%>">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 

<logic:notEqual name="GeographicAddressForm" property="lang" value="<%= defLang %>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/deleteGeographicAddress" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="parties.button.delete-translation" />
  <tiles:put name="formName"   value="GeographicAddressForm" />
  <tiles:put name="confirm" value="are-you-sure-you-want-to-delete-this-translation"/>
  <tiles:put name="actionParam" value="deleteDetail"/>
  <tiles:put name="actionParamValue" value="1"/>
</tiles:insert>
</logic:notEqual>

<br><br>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/listRelatedTelecomAddresses" />
  <tiles:put name="buttonName" value="listRelatedButton" />
  <tiles:put name="buttonValue" value="parties.button.list-related-telecom" />
  <tiles:put name="formName"   value="GeographicAddressForm" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="mainid"/>
  	<tiles:add value="partyid"/>
  	<tiles:add value="listaction"/>  	
  	<tiles:add value="related"/>    	
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%= addressId %></tiles:add>
  	<tiles:add><%= titleData.getValue("partyid").toString() %></tiles:add>  	
  	<tiles:add value="TelecomAddresses"/>
  	<tiles:add value="true"/>  
  </tiles:putList>
</tiles:insert>

</html:form>

<br>
<p>
<h3  class="title2">Translations</h3>
<p>

<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
	<tiles:put name="editAction"  value="/ext/parties/orgchart/loadGeographicAddress" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="view"/>
    <tiles:putList name="editActionParamList">
    	<tiles:add value="partyid"/>
    	<tiles:add value="chartid"/>
    </tiles:putList>
    <tiles:putList name="editActionParamValueList">
    	<tiles:add><%= titleData.getValue("partyid").toString() %></tiles:add>
    	<tiles:add><%= chartid %></tiles:add>
    </tiles:putList>
    <tiles:put name="addAction"  value="/ext/parties/orgchart/loadGeographicAddress" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
    <tiles:putList name="addActionParamList">
    	<tiles:add value="partyid"/>
    	<tiles:add value="chartid"/>
    </tiles:putList>
    <tiles:putList name="addActionParamValueList">
    	<tiles:add><%= titleData.getValue("partyid").toString() %></tiles:add>
    	<tiles:add><%= chartid %></tiles:add>
    </tiles:putList>
</tiles:insert>

<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>
