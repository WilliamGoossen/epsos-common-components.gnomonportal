<%@ include file="/html/portlet/ext/crm/tasks/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.portlet.crm.tasks.CrTaskForm" %>

<%
Integer taskid = (Integer)request.getAttribute("taskid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/tasks/updateComment?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.task.comment.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/tasks/deleteComment?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.task.comment.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/crm/tasks/addComment?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.task.comment.add";
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="my_redirect" value="<%= redirect %>">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="CrTaskCommentForm"/>
</tiles:insert>
<br>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>


<%
java.util.HashMap map = new java.util.HashMap();
map.put("taskid", taskid.toString());
map.put("redirect", redirect);
pageContext.setAttribute("params", map);
%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/tasks/listComments" name="params"><%= LanguageUtil.get(pageContext, "crm.task.comment.list") %></html:link>


