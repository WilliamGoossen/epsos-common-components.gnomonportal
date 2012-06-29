<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>



<% try {

	String lookupFieldIdHtmlId = request.getParameter("lookupFieldIdHtmlId");
	String lookupFieldDisplHtmlId = request.getParameter("lookupFieldDisplHtmlId");
	String openerFormName = request.getParameter("openerFormName");
%>

<%@ include file="/html/portlet/ext/struts_includes/Lookup_js.jsp" %>

<%
String lookupActionUrl = "/ext/events/lookupYellowPage?actionURL=true";
%>
<html:form action="<%= lookupActionUrl %>" method="post">
<table>
	<tr><td>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
		<tiles:put name="formName" value="BsLookupYellowPageForm"/>
	</tiles:insert>
	</td><td>
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "gn.button.search") %>">
	</td></tr>
</table>
</html:form>
<br>
<%
List itemsList=(List) request.getAttribute("itemsList");
%>
<form name="BsYellowPage_Lookup_List_Form" method="post" action="/some/url">
<h1><%= LanguageUtil.get(pageContext, "bs.yellowpages.list" ) %></h1>
<display:table id="items" name="itemsList" requestURI="//ext/events/lookupYellowPage" pagesize="20" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult listItem = (ViewResult)pageContext.getAttribute("items"); %>
<display:column >
<input type="radio" name="group1" value="<%=listItem.getMainid() + "&" + listItem.getField1() %>">
</display:column>
<display:column property="field1" titleKey="bs.yellowpages.title" sortable="true" headerClass="sortable"/>
<display:column property="field2" titleKey="bs.yellowpages.description" sortable="true" headerClass="sortable"/>
<display:column property="field3" titleKey="bs.yellowpages.address" sortable="true" headerClass="sortable"/>
<display:column property="field4" titleKey="bs.yellowpages.email" sortable="true" headerClass="sortable"/>
</display:table>
<% if (itemsList.size() > 0) { %>
<input type="button" class="portlet-form-button" name="Select" value="<%= LanguageUtil.get(pageContext, "gn.button.select")%>" onclick="onSelect('BsYellowPage_Lookup_List_Form', 'group1')">
<% } %>
<input type="button" class="portlet-form-button" name="Clear" value="<%= LanguageUtil.get(pageContext, "gn.button.clear")%>" onclick="onClear()">

</form>


<% } catch (Exception e) {} %>