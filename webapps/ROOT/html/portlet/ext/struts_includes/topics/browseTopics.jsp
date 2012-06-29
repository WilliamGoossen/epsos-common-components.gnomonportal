<%@ include file="/html/common/init.jsp" %>

<%@ page import="com.ext.portlet.topics.service.TopicsTreeBuilder" %>
<%@ page import="com.ext.util.TreeViewDescription" %>

<html>
<head>
	<title><%= LanguageUtil.get(pageContext, "gn.topics.browser.choose") %></title>
	<link href="/html/themes/brochure/css/main.css" type="text/css" rel="stylesheet" />
</head>
<body>
<h2><%= LanguageUtil.get(pageContext, "gn.topics.browser.choose") %></h2>
<br>

<%
String openerFormName = request.getParameter("openerFormName");
String openerFormFieldName = request.getParameter("openerFormFieldName");
String rootTopicIds = request.getParameter("rootTopicIds");
String multiSelection = request.getParameter("multiSelection");
boolean multipleSelection = multiSelection != null && multiSelection.equals("true");

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

</body>
</html>