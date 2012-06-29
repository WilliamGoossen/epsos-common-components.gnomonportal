<%@ include file="/html/portlet/ext/srv/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
	

String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/srv_actions/update?actionURL=true" ;
String buttonText = "srv.button.update";
String titleText = "srv.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/srv_actions/delete?actionURL=true" ;
 	buttonText = "srv.button.delete";
 	titleText = "srv.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/srv_actions/add?actionURL=true" ;
	buttonText = "srv.button.add";
	titleText = "srv.add";
}


com.ext.portlet.srv.actions.SrvServiceActionForm srvForm = (com.ext.portlet.srv.actions.SrvServiceActionForm) request.getAttribute("SrvServiceActionForm");
%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="SrvServiceActionForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>







</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>



</html:form>




<br>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta" action="/ext/srv_actions/list"><img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "srv.list") %></html:link></TD>
</TR></TABLE>




<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3  >Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/srv_actions/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/srv_actions/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<%
} catch (Exception e) {e.printStackTrace(); } %>
