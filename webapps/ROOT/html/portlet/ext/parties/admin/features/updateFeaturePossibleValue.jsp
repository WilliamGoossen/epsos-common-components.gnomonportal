<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.form.update-feature-possiblevalue") %></h3>


<% try {
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="RoleFeaturePossibleValueForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("featuretypeid","featuretypeid","text",true));
fields.addElement(new StrutsFormFields("partyroletypeid","partyroletypeid","text",true));
fields.addElement(new StrutsFormFields("langid","langid","text",true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true));
new_field = new StrutsFormFields("name","parties.admin.featurepossiblevalue.name","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/admin/updateFeaturePossibleValue?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 

<logic:notEqual name="RoleFeaturePossibleValueForm" property="lang" value="<%= defLang %>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/deleteFeaturePossibleValue" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="parties.button.delete-translation" />
  <tiles:put name="formName"   value="RoleFeaturePossibleValueForm" />
  <tiles:put name="confirm" value="are-you-sure-you-want-to-delete-this-translation"/>
  <tiles:put name="actionParam" value="deleteDetail"/>
  <tiles:put name="actionParamValue" value="1"/>
</tiles:insert>
</logic:notEqual>
</html:form>
<bean:define id="mainid" name="RoleFeaturePossibleValueForm" property="mainid"/>
<br>
<p>
<h3>Translations</h3>
<p>

<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
	<tiles:put name="editAction"  value="/ext/parties/admin/loadFeaturePossibleValue" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="view"/>
    <tiles:putList name="editActionParamList">
    	<tiles:add value="mainid"/>
    	<tiles:add value="featuretypeid"/>
    	<tiles:add value="partyroletypeid"/>
    </tiles:putList>
    <tiles:putList name="editActionParamValueList">
    	<tiles:add><%= mainid %></tiles:add>
    	<tiles:add><%= titleData.getValue("featuretypeid").toString() %></tiles:add>
    	<tiles:add><%= titleData.getValue("partyroletypeid").toString() %></tiles:add>
    </tiles:putList>
    <tiles:put name="addAction"  value="/ext/parties/admin/loadFeaturePossibleValue" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
    <tiles:putList name="addActionParamList">
    	<tiles:add value="mainid"/>
    	<tiles:add value="featuretypeid"/>
    	<tiles:add value="partyroletypeid"/>
    </tiles:putList>
    <tiles:putList name="addActionParamValueList">
    	<tiles:add><%= mainid %></tiles:add>
    	<tiles:add><%= titleData.getValue("featuretypeid").toString() %></tiles:add>
    	<tiles:add><%= titleData.getValue("partyroletypeid").toString() %></tiles:add>
    </tiles:putList>
</tiles:insert>

<%
java.util.HashMap params = new java.util.HashMap();
params.put("mainid", titleData.getValue("featuretypeid").toString());
params.put("partyroletypeid", titleData.getValue("partyroletypeid").toString());
pageContext.setAttribute("paramsName", params);
%>
<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/listFeaturePossibleValues" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.link.feature.possiblevalues") %></html:link></TD>
</TR></TABLE>

<% } catch (Exception e) {e.printStackTrace(); } %>
