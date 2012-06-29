<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-organization") %></h3>


<% try {
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="OrganizationAddForm";

fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("typeid","parties.manager.organization.typeid","select",false);
new_field.setCollectionProperty("typeIds");
new_field.setCollectionLabel("typeNames");
fields.addElement(new_field);

new_field = new StrutsFormFields("name","parties.manager.organization.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);

fields.addElement(new StrutsFormFields("liferayCompany","parties.manager.organization.liferaycompany","boolean",false));
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/manager/addOrganization?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.add") %></html:submit> 
 
</html:form>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>
<% } catch (Exception e) {} %>