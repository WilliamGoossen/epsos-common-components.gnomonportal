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
    "javascript:selectedTopic(<%= item2.urlParamValues[0]%>, <%= "'"+item2.title +"'"%>)", 
    <% } else { %>
    null, <% } %>
    '', '<%= LanguageUtil.get(pageContext, item2.description) %>'
    <% if (item2 instanceof TreeViewDescription.TreeViewFolder ) { %>,
		<% request.setAttribute("recursionItem", item2); %>
		<jsp:include page="/html/portlet/ext/struts_includes/topics/topicTreeItemInclude.jsp"/>
    <% } %> 
    ]  
    <% if (j< item.getItemsSize()-1) { %>,<% } 

} %>

