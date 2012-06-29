<%@ include file="/html/portlet/ext/crm/helpdesk/stats/init.jsp" %>


<ul>
<li><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskStats/list"/><portlet:param name="search" value="false"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.searchform1") %></a></li>
<li><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskStats/listStats"/><portlet:param name="search" value="false"/></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.stats.searchform2") %></a></li>
</ul>




