<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/faq/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>