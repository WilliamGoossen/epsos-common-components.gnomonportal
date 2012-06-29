<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/events/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>