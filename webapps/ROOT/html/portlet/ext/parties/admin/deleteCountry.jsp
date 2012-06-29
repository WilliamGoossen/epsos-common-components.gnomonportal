<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.form.delete-country") %></h3>

<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="CountryForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true, true));
fields.addElement(new StrutsFormFields("langId","langId","text",true, true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true));
fields.addElement(new StrutsFormFields("alphabeticCode","parties.admin.country.alphabeticcode","text",false,true));
fields.addElement(new StrutsFormFields("numericCode","parties.admin.country.numericcode","text",false,true));
fields.addElement(new StrutsFormFields("name","parties.admin.country.name","text",false,true));
fields.addElement(new StrutsFormFields("officialName","parties.admin.country.officialname","text",false,true));
request.setAttribute("_vector_fields", fields);
%>
<html:form action="/ext/parties/admin/deleteCountry?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.delete") %></html:submit>

</html:form>
<p><br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewCountries"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-country") %></html:link></TD>
</TR></TABLE>

