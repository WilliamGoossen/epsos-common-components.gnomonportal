<%@ include file="/html/portlet/ext/base/civitems/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/civitems/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>
