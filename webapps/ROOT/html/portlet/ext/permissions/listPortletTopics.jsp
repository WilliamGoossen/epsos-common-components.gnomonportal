<%@ include file="/html/portlet/ext/permissions/init.jsp" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<%String redirect = (String)request.getParameter("redirect"); %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h1 class="title1"><%= LanguageUtil.get(pageContext, "gn.permissions.portlet.topics") %></h1>

<display:table id="topics" name="topicsList" requestURI="//ext/permissions/listPortletTopics" pagesize="20" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult listItem = (ViewResult)pageContext.getAttribute("topics"); %>
<display:column property="field2" class="gamma1" titleKey="gn.permissions.topics.name" />
<display:column property="field3" class="gamma1" titleKey="gn.permissions.topics.description" />
<display:column style="text-align: right">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/deletePortletTopic"/><portlet:param name="mainid" value="<%= listItem.getMainid().toString() %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>
</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/loadPortletTopics"/><portlet:param name="portletid" value="<%= (String)request.getAttribute("portletid") %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/post.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

<br>
<br>

<portlet:actionURL var="listURL">
	<portlet:param name="struts_action" value="/ext/permissions/viewPortlets"/>
</portlet:actionURL>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR>
	<TD>
		<a href="<%=Validator.isNull(redirect)? listURL:redirect%>">
		<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.permissions.portlet.list") %>
		</a>
	</TD>
</TR>
</TABLE>