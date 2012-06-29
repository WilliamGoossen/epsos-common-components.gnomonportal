<%@ include file="/html/portlet/ext/crm/devicealerts/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.portlet.crm.devicealerts.CrDeviceAlertForm" %>

<%
Integer deviceAlertId = (Integer)request.getAttribute("deviceAlertId");
String newStatus = request.getParameter("newStatus");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/devicealerts/updateComment?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.devicealert.comment.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/devicealerts/deleteComment?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.devicealert.comment.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/crm/devicealerts/addComment?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.devicealert.comment.add";
}

if (Validator.isNotNull(newStatus)) {
	if (newStatus.equals(CrDeviceAlertForm.STATUS_2))
		titleText = "crm.devicealert.dispatch";
	else if (newStatus.equals(CrDeviceAlertForm.STATUS_3))
		titleText = "crm.devicealert.close";
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
<c:if test="<%=Validator.isNotNull(newStatus) %>">
<input type="hidden" name="newStatus" value="<%= newStatus %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="CrDeviceAlertCommentForm"/>
</tiles:insert>
<br>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>


<%
if (Validator.isNotNull(newStatus)) {
	%>
	<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "crm.devicealert.list") %></a>	
<%
}
else
{
java.util.HashMap map = new java.util.HashMap();
map.put("deviceAlertId", deviceAlertId.toString());
map.put("redirect", redirect);
pageContext.setAttribute("params", map);
%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/devicealerts/listComments" name="params"><%= LanguageUtil.get(pageContext, "crm.devicealert.comment.list") %></html:link>
<% } %>

