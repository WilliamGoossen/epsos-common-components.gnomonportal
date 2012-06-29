<%@ include file="/html/portlet/ext/crm/devices/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.portlet.crm.devices.assignments.CrDeviceAssignmentForm" %>

<%
Integer crmDeviceId = (Integer)request.getAttribute("crmDeviceId");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/devices/updateAssignment?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.device.assignment.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/devices/deleteAssignment?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.device.assignment.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/crm/devices/addAssignment?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.device.assignment.add";
}

%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="redirect" value="<%= redirect %>">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="CrDeviceAssignmentForm"/>
</tiles:insert>
<br>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>


<%
java.util.HashMap map = new java.util.HashMap();
map.put("crmDeviceId", crmDeviceId.toString());
map.put("redirect", redirect);
pageContext.setAttribute("params", map);
%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/devices/listAssignments" name="params"><%= LanguageUtil.get(pageContext, "crm.device.assignment.list") %></html:link>


