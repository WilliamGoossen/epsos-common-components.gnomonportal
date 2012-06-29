<%@ include file="/html/portlet/ext/base/courses/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.base.courses.BsCourseForm" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/courses/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "bs.course.action.update";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/courses/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.course.action.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/courses/add?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "bs.course.action.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/courses/add?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "bs.course.action.add-translation";
}
%>

<h3><%= LanguageUtil.get(pageContext, titleText)  %></h3>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="BsCourseForm"/>
</tiles:insert>

<% if (loadaction != null && !loadaction.equals("add")) { %>

<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.course.teachers") %></legend>
<label></label>

<% List<ViewResult> courseTeachers = (List<ViewResult>)request.getAttribute("courseTeachers"); %>
<table width="40%">
<% if (courseTeachers != null && courseTeachers.size() > 0 ) {
	for (ViewResult p: courseTeachers) { %>
	<% if (hasEdit) { %>
		<td>
			<input type="checkbox" name="partyid" value="<%= p.getMainid().toString() %>">
		</td>
	<% } %>
	<td align="left"><%= p.getField1() %></td></tr>
<% }
 } %>
 <tr><td colspan="2">
 <% if (hasEdit) { %>
 <a href="javascript: document.BsCourseForm.elements['redirect'].value = '<%= currentURL %>'; document.BsCourseForm.action='<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/courses/deleteParties"/>
<portlet:param name="reltype" value="<%= BsCourseForm.COURSE_TEACHER_REL %>"/>
<portlet:param name="courseid" value="<%= formBean.getMainid().toString() %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>'; document.BsCourseForm.submit();">
<img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_minus.gif"> <%= LanguageUtil.get(pageContext, "delete") %></a>
&nbsp;&nbsp;&nbsp;
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/courses/listAvailableParties"/>
<portlet:param name="reltype" value="<%= BsCourseForm.COURSE_TEACHER_REL %>"/>
<portlet:param name="courseid" value="<%= formBean.getMainid().toString() %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_plus.gif""><%= LanguageUtil.get(pageContext, "add") %></a>
<% } %>
</td></tr>
</table>


</fieldset>

<%
String tmimaRole = prefs.getValue("departmentRole", StringPool.BLANK);
if (Validator.isNotNull(tmimaRole) && !tmimaRole.equals("$FREETEXT$")) { %>
<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.course.departments") %></legend>
<label></label>
<% List<ViewResult> courseDepartments = (List<ViewResult>)request.getAttribute("courseDepartments"); %>
<table width="40%">
<% if (courseDepartments != null && courseDepartments.size() > 0 ) {
	for (ViewResult p2: courseDepartments) { %>
	<tr>
	<% if (hasEdit) { %>
		<td>
		<input type="checkbox" name="partyid" value="<%= p2.getMainid().toString() %>">
		</td>
	<% } %>
	<td align="left"><%= p2.getField1() %></td></tr>
<% }
 } %>
<tr><td colspan="2">
<% if (hasEdit) { %>
<a href="javascript: document.BsCourseForm.elements['redirect'].value = '<%= currentURL %>'; document.BsCourseForm.action='<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/courses/deleteParties"/>
<portlet:param name="reltype" value="<%= BsCourseForm.COURSE_DEPARTMENT_REL %>"/>
<portlet:param name="courseid" value="<%= formBean.getMainid().toString() %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>'; document.BsCourseForm.submit();">
<img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_minus.gif"> <%= LanguageUtil.get(pageContext, "delete") %></a>

&nbsp;&nbsp;&nbsp;
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/courses/listAvailableParties"/>
<portlet:param name="reltype" value="<%= BsCourseForm.COURSE_DEPARTMENT_REL %>"/>
<portlet:param name="courseid" value="<%= formBean.getMainid().toString() %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_plus.gif"><%= LanguageUtil.get(pageContext, "add") %></a>
<% } %>
</td></tr>
</table>
</fieldset>
<% } %>

<% } %>

<tiles:insert page="/html/portlet/ext/struts_includes/metaData_div.jsp" flush="true">
	<tiles:put name="formName" value="BsCourseForm"/>
	<tiles:put name="className" value="gnomon.hibernate.model.base.courses.BsCourse"/>
	<%	 if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<% if (loadaction == null || loadaction.equals("crossPublish") || loadaction.equals("view")  || loadaction.equals("delete") ) { %>
	<tiles:put name="readOnly" value="true"/>
	<% } %>
</tiles:insert>


<div class="button-holder">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="BsCourseForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/courses/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="BsCourseForm" />
		  <tiles:put name="confirm" value="gn.messages.are-you-sure-you-want-to-delete-this-translation"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>
</div>
</html:form>


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2"><%= LanguageUtil.get(pageContext, "gn.translations" ) %></h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/courses/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/courses/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>
