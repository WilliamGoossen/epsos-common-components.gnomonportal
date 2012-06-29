<%@ include file="/html/portlet/ext/base/documents/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
//com.ext.portlet.base.documents.BsDocumentForm aFormBean = (com.ext.portlet.base.documents.BsDocumentForm)request.getAttribute("BsDocumentForm");
//System.out.println(aFormBean.toString());

String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/documents/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "bs.documents.action.update";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/documents/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.documents.action.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/documents/add?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "bs.documents.action.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/documents/add?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "bs.documents.action.add-translation";
}

com.ext.portlet.base.documents.BsDocumentForm formBean = (com.ext.portlet.base.documents.BsDocumentForm) request.getAttribute("BsDocumentForm");
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
<tiles:put name="formName" value="BsDocumentForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="BsDocumentForm"/>
	<tiles:put name="className" value="gnomon.hibernate.model.base.news.BsDocument"/>
	<%
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>

</table>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="BsDocumentForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/documents/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="BsDocumentForm" />
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
		<tiles:put name="editAction"  value="/ext/documents/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/documents/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>

	<br><br>

	<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
		<tiles:put name="className" value="<%= gnomon.hibernate.model.base.documents.BsDocument.class.getName() %>"/>
		<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
		<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
	</tiles:insert>

</c:if>

