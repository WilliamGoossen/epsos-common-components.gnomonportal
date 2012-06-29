<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>

<%@ page import="gnomon.hibernate.model.gn.kms.GnKmsTagEntry" %>
<%
Integer groupid = (Integer)request.getAttribute("groupid");
List actionList=(List) request.getAttribute("tagentryList");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, "gn.kms.tagentry.list") %></h2>

<display:table id="tagentry" name="tagentryList" requestURI="//ext/kms/viewTagEntry" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% GnKmsTagEntry gnTagEntry = (GnKmsTagEntry) pageContext.getAttribute("tagentry"); %>
<display:column   titleKey="gn.kms.tagentry.tag" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadTagEntry"/><portlet:param name="mainid" value="<%= gnTagEntry.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>"><%= gnTagEntry.getTag() %></a>
</display:column>

<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadTagEntry"/><portlet:param name="mainid" value="<%= gnTagEntry.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>

</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadTagEntry"/><portlet:param name="loadaction" value="add"/><portlet:param name="groupid" value="<%= ""+groupid %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

<br><br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/kms/viewTagGroup"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.taggroup.list") %></html:link></TD>
</TR></TABLE>