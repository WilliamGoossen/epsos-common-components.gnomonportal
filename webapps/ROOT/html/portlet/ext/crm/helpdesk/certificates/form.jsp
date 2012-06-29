<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>

<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.hibernate.model.crm.CrCategory" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>


<%
try {

String buttonText = "crm.button.submit";
String titleText = "crm.helpdesk.request.add";
String categoryId = (String)request.getAttribute("categoryId");
String categoryName = (String)request.getAttribute("categoryName");
String categoryDescription = (String)request.getAttribute("categoryDescription");
String metaDataClassName = (String)request.getAttribute("metaDataClassName");
List requestTypes = (List)request.getAttribute("requestTypes");
%>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>

<form name="CRM_HELPDESK_CERTIFICATES_ADD_REQUEST_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskCertificates/addRequest"/></portlet:actionURL>" method="post" enctype="multipart/form-data">
<input type="hidden" name="categoryId" value="<%= categoryId %>">
<input type="hidden" name="categoryName" value="<%= categoryName %>">
<table width="100%" border="0">
<tr valign="top">
<td valign="top" rowspan="2" width="50%">
<h3><%= LanguageUtil.get(pageContext, "crm.helpdesk.certificates.request") %></h3>
<br>
<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="CRM_HELPDESK_CERTIFICATES_ADD_REQUEST_FORM"/>
	<tiles:put name="className" value="<%= metaDataClassName %>"/>
</tiles:insert>
<br>
<span><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.comments") %></span><br>
<textarea name="reqDescription" rows="15" cols="65">
</textarea>
</td>

<td valign="top" width="50%">
<h3><%= LanguageUtil.get(pageContext, "crm.helpdesk.certificates.to") %> &nbsp; <%= categoryName %></h3>
<%= categoryDescription %>
</td>
</tr>

<tr>
<td>
<br />

<strong><%= LanguageUtil.get(pageContext, "crm.helpdesk.certificates.request.text") %></strong>
<br />
<br />
<ul>
<% for (int r=0; r<requestTypes.size(); r++) {
	 	ViewResult reqView = (ViewResult)requestTypes.get(r); %>
	<li style="margin:5px;">
		<input  type="radio" <% if (r==0) { out.print("checked"); } %> name="requestTypeId" value="<%= reqView.getMainid().toString() %>">&nbsp;<%= reqView.getField1() %>
	</li>	 	
<% } %>
</ul>
</td>
</tr>
</table>
<br>
<input type="submit" value="<%= LanguageUtil.get(pageContext, buttonText) %>">
</form>
<br>
<%
} catch (Exception e) {e.printStackTrace(); } %>