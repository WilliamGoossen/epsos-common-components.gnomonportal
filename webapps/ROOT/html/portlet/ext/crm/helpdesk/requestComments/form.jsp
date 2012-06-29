<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.portlet.crm.helpdesk.requestComments.CrRequestCommentForm" %>

<%
Integer requestid = (Integer)request.getAttribute("requestid");
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/helpdesk/updateRequestComment?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.helpdesk.request.comment.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/helpdesk/deleteRequestComment?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.helpdesk.request.comment.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/crm/helpdesk/addRequestComment?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.helpdesk.request.comment.add";
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="my_redirect" value="<%= redirect %>">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="CrRequestCommentForm"/>
</tiles:insert>
<br>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">
</html:form>
<br>


<%
java.util.HashMap map = new java.util.HashMap();
map.put("requestid", requestid.toString());
map.put("redirect", redirect);
pageContext.setAttribute("params", map);
%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/helpdesk/listRequestComments" name="params"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %></html:link>


