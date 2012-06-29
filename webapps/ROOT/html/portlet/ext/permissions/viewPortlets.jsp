<%@ include file="/html/portlet/ext/permissions/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "gn.permissions.portlet.list") %></h2>
<!-- Portlets List -->
<display:table id="portlets" name="portletsList" requestURI="//ext/permissions/viewPortlets" pagesize="20" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult listItem = (ViewResult)pageContext.getAttribute("portlets"); %>
<display:column class="gamma1" property="field2" titleKey="gn.permissions.portlet.title" sortable="true">
</display:column>
<c:if test="<%= hasAdmin %>">
	<display:column style="text-align: right">
	<%--<a name="#<%= listItem.getField2().toString()%>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/permissions/loadPortletActions"/><portlet:param name="portletid" value="<%= listItem.getField1().toString() %>"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>"><img src="/html/themes/classic/images/common/permissions.png" title="<%= LanguageUtil.get(pageContext, "actions")%>" alt="<%= LanguageUtil.get(pageContext, "actions")%>"></a>--%>
	<a name="#<%= listItem.getField2().toString()%>" href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/permissions/loadPortletSettings"/>
		<portlet:param name="portletid" value="<%= listItem.getField1().toString() %>"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>">
		<img src="/html/themes/classic/images/common/configuration.png" title="<%= LanguageUtil.get(pageContext, "settings")%>" alt="<%= LanguageUtil.get(pageContext, "settings")%>">
	</a>
	<a name="#<%= listItem.getField2().toString()%>" href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/permissions/listPortletTopics"/>
		<portlet:param name="portletid" value="<%= listItem.getField1().toString() %>"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>">
		<img src="/html/themes/classic/images/common/recent_changes.png" title="<%= LanguageUtil.get(pageContext, "topics")%>" alt="<%= LanguageUtil.get(pageContext, "topics")%>">
	</a>
	</display:column>
</c:if>
</display:table>
<%--
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/permissions/view"><img src="/html/themes/classic/images/common/view_articles.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.permissions.action.list") %></html:link></TD>
</TR></TABLE>
--%>