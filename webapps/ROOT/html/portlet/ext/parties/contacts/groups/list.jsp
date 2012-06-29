<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<h2><%= LanguageUtil.get(pageContext, "contacts.group.list") %></h2>
<!-- Groups List -->
<display:table id="group" name="groups" requestURI="//ext/parties/contacts/listGroups?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("group"); %>
<display:column titleKey="contacts.group.name" sortable="true" style="width:100%">
<strong>
<a href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/parties/contacts/loadGroup"/>
		<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
		<portlet:param name="loadaction" value="view"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>">
		<%= gnItem.getField1().toString() %>
        </a></strong>
<br/>
<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField2(),"")).trim(),200)%>
</display:column>

<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasEdit %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/parties/contacts/loadGroup"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
				</a>
			</td>
		</tr>
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_users.png" border="0" alt="<%=LanguageUtil.get(pageContext, "contacts.group.member.list") %>">
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/parties/contacts/listGroupMembers"/>
						<portlet:param name="groupid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "contacts.group.member.list") %>
				</a>
			</td>
		</tr>
	</c:if>
	<c:if test="<%= hasDelete %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/parties/contacts/loadGroup"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="delete"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
				</a>
			</td>
		</tr>
	</c:if>
	</tbody>
	</table>
</div>
</display:column>
</c:if>

</display:table>
<br/><br/>

<form name="PaPartyGroupForm" action="/ext/parties/contacts/loadGroup" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/parties/contacts/loadGroup" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="PaPartyGroupForm" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:put name="actionPermission" value="add"/>
	  <tiles:put name="partyRoleActionPermission" value="add"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</form>

<br>

<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><a href="<portlet:actionURL></portlet:actionURL>"><%= LanguageUtil.get(pageContext, "contacts.link.back") %></a>
