<%@ include file="/html/portlet/ext/base/contentrel/init.jsp" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%@ page import="com.ext.portlet.base.search.GnSearchResultRow" %>
<%@ page import="com.ext.portlet.base.contentrel.ContentRelUtil" %>

<h2><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_content_rels") %></h2>
<br>
<%
String[] rel_portletNames = (String[])request.getAttribute("rel_portletNames");
String[] rel_portletClassNames = (String[])request.getAttribute("rel_portletClassNames");

String rel_className = request.getParameter("rel_className");
if (Validator.isNull(rel_className)) rel_className = (String)request.getAttribute("rel_className");
if (Validator.isNull(rel_className)) rel_className = "";
String rel_primaryKey = request.getParameter("rel_primaryKey");
if (Validator.isNull(rel_primaryKey)) rel_primaryKey = (String)request.getAttribute("rel_primaryKey");
if (Validator.isNull(rel_primaryKey)) rel_primaryKey = "";

String searchPortlet = request.getParameter("searchPortlet");
if (Validator.isNull(searchPortlet)) searchPortlet = (String)request.getAttribute("searchPortlet");
if (Validator.isNull(searchPortlet)) searchPortlet = "";
String searchKeywords = request.getParameter("searchKeywords");
if (Validator.isNull(searchKeywords)) searchKeywords = (String)request.getAttribute("searchKeywords");
if (Validator.isNull(searchKeywords)) searchKeywords = "*";

%>
<form name="BS_RELATED_CONTENT_SEARCH_FORM" action="<portlet:actionURL></portlet:actionURL>" method="post">
<input type="hidden" name="search" value="true" />
<input type="hidden" name="rel_className" value="<%= rel_className %>" />
<input type="hidden" name="rel_primaryKey" value="<%= rel_primaryKey %>" />

<table>
<tr>
<td>
<span><%= LanguageUtil.get(pageContext, "bs.related.content.portlet") %></span></td>
<td>
<select name="searchPortlet">
<% for (int i=0; i<rel_portletNames.length; i++) {
		String pName = rel_portletNames[i];
		String pClassName = rel_portletClassNames[i];
	%>
	<option value="<%= pClassName %>" <% if (pClassName.equals(searchPortlet)) { out.print("selected"); } %>>
		<%= LanguageUtil.get(pageContext, "javax.portlet.title."+pName) %>
	</option>
	<%
   } 
%>
<% if (!rel_className.equals(ContentRelUtil.JOURNAL_CLASSNAME)) { %>
	<option value="<%= ContentRelUtil.JOURNAL_CLASSNAME %>" <% if (ContentRelUtil.JOURNAL_CLASSNAME.equals(searchPortlet)) { out.print("selected"); } %>>
		<%= LanguageUtil.get(pageContext, "javax.portlet.title."+ContentRelUtil.JOURNAL_PORTLET) %>
	</option>
<% } %>	
</select>
</td>
</tr>
<tr>
<td>
<span><%= LanguageUtil.get(pageContext, "bs.related.content.keywords") %></span></td>
<td>
<input type="text" name="searchKeywords" value="<%= searchKeywords %>">
</td>
</tr>
<tr>
<td>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "bs.related.content.search") %>">
</td>
</tr>
</table>
</form>

<br>

<!-- search results -->


<% 
List<GnSearchResultRow> searchResults = (List<GnSearchResultRow>)request.getAttribute("searchResults");
%>
<form name="BS_RELATED_CONTENT_ADD_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/contentrel/addRelatedItems"/></portlet:actionURL>" method="post">
<input type="hidden" name="rel_className" value="<%= rel_className %>">
<input type="hidden" name="rel_primaryKey" value="<%= rel_primaryKey %>">

<display:table id="item" name="searchResults" requestURI="//ext/contentrel/search?actionURL=true" pagesize="10" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% GnSearchResultRow searchItem = (GnSearchResultRow) pageContext.getAttribute("item"); %>
<display:column>
<input type="checkbox" name="rel_relatedItem" value="<%= searchItem.getClassName()+"."+searchItem.getId() %>">
</display:column>
<display:column titleKey="title" sortable="true" style="width:100%">
<strong>
<a title="<%= searchItem.getTitle() %>"
   <% if (searchItem.getPortlet().equals(ContentRelUtil.JOURNAL_PORTLET)) { %>
   href="<%= searchItem.getUrl() %>">
   <% } else { %>
   href="<liferay-portlet:actionURL portletName="<%= searchItem.getPortlet() %>" windowState="pop_up">
		<liferay-portlet:param name="struts_action" value="<%= searchItem.getUrl() %>"/>
		<liferay-portlet:param name="mainid" value="<%= searchItem.getId() %>"/>
		<liferay-portlet:param name="loadaction" value="view"/>
		<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
		</liferay-portlet:actionURL>">
   <% } %>	
   		<% if (searchItem.getClassName().equals(gnomon.hibernate.model.base.documents.BsDocument.class.getName())) { %>
		<%String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(searchItem.getTitle().toString(), "page");
			String docTitle=searchItem.getTitle();
			int pos = docTitle.lastIndexOf(StringPool.PERIOD);
			if (pos != -1) {
				docTitle = docTitle.substring(0, pos);
			}
		%>
		<img alt="gif icon" style="float:left; border:0;" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
		
		 <%= docTitle %>
		
		<% } else {%>
        <%= searchItem.getTitle() %>
       <%}%> 	
        </a>
</strong>
<br/>
<% if (searchItem.getClassName().equals(gnomon.hibernate.model.base.news.BsNew.class.getName())) { %>
<%= StringUtils.check_null(searchItem.getDescription(),"") %>
<% } else { %>
<%= StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(searchItem.getDescription(),"")).trim(),500) %>
<% } %>
</display:column>
</display:table>
<br>
<% if (searchResults != null && searchResults.size() > 0) { %>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "bs.related.content.add") %>">
<% } %>
</form>














