<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>

<%@ page import="gnomon.hibernate.model.gn.kms.GnKmsClass" %>
<%
List actionList=(List) request.getAttribute("classList");
%>

<h2><%= LanguageUtil.get(pageContext, "gn.kms.class.list") %></h2>

<display:table id="kms" name="classList" requestURI="//ext/kms/viewClass" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% GnKmsClass gnClass = (GnKmsClass) pageContext.getAttribute("kms"); %>
<display:column titleKey="gn.kms.classaspect.classname" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadClass"/><portlet:param name="mainid" value="<%= gnClass.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>"><%= gnClass.getClassName() %></a>
</display:column>

<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadClass"/><portlet:param name="mainid" value="<%= gnClass.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>

</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadClass"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>
