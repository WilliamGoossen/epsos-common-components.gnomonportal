<%@ include file="/html/portlet/ext/base/banners/init.jsp" %>

<%
String includedPage = "/html/portlet/ext/base/banners/list" + prefs.getValue("list-style", "1") + ".jsp";
%>

<jsp:include page="<%=includedPage%>" flush="true"/>
