<%@ include file="/html/portlet/ext/permissions/init.jsp" %>


<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h1 class="title1"><%= LanguageUtil.get(pageContext, "gn.permissions.topics.choose") %></h1>

<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>

<br>
<br>

<%
java.util.HashMap params = new java.util.HashMap();
params.put("portletid", request.getAttribute("portletid"));
pageContext.setAttribute("paramsName", params);
%>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/permissions/listPortletTopics" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.permissions.portlet.topics") %></html:link></TD>
</TR></TABLE>