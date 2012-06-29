<%@ include file="/html/portlet/ext/base/smslists/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>


<%
String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/smslists/updateSubscriber?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "bs.smslists.action.update-subscriber";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/smslists/deleteSubscriber?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.smslists.action.delete-subscriber";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/smslists/addSubscriber?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "bs.smslists.action.add-subscriber";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/smslists/addSubscriber?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "bs.smslists.action.add-subscriber-translation";
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>


<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="BsSmsListSubscriberForm"/>
</tiles:insert>

<div class="button-holder">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

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