<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<table>
<tr>
<td valign="top">
<%
String chartid = (String) request.getParameter("chartid");
com.ext.portlet.parties.orgchart.util.LoadTreeDescriptionHelper.render(request);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td valign="top">
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>
<% String partyid = (String)titleData.getValue("partyid"); %>

<h3  class="title1">
<%= LanguageUtil.get(pageContext, "parties.manager.form.update-identifier") %></h3>


<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="PartyIdentifierForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("partyid","partyid","text",true));
new_field = new StrutsFormFields("identifierType","parties.manager.identifier.identifiertype","select",false);
new_field.setCollectionProperty("identifierTypes");
new_field.setCollectionLabel("identifierTypeKeys");
fields.addElement(new_field);
new_field = new StrutsFormFields("identifier","parties.manager.identifier.identifier","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("registrationAuthority","parties.manager.identifier.registrationauthority","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
/*new_field = new StrutsFormFields("validFrom","parties.manager.identifier.validfrom","date",false);
new_field.setDateFormat("%d/%m/%Y");
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("validTo","parties.manager.identifier.validto","date",false);
new_field.setDateFormat("%d/%m/%Y");
new_field.setRequired(true);
fields.addElement(new_field);*/
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/orgchart/updatePartyIdentifier?actionURL=true" method="post">
<bean:define id="labels" name="PartyIdentifierForm" property="identifierTypeKeys"/>
<% 
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<input type="hidden" name="chartid" value="<%=chartid%>">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 

</html:form>

<%@ include file="/html/portlet/ext/parties/orgchart/party/addressFooter.jsp" %>
</td>
</tr>
</table>