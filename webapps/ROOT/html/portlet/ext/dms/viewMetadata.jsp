<%@ include file="/html/portlet/ext/dms/init.jsp" %>

<%@ page import="com.ext.util.FieldsMetaData" %>
<%@ page import="com.ext.util.FieldsData" %>
<%@ page import="com.ext.portlet.cms.kms.MetaDataUtil" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>

<%
ArrayList alfrescodata = (ArrayList)request.getAttribute("contentPermissions");
ArrayList alfrescoroles = com.ext.portlet.dms.util.AlfrescoContentUtil.getContentRoles();
List users = (List)request.getAttribute("users");
request.setAttribute("alfrescodata",alfrescodata);
String parentuuid = request.getParameter("parentuuid");
uuid = request.getParameter("uuid");
String filename=ParamUtil.getString(request,"filename");
String foldername=ParamUtil.getString(request,"foldername");
String contenttype="content";//ParamUtil.getString(request,"contenttype");

//String userId=com.liferay.portal.util.PortalUtil.getUserId(request);
org.alfresco.webservice.util.AuthenticationDetails details=(org.alfresco.webservice.util.AuthenticationDetails)request.getSession().getAttribute("authdetails");
boolean hasReadPermissions = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,uuid,"ReadPermissions");
boolean hasChangePermissions = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,uuid,"ChangePermissions");
boolean hasToggleInheritance = hasReadPermissions && hasChangePermissions;
%>

<form name="AlfrescoDocumentForm" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/dms/changeMetaData"/></portlet:actionURL>" method="post">
<input type="hidden" name="uuid" value="<%= uuid %>">

<%
String lang = GeneralUtils.getLocale(request);
Long companyId = PortalUtil.getCompanyId(request);
if (MetaDataUtil.hasMetaData(companyId, null, lang, com.ext.portlet.dms.util.AlfrescoContentUtil.ALFRESCO_DOCUMENT_CLASS_NAME)) {
%>

<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
		<tiles:put name="formName" value="AlfrescoDocumentForm" />
		<tiles:put name="className" value="<%= com.ext.portlet.dms.util.AlfrescoContentUtil.ALFRESCO_DOCUMENT_CLASS_NAME %>" />
		<tiles:put name="primaryKey" value="<%= uuid %>" />
</tiles:insert>

<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "submit") %>">

<% } else { %>

<%= LanguageUtil.get(pageContext, "metadata.fields.alertMessage.no-metadata-defined") %>

<% } %>

</form>