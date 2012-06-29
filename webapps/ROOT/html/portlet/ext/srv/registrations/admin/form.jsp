<%@ include file="/html/portlet/ext/srv/registrations/admin/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/srv_adminregistrations/update?actionURL=true" ;
String buttonText = "srv.adminregistrations.button.update";
String titleText = "srv.adminregistrations.edit";

Integer classId=0;
classId = (Integer) request.getAttribute("classId");

String className=(String)request.getAttribute("className");
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/srv_adminregistrations/delete?actionURL=true" ;
 	buttonText = "srv.adminregistrations.button.delete";
 	titleText = "srv.adminregistrations.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/srv_adminregistrations/add?actionURL=true" ;
	buttonText = "srv.adminregistrations.button.add";
	titleText = "srv.adminregistrations.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/srv_adminregistrations/add?actionURL=true" ;
	buttonText = "srv.adminregistrations.button.add-translation";
	titleText = "srv.adminregistrations.add-translation";
}
%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>


<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<bean:define id="labels" name="SrvServiceAdminRegistrationForm" property="statusNames"/>
<% 
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>
<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="SrvServiceAdminRegistrationForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>




<%
com.ext.portlet.srv.registrations.admin.SrvServiceAdminRegistrationForm formBean=null;
if (Validator.isNotNull(classId) && classId!=0) {  %>
<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="SrvServiceAdminRegistrationForm"/>
	<tiles:put name="className"><%= className %></tiles:put>
	<% formBean = (com.ext.portlet.srv.registrations.admin.SrvServiceAdminRegistrationForm) request.getAttribute("SrvServiceAdminRegistrationForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>
<% }  %>


</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>


</html:form>




<%--
<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3  >Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/srv_registrations/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/srv_registrations/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>
--%>
<%
} catch (Exception e) {e.printStackTrace(); } %>
