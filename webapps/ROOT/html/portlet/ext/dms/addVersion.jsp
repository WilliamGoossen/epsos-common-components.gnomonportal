<%@ include file="/html/portlet/ext/dms/init.jsp" %>


<%
uuid = request.getParameter("uuid");
String contenttype="content";//request.getParameter("contenttype");
String parentuuid = request.getParameter("parentuuid");
PortletURLImpl PURL2 = new PortletURLImpl(request, "gn_dms", plid, true);
PURL2.setWindowState(WindowState.NORMAL);
PURL2.setPortletMode(PortletMode.VIEW);
PURL2.setParameter("struts_action", "/ext/dms/addVersion");
PURL2.setParameter("cmd", "add");
String url2 = PURL2.toString(); 
%>


<form action="<%=url2%>" method="post" name="<portlet:namespace />fm3" enctype="multipart/form-data">
<input class="form-text" name="<portlet:namespace />uuid" size="30" type="text" value="<%= uuid%>">
<input class="form-text" name="<portlet:namespace />parentuuid" size="30" type="text" value="<%= parentuuid%>">
<input class="form-text" name="<portlet:namespace />contenttype" size="30" type="text" value="<%= contenttype%>">
<input class="form-text" name="<portlet:namespace />cmd" size="30" type="hidden" value="add">
<input class="form-text" name="docFileContents" size="30" type="file" value="">
<input class="form-text" name="comments" size="30" type="text" value="">
<input class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "Upload File") %>">
</form>