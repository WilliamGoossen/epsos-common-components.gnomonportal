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
String formUrl = "/ext/payment/pay_form/pay?actionURL=true" ;
String buttonText = "pmt.pay_form.button.continue";
String titleText = "pmt.pay_form.action.pay"; 

%>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>
<% if (!Validator.isNull(loadaction) && loadaction.equals("add")) { %>
<input type="hidden" name="metadataClassId" value="<%= metadataClassId %>">
<% }  %>
 
<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="PmtForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>

<%
com.ext.portlet.payment.pay_form.PmtForm formBean=null;
if (Validator.isNotNull(metaDataClass)) {  %>
<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="PmtForm"/>
	<tiles:put name="className"><%= metaDataClass %></tiles:put>
	<% formBean = (com.ext.portlet.payment.pay_form.PmtForm) request.getAttribute("PmtForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>
<% }  %>
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


