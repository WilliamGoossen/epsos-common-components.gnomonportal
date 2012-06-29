<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>


<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.form.update-featuretype") %></h3>

<bean:define id="formLang" name="RoleFeatureTypeForm" property="lang" />

<%
String loadaction = request.getParameter("loadaction");

boolean transFlag = !defLang.equals(formLang);

StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="RoleFeatureTypeForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true, transFlag));
fields.addElement(new StrutsFormFields("partyroletypeid","partyroletypeid","text",true, transFlag));
fields.addElement(new StrutsFormFields("langId","langId","text",true, transFlag));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true, transFlag));
new_field = new StrutsFormFields("name","parties.admin.featuretype.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("fieldcode","parties.admin.featuretype.fieldcode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("fieldType","parties.admin.featuretype.fieldtype","select",false, transFlag);
new_field.setCollectionProperty("fieldTypes");
new_field.setCollectionLabel("fieldTypesNames");
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("mandatory","parties.admin.featuretype.mandatory","boolean",false, transFlag));
fields.addElement(new StrutsFormFields("readonly","parties.admin.featuretype.readonly","boolean",false, transFlag));
fields.addElement(new StrutsFormFields("hidden","parties.admin.featuretype.hidden","boolean",false, transFlag));
fields.addElement(new StrutsFormFields("automatic","parties.admin.featuretype.automatic","boolean",false, transFlag));
new_field = new StrutsFormFields("rightsNoneRoleIds","parties.admin.featuretype.rights.none","select",false, transFlag);
new_field.setCollectionProperty("roleIds");
new_field.setCollectionLabel("roleNames");
new_field.setMultipleSelection(4);
fields.addElement(new_field);
new_field = new StrutsFormFields("rightsReadOnlyRoleIds","parties.admin.featuretype.rights.read","select",false, transFlag);
new_field.setCollectionProperty("roleIds");
new_field.setCollectionLabel("roleNames");
new_field.setMultipleSelection(4);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("pattern","parties.admin.featuretype.pattern","text",false, transFlag));
fields.addElement(new StrutsFormFields("defaultValue","parties.admin.featuretype.defaultvalue","text",false, transFlag));
fields.addElement(new StrutsFormFields("ruleFile","parties.admin.featuretype.rulefile","text",false, transFlag));
fields.addElement(new StrutsFormFields("groupName","parties.admin.featuretype.groupname","text",false, transFlag));
fields.addElement(new StrutsFormFields("orderIndex","parties.admin.featuretype.orderindex","text",false, transFlag));
new_field = new StrutsFormFields("compType","parties.admin.featuretype.comptype","select",false, transFlag);
new_field.setOnChange("return _PARTIES_ADMIN_FEATURETYPES_changeCompType();");
new_field.setCollectionProperty("compTypes");
new_field.setCollectionLabel("compTypesNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);

%>

<html:form action="/ext/parties/admin/updateFeatureType?actionURL=true" method="post">
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
<SCRIPT LANGUAGE="JavaScript">
function _PARTIES_ADMIN_FEATURETYPES_changeCompType() {
	if (document.RoleFeatureTypeForm.elements["compType"].value == "<%= com.ext.util.FieldsMetaData.COMPTYPE_SELECT %>")
	{
		document.RoleFeatureTypeForm.elements["listPossibleValuesButton"].disabled = false;
		document.RoleFeatureTypeForm.elements["listPossibleValuesButton"].className = "portlet-form-button";
	}
	else
	{
		document.RoleFeatureTypeForm.elements["listPossibleValuesButton"].disabled = true;
		document.RoleFeatureTypeForm.elements["listPossibleValuesButton"].className = "gamma1-FormButtonDisable";
	}
	return true;
}
</SCRIPT>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/listFeaturePossibleValues" />
  <tiles:put name="buttonName" value="listPossibleValuesButton" />
  <tiles:put name="buttonValue" value="parties.button.list-possible-values" />
  <tiles:put name="formName"   value="RoleFeatureTypeForm" />
</tiles:insert>

<SCRIPT LANGUAGE="JavaScript"> _PARTIES_ADMIN_FEATURETYPES_changeCompType(); </SCRIPT>

<br><br>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 

<logic:notEqual name="RoleFeatureTypeForm" property="lang" value="<%= defLang %>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/deleteFeatureType" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="parties.button.delete-translation" />
  <tiles:put name="formName"   value="RoleFeatureTypeForm" />
  <tiles:put name="confirm" value="are-you-sure-you-want-to-delete-this-translation"/>
  <tiles:put name="actionParam" value="deleteDetail"/>
  <tiles:put name="actionParamValue" value="1"/>
</tiles:insert>
</logic:notEqual>

</html:form>

<br>
<p>
<h3>Translations</h3>
<p>

<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
	<tiles:put name="editAction"  value="/ext/parties/admin/loadFeatureType" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="view"/>
    <tiles:putList name="editActionParamList">
    	<tiles:add value="partyroletypeid"/>
    </tiles:putList>
    <tiles:putList name="editActionParamValueList">
    	<tiles:add><%= titleData.getValue("partyroletypeid").toString() %></tiles:add>
    </tiles:putList>
    <tiles:put name="addAction"  value="/ext/parties/admin/loadFeatureType" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
    <tiles:putList name="addActionParamList">
    	<tiles:add value="partyroletypeid"/>
    </tiles:putList>
    <tiles:putList name="addActionParamValueList">
    	<tiles:add><%= titleData.getValue("partyroletypeid").toString() %></tiles:add>
    </tiles:putList>
</tiles:insert>

<br>
<%
java.util.HashMap params = new java.util.HashMap();
params.put("partyroletypeid", titleData.getValue("partyroletypeid").toString());
pageContext.setAttribute("paramsName", params);
%>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewFeatureTypes" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.link.featuretypes") %></html:link></TD>
</TR></TABLE>


