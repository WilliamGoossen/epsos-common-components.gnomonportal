<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.parties.contacts.groups.PaPartyGroupForm" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/parties/contacts/updateGroup?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "contacts.group.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/parties/contacts/deleteGroup?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "contacts.group.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/parties/contacts/addGroup?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "contacts.group.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/parties/contacts/addGroup?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "contacts.group.add-translation";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("view"))
{
	formUrl = "/ext/parties/contacts/loadGroup?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "contacts.group.view";
}
%>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>


<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="PaPartyGroupForm"/>
</tiles:insert>

<c:if test="<%= !loadaction.equals("view") && (hasPublish || hasEdit || hasDelete) %>">

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="PaPartyGroupForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/parties/contacts/deleteGroup" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="PaPartyGroupForm" />
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

</c:if>

</html:form>


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2"><%= LanguageUtil.get(pageContext, "gn.translations" ) %></h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/parties/contacts/loadGroup" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/parties/contacts/loadGroup" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<br>

<br>
<% if (!loadaction.equals("add")) {
	String groupid = (String)request.getAttribute("groupid"); 
	List groupMembers = (List)request.getAttribute("groupMembers");
	String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";

%>
<h2><%= LanguageUtil.get(pageContext, "contacts.group.member.list") %></h2>
<%@ include file="/html/portlet/ext/parties/contacts/groups/members/memberList.jspf" %>
<% } %>

<br>

<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/contacts/listGroups"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "contacts.group.list") %></a>