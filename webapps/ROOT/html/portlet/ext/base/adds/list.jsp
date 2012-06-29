<%@ include file="/html/portlet/ext/base/news/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/adds/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>