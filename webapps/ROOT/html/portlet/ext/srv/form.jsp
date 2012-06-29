<%@ include file="/html/portlet/ext/srv/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
	
String metadataClassId = request.getParameter("metadataClassId");
if (Validator.isNull(metadataClassId))
	metadataClassId = (String)request.getAttribute("metadataClassId");

String metaDataClass = (String)request.getAttribute("metaDataClass");

String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/srv/update?actionURL=true" ;
String buttonText = "srv.button.update";
String titleText = "srv.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/srv/delete?actionURL=true" ;
 	buttonText = "srv.button.delete";
 	titleText = "srv.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/srv/add?actionURL=true" ;
	buttonText = "srv.button.add";
	titleText = "srv.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/srv/add?actionURL=true" ;
	buttonText = "srv.button.add-translation";
	titleText = "srv.add-translation";
}

com.ext.portlet.srv.SrvServiceForm srvForm = (com.ext.portlet.srv.SrvServiceForm) request.getAttribute("SrvServiceForm");
%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<% if (!Validator.isNull(loadaction) && loadaction.equals("add")) { %>
<input type="hidden" name="metadataClassId" value="<%= metadataClassId %>">
<% }  %>

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="SrvServiceForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>







</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="SrvServiceForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/srv/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="srv.button.delete-translation" />
		  <tiles:put name="formName"   value="SrvServiceForm" />
		  <tiles:put name="confirm" value="srv.button.delete-translation-are-you-sure"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

</html:form>

<% if (loadaction!=null && !loadaction.equals("add") ) { %>
	<br>
	<a href = "<liferay-portlet:actionURL portletName="SRV_SERVICE_REPORTS" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/srv_reports/list"/>
	<liferay-portlet:param name="serviceid" value="<%=srvForm.getMainid().toString()%>"/></liferay-portlet:actionURL>">
	<%=LanguageUtil.get(pageContext,"view-service-reports")%></a>
	
	
<%}%>


<br>

<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta" action="/ext/srv/list"><img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "srv.list") %></html:link></TD>
</TR></TABLE>




<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3  >Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/srv/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/srv/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<%
} catch (Exception e) {e.printStackTrace(); } %>
