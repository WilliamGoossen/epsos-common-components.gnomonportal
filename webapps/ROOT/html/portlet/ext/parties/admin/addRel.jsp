<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3 class="title1">
<logic:equal parameter="loadaction" value="trans">
<%= LanguageUtil.get(pageContext, "parties.admin.form.add-rel-translation") %>
</logic:equal>
<logic:notEqual parameter="loadaction" value="trans">
<%= LanguageUtil.get(pageContext, "parties.admin.form.add-rel") %>
</logic:notEqual></h3>


<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="PartyRelationshipTypeForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("langId","langId","text",true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false,true));
new_field = new StrutsFormFields("name","parties.admin.partyrelationshiptype.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("description","parties.admin.partyrelationshiptype.description","text",false));
new_field = new StrutsFormFields("clientRoleName","parties.admin.partyrelationshiptype.clientrolename","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("supplierRoleName","parties.admin.partyrelationshiptype.supplierrolename","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/admin/addRelType?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<logic:notEqual parameter="loadaction" value="trans">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/addRelType" />
  <tiles:put name="buttonName" value="addButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="PartyRelationshipTypeForm" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
</tiles:insert>
</logic:notEqual>

<logic:equal parameter="loadaction" value="trans">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/addRelType" />
  <tiles:put name="buttonName" value="addButton" />
  <tiles:put name="buttonValue" value="parties.button.add-translation" />
  <tiles:put name="formName"   value="PartyRelationshipTypeForm" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="trans"/>
</tiles:insert>
</logic:equal>

</html:form>
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewRelTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-rel") %></html:link></TD>
</TR></TABLE>

