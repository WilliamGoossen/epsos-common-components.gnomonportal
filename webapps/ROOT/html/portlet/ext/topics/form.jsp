<%@ include file="/html/portlet/ext/topics/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/topics/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "gn.topics.action.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/topics/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "gn.topics.action.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/topics/add?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "gn.topics.action.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/topics/add?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "gn.topics.action.add-translation";
}
ViewResult rootTopic = (ViewResult) request.getAttribute("rootTopic");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="GnTopicForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>
</table>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>



<logic:notEqual name="GnTopicForm" property="lang" value="<%= defLang %>">
<% if (!loadaction.equals("trans")) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/topics/delete" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
  <tiles:put name="formName"   value="GnTopicForm" />
  <tiles:put name="confirm" value="gn.topics.are-you-sure-you-want-to-delete-this-translation"/>
  <tiles:put name="actionParam" value="deleteDetail"/>
  <tiles:put name="actionParamValue" value="1"/>
</tiles:insert>
<% } %>
</logic:notEqual>
</html:form>
<br>
<% if (loadaction != null && loadaction.equals("edit")) { %>
<p>
<h3 class="title2">Translations</h3>
<p>

<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
	<tiles:put name="editAction"  value="/ext/topics/load" />
	<tiles:put name="editActionParam" value="loadaction"/>
    <tiles:put name="editActionParamValue" value="edit"/>
    <tiles:put name="addAction"  value="/ext/topics/load" />
	<tiles:put name="addActionParam" value="loadaction"/>
    <tiles:put name="addActionParamValue" value="trans"/>
</tiles:insert>

<% } %>

<br>
<%--
java.util.HashMap paramsHash = new java.util.HashMap();
if (rootTopic != null)
	paramsHash.put("mainid", rootTopic.getMainid().toString());
pageContext.setAttribute("params", paramsHash);
%>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR>
<TD>
<html:link styleClass="beta1" action="/ext/topics/view" name="params"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.topics.action.list") %></html:link>
</TD>
</TR>
</TABLE>
--%>