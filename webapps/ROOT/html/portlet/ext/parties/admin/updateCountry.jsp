<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.form.update-country") %></h3>


<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="CountryForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("langId","langId","text",true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false,true));
new_field = new StrutsFormFields("alphabeticCode","parties.admin.country.alphabeticcode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("numericCode","parties.admin.country.numericcode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("name","parties.admin.country.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("officialName","parties.admin.country.officialname","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/admin/updateCountry?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 

<logic:notEqual name="CountryForm" property="lang" value="<%= defLang %>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/deleteCountry" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="parties.button.delete-translation" />
  <tiles:put name="formName"   value="CountryForm" />
  <tiles:put name="confirm" value="are-you-sure-you-want-to-delete-this-translation"/>
  <tiles:put name="actionParam" value="deleteDetail"/>
  <tiles:put name="actionParamValue" value="1"/>
</tiles:insert>
</logic:notEqual>
</html:form>
<br>
<p>
<h3 class="title2">Translations</h3>
<p>

<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
	<tiles:put name="editAction"  value="/ext/parties/admin/loadCountry" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="view"/>
    <tiles:put name="addAction"  value="/ext/parties/admin/loadCountry" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
</tiles:insert>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewCountries"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-country") %></html:link></TD>
</TR></TABLE>

