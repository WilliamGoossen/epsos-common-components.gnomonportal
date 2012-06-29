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
 	treeViewDesc = (TreeViewDescription)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TreeViewDescription.ATTRIBUTE);

if (treeViewDesc != null)
{
	
%>
		
<script language="JavaScript" src="/html/portlet/ext/js/tree/JSCookTree.js"  type="text/javascript"></script>
<link rel="stylesheet" href="/html/portlet/ext/js/tree/ThemeXP/theme.css" TYPE="text/css">
<SCRIPT LANGUAGE="JavaScript" SRC="/html/portlet/ext/js/tree/ThemeXP/theme.js"  type="text/javascript"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript"  type="text/javascript"><!--
var <portlet:namespace/>treeViewMenu =
[
<% for (int i=0; i<treeViewDesc.getItemsSize(); i++) { 
	TreeViewDescription.TreeViewItem item = (TreeViewDescription.TreeViewItem)treeViewDesc.getItem(i); %>
    [<% if (item.icon != null) { %> '<%= item.icon %>' <% } else { %> null <% } %>, 
    '<%= LanguageUtil.get(pageContext, item.title) %>', 
    <% if (item.urlAction != null ) { %>
    '<portlet:actionURL><portlet:param name="struts_action" value="<%= item.urlAction %>"/>'+
    <% if (item.urlParamNames != null) {
    	for (int p=0; p<item.urlParamNames.length; p++) { %>
    	'<portlet:param name="<%= item.urlParamNames[p] %>" value="<%= item.urlParamValues[p] %>"/>'+
    <% } } %>
    '</portlet:actionURL>', 
    <% } else { %>
    null,
    <% } %>
    '', '<%= LanguageUtil.get(pageContext, item.description) %>'
    <% if (item instanceof TreeViewDescription.TreeViewFolder && ((TreeViewDescription.TreeViewFolder)item).getItemsSize() > 0) { %> , 
    	<% request.setAttribute("recursionItem", item); %>
		<jsp:include page="/html/portlet/ext/struts_includes/treeItemInclude.jsp"/>
    <% } %> 
    ]  
    <% if (i<treeViewDesc.getItemsSize()-1) { %>,<% } %> 
<% } %>
];

var <portlet:namespace/>treeViewMenuSelectedLink = null;
<%
if (treeViewDesc.getSelectedItem() != null)
{
	TreeViewDescription.TreeViewItem item = treeViewDesc.getSelectedItem(); %>
	<portlet:namespace/>treeViewMenuSelectedLink = 
		'<portlet:actionURL><portlet:param name="struts_action" value="<%= item.urlAction %>"/>'+
	    <% if (item.urlParamNames != null) {
	    	for (int p=0; p<item.urlParamNames.length; p++) { %>
	    	'<portlet:param name="<%= item.urlParamNames[p] %>" value="<%= item.urlParamValues[p] %>"/>'+
	    <% } } %>
	    '</portlet:actionURL>';
<% } %>

--></script>
<div id="<portlet:namespace/>treeViewID"></div>
<SCRIPT LANGUAGE="JavaScript"  type="text/javascript"><!--
	var <portlet:namespace/>treeViewIndex;
	var <portlet:namespace/>selectedTreeItem;
	window.onload = function(){
		<portlet:namespace/>treeViewIndex = ctDraw ('<portlet:namespace/>treeViewID', <portlet:namespace/>treeViewMenu, ctThemeXP1, 'ThemeXP', <%= treeViewDesc.getBranchControl() %>, <%= treeViewDesc.getDefaultExpandLevel() %>);
	    if (<portlet:namespace/>treeViewMenuSelectedLink != null) {
			<portlet:namespace/>selectedTreeItem = ctExposeItem(<portlet:namespace/>treeViewIndex, <portlet:namespace/>treeViewMenuSelectedLink);
			ctOpenFolder(<portlet:namespace/>selectedTreeItem);
		}
	};
--></SCRIPT>
<% 
} 
%>
<% } catch (Exception e) { e.printStackTrace(); } %>