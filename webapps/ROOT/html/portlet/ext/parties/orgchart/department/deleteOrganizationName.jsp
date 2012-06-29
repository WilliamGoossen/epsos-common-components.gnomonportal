<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<table>
<tr>
<td valign="top" width="30%">
<%
String chartid = (String) request.getParameter("chartid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td width="70%" valign="top">
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>
<% String organizationid = (String)titleData.getValue("organizationid"); %>

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.orgchart.form.delete-department-name") %></h3>

<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="OrganizationNameForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true, true));
fields.addElement(new StrutsFormFields("langid","langid","text",true, true));
fields.addElement(new StrutsFormFields("organizationid","organizationid","text",true, true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false,true));
fields.addElement(new StrutsFormFields("name","parties.orgchart.department.name","text",false, true));
new_field = new StrutsFormFields("validFrom","parties.manager.organization.validfrom","date",false, true);
new_field.setDateFormat("%d/%m/%Y");
fields.addElement(new_field);
new_field = new StrutsFormFields("validTo","parties.manager.organization.validto","date",false, true);
new_field.setDateFormat("%d/%m/%Y");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>
<html:form action="/ext/parties/orgchart/deleteOrganizationName?actionURL=true" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<input type="hidden" name="chartid" value="<%=chartid%>">
<input type="hidden" name="partyid" value="<%=organizationid%>">

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.delete") %></html:submit>

</html:form>
<p><br>

<%
java.util.HashMap params = new java.util.HashMap();
params.put("organizationid", organizationid);
params.put("partyid", organizationid);
params.put("chartid", chartid);
pageContext.setAttribute("paramsName", params);
%>

<html:link styleClass="beta1" action="/ext/parties/orgchart/listOrganizationNames" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.orgchart.back-to-department-names") %></html:link>
</td>
</tr>
</table>

