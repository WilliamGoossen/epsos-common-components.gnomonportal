<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="RoleFeatureTypeForm";
%>

<h3 class="title1">
<logic:equal parameter="loadaction" value="trans">
<%= LanguageUtil.get(pageContext, "parties.admin.form.add-featuretype-translation") %>

<%
fields.addElement(new StrutsFormFields("mainid","mainid","text",true, true));
fields.addElement(new StrutsFormFields("partyroletypeid","partyroletypeid","text",true, true));
fields.addElement(new StrutsFormFields("langId","langId","text",true, true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true));
new_field = new StrutsFormFields("name","parties.admin.featuretype.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("fieldcode","parties.admin.featuretype.fieldcode","text",false, true);
fields.addElement(new_field);
new_field = new StrutsFormFields("fieldType","parties.admin.featuretype.fieldtype","select",false, true);
new_field.setCollectionProperty("fieldTypes");
new_field.setCollectionLabel("fieldTypesNames");
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("mandatory","parties.admin.featuretype.mandatory","boolean",false, true));
fields.addElement(new StrutsFormFields("readonly","parties.admin.featuretype.readonly","boolean",false, true));
fields.addElement(new StrutsFormFields("hidden","parties.admin.featuretype.hidden","boolean",false, true));
fields.addElement(new StrutsFormFields("automatic","parties.admin.featuretype.automatic","boolean",false, true));
new_field = new StrutsFormFields("rightsNoneRoleIds","parties.admin.featuretype.rights.none","select",false, true);
new_field.setCollectionProperty("roleIds");
new_field.setCollectionLabel("roleNames");
new_field.setMultipleSelection(4);
fields.addElement(new_field);
new_field = new StrutsFormFields("rightsReadOnlyRoleIds","parties.admin.featuretype.rights.read","select",false, true);
new_field.setCollectionProperty("roleIds");
new_field.setCollectionLabel("roleNames");
new_field.setMultipleSelection(4);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("pattern","parties.admin.featuretype.pattern","text",false, true));
fields.addElement(new StrutsFormFields("defaultValue","parties.admin.featuretype.defaultvalue","text",false, true));
fields.addElement(new StrutsFormFields("ruleFile","parties.admin.featuretype.rulefile","text",false, true));
fields.addElement(new StrutsFormFields("groupName","parties.admin.featuretype.groupname","text",false, true));
fields.addElement(new StrutsFormFields("orderIndex","parties.admin.featuretype.orderindex","text",false, true));
new_field = new StrutsFormFields("compType","parties.admin.featuretype.comptype","select",false, true);
new_field.setCollectionProperty("compTypes");
new_field.setCollectionLabel("compTypesNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>
</logic:equal>

<logic:notEqual parameter="loadaction" value="trans">
<%= LanguageUtil.get(pageContext, "parties.admin.form.add-featuretype") %>
<%
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("partyroletypeid","partyroletypeid","text",true, true));
fields.addElement(new StrutsFormFields("langId","langId","text",true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true));
new_field = new StrutsFormFields("name","parties.admin.featuretype.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("fieldcode","parties.admin.featuretype.fieldcode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);new_field = new StrutsFormFields("fieldType","parties.admin.featuretype.fieldtype","select",false);
new_field.setCollectionProperty("fieldTypes");
new_field.setCollectionLabel("fieldTypesNames");
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("mandatory","parties.admin.featuretype.mandatory","boolean",false));
fields.addElement(new StrutsFormFields("readonly","parties.admin.featuretype.readonly","boolean",false));
fields.addElement(new StrutsFormFields("hidden","parties.admin.featuretype.hidden","boolean",false));
fields.addElement(new StrutsFormFields("automatic","parties.admin.featuretype.automatic","boolean",false));
new_field = new StrutsFormFields("rightsNoneRoleIds","parties.admin.featuretype.rights.none","select",false);
new_field.setCollectionProperty("roleIds");
new_field.setCollectionLabel("roleNames");
new_field.setMultipleSelection(4);
fields.addElement(new_field);
new_field = new StrutsFormFields("rightsReadOnlyRoleIds","parties.admin.featuretype.rights.read","select",false);
new_field.setCollectionProperty("roleIds");
new_field.setCollectionLabel("roleNames");
new_field.setMultipleSelection(4);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("pattern","parties.admin.featuretype.pattern","text",false));
fields.addElement(new StrutsFormFields("defaultValue","parties.admin.featuretype.defaultvalue","text",false));
fields.addElement(new StrutsFormFields("ruleFile","parties.admin.featuretype.rulefile","text",false));
fields.addElement(new StrutsFormFields("groupName","parties.admin.featuretype.groupname","text",false));
fields.addElement(new StrutsFormFields("orderIndex","parties.admin.featuretype.orderindex","text",false));
new_field = new StrutsFormFields("compType","parties.admin.featuretype.comptype","select",false);
new_field.setCollectionProperty("compTypes");
new_field.setCollectionLabel("compTypesNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>
</logic:notEqual></h3>



<html:form action="/ext/parties/admin/addFeatureType?actionURL=true" method="post">
<bean:define id="labels1" name="RoleFeatureTypeForm" property="fieldTypesNames"/>
<bean:define id="labels2" name="RoleFeatureTypeForm" property="compTypesNames"/>
<% 
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels1;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}

labelsList = (String[])labels2;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<logic:notEqual parameter="loadaction" value="trans">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/addFeatureType" />
  <tiles:put name="buttonName" value="addButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="RoleFeatureTypeForm" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
</tiles:insert>
</logic:notEqual>

<logic:equal parameter="loadaction" value="trans">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/addFeatureType" />
  <tiles:put name="buttonName" value="addButton" />
  <tiles:put name="buttonValue" value="parties.button.add-translation" />
  <tiles:put name="formName"   value="RoleFeatureTypeForm" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="trans"/>
</tiles:insert>
</logic:equal>

</html:form>
<br>
<%
java.util.HashMap params = new java.util.HashMap();
params.put("partyroletypeid", titleData.getValue("partyroletypeid").toString());
pageContext.setAttribute("paramsName", params);
%>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewFeatureTypes" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.link.featuretypes") %></html:link></TD>
</TR></TABLE>

