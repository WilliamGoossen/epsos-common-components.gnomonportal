<%@ include file="/html/portlet/ext/payment/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
String metadataClassId = request.getParameter("metadataClassId");
if (Validator.isNull(metadataClassId))
	metadataClassId = (String)request.getAttribute("metadataClassId");

String loadaction = (String)request.getAttribute("loadaction");
String metaDataClass = (String)request.getAttribute("metaDataClass");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/payment/service_payment_type/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "pmt.service_payment_type.action.update";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/payment/service_payment_type/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "pmt.service_payment_type.action.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/payment/service_payment_type/add?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "pmt.service_payment_type.action.add";
}

%>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="PmtSrvPmtTypeForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>

</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>


<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>

</html:form>



