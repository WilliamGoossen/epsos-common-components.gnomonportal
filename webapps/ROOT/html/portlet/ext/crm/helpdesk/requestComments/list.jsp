<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>

<%@ page import="gnomon.hibernate.model.crm.CrRequestComment" %>
<%@ page import="com.ext.portlet.crm.helpdesk.requestComments.CrRequestCommentForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.categories.auditors.CrCategoryAuditorForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%
try {
Integer requestid = (Integer)request.getAttribute("requestid");
List commentsList=(List) request.getAttribute("commentsList");
GnPersistenceService serv = GnPersistenceService.getInstance(null);
String lang = GeneralUtils.getLocale(request);
String[] partyNameFields = new String[]{"langs.description"};
PaPerson person = PartiesService.getInstance().getPaPerson(user.getUserId());
boolean hasComment = 
	PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.COMMENT) ||
	CrmService.getInstance().userHasAuditorRight(user.getUserId(), requestid, CrCategoryAuditorForm.RIGHTS_COMMENT);
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h3><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %></h3>

<form name="CRM_Request_Comments_ButtonForm" action="/some/url" method="post">
<display:table id="comment" name="commentsList" requestURI="//ext/crm/helpdesk/listRequestComments" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% CrRequestComment gnItem = (CrRequestComment) pageContext.getAttribute("comment"); %>
<display:column titleKey="crm.helpdesk.request.comment.partyid" sortable="true">
<%
ViewResult partyView = serv.getObjectWithLanguage(PaParty.class, gnItem.getPaParty().getMainid(), lang, partyNameFields);
out.print(partyView.getField1());
 %>
</display:column>
<display:column titleKey="crm.helpdesk.request.comment.date" sortable="true">
<%= CrRequestCommentForm.date_time_format.format(gnItem.getCommentDate()) %>
</display:column>
<display:column property="commentTitle" titleKey="crm.helpdesk.request.comment.title" sortable="true"/>
<display:column titleKey="crm.helpdesk.request.showcomments" sortable="true">
<% if (gnItem.isShowComments()) { %>
<%= LanguageUtil.get(pageContext, "yes") %>
<% } else { %>
<%= LanguageUtil.get(pageContext, "no") %>
<% } %>
</display:column>
<display:column property="commentText" titleKey="crm.helpdesk.request.comment.text" sortable="true"/>

<% if (hasComment) { %>
<display:column style="text-align: right; white-space:nowrap;">
<% if (gnItem.getPaParty().getMainid().equals(person.getMainid())) { %>
<a href="#" onclick="javascript:_toggleMenu(event, '<portlet:namespace/>browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
<br>
<div id="<portlet:namespace/>browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/helpdesk/loadRequestComment"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="edit"/>
					<portlet:param name="requestid" value="<%= requestid.toString() %>"/>
					<portlet:param name="redirect" value="<%= redirect %>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/crm/helpdesk/loadRequestComment"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="delete"/>
					<portlet:param name="requestid" value="<%= requestid.toString() %>"/>
					<portlet:param name="redirect" value="<%= redirect %>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
			</a>
		</td>
	</tr>
	</tbody>
	</table>
</div>
<% } %>
</display:column>
<% } %>

</display:table>
<br />

<% if (hasAdd && hasComment) {%>
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/crm/helpdesk/loadRequestComment" />
	  <tiles:put name="buttonName" value="addButtonRequestComment" />
	  <tiles:put name="buttonValue" value="crm.button.add" />
	  <tiles:put name="formName"   value="CRM_Request_Comments_ButtonForm" />
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="requestid"/>
	  	<tiles:add value="redirect"/>
	  </tiles:putList>
	  <tiles:putList name="actionParamValueList">
	  	<tiles:add><%= requestid.toString() %></tiles:add>
	  	<tiles:add><%= redirect %></tiles:add>
	  </tiles:putList>
	</tiles:insert>
<% } %>

</form>
<br>


<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="middle">&nbsp;<a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "crm.button.back") %></a>


<% } catch (Exception e) { e.printStackTrace();} %>