<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%
try {
	
Integer propertyid = (Integer)request.getAttribute("propertyid");
String parentid = (String)request.getAttribute("parentid");
Integer aspectid = (Integer)request.getAttribute("aspectid");
List options=(List) request.getAttribute("options");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, "gn.kms.option.list") %></h2>

<display:table id="option" name="options" requestURI="//ext/kms/listOption" pagesize="20" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult item = (ViewResult) pageContext.getAttribute("option"); %>
<display:column   titleKey="gn.kms.option.name" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/listOption"/><portlet:param name="propertyid" value="<%= propertyid.toString() %>"/><portlet:param name="parentid" value="<%= item.getMainid().toString() %>"/></portlet:actionURL>"><%= item.getField1() %></a>
</display:column>
<display:column   property="field2" titleKey="gn.kms.option.valuecode" sortable="true"/>
<display:column   property="field3" titleKey="gn.kms.option.orderindex" sortable="true"/>
<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadOption"/><portlet:param name="mainid" value="<%= item.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>"></a>
<a title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadOption"/><portlet:param name="mainid" value="<%= item.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>
</display:table>

<% if (parentid == null) { %>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadOption"/><portlet:param name="loadaction" value="add"/><portlet:param name="propertyid" value="<%= propertyid.toString() %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>
<% } else { %>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadOption"/><portlet:param name="loadaction" value="add"/><portlet:param name="propertyid" value="<%= propertyid.toString() %>"/><portlet:param name="parentid" value="<%= parentid.toString() %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

<% } %>
<br><br>

<%
if (parentid == null) {
java.util.HashMap params = new java.util.HashMap();
params.put("aspectid", aspectid);
pageContext.setAttribute("paramsName", params);
%>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/kms/listProperty" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.property.list") %></html:link></TD>
</TR></TABLE>

<% } else { 
	java.util.HashMap params = new java.util.HashMap();
	params.put("propertyid", propertyid);
	pageContext.setAttribute("paramsName", params);
	%>

	<TABLE border="0" cellpadding="0" cellspacing="0">
	<TR><TD><html:link styleClass="beta1" action="/ext/kms/listOption" name="paramsName"><img src="/html/themes/classic/images/common/top.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.option.list") %></html:link></TD>
	</TR></TABLE>
<% } 

} catch (Exception e) { e.printStackTrace(); } %>
