<%@ include file="/html/common/init.jsp" %>
<%@ page import="com.ext.util.TreeViewDescription" %>
<%@ page import="com.liferay.portal.kernel.language.LanguageUtil" %>

<%
TreeViewDescription.TreeViewFolder item = (TreeViewDescription.TreeViewFolder)request.getAttribute("recursionItem");

for (int j=0; j<item.getItemsSize(); j++) { 
	TreeViewDescription.TreeViewItem item2 = item.getItem(j); %>
    [<% if (item2.icon != null) { %> '<%= item2.icon %>' <% } else { %> null <% } %>, 
    '<%= LanguageUtil.get(pageContext, item2.title) %>', 
    <% if (item2.urlAction != null ) { %>
    '<portlet:actionURL><portlet:param name="struts_action" value="<%= item2.urlAction %>"/>'+
    <% if (item2.urlParamNames != null) {
    	for (int p=0; p<item2.urlParamNames.length; p++) { %>
    	'<portlet:param name="<%= item2.urlParamNames[p] %>" value="<%= item2.urlParamValues[p] %>"/>'+
    <% } } %>
    '</portlet:actionURL>', 
    <% } else { %> null, <% } %>
    '', '<%= LanguageUtil.get(pageContext, item2.description) %>'
    <% if (item2 instanceof TreeViewDescription.TreeViewFolder && ((TreeViewDescription.TreeViewFolder)item2).getItemsSize() > 0) { %>,
		<% request.setAttribute("recursionItem", item2); %>
		<jsp:include page="/html/portlet/ext/struts_includes/treeItemInclude.jsp"/>
    <% } %> 
    ]  
    <% if (j< item.getItemsSize()-1) { %>,<% } 

} %>

