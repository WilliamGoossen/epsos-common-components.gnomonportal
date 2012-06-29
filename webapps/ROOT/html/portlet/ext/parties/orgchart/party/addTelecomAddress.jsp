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

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-telecom-address") %></h3>

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

<html:form action="/ext/parties/orgchart/addTelecomAddress?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="chartid" value="<%=chartid%>">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.add") %></html:submit> 
</html:form>

<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>


