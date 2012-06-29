<%@ include file="/html/portlet/ext/dms/init.jsp" %>

<div id="<portlet:namespace />dms">
<%
boolean listFileButtons = GetterUtil.getBoolean(prefs.getValue("list-file-buttons", "false"));
boolean listFolderButtons = GetterUtil.getBoolean(prefs.getValue("list-folder-buttons", "true"));

long userId=com.liferay.portal.util.PortalUtil.getUserId(request);
//String encPassword=request.getSession().getAttribute("ticket").toString();
//String password=gnomon.business.StringEncrypter.decryptPassword(encPassword);
org.alfresco.webservice.util.AuthenticationDetails details=(org.alfresco.webservice.util.AuthenticationDetails)request.getSession().getAttribute("authdetails");
String content = (String)request.getAttribute(WebKeys.ALFRESCO_CONTENT);
String keywords = ParamUtil.getString(request, "keywords", StringPool.BLANK);
ArrayList alfrescodata = (ArrayList)request.getAttribute("alfrescodata");
ResultSetRow[] searchResults = new ResultSetRow[0];
String cmd = ParamUtil.getString(request, Constants.CMD);
String error = ParamUtil.getString(request, "error");
String selUuid = ParamUtil.getString(request, "uuid");
String parentUuid = ParamUtil.getString(request, "parentuuid");
String rootuuid = request.getAttribute("rootuuid").toString();
if (Validator.isNull(selUuid)) selUuid=uuid;
//if (Validator.isNotNull(cmd)) {
//	selUuid = null;
//}
String baseURL = ParamUtil.getString(request, "baseURL", currentURL);
%>

<%

String formName = "";
String formAction = "";
String className = "";
long classPK = 0;
//long userId = 0;
String subject = "";
String redirect = "";
String namespace = StringPool.BLANK;

if (renderRequest != null) {
	namespace = renderResponse.getNamespace();
}
try
{
formName = namespace + request.getAttribute("liferay-ui:discussion:formName");
formAction = (String)request.getAttribute("liferay-ui:discussion:formAction");
className = (String)request.getAttribute("liferay-ui:discussion:className");
classPK = GetterUtil.getLong((String)request.getAttribute("liferay-ui:discussion:classPK"));
//userId = GetterUtil.getLong((String)request.getAttribute("liferay-ui:discussion:userId"));
subject = (String)request.getAttribute("liferay-ui:discussion:subject");
redirect = (String)request.getAttribute("liferay-ui:discussion:redirect");
}
catch (Exception e)
{

}
%>

<script>



function deleteFolder(p_strutsaction,p_uuid,p_redirect) {

	if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-folder-and-all-its-contents") %>')) {
		var url = '<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
					<portlet:param name="struts_action" value="p_strutsaction" />
					<portlet:param name="uuid" value="p_uuid" />
					<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
					<portlet:param name="redirect" value="p_redirect" />
				</portlet:actionURL>';
		url =url.replace("p_strutsaction",p_strutsaction);
		url =url.replace("p_uuid",p_uuid);
		url =url.replace("p_redirect",escape(p_redirect));


		AjaxUtil.update2(url, "<portlet:namespace />dms");
	}
}

function breadcrumb(url)
{
AjaxUtil.update2(unescape(url), "<portlet:namespace />dms");
}

function browseContent(p_strutsaction,p_uuid,p_parentuuid,p_filename,p_contenttype) {
	var url;
	url = '<portlet:renderURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
	<portlet:param name="struts_action" value="p_strutsaction" />
	<portlet:param name="uuid" value="p_uuid" />
	<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
	<portlet:param name="parentuuid" value="p_parentuuid" />
	<portlet:param name="filename" value="p_filename" />
	<portlet:param name="contenttype" value="p_contenttype" />
	</portlet:renderURL>';
	url =url.replace("p_strutsaction",p_strutsaction);
	url =url.replace("p_uuid",p_uuid);
	url =url.replace("p_parentuuid",p_parentuuid);
	url =url.replace("p_filename",p_filename);
	url =url.replace("p_contenttype",p_contenttype);
	AjaxUtil.update2(url, "<portlet:namespace />dms");
}

