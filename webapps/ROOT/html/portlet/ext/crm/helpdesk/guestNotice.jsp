<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>

<%

String requestCode = (String)request.getAttribute("requestCode");
String requestNotice = (String)request.getAttribute("requestNotice");

%>


<%=LanguageUtil.get(pageContext,"crm.helpdesk.request.category.submittedOk")%> &nbsp;<%=requestCode%> <br>

<%=requestNotice%>