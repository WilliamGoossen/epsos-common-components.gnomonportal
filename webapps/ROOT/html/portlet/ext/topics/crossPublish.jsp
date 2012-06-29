<%@ include file="/html/portlet/ext/topics/init.jsp" %>

<br>

<% if ("true".equals(request.getParameter("publish"))) { %>
<script language="JavaScript">
self.close();
</script>
<% } else { %>
<h3><%= LanguageUtil.get(pageContext, "bs.configuration.crosspublishing") %></h3>

<br>

<form method="post" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/crossPublish"/></portlet:actionURL>" class="uni-form">
<input type="hidden" name="contentid" value="<%= request.getParameter("contentid") %>">
<input type="hidden" name="roottopicids" value="<%= request.getParameter("roottopicids") %>">
<input type="hidden" name="publish" value="true">

<tiles:insert page="/html/portlet/ext/struts_includes/topics/topicTreeView.jsp" flush="true">
	<tiles:put name="attributeName" value="topics_tree_desc"/>
</tiles:insert>

<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "gn.button.cross-publish") %>">
</div>
</form>
<% } %>


