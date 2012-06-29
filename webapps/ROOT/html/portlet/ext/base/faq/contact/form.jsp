<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
%>

<c:choose>
	<c:when test="<%=(Validator.isNull(loadaction) || loadaction.equals("add"))%>">
		<tiles:insert page="/html/portlet/ext/base/faq/contact/addForm.jsp" flush="true"/>
	</c:when>
	<c:otherwise>
		<tiles:insert page="/html/portlet/ext/base/faq/contact/editForm.jsp" flush="true"/>
	</c:otherwise>
</c:choose>