<%@ include file="/html/portlet/ext/base/events/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/eventlocations/updateRoom?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "bs.events.room.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/eventlocations/deleteRoom?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.events.room.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/eventlocations/addRoom?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "bs.events.room.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/eventlocations/addRoom?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "bs.events.room.add-translation";
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="EvRoomForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>
</table>

<br>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="EvRoomForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/eventlocations/deleteRoom" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="EvRoomForm" />
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

</html:form>


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2"><%= LanguageUtil.get(pageContext, "gn.translations" ) %></h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/eventlocations/loadRoom" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/eventlocations/loadRoom" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>