<%@ include file="/html/common/init.jsp" %>

<portlet:defineObjects />

<%@ page import="com.ext.portlet.dms.util.*" %>

<%@ page import="org.alfresco.webservice.types.NamedValue" %>
<%@ page import="org.alfresco.webservice.types.Node" %>
<%@ page import="org.alfresco.webservice.types.ResultSetRow" %>
<%@ page import="org.alfresco.webservice.types.ResultSetRowNode" %>
<%@ page import="org.alfresco.webservice.util.*" %>
<%@ page import="javax.portlet.PortletURL" %>

<%
String currentURL = PortalUtil.getCurrentURL(request);
String openerFormName = request.getParameter("openerFormName");
String openerFormFieldName = request.getParameter("openerFormFieldName");
String openerLabelName = request.getParameter("openerLabelName");
String instanceUuid = request.getParameter("instanceUuid");
String globalUuid = GetterUtil.getString(PropsUtil.get("alfresco.uuid"));
String multiSelection = request.getParameter("multiSelection");
boolean multipleSelection = multiSelection != null && multiSelection.equals("true");
String selUuid = ParamUtil.getString(request,"uuid", instanceUuid);
String cmd = ParamUtil.getString(request,"cmd");
String keywords = ParamUtil.getString(request, "keywords");

AuthenticationDetails details = (AuthenticationDetails) request.getSession().getAttribute("authdetails");
ResultSetRow[] searchResults = new ResultSetRow[0];
String realPath = CommonUtil.getRootPath(pageContext.getServletContext()) + themeDisplay.getPathThemeImages()+ "/alfresco/filetypes/";
ArrayList alfrescodata = AlfrescoContentUtil.prepareFolderData(details, selUuid, null, "", realPath);
request.setAttribute("alfrescodata",alfrescodata);

Node instanceNode = AlfrescoContentUtil.getNode(details,instanceUuid);
NamedValue[] instanceNamedValues = instanceNode.getProperties();
String instanceFolderName = AlfrescoContentUtil.getNamedValue(instanceNamedValues, org.alfresco.webservice.util.Constants.PROP_NAME);

%>

<liferay-portlet:renderURL portletName="gn_dms" varImpl="portletURL">
	<portlet:param name="struts_action" value="/ext/dms/browseFolders" />
	<portlet:param name="openerFormName" value="<%= openerFormName %>" />
	<portlet:param name="openerFormFieldName" value="<%= openerFormFieldName %>" />
	<portlet:param name="openerLabelName" value="<%= openerLabelName %>" />
	<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
</liferay-portlet:renderURL>

<%
String breadcrumbs = AlfrescoContentUtil.createBreadcrumb(details,selUuid,(com.liferay.portlet.PortletURLImpl)portletURL,globalUuid);
%>

<html>
<head>
	<title><%= LanguageUtil.get(pageContext, "dms.folders.browser.choose") %></title>
	<link href="/c/portal/css_cached?themeId=brochure&colorSchemeId=01" type="text/css" rel="stylesheet" />
</head>
<body>

<div id="<portlet:namespace />dms">
	<h3><%= LanguageUtil.get(pageContext, "dms.folders.browser.choose") %></h3>
	<br/>

	<%=breadcrumbs %>
	<form name="rootFolderForm" method="post" action="/some/url">
	<input type="hidden" id="rootUuid" value="<%=instanceUuid%>" size="40">
	<input type="hidden" id="rootName" value="<%=instanceFolderName%>" size="40">
	<display:table name="alfrescodata" id="ad" style="width:100%; text-align:left;">
		<%
		com.ext.portlet.dms.util.AlfrescoRow ar = (com.ext.portlet.dms.util.AlfrescoRow)pageContext.getAttribute("ad");
		%>

		<display:column style="width:1%; white-space:nowrap; padding-right:5px;">
			<input type="radio" name="rootid" title="<%= gnomon.business.StringUtils.check_null(ar.getName(),ar.getTitle())%>" value="<%=ar.getUuid()%>" OnClick="javascript:document.getElementById('rootUuid').value=this.value;document.getElementById('rootName').value=this.title;">
		</display:column>
		<display:column titleKey="dms.contentname" style="width:99%;">
			<a href="#" onClick="javascript:browseContent('/ext/dms/browseFolders','<%=ar.getUuid()%>','<%= selUuid%>','','folder','<%=instanceUuid%>','<%=instanceFolderName%>');return false;"
		"><%= gnomon.business.StringUtils.check_null(ar.getName(),ar.getTitle())%></a>
		</display:column>

	</display:table>

	<c:if test="<%=alfrescodata!=null && alfrescodata.size()>0 %>">
		<input type="button" name="select" value="<%= LanguageUtil.get(pageContext, "select") %>" onClick="selectFolder();">
		&nbsp;
		<input type="button" name="select" value="<%= LanguageUtil.get(pageContext, "clear") %>" onClick="clearFolder();">
		&nbsp;
		<input type="button" name="select" value="<%= LanguageUtil.get(pageContext, "cancel") %>" onClick="self.close();">
	</c:if>
	</form>
