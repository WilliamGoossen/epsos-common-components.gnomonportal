<%@ include file="/html/portlet/ext/base/bookmarks/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/bookmarks/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>