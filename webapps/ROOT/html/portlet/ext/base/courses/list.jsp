<%@ include file="/html/portlet/ext/base/courses/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/courses/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>