function uploadFolder(form) {
	var inputs = jQuery("input, textarea, select", form);
	var url = form.action + "&" + inputs.serialize(); // see note below
	AjaxUtil.update2(url,"<portlet:namespace />dms");
}


	function <%= namespace %>deleteMessage(i) {
		eval("var messageId = document.<%= formName %>.<%= namespace %>messageId" + i + ".value;");

		document.<%= formName %>.<%= namespace %><%= Constants.CMD %>.value = "<%= Constants.DELETE %>";
		document.<%= formName %>.<%= namespace %>messageId.value = messageId;
		submitForm(document.<%= formName %>);
	}

	function <%= namespace %>postReply(i) {
		eval("var parentMessageId = document.<%= formName %>.<%= namespace %>parentMessageId" + i + ".value;");
		eval("var subject = document.<%= formName %>.<%= namespace %>postReplySubject" + i + ".value;");
		eval("var body = document.<%= formName %>.<%= namespace %>postReplyBody" + i + ".value;");

		document.<%= formName %>.<%= namespace %><%= Constants.CMD %>.value = "<%= Constants.ADD %>";
		document.<%= formName %>.<%= namespace %>parentMessageId.value = parentMessageId;
		document.<%= formName %>.<%= namespace %>subject.value = subject;
		document.<%= formName %>.<%= namespace %>body.value = body;
		submitForm(document.<%= formName %>);
	}

	function <%= namespace %>scrollIntoView(messageId) {
		document.getElementById("<%= namespace %>messageScroll" + messageId).scrollIntoView();
	}

	function <%= namespace %>updateMessage(i) {
		eval("var messageId = document.<%= formName %>.<%= namespace %>messageId" + i + ".value;");
		eval("var subject = document.<%= formName %>.<%= namespace %>editSubject" + i + ".value;");
		eval("var body = document.<%= formName %>.<%= namespace %>editBody" + i + ".value;");

		document.<%= formName %>.<%= namespace %><%= Constants.CMD %>.value = "<%= Constants.UPDATE %>";
		document.<%= formName %>.<%= namespace %>messageId.value = messageId;
		document.<%= formName %>.<%= namespace %>subject.value = subject;
		document.<%= formName %>.<%= namespace %>body.value = body;
		submitForm(document.<%= formName %>);
	}


</script>


<%
String searchJS = "javascript: toggleById('" + renderResponse.getNamespace() + "searchForm" + "',true); self.focus(); void(0);";
%>
<c:if test="<%= (details!=null) %>">
<div align="right">
	<c:choose>
		<c:when test="<%=Validator.isNotNull(keywords)%>">
			<a class="toggle" href="<%=baseURL%>">« <%= LanguageUtil.get(pageContext, "back") %></a>
		</c:when>
		<c:otherwise>
			<a href="<%=searchJS%>"><%= LanguageUtil.get(pageContext, "dms.search") %></a>
		</c:otherwise>
	</c:choose>
	<div id="<portlet:namespace />searchForm" style="display: <%=Validator.isNull(keywords)?"none":"" %>; text-align:right; padding-top:<%=Validator.isNull(keywords)?"10":"20"%>px; padding-bottom:20px; background-color:alpha;">
		<portlet:actionURL var="searchURL" >
			<portlet:param name="struts_action" value="/ext/dms/view" />
			<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
		</portlet:actionURL>

		<form action="<%=searchURL%>" method="post" name="<portlet:namespace />fm2">
		<input class="form-text" name="<portlet:namespace />keywords" size="50" type="text" value="<%=keywords.replace("\"","&quot;")%>">
		<input class="form-text" name="<portlet:namespace />cmd" size="50" type="hidden" value="search">
		<input class="form-text" name="<portlet:namespace />uuid" size="50" type="hidden" value="<%= selUuid %>">
		<input class="form-text" name="<portlet:namespace />baseURL" size="50" type="hidden" value="<%=baseURL%>">
		<input style="valign: bottom; border:0;" type="image" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/search_icon.gif">
		</form>
	</div>
