<%@ page import="gnomon.hibernate.model.gn.GnAction" %>
<%@ include file="/html/portlet/ext/permissions/init.jsp" %>

<%
List actionList=(List) request.getAttribute("actionList");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "gn.permissions.action.list") %></h2>
<!-- Action Types List -->
<display:table id="action" name="actionList" requestURI="//ext/permissions/view" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% GnAction gnAction = (GnAction) pageContext.getAttribute("action"); %>
<display:column class="gamma1" titleKey="gn.permissions.action.name" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/load"/><portlet:param name="mainid" value="<%= gnAction.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>"><%= gnAction.getActionName() %></a>
</display:column>
<display:column style="text-align: right; height: 20;">
<% if (gnAction.isDeletable()==true) { %>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/load"/><portlet:param name="mainid" value="<%= gnAction.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
<% } %>
</display:column>
</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/load"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

<br>
<br>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/viewPortlets"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/pages.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.permissions.portlet.list") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.permissions.portlet.list") %></a>
