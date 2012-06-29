<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.liferay.portlet.journal.model.JournalArticle" %>



<% try {

	String lookupFieldIdHtmlId = request.getParameter("lookupFieldIdHtmlId");
	String lookupFieldDisplHtmlId = request.getParameter("lookupFieldDisplHtmlId");
	String openerFormName = request.getParameter("openerFormName");
%>

<%@ include file="/html/portlet/ext/struts_includes/Lookup_js.jsp" %>

<%
String lookupActionUrl = "/ext/topics/lookupArticles?actionURL=true";
%>
<html:form action="<%= lookupActionUrl %>" method="post">
<table>
	<tr><td>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
		<tiles:put name="formName" value=""/>
	</tiles:insert>
	</td><td>
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "gn.button.search") %>">
	</td></tr>
</table>
</html:form>
<br>
<%
List itemsList=(List) request.getAttribute("itemsList");
%>
<h3><%= LanguageUtil.get(pageContext, "javax.portlet.title.15" ) %></h3>

<form name="JournalArticle_Lookup_List_Form" method="post" action="/some/url">

<display:table id="item" name="itemsList" requestURI="//ext/topics/lookupArticles" pagesize="20" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% JournalArticle article  = (JournalArticle)pageContext.getAttribute("item"); %>


<display:column>
<input type="radio" name="group1" value="<%=article.getId() + "&" + article.getTitle() %>">
</display:column>

<display:column property="title" titleKey="title" sortable="true" />
<display:column property="articleId" titleKey="id" sortable="true" />
<display:column property="version" titleKey="version" sortable="true" />
<display:column property="userName" titleKey="author" sortable="true" />

</display:table>
<% if (itemsList.size() > 0) { %>
<input type="button" class="portlet-form-button" name="Select" value="<%= LanguageUtil.get(pageContext, "gn.button.select")%>" onclick="onSelect('JournalArticle_Lookup_List_Form', 'group1')">
<% } %>
<input type="button" class="portlet-form-button" name="Clear" value="<%= LanguageUtil.get(pageContext, "gn.button.clear")%>" onclick="onClear()">

</form>


<% } catch (Exception e) {} %>