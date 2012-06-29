<%@ include file="/html/portlet/ext/dms/init.jsp" %>


<div id="<portlet:namespace />dms">

<%
long userId=com.liferay.portal.util.PortalUtil.getUserId(request);
org.alfresco.webservice.util.AuthenticationDetails details=(org.alfresco.webservice.util.AuthenticationDetails)request.getSession().getAttribute("authdetails");
String contenttype="content";//ParamUtil.getString(request,"contenttype");
com.ext.portlet.dms.util.AlfrescoRow ar = (com.ext.portlet.dms.util.AlfrescoRow)request.getAttribute("alfrescocontent");
String extensionimg="";
try {
	extensionimg = gnomon.business.FileUtils.getFileExtension(ar.getName());
} catch (Exception e) {
	extensionimg = "_default";
}
if (ar==null) {
	ar = new com.ext.portlet.dms.util.AlfrescoRow();
//	ar.setFilename(com.liferay.portal.kernel.util.ParamUtil.getString(request,"filename"));
	ar.setUuid(request.getParameter("uuid"));
	ar.setIcon(extensionimg);
} else {
	ar.setUuid(request.getParameter("uuid"));
	//ar.setFilename(com.liferay.portal.kernel.util.ParamUtil.getString(request,"filename"));
	ar.setIcon(extensionimg);
}

request.setAttribute("ar",ar);
String parentuuid = request.getParameter("parentuuid");

boolean hasReadPermissions = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"ReadPermissions");
boolean hasChangePermissions = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"ChangePermissions");
boolean hasDeleteFile = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"DeleteNode");
boolean hasReadHistoryPermissions = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"ReadProperties");
boolean hasReadCommentsPermissions = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"ReadProperties");
hasReadCommentsPermissions |= PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionKeys.ADD_DISCUSSION);
boolean hasEditFile = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"WriteProperties");
%>

<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>" var="downloadURL">
	<portlet:param name="struts_action" value="/ext/dms/getfile" />
	<portlet:param name="uuid" value="<%= ar.getUuid() %>" />
	<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
	<portlet:param name="filename" value="<%= ar.getName() %>" />
</portlet:actionURL>

<jsp:include page="contentInfo.jsp">
<jsp:param name="parentuuid" value="{parameterValue | <%= parentuuid %>}" />
</jsp:include>

<% if (false && com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"WriteContent")) {
		String url4 = "";
		PortletURL PURL4 = new PortletURLImpl(request, "gn_dms", plid, true);
		PURL4.setPortletMode(PortletMode.VIEW);
		PURL4.setParameter("struts_action", "/ext/dms/addVersion");
		PURL4.setParameter("uuid", ar.getUuid());
		PURL4.setParameter("parentuuid", parentuuid);
		PURL4.setParameter("cmd", "edit");
		PURL4.setParameter("contenttype", contenttype);
		PURL4.setWindowState(WindowState.NORMAL);
		url4 = PURL4.toString();
%>
<a href="<%=url4%>"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/edit_icon.gif"></a>
&nbsp;
<% } %>

<% if (hasDeleteFile) { %>
	<portlet:actionURL var="url2">
				<portlet:param name="struts_action" value="/ext/dms/deleteContent" />
				<portlet:param name="uuid" value="<%= ar.getUuid() %>" />
				<portlet:param name="parentuuid" value="<%=parentuuid %>" />
				<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
				<portlet:param name="contenttype" value="<%= contenttype %>" />
			</portlet:actionURL>
		<%
%>

<a href="#" onClick="javascript: if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-document-and-all-its-versions") %>')) {document.location='<%=url2%>'};return 0;"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/delete.gif"></a>
<% } %>

