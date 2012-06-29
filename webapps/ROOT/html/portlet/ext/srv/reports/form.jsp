<%@ include file="/html/portlet/ext/srv/reports/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/srv_reports/update?actionURL=true" ;
String buttonText = "srv.button.reports.update";
String titleText = "srv.reports.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/srv_reports/delete?actionURL=true" ;
 	buttonText = "srv.button.delete";
 	titleText = "srv.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/srv_reports/add?actionURL=true" ;
	buttonText = "srv.reports.button.add";
	titleText = "srv.reports.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/srv_reports/add?actionURL=true" ;
	buttonText = "srv.reports.button.add-translation";
	titleText = "srv.reports.add-translation";
}

com.ext.portlet.srv.reports.SrvServiceReportForm srvForm = (com.ext.portlet.srv.reports.SrvServiceReportForm) request.getAttribute("SrvServiceReportForm");
%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">


<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="SrvServiceReportForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>
</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>


</html:form>



<br>
<br>


 <%
           java.util.HashMap params= new java.util.HashMap();
           params.put("serviceid",srvForm.getServiceId());
          
           pageContext.setAttribute("paramsName", params);
           
         %>  

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta" action="/ext/srv_reports/list" name="paramsName">
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "crm.srv.reports.list") %></html:link></TD>
</TR></TABLE>


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3  >Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/srv_reports/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/srv_reports/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<%
} catch (Exception e) {e.printStackTrace(); } %>