</div>

<script language="JavaScript">
function clearFolder() {
	var openerField = opener.document.<%=openerFormName%>.elements['<%= openerFormFieldName %>'];
	var openerLabel = opener.document.getElementById('<%=openerLabelName%>');
	openerField.value = '';
	openerLabel.childNodes[0].nodeValue = '';
	self.close();
}
function selectFolder() {
	var openerField = opener.document.<%=openerFormName%>.elements['<%= openerFormFieldName %>'];
	var openerLabel = opener.document.getElementById('<%=openerLabelName%>');
	if (openerField.value != document.getElementById('rootUuid').value)
	{
		// replace any value with the current one
		openerField.value = document.getElementById('rootUuid').value;
		openerLabel.childNodes[0].nodeValue = document.getElementById('rootName').value;
		//openerField_Names.value = topicName;
	}
	self.close();
}

function breadcrumb(url)
{
AjaxUtil.update2(unescape(url), "<portlet:namespace />dms");
}

function browseContent(p_strutsaction,p_uuid,p_parentuuid,p_filename,p_contenttype,p_instanceuuid,p_foldername) {
	var url;
	url = '<portlet:renderURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
	<portlet:param name="struts_action" value="p_strutsaction" />
	<portlet:param name="parentuuid" value="p_parentuuid" />
	<portlet:param name="filename" value="p_filename" />
	<portlet:param name="contenttype" value="p_contenttype" />
	<portlet:param name='openerFormName' value='_86_fm' />
	<portlet:param name='openerFormFieldName' value='_86_instanceUuid' />
	<portlet:param name='openerLabelName' value='_86_instanceFolderName' />
	<portlet:param name='instanceUuid' value="p_instanceuuid" />
	<portlet:param name='uuid' value="p_uuid" />
	</portlet:renderURL>';
	url =url.replace("p_strutsaction",p_strutsaction);
	url =url.replace("p_uuid",p_uuid);
	url =url.replace("p_parentuuid",p_parentuuid);
	url =url.replace("p_filename",p_filename);
	url =url.replace("p_contenttype",p_contenttype);
	url =url.replace("p_instanceuuid",p_instanceuuid);
	url =url.replace("p_foldername",p_foldername);
	AjaxUtil.update2(url, "<portlet:namespace />dms");
}
</script>


<%!
private static Log _log = LogFactoryUtil.getLog("portal-web.docroot.html.portlet.ext.dms.edit_configuration.jsp");
%>





<%--


<div id="<portlet:namespace />dms">
<%

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
<script>

function breadcrumb(url)
{
AjaxUtil.update2(unescape(url), "<portlet:namespace />dms");
}

function browseContent(p_strutsaction,p_uuid,p_parentuuid,p_filename,p_contenttype) {
	var url;
	url = '<portlet:renderURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
	<portlet:param name="struts_action" value="p_strutsaction" />
	<portlet:param name="uuid" value="p_uuid" />
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
</script>


<%
String searchJS = "javascript: toggleById('searchForm',true); self.focus(); void(0);";
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
	<div id="searchForm" style="display: <%=Validator.isNull(keywords)?"none":"" %>; text-align:right; padding-top:<%=Validator.isNull(keywords)?"10":"20"%>px; padding-bottom:20px; background-color:alpha;">
		<portlet:renderURL var="searchURL">
			<portlet:param name="struts_action" value="/ext/dms/view" />
		</portlet:renderURL>

		<form action="<%=searchURL%>" method="post" name="<portlet:namespace />fm2">
		<input class="form-text" name="<portlet:namespace />keywords" size="50" type="text" value="<%=keywords.replace("\"","&quot;")%>">
		<input class="form-text" name="<portlet:namespace />cmd" size="50" type="hidden" value="search">
		<input class="form-text" name="<portlet:namespace />uuid" size="50" type="hidden" value="<%= rootuuid%>">
		<input class="form-text" name="<portlet:namespace />baseURL" size="50" type="hidden" value="<%=baseURL%>">
		<input style="valign: bottom; border:0;" type="image" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/search_icon.gif">
		</form>
	</div>
</div>
</c:if>

<liferay-portlet:renderURL portletConfiguration="false" varImpl="portletURL" />
<%
//String breadcrumbs = AlfrescoContentUtil.createBreadcrumb(com.liferay.portal.util.PropsUtil.get("alfresco.userid"),com.liferay.portal.util.PropsUtil.get("alfresco.password"),selUuid,(com.liferay.portlet.PortletURLImpl)portletURL);
String breadcrumbs = AlfrescoContentUtil.createBreadcrumb(details,selUuid,(com.liferay.portlet.PortletURLImpl)portletURL);
%>

<portlet:renderURL var="ajaxBrowseURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
	<portlet:param name="struts_action" value="/ext/dms/view" />
	<portlet:param name="uuid" value="<%= selUuid%>" />