<% if (hasEditFile) { %>

	<portlet:actionURL var="editPropertiesURL">
				<portlet:param name="struts_action" value="/ext/dms/changeProperties" />
				<portlet:param name="uuid" value="<%= ar.getUuid() %>" />
				<portlet:param name="parentuuid" value="<%=parentuuid %>" />
				<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
				<portlet:param name="filename" value="<%= ar.getName() %>" />
			</portlet:actionURL>

		<%
%>

<%
String editPropertiesJS = "javascript: toggleById('" + renderResponse.getNamespace() + "propertiesDiv" + "',true); self.focus(); void(0);";
%>
<a href="<%= editPropertiesJS %>"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/edit_properties.gif"></a>
<div id="<portlet:namespace />propertiesDiv" class="beta-gradient" style="display: <%="none" %>; padding-top:20px;">
	<form action="<%= editPropertiesURL %>" method="post" name="<portlet:namespace />fm4">
		<input class="form-text" name="<portlet:namespace />uuid" size="30" type="hidden" value="<%= ar.getUuid()%>">
		<table>
		<tr>
			<td><%= LanguageUtil.get(pageContext, "dms.title") %></td>
			<td><input class="form-text" name="docFileTitle" size="30" type="text" value=""></td>
		</tr>
		<tr>
			<td><%= LanguageUtil.get(pageContext, "dms.description") %></td>
			<td><input class="form-text" name="docFileDescription" size="30" type="text" value=""></td>
		</tr>
		<tr>
			<td colspan="2">
				<input id="submitPropertiesBtn" class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "submit") %>">
				<input id="cancelPropertiesBtn" class="portlet-form-button" type="button" onClick="<%=editPropertiesJS %>" value="<%= LanguageUtil.get(pageContext, "cancel") %>">
			</td>
		</tr>
		</table>
	</form>
</div>

<% } %>




<br/><br/>

<%
String tab = ParamUtil.getString(request, "tab");
String tabNames = "";
if (hasReadHistoryPermissions) {
	tabNames = tabNames + (Validator.isNull(tabNames)?"":",") + "version-history";
}
if (hasReadCommentsPermissions) {
	tabNames = tabNames + (Validator.isNull(tabNames)?"":",") + "comments";
}
if (hasReadPermissions) {
	tabNames = tabNames + (Validator.isNull(tabNames)?"":",") + "permissions";
}

tabNames = tabNames + (Validator.isNull(tabNames)?"":",") + "Metadata";
%>


<c:if test="<%=hasReadHistoryPermissions || hasReadCommentsPermissions || hasReadPermissions%>">
	<br>

	<portlet:actionURL var="redirectURL">
		<portlet:param name="struts_action" value="/ext/dms/filedetails" />
		<portlet:param name="uuid" value="<%=ar.getUuid()%>" />
		<portlet:param name="parentuuid" value="<%=parentuuid%>" />
		<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
		<portlet:param name="filename" value="<%=ar.getName()%>" />
	</portlet:actionURL>


	<liferay-ui:tabs
		names="<%=tabNames%>"
		param="tab"
		refresh="<%= false %>"
	>

	<c:if test="<%=hasReadHistoryPermissions%>">
		<liferay-ui:section>
			<jsp:include page="viewVersions.jsp"/>
		</liferay-ui:section>
	</c:if>
	<c:if test="<%= hasReadCommentsPermissions%>">
		<liferay-ui:section>
			<portlet:actionURL var="discussionURL">
				<portlet:param name="struts_action" value="/ext/dms/edit_file_discussion" />
			</portlet:actionURL>


			<liferay-ui:discussion
				formName="fm2"
				formAction="<%= discussionURL %>"
				className="<%= com.ext.portlet.dms.util.AlfrescoRow.class.getName() %>"
				classPK="<%= (new com.ext.util.GeneralHashFunctionLibrary()).RSHash(ar.getUuid()) %>"
				userId="<%= PortalUtil.getUserId(request) %>"
				subject="<%= ar.getName() %>"
				redirect="<%= redirectURL + "&tab=comments" %>"
			/>
		</liferay-ui:section>
	</c:if>
	<c:if test="<%= hasReadPermissions%>">
		<liferay-ui:section>
			<jsp:include page="viewPermissions.jsp"/>
		</liferay-ui:section>
	</c:if>

		<liferay-ui:section>
			<jsp:include page="viewMetadata.jsp"/>
		</liferay-ui:section>

	</liferay-ui:tabs>
</c:if>

</div>
<%!
private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.portlet.ext.dms.edit_configuration.jsp");
%>