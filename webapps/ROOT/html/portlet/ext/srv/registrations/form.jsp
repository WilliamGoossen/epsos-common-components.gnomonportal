<%@ include file="/html/portlet/ext/srv/registrations/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<liferay-ui:success key="srv.registration.success.msg" message="srv.registration.success.msg" />
<c:if test="<%= themeDisplay.isSignedIn() %>">
<%
try {
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/srv_registrations/update?actionURL=true" ;
String buttonText = "srv.registrations.button.update";
String titleText = "srv.registrations.edit";

String isOneAspect=(String) request.getAttribute("isOneAspect");
Integer classId=0;
classId = (Integer) request.getAttribute("classId");
String className=(String)request.getAttribute("className");

String singleServiceSubmitted=(String)request.getAttribute("singleServiceSubmitted");

Boolean all_services =(Boolean) request.getAttribute("all_services");
boolean loadPhase = false;

if(Validator.isNull(loadaction)){
	loadaction="add";
	loadPhase = true;
}
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/srv_registrations/delete?actionURL=true" ;
 	buttonText = "srv.registrations.button.delete";
 	titleText = "srv.registrations.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/srv_registrations/add?actionURL=true" ;
	buttonText = "srv.registrations.button.add";
	titleText = "srv.registrations.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/srv_registrations/add?actionURL=true" ;
	buttonText = "srv.registrations.button.add-translation";
	titleText = "srv.registrations.add-translation";
}
%>

<%--
<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<h4> <%= LanguageUtil.get(pageContext, "srv.registrations.registrationSummary") %></h4>
--%>
<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<%if(isOneAspect.equals("0") ) {
if(Validator.isNull(singleServiceSubmitted))
buttonText = "select";

%>
<input type="hidden" name="single_selection" value="1">
<%}%>
<%if(Validator.isNotNull(singleServiceSubmitted)) {%>
<input type="hidden" name="singleServiceSubmitted" value="1">
<%}%>





<table border="0"  >
	
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="SrvServiceRegistrationForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>



<% if(all_services==null || all_services!=true) {%>

<%
com.ext.portlet.srv.registrations.SrvServiceRegistrationForm formBean=null;
if (Validator.isNotNull(classId) && classId!=0) {  %>
<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="SrvServiceRegistrationForm"/>
	<tiles:put name="className"><%= className %></tiles:put>
	<% formBean = (com.ext.portlet.srv.registrations.SrvServiceRegistrationForm) request.getAttribute("SrvServiceRegistrationForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="noTable" value="true"/>
	<tiles:put name="keepValuesOnValidationError" value="true"/>
</tiles:insert>
<% }  %>



</table>



<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>
<%} else {%>
	</table>
<%}%>

</html:form>
<br>
<!-- 
<%= LanguageUtil.get(pageContext, "srv.registration.msg") %>
 -->
 
<BR>
<%if (!loadPhase){ %>
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/srv_registrations/load"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png">
<%= LanguageUtil.get(pageContext, "srv.back") %>
</a>
<BR>
<%} %>




<%
} catch (Exception e) {
	System.out.println("ERROR=" + e.getMessage());
	e.printStackTrace(); } %>
</c:if>
<c:if test="<%= !themeDisplay.isSignedIn() %>">
<div class="journal-content-article">
<%= LanguageUtil.get(pageContext, "srv.you-have-to-login") %>
</div>
</c:if>