</portlet:renderURL>


<h1><%= error %></h1>

<c:if test="<%= (searchResults != null) && (!cmd.equals("search"))&& (searchResults.length == 0) %>">
	<%= breadcrumbs %>
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
	<display:table name="${alfrescodata}" id="ad" style="width:100%; text-align:left;">

	<%
	com.ext.portlet.dms.util.AlfrescoRow ar = (com.ext.portlet.dms.util.AlfrescoRow)pageContext.getAttribute("ad");
	Hashtable permissionResults = AlfrescoContentUtil.getPermissionsForUser(details,ar.getUuid());
	String linkuuid=selUuid;
	if (cmd.equals("search")) {
		linkuuid=ar.getParentuuid();
		if (Validator.isNull(linkuuid)) linkuuid=selUuid;
	}
	boolean hasReadPermissions = false;
	if (ar.getContenttype().equalsIgnoreCase("folder") && listFolderButtons) {
		hasReadPermissions = permissionResults.containsKey("ReadPermissions");//com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,ar.getUuid(),"ReadPermissions");
	}

	%>

	<%
	// create browsing urls
	String p_strutsaction = "";
	String p_uuid = "";
	String p_parentuuid = "";
	String p_filename = "";
	String p_contenttype = "";
	if (ar.getContenttype().equalsIgnoreCase("folder")) {
		p_strutsaction = "/ext/dms/view";
		p_uuid = ar.getUuid();
		p_parentuuid = selUuid;
	} else {
		p_strutsaction = "/ext/dms/filedetails";
		p_uuid = ar.getUuid();
		p_parentuuid = linkuuid;
		p_filename = ar.getName();
		p_contenttype = ar.getContenttype();
	}
	String title = "";
	if (Validator.isNull(ar.getTitle()))
	{
	 title = ar.getName();
	}
	else
	{
	title = ar.getTitle();
	}
	%>
	<display:column titleKey="dms.contentname" style="width:99%;">
		<a title="<%= gnomon.business.StringUtils.check_null(ar.getDescription(),"")%>" href="#" onClick="javascript:browseContent('<%=p_strutsaction%>','<%= p_uuid%>','<%= p_parentuuid%>','<%= p_filename%>','<%= p_contenttype%>');return false;"
		"><img border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/filetypes/<%=ar.getIcon()%>.gif">&nbsp;<%= title %>
		<% if (cmd.equals("search")) {%>
		<% String breadcrumbs1 = AlfrescoContentUtil.createBreadcrumb(details,ar.getParentuuid(),(com.liferay.portlet.PortletURLImpl)portletURL); %>
		<br><%= breadcrumbs1%>
		<% } %>
		</a>
	</display:column>

	<display:column style="width:1%; white-space:nowrap; text-align:right; padding-right:5px;">

	</display:column>
</display:table>

</c:when>
<c:otherwise>
	<%= LanguageUtil.get(pageContext, "dms.no_documents_found")  %>
</c:otherwise>
</c:choose>
</c:if>


<br>

</div>


--%>








<%--
Integer[] rootIds = null;
if (rootTopicIds != null && !rootTopicIds.equals(""))
{
	String[] rootTopics = rootTopicIds.split(",");
	rootIds = new Integer[rootTopics.length];
	for (int rt=0; rt<rootTopics.length; rt++)
		rootIds[rt] = Integer.valueOf(rootTopics[rt]);
}
%>
<script language="JavaScript">
function selectedTopic(topicid, topicName) {
	var openerField = opener.document.<%= openerFormName%>.elements["<%= openerFormFieldName %>"];
	var openerField_Names = opener.document.<%= openerFormName%>.elements["<%= openerFormFieldName +"_Names"%>"];
	<% if (multipleSelection) { // multiple topic selection %>
	if (openerField.value.indexOf(""+topicid) == -1)
	{
		// only add the chosen topicid if not already there
		if (openerField.value != null && openerField.value != "")
			openerField.value += ','+topicid;
		else
			openerField.value += topicid;
		if (openerField_Names.value != null && openerField_Names.value != "")
			openerField_Names.value += ', '+topicName;
		else
			openerField_Names.value += topicName;
	}
	<% } else { // single topic selection %>
	if (openerField.value != topicid)
	{
		// replace any value with the current one
		openerField.value = topicid;
		openerField_Names.value = topicName;
	}
	<% } %>
	self.close();
}
</script>
<%
String lang = gnomon.business.GeneralUtils.getLocale(request);

TreeViewDescription treeDesc = TopicsTreeBuilder.buildTopicsTree(PortalUtil.getCompanyId(request), rootIds, lang, "", null, null, null, "gn.permissions.topics.choose",request);
request.setAttribute("topics_tree_desc", treeDesc);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/topics/topicTreeView.jsp" flush="true">
	<tiles:put name="attributeName" value="topics_tree_desc"/>
</tiles:insert>
--%>


</body>
</html>