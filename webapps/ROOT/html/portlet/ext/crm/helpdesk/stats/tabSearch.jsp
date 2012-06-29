<%@ include file="/html/portlet/ext/crm/helpdesk/stats/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>


<h2><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.searchform2") %></h2>


<%
StrutsFormFields new_field=null;
java.util.Vector<StrutsFormFields> fields=new java.util.Vector<StrutsFormFields>();
String curFormName="CrRequestXTabStatsForm";
new_field = new StrutsFormFields("reqDateFrom","crm.helpdesk.request.date-from","date",false,false);
new_field.setDateFormat(com.ext.util.CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDateTo","crm.helpdesk.request.date-to","date",false,false);
new_field.setDateFormat(com.ext.util.CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
new_field = new StrutsFormFields("status","crm.helpdesk.request.status","select",false,false);
new_field.setCollectionProperty("statusIds");
new_field.setCollectionLabel("statusKeys");
fields.addElement(new_field);
new_field = new StrutsFormFields("categoryid","crm.helpdesk.request.category","select",false,false);
new_field.setCollectionLabel("categoryNames");
new_field.setCollectionProperty("categoryIds");
fields.addElement(new_field);
new_field = new StrutsFormFields("officerid","crm.helpdesk.category.officerid","select",false,false);
new_field.setCollectionLabel("officerNames");
new_field.setCollectionProperty("officerIds");
fields.addElement(new_field);
new_field = new StrutsFormFields("departmentid","crm.helpdesk.category.departmentid","select",false,false);
new_field.setCollectionLabel("departmentNames");
new_field.setCollectionProperty("departmentIds");
fields.addElement(new_field);

request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/crm/helpdeskStats/listStats?actionURL=true" method="post">
<bean:define id="labels" name="CrRequestXTabStatsForm" property="statusKeys"/>
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
<input type="hidden" name="search" value="true">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "crm.button.submit") %></html:submit> 

</html:form>

<br />

<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;<a href="<portlet:renderURL><portlet:param name="struts_action" value="/ext/crm/helpdeskStats/view"/></portlet:renderURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.back-to-search") %></a></li>

