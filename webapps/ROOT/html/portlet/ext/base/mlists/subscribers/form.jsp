<%@ include file="/html/portlet/ext/base/mlists/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>


<%
String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/mlists/updateSubscriber?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "bs.mlists.action.update-subscriber";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/mlists/deleteSubscriber?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.mlists.action.delete-subscriber";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/mlists/addSubscriber?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "bs.mlists.action.add-subscriber";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/mlists/addSubscriber?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "bs.mlists.action.add-subscriber-translation";
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input alt=" " type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input alt=" " type="hidden" name="redirect" value="<%= redirect %>">
</c:if>


<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="BsMListSubscriberForm"/>
</tiles:insert>

<div class="button-holder">

<html:submit alt="Submit" styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input alt="<%= LanguageUtil.get(pageContext, "cancel") %>" class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input alt="<%= LanguageUtil.get(pageContext, "back") %>" class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>
</div>

</html:form>