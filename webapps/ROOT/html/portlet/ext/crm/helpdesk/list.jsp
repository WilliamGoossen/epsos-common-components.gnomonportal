<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>

<jsp:include page="/html/portlet/ext/crm/helpdesk/list_tile.jsp" />

<% if (hasEdit) { %>
<br>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/><portlet:param name="search" value="none"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.back-to-first-page") %></a>
<% } %>