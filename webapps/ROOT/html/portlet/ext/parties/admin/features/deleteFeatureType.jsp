<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.form.delete-featuretype") %></h3>

<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="RoleFeatureTypeForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true, true));
fields.addElement(new StrutsFormFields("langId","langId","text",true, true));
fields.addElement(new StrutsFormFields("partyroletypeid","partyroletypeid","text",true, true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true));
fields.addElement(new StrutsFormFields("name","parties.admin.featuretype.name","text",false, true));
fields.addElement(new StrutsFormFields("fieldcode","parties.admin.featuretype.fieldcode","text",false, true));
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
<html:form action="/ext/parties/admin/deleteFeatureType?actionURL=true" method="post">
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
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.delete") %></html:submit>

</html:form>
<p><br>
<%
java.util.HashMap params = new java.util.HashMap();
params.put("partyroletypeid", titleData.getValue("partyroletypeid").toString());
pageContext.setAttribute("paramsName", params);
%>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewFeatureTypes" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.link.featuretypes") %></html:link></TD>
</TR></TABLE>


