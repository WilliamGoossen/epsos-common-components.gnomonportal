<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.*" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_CATALOGS %></tiles:put>
</tiles:insert>

<%
String catalogId = request.getParameter("catalogId");
boolean related = false;
if (request.getParameter("related") != null && request.getParameter("related").equals("true"))
	related = true;
String searchItem = request.getParameter("searchItem");
if (searchItem == null) searchItem = "";
List relatedProfiles = (List) request.getAttribute("relatedProfiles");
%>


<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h3><%= related ? LanguageUtil.get(pageContext, "ec.admin.catalog.profile.list") : LanguageUtil.get(pageContext, "ec.admin.catalog.profile.assign") %></h3>

<form name="EC_CATALOG_RELATED_PROFILES_SEARCH_FORM"  method="post"  action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/listCatalogProfiles"/></portlet:actionURL>" class="uni-form">
<input type="hidden" name="catalogId" value="<%= catalogId %>">
<input type="hidden" name="related" value="<%= related %>">
<div class="inline-labels">
<div class="ctrl-holder">
<label for="searchItem"><%= LanguageUtil.get(pageContext, "parties.manager.person.name") %></label>
<input type="text" name="searchItem" value="<%= searchItem %>">
</div>
</div>
<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">
</div>
</form>

<br>

<form name="EC_CATALOG_RELATED_PROFILES_FORM" method="post" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/updateCatalogProfiles"/></portlet:actionURL>">

<input type="hidden" name="catalogId" value="<%= catalogId %>">

<display:table id="item" name="relatedProfiles" requestURI="//ext/products/admin/listCatalogProfiles?actionURL=true" pagesize="30" sort="list" export="false" style="width: 100%;">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<display:column>
<input type="checkbox" name="profileId" value="<%= gnItem.getMainid().toString() %>">
</display:column>
<display:column property="field1" titleKey="parties.manager.person.name" sortable="true"/>
</display:table>

<% if (hasEdit) {

if (relatedProfiles != null && relatedProfiles.size() > 0) { %>

<%if (related) { %>

<input type="hidden" name="related" value="false">

<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.catalog.profile.unassign")%>">

<% } else { %>

<input type="hidden" name="related" value="true">

<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.catalog.profile.assign")%>">

<% }  %>

<% }  %>

<%if (related) { %>
<br><br>
<div class="add_button">
    <a href="<portlet:actionURL>
    <portlet:param name="struts_action" value="/ext/products/admin/listCatalogProfiles"/>
    <portlet:param name="catalogId" value="<%= catalogId %>"/>
    <portlet:param name="related" value="false"/>
    <portlet:param name="redirect" value="<%= currentURL %>"/>
    </portlet:actionURL>">
    <img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
    <%= LanguageUtil.get(pageContext, "ec.admin.catalog.profile.assign") %>
    </a>
</div>
<% } %>

<% } %>

</form>

<br>

<% if (redirect != null) { %>
<a href="<%= redirect %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="back">
<%= LanguageUtil.get(pageContext, "back") %></a>
<% } %>