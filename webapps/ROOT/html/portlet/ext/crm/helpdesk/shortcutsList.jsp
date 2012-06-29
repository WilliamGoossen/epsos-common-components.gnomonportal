<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestSearchForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<% try {%>

<table width="100%">
<tr valign="top">
<td>
<%


Integer VISIBLE_DUE_TO_CATEGORY_COUNTER = (Integer)request.getAttribute("VISIBLE_DUE_TO_CATEGORY");
Integer VISIBLE_DUE_TO_ASSIGNMENT_COUNTER = (Integer)request.getAttribute("VISIBLE_DUE_TO_ASSIGNMENT");
Integer VISIBLE_DUE_TO_MANAGEMENT_COUNTER = (Integer)request.getAttribute("VISIBLE_DUE_TO_MANAGEMENT");
Integer VISIBLE_DUE_TO_CREATION_COUNTER = (Integer)request.getAttribute("VISIBLE_DUE_TO_CREATION");





List<ViewResult> allStatusCount = (List<ViewResult>) request.getAttribute("countByStatus");
List<ViewResult> allCategoryCount = (List<ViewResult>) request.getAttribute("countByCategory");
List<ViewResult> allRtypeCount = (List<ViewResult>) request.getAttribute("countByReqType");
List<ViewResult> allCheckCount = (List<ViewResult>) request.getAttribute("countByCheckType");
%>

<fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.status") %></legend>
<ul>
<% Iterator iter = allStatusCount.iterator();

while(iter.hasNext()) {
	ViewResult gnItem = (ViewResult)iter.next();%>
	
	<li><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="status" value="<%= gnItem.getField2().toString() %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.request.status"/>
<portlet:param name="titleDataValue" value="<%="crm.helpdesk.status." +gnItem.getField2().toString()%>"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.status." +gnItem.getField2().toString()) %>
(<%= gnItem.getField1().toString()%>)</a>
</li>
	
<%}%>
	

</ul>
</fieldset>

</td>
<td>&nbsp;&nbsp;</td>
<td>

<fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.category") %> </legend>

<ul>

<%  iter = allCategoryCount.iterator();

while(iter.hasNext()) {
	ViewResult gnItem = (ViewResult)iter.next();%>
	
	<li><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="reqCategory" value="<%= gnItem.getField2().toString() %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.request.category"/>
<portlet:param name="titleDataValue" value="<%= gnItem.getField3().toString()%>"/>
</portlet:actionURL>"><%= gnItem.getField3().toString() %>
(<%= gnItem.getField1().toString()%>)</a>
</li>
	
<%}%>


</ul>
</fieldset>

</td>
<td>&nbsp;&nbsp;</td>
<td>

<%
//if (CrmService.SHOW_REQUEST_TYPE) { 
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) {
%>
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.type") %> </legend>

<ul>


<%  iter = allRtypeCount.iterator();

while(iter.hasNext()) {
	ViewResult gnItem = (ViewResult)iter.next();%>
	
	<li><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="reqType" value="<%= gnItem.getField2().toString() %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.request.type"/>
<portlet:param name="titleDataValue" value="<%= gnItem.getField3().toString() %>"/>
</portlet:actionURL>"><%= gnItem.getField3().toString() %>
(<%= gnItem.getField1().toString()%>)</a>
</li>
	
<%}%>

</ul>

</fieldset>
<% } %>

<% if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-check-type"),false)) { %>
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.checktype.name") %></legend>
<ul>




<%  iter = allCheckCount.iterator();

while(iter.hasNext()) {
	ViewResult gnItem = (ViewResult)iter.next();%>
	
	<li><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="checkType" value="<%= gnItem.getField2().toString() %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.checktype.name"/>
<portlet:param name="titleDataValue" value="<%= gnItem.getField3().toString() %>"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, gnItem.getField3().toString()) %>
(<%= gnItem.getField1().toString()%>)</a>
</li>
	
<%}%>
</ul>
</fieldset>
<% } %>
</td>
</tr>
<tr>
<td colspan="5">
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.visible") %></legend>
<ul>
<li>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="visibilityType" value="<%= CrRequestSearchForm.VISIBLE_DUE_TO_CATEGORY %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.request.visible"/>
<portlet:param name="titleDataValue" value="crm.helpdesk.request.visible.due-to-category"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.visible.due-to-category") %>( <%= VISIBLE_DUE_TO_CATEGORY_COUNTER != null? VISIBLE_DUE_TO_CATEGORY_COUNTER.toString() : "0" %> )</a>
</li>
<li>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="visibilityType" value="<%= CrRequestSearchForm.VISIBLE_DUE_TO_ASSIGNMENT %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.request.visible"/>
<portlet:param name="titleDataValue" value="crm.helpdesk.request.visible.due-to-assignment"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.visible.due-to-assignment") %>( <%= VISIBLE_DUE_TO_ASSIGNMENT_COUNTER != null? VISIBLE_DUE_TO_ASSIGNMENT_COUNTER.toString() : "0" %> )</a>
</li>
<li>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="visibilityType" value="<%= CrRequestSearchForm.VISIBLE_DUE_TO_CREATION %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.request.visible"/>
<portlet:param name="titleDataValue" value="crm.helpdesk.request.visible.due-to-creation"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.visible.due-to-creation") %>( <%= VISIBLE_DUE_TO_CREATION_COUNTER != null? VISIBLE_DUE_TO_CREATION_COUNTER.toString() : "0" %> )</a>
</li>
<li>
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdesk/list"/>
<portlet:param name="search" value="search"/>
<portlet:param name="visibilityType" value="<%= CrRequestSearchForm.VISIBLE_DUE_TO_MANAGEMENT %>"/>
<portlet:param name="titleDataKey" value="crm.helpdesk.request.visible"/>
<portlet:param name="titleDataValue" value="crm.helpdesk.request.visible.due-to-management"/>
</portlet:actionURL>"><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.visible.due-to-management") %>( <%= VISIBLE_DUE_TO_MANAGEMENT_COUNTER != null? VISIBLE_DUE_TO_MANAGEMENT_COUNTER.toString() : "0" %> )</a>
</li>
</ul>
</fieldset>

</td>
</tr>
<tr>
<td colspan="5">
<br>
<jsp:include page="/html/portlet/ext/crm/helpdesk/list_tile.jsp" />

</td>
</tr>
</table>

<%} catch (Exception e) {
	e.printStackTrace();
}%>