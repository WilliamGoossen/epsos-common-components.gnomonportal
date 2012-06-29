<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

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

<h3  class="title1">
<logic:equal parameter="loadaction" value="trans">
<%= LanguageUtil.get(pageContext, "parties.manager.form.add-geographic-address-translation") %>
</logic:equal>
<logic:notEqual parameter="loadaction" value="trans">
<%= LanguageUtil.get(pageContext, "parties.manager.form.add-geographic-address") %>
</logic:notEqual></h3>

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

<html:form action="/ext/parties/orgchart/addGeographicAddress?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="chartid" value="<%=chartid%>">
<logic:notEqual parameter="loadaction" value="trans">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/addGeographicAddress" />
  <tiles:put name="buttonName" value="addButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="GeographicAddressForm" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
</tiles:insert>
</logic:notEqual>

<logic:equal parameter="loadaction" value="trans">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/orgchart/addGeographicAddress" />
  <tiles:put name="buttonName" value="addButton" />
  <tiles:put name="buttonValue" value="parties.button.add-translation" />
  <tiles:put name="formName"   value="GeographicAddressForm" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="trans"/>
</tiles:insert>
</logic:equal>

</html:form>

<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>

