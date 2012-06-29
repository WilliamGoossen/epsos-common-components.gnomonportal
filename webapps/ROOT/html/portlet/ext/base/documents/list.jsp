<%@ include file="/html/portlet/ext/base/documents/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/documents/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>
