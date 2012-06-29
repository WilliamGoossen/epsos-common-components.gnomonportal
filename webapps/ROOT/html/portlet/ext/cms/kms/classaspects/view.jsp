<%@ include file="/html/portlet/ext/cms/kms/init.jsp" %>

<%@ page import="gnomon.hibernate.model.gn.kms.GnKmsClassAspect" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%
List actionList=(List) request.getAttribute("aspectList");
GnPersistenceService serv = GnPersistenceService.getInstance(null);
String lang = GeneralUtils.getLocale(request);
String[] descFields = new String[]{"langs.description"};
%>

<h2><%= LanguageUtil.get(pageContext, "gn.kms.classaspect.list") %></h2>

<display:table id="aspect" name="aspectList" requestURI="//ext/kms/viewClassAspect" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% GnKmsClassAspect gnAspect = (GnKmsClassAspect) pageContext.getAttribute("aspect"); %>
<display:column   titleKey="gn.kms.classaspect.classname" sortable="true">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadClassAspect"/><portlet:param name="mainid" value="<%= gnAspect.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>"><%= gnAspect.getClassName() %></a>
</display:column>
<display:column   titleKey="gn.kms.classaspect.aspectid" sortable="true">
<%= gnAspect.getGnKmsAspect().getName() %>
</display:column>
<display:column   titleKey="gn.kms.classaspect.enabled" sortable="true">
<%= gnAspect.isEnabled() %>
</display:column>
<display:column titleKey="gn.kms.classaspect.partyid" sortable="true">
<% if (gnAspect.getPaParty() != null) {
	ViewResult partyView = serv.getObjectWithLanguage(PaParty.class, gnAspect.getPaParty().getMainid(), lang, descFields);
	if (partyView != null)
		out.print(partyView.getField1());
}
%>
</display:column>
<display:column style="text-align: right; height: 20;">
<a title="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadClassAspect"/><portlet:param name="mainid" value="<%= gnAspect.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>

</display:table>

<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/kms/loadClassAspect"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>">
<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>

