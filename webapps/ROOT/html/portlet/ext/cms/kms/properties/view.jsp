<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%
Integer aspectid = (Integer)request.getAttribute("aspectid");
List properties=(List) request.getAttribute("properties");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h2><%= LanguageUtil.get(pageContext, "gn.kms.property.list") %></h2>

<display:table id="prop" name="properties" requestURI="//ext/kms/listProperty" pagesize="20" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult item = (ViewResult) pageContext.getAttribute("prop"); %>
<display:column   titleKey="gn.kms.property.name" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadProperty"/><portlet:param name="mainid" value="<%= item.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>"><%= item.getField1() %></a>
</display:column>
<display:column   property="field2" titleKey="gn.kms.property.fieldcode" sortable="true"/>
<display:column   property="field3" titleKey="gn.kms.property.orderindex" sortable="true"/>
<display:column   property="field4" titleKey="gn.kms.property.groupname" sortable="true"/>
<display:column   property="field5" titleKey="gn.kms.property.tabname" sortable="true"/>

<display:column style="text-align: right; height: 20;">
<% if (item.getField6() != null && item.getField6().toString().equals(""+com.ext.util.FieldsMetaData.COMPTYPE_SELECT)) { %>
<a title="<%=LanguageUtil.get(pageContext, "gn.kms.option.list") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/listOption"/><portlet:param name="propertyid" value="<%= item.getMainid().toString() %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/all_pages.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.kms.option.list") %>"></a>
<% } %>
</display:column>

<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadProperty"/><portlet:param name="mainid" value="<%= item.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>

</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadProperty"/><portlet:param name="loadaction" value="add"/><portlet:param name="aspectid" value="<%= aspectid.toString() %>"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

<br><br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/kms/viewAspect"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "gn.kms.aspect.list") %></html:link></TD>
</TR></TABLE>