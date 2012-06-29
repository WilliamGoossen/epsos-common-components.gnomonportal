<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>

<%@ page import="gnomon.hibernate.model.gn.kms.GnKmsTagGroup" %>
<%
List actionList=(List) request.getAttribute("taggroupList");
%>

<h2><%= LanguageUtil.get(pageContext, "gn.kms.taggroup.list") %></h2>

<display:table id="taggroup" name="taggroupList" requestURI="//ext/kms/viewTagGroup" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% GnKmsTagGroup gnTagGroup = (GnKmsTagGroup) pageContext.getAttribute("taggroup"); %>
<display:column   titleKey="gn.kms.taggroup.name" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadTagGroup"/><portlet:param name="mainid" value="<%= gnTagGroup.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>"><%= gnTagGroup.getName() %></a>
</display:column>

<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.kms.tagentry.list") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/viewTagEntry"/><portlet:param name="groupid" value="<%= gnTagGroup.getMainid().toString() %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/all_pages.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.kms.tagentry.list") %>"></a>
</display:column>

<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadTagGroup"/><portlet:param name="mainid" value="<%= gnTagGroup.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>

</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadTagGroup"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

