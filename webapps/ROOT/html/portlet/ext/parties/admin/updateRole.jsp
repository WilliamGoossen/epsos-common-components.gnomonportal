<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.form.update-rol") %></h3>


<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="PartyRoleTypeForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("langId","langId","text",true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false,true));
new_field = new StrutsFormFields("name","parties.admin.partyroletype.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("description","parties.admin.partyroletype.description","text",false));
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/admin/updateRoleType?actionURL=true" method="post">
<bean:define id="mainid" name="PartyRoleTypeForm" property="mainid"/>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
	
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/viewFeatureTypes" />
  <tiles:put name="buttonName" value="viewButtonRoleFeatures" />
  <tiles:put name="buttonValue" value="parties.button.list-feature-types" />
  <tiles:put name="formName"   value="PartyRoleTypeForm" />
  <tiles:put name="actionParam" value="partyroletypeid"/>
  <tiles:put name="actionParamValue"><%= mainid.toString() %></tiles:put>
</tiles:insert>


<logic:notEqual name="PartyRoleTypeForm" property="lang" value="<%= defLang %>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/deleteRoleType" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="parties.button.delete-translation" />
  <tiles:put name="formName"   value="PartyRoleTypeForm" />
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
	<tiles:put name="editAction"  value="/ext/parties/admin/loadRoleType" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="view"/>
    <tiles:put name="addAction"  value="/ext/parties/admin/loadRoleType" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
</tiles:insert>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewRoleTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-rol") %></html:link></TD>
</TR></TABLE>