</div>
</c:if>

<liferay-portlet:renderURL portletConfiguration="false" varImpl="portletURL" />
<%
//String breadcrumbs = AlfrescoContentUtil.createBreadcrumb(com.liferay.portal.util.PropsUtil.get("alfresco.userid"),com.liferay.portal.util.PropsUtil.get("alfresco.password"),selUuid,(com.liferay.portlet.PortletURLImpl)portletURL);
String breadcrumbs = AlfrescoContentUtil.createBreadcrumb(details,selUuid,(com.liferay.portlet.PortletURLImpl)portletURL,instanceUuid);
%>

<portlet:renderURL var="ajaxBrowseURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
	<portlet:param name="struts_action" value="/ext/dms/view" />
	<portlet:param name="uuid" value="<%= selUuid%>" />
	<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
</portlet:renderURL>


<h1><%= error %></h1>

<c:if test="<%= (searchResults != null) && (!cmd.equals("search"))&& (searchResults.length == 0) %>">
	<%= breadcrumbs %>
	<c:if test="<%=!listFolderButtons%>">
		<c:if test="<%=com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,selUuid,"WriteContent")%>">
			<portlet:actionURL windowState="<%= WindowState.NORMAL.toString() %>" var="editCurrentFolderURL">
				<portlet:param name="struts_action" value="/ext/dms/editFolder" />
				<portlet:param name="uuid" value="<%= selUuid %>" />
				<portlet:param name="parentuuid" value="<%=parentUuid %>" />
				<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
				<portlet:param name="redirect" value="<%= currentURL %>" />
			</portlet:actionURL>
			&nbsp;<a href="<%=editCurrentFolderURL%>"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/edit_icon.gif"></a>
		</c:if>
		
		<c:if test="<%=com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,selUuid,"DeleteNode")%>">
			<portlet:actionURL windowState="<%= WindowState.NORMAL.toString() %>" var="deleteCurrentFolderURL">
				<portlet:param name="struts_action" value="/ext/dms/deleteContent" />
				<portlet:param name="uuid" value="<%= selUuid %>" />
				<portlet:param name="parentuuid" value="<%= parentUuid %>" />
				<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
				<portlet:param name="contenttype" value="folder" />
			</portlet:actionURL>
			&nbsp;<a href="#" onClick="javascript: if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-the-selected-folder-and-all-its-contents") %>')) {document.location='<%=deleteCurrentFolderURL%>'};return 0;"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/delete.gif"></a>
		</c:if>
	</c:if>
	<c:if test="<%= Validator.isNotNull(breadcrumbs) %>">
		<br><br>
	</c:if>
</c:if>

<c:if test="<%= (details==null) %>">
<%= LanguageUtil.get(pageContext, "dms.authentication_problem") %>
</c:if>

<c:if test="<%= (details!=null) %>">
	<c:choose>
		<c:when test="<%=(alfrescodata!=null) && (alfrescodata.size()>0)%>">
			<c:choose>
				<c:when test="<%=Validator.isNotNull(instancePortletListStyle) && instancePortletListStyle.equals("grid") %>">
					<%@ include file="/html/portlet/ext/dms/viewGrid.jspf" %>
				</c:when>
				<c:otherwise>
					<%@ include file="/html/portlet/ext/dms/viewList.jspf" %>
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<%= LanguageUtil.get(pageContext, "dms.no_documents_found")  %>
		</c:otherwise>
	</c:choose>
</c:if>


<portlet:actionURL var="createFolderURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
	<portlet:param name="struts_action" value="/ext/dms/createFolder" />
