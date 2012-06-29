<%@ include file="/html/common/init.jsp" %>
<%@ page import="com.ext.util.TreeViewDescription" %>
<%@ page import="com.liferay.portal.kernel.language.LanguageUtil" %>
<%@ page import="com.ext.portlet.base.contentRss.TopicsTreeBuilder" %>

<%
TreeViewDescription.TreeViewFolder item = (TreeViewDescription.TreeViewFolder)request.getAttribute("recursionItem");

for (int j=0; j<item.getItemsSize(); j++) { 
	TreeViewDescription.TreeViewItem item2 = item.getItem(j); %>
    [<% if (item2.icon != null) { %> '<%= item2.icon %>' <% } else { %> null <% } %>, 
    '<%= LanguageUtil.get(pageContext, item2.title) %>', 
    <% if (Validator.isNotNull(item2.urlAction)) { 
    	String queryStr = TopicsTreeBuilder.getQueryStrForParams(item2.urlParamNames, item2.urlParamValues, true);
    %>
    "<%= item2.urlAction + queryStr%>", 
    <% } else { %>
    null, <% } %>
    '', '<%= LanguageUtil.get(pageContext, item2.description) %>'
    <% if (item2 instanceof TreeViewDescription.TreeViewFolder ) { %>,
		<% request.setAttribute("recursionItem", item2); %>
		<jsp:include page="/html/portlet/ext/base/gnContentRss/topicTreeItemInclude.jsp"/>
    <% } %> 
    ]  
    <% if (j< item.getItemsSize()-1) { %>,<% } 

} %>

