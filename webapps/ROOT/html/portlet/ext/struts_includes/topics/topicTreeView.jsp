<%@ include file="/html/common/init.jsp" %>
<%@ page import="com.ext.util.TreeViewDescription" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>

<% try { %>

<%
TreeViewDescription treeViewDesc = null;

if (tileAttribute != null)
  	treeViewDesc = (TreeViewDescription)request.getAttribute(tileAttribute);
else
 	treeViewDesc = (TreeViewDescription)request.getAttribute(TreeViewDescription.ATTRIBUTE);

if (treeViewDesc != null)
{
	
%>
		
<script language="JavaScript" src="/html/portlet/ext/js/tree/JSCookTree.js"></script>
<link rel="stylesheet" href="/html/portlet/ext/js/tree/ThemeXP/theme.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="/html/portlet/ext/js/tree/ThemeXP/theme.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript"><!--
var treeViewMenu =
[
<% for (int i=0; i<treeViewDesc.getItemsSize(); i++) { 
	TreeViewDescription.TreeViewItem item = (TreeViewDescription.TreeViewItem)treeViewDesc.getItem(i); %>
    [<% if (item.icon != null) { %> '<%= item.icon %>' <% } else { %> null <% } %>, 
    '<%= LanguageUtil.get(pageContext, item.title) %>', 
    <% if (item.urlAction != null ) { %>
    "javascript:selectedTopic(<%= item.urlParamValues[0]%>, <%= "'"+item.title +"'"%>)", 
    <% } else { %>
    null,
    <% } %>
    '', '<%= LanguageUtil.get(pageContext, item.description) %>'
    <% if (item instanceof TreeViewDescription.TreeViewFolder ) { %> , 
    	<% request.setAttribute("recursionItem", item); %>
		<jsp:include page="/html/portlet/ext/struts_includes/topics/topicTreeItemInclude.jsp"/>
    <% } %> 
    ]  
    <% if (i<treeViewDesc.getItemsSize()-1) { %>,<% } %> 
<% } %>
];

var treeViewMenuSelectedLink = null;
<%
if (treeViewDesc.getSelectedItem() != null)
{
	TreeViewDescription.TreeViewItem item = treeViewDesc.getSelectedItem(); %>
	treeViewMenuSelectedLink = item.urlAction ;
<% } %>

--></script>
<div id="treeViewID"></div>
<SCRIPT LANGUAGE="JavaScript"><!--
	var treeViewIndex = ctDraw ('treeViewID', treeViewMenu, ctThemeXP1, 'ThemeXP', <%= treeViewDesc.getBranchControl() %>, <%= treeViewDesc.getDefaultExpandLevel() %>);
	if (treeViewMenuSelectedLink != null) {
		var selectedTreeItem = ctExposeItem(treeViewIndex, treeViewMenuSelectedLink);
		ctOpenFolder(selectedTreeItem);
	}
--></SCRIPT>
<% 
} 
%>
<% } catch (Exception e) { e.printStackTrace(); } %>