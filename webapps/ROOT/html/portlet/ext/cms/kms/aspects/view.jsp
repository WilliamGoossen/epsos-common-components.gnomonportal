<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>

<%@ page import="gnomon.hibernate.model.gn.kms.GnKmsAspect" %>
<%
List actionList=(List) request.getAttribute("aspectList");
%>

<h2><%= LanguageUtil.get(pageContext, "gn.kms.aspect.list") %></h2>

<display:table id="aspect" name="aspectList" requestURI="//ext/kms/viewAspect" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% GnKmsAspect gnAspect = (GnKmsAspect) pageContext.getAttribute("aspect"); %>
<display:column titleKey="gn.kms.aspect.name" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadAspect"/><portlet:param name="mainid" value="<%= gnAspect.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>"><%= gnAspect.getName() %></a>
</display:column>

<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.kms.property.list") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/listProperty"/><portlet:param name="aspectid" value="<%= gnAspect.getMainid().toString() %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/configuration.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.kms.property.list") %>"></a>
</display:column>

<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadAspect"/><portlet:param name="mainid" value="<%= gnAspect.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>

</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadAspect"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

<br><br>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/viewClass"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/all_pages.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.kms.class.list") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.kms.class.list") %></a>

<br><br>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/viewClassAspect"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/links.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.kms.classaspect.list") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.kms.classaspect.list") %></a>

<br><br>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/viewTagGroup"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.kms.taggroup.list") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.kms.taggroup.list") %></a>
