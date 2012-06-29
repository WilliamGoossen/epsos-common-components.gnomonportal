<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-organization") %></h3>

<% try {
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="OrganizationAddForm";
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("name","parties.manager.organization.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
/*new_field = new StrutsFormFields("validFrom","parties.manager.organization.validfrom","date",false);
new_field.setDateFormat("%d/%m/%Y");
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("validTo","parties.manager.organization.validto","date",false);
new_field.setDateFormat("%d/%m/%Y");
new_field.setRequired(true);
fields.addElement(new_field);*/
new_field = new StrutsFormFields("typeid","parties.manager.organization.typeid","select",false);
new_field.setCollectionProperty("typeIds");
new_field.setCollectionLabel("typeNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/orgchart/addRootOrganization?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.add") %></html:submit> 
 
</html:form>

<br>
<html:link styleClass="beta1" action="/ext/parties/orgchart/viewCharts"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.orgchart.back-to-orgcharts") %></html:link>
<br>
<% } catch (Exception e) {} %>