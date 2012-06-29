<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<table>
<tr>
<td valign="top" width="30%">
<%
String chartid = (String) request.getParameter("chartid");
String partyid = (String) request.getParameter("partyid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top">
<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.orgchart.form.add-department") %></h3>


<% 
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="OrganizationAddForm";
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("name","parties.orgchart.department.name","text",false);
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
new_field = new StrutsFormFields("typeid","parties.orgchart.department.typeid","select",false);
new_field.setCollectionProperty("typeIds");
new_field.setCollectionLabel("typeNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/orgchart/addOrganization?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=partyid%>">

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.add") %></html:submit> 
 
</html:form>

</td>
</tr>
</table>