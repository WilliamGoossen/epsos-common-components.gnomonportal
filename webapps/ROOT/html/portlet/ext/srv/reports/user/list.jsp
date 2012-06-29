<%@ include file="/html/portlet/ext/srv/reports/user/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<h2><%= LanguageUtil.get(pageContext, "srv.reports.list") %></h2>
<%
List serviceReports=(List) request.getAttribute("serviceReports");
System.out.println("AA");
%>

<form name="SRV_ServicesReport_ButtonForm" action="/some/url" method="post">

<input type="hidden" name="serviceid" value="<%= ParamUtil.getString(request,"serviceid") %>">
<% if (serviceReports!=null && serviceReports.size()>0) { %>
<display:table id="service" name="serviceReports" requestURI="//ext/srv_reports/list?actionURL=true" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">

<%
gnomon.hibernate.model.views.ViewResult gnItem = (gnomon.hibernate.model.views.ViewResult) pageContext.getAttribute("service"); %>
<%
String reportUrl="";
if(gnItem!=null) {
	 reportUrl =gnItem.getField5() + "?w=700&r="+ gnItem.getField6()+"&id=" + gnItem.getField3();
}
%>
<display:column>
<b><%= gnItem.getField1() %></b><br>
<a  href="#"  onClick="document.getElementById('frame_div').style.visibility='visible';document.getElementById('r_iframe').src='<%=reportUrl%>'"><%=gnItem.getField4()%></a>
</display:column>
<%--
<display:column property="field1" titleKey="srv.name" sortable="true" />
<display:column titleKey="srv.reports.name" sortable="true" >
	<a  href="#"  onClick="document.getElementById('frame_div').style.visibility='visible';document.getElementById('r_iframe').src='<%=reportUrl%>'"><%=gnItem.getField4()%></a>
	</display:column>
--%>


</display:table>


</form>

<br><br>
<div id="frame_div" style="visibility:hidden">
<iframe id="r_iframe" src="" width="950" height="400" frameborder="0"></iframe>
</div>
<% }
else { %>
<%= LanguageUtil.get(pageContext, "srv.reports.noapplications") %>
<% } %>