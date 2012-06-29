<%@ include file="/html/portlet/ext/dms/init.jsp" %>


<%
String foldername = ParamUtil.getString(request, "foldername");
uuid = ParamUtil.getString(request, "uuid");
String parentuuid = ParamUtil.getString(request, "parentuuid");
PortletURL PURL2 = new PortletURLImpl(request, "gn_dms", plid, true);
PURL2.setWindowState(WindowState.NORMAL);
PURL2.setPortletMode(PortletMode.VIEW);
PURL2.setParameter("struts_action", "/ext/dms/updateFolder");
String url2 = PURL2.toString(); 
%>
<form action="<%=url2%>" method="post" name="<portlet:namespace />fm2">
<input class="form-text" name="<portlet:namespace />foldername" size="30" type="text" value="<%= foldername %>">
<input class="form-text" name="<portlet:namespace />uuid" size="30" type="hidden" value="<%= uuid %>">
<input class="form-text" name="<portlet:namespace />parentuuid" size="30" type="hidden" value="<%= parentuuid %>">
<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "update") %>">
<input class="portlet-form-button" type="button" onClick="javascript:history.go(-1);" value="<%= LanguageUtil.get(pageContext, "cancel") %>">
</form>