</portlet:actionURL>
<portlet:actionURL var="createContentURL">
	<portlet:param name="struts_action" value="/ext/dms/createContent" />
</portlet:actionURL>


<br>
<%
boolean hasCreateFolder = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,selUuid,"CreateChildren");
boolean hasCreateFile = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,selUuid,"CreateChildren");
String addFolderJS = "javascript: toggleById('" + renderResponse.getNamespace() + "folderForm" + "',true); document.getElementById('" + renderResponse.getNamespace() + "fileForm" + "').style.display='none'; self.focus(); void(0);";
String addFileJS = "javascript: toggleById('" + renderResponse.getNamespace() + "fileForm" + "',true); document.getElementById('" + renderResponse.getNamespace() + "folderForm" + "').style.display='none'; self.focus(); void(0);";
%>

<c:if test="<%=hasCreateFolder%>">
	<a href="<%=addFolderJS%>"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/create_space.gif">&nbsp;<%= LanguageUtil.get(pageContext, "dms.addfolder") %></a>&nbsp;&nbsp;
</c:if>
<c:if test="<%=hasCreateFile%>">
	<a href="<%=addFileJS%>"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/add.gif">&nbsp;<%= LanguageUtil.get(pageContext, "dms.uploadfile") %></a>
</c:if>


<c:if test="<%=hasCreateFolder%>">
	<div id="<portlet:namespace />folderForm" class="beta-gradient" style="display: <%="none" %>; padding-top:20px;">
<form action="<%=createFolderURL %>" method="post" name="<portlet:namespace />uploadFolder"
		onsubmit="uploadFolder(document.<portlet:namespace />uploadFolder); return false;">
		<input name="<portlet:namespace />redirect" type="hidden" value="<%= ajaxBrowseURL %>" size="200">
		<input class="form-text" name="<portlet:namespace />uuid" size="30" type="hidden" value="<%= selUuid%>">
		<input class="form-text" name="<portlet:namespace />foldername" size="30" type="text" value="" onKeyUp="javascript:if (this.value!='') {document.getElementById('submitFolderBtn').disabled=false} else {document.getElementById('submitFolderBtn').disabled=true}">
		<input id="submitFolderBtn" disabled class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "submit") %>">
		<input id="cancelFolderBtn" class="portlet-form-button" type="button" onClick="<%=addFolderJS %>" value="<%= LanguageUtil.get(pageContext, "cancel") %>">
		</form>
	</div>
</c:if>

<c:if test="<%=hasCreateFile%>">
	<div id="<portlet:namespace />fileForm" class="beta-gradient" style="display: <%="none" %>; padding-top:20px;">
		<form action="<%=createContentURL%>" method="post" name="<portlet:namespace />fm3" enctype="multipart/form-data">
		<input class="form-text" name="<portlet:namespace />uuid" size="30" type="hidden" value="<%= selUuid%>">
		<table>
		<tr>
		<td><%= LanguageUtil.get(pageContext, "dms.filename") %></td>
		<td><input class="form-text" name="docFileContents" size="30" type="file" value="" onChange="javascript:if (this.value!='') {document.getElementById('submitFileBtn').disabled=false} else {document.getElementById('submitFileBtn').disabled=true}"></td>
		</tr>
		<tr>
		<td><%= LanguageUtil.get(pageContext, "dms.title") %></td>
		<td><input class="form-text" name="docFileTitle" size="30" type="text" value=""></td>
		</tr>
		<tr>
		<td><%= LanguageUtil.get(pageContext, "dms.description") %></td>
		<td><input class="form-text" name="docFileDescription" size="30" type="text" value=""></td>
		</tr>
		<tr>
		<td><input id="submitFileBtn" disabled class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "submit") %>"></td>
		<td><input id="cancelFileBtn" class="portlet-form-button" type="button" onClick="<%=addFileJS %>" value="<%= LanguageUtil.get(pageContext, "cancel") %>"></td>
		</tr>
		</table>
		</form>
	</div>
</c:if>
</div>
