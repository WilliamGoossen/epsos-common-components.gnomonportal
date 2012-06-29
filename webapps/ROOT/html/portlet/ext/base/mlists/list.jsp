<%@ include file="/html/portlet/ext/base/mlists/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%--tiles:insert page="/html/portlet/ext/struts_includes/testDisplayTag.jsp" flush="true">
	<tiles:put name="viewStyle"  value="list" />
</tiles:insert--%>


<!-- MLists List -->
<display:table id="mlist" name="mlists" requestURI="//ext/mlists/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("mlist"); %>
	<display:column titleKey="bs.mlists.mlist" sortable="true" style="width:100%">
		<b><a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/mlists/load"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>"><%= gnItem.getField3().toString() %></a></b>
		<c:if test="<%= hasAdmin %>">
			<br/>
			(
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/mlists/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="view"/>
					<portlet:param name="tab" value="subscribers"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
					<%= gnItem.getField1().toString() %>&nbsp;<%=LanguageUtil.get(pageContext, "bs.mlists.mlist.subscribers") %></a>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/mlists/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="view"/>
					<portlet:param name="tab" value="posts"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>"><%= gnItem.getField2().toString() %>&nbsp;<%=LanguageUtil.get(pageContext, "bs.mlists.mlist.posts") %></a>
			)
		</c:if>
	</display:column>
	
	<c:if test="<%= hasAdmin || hasEdit || hasDelete %>">
		<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
			<tbody>
			<c:if test="<%= hasAdmin %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_articles.png" border="0" alt="<%=LanguageUtil.get(pageContext, "bs.mlists.mlist.posts") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/mlists/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="view"/>
								<portlet:param name="tab" value="posts"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "bs.mlists.mlist.posts") %>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_users.png" border="0" alt="<%=LanguageUtil.get(pageContext, "bs.mlists.mlist.subscribers") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/mlists/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="view"/>
								<portlet:param name="tab" value="subscribers"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "bs.mlists.mlist.subscribers") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/mlists/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="edit"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.button.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/mlists/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.button.delete") %>
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

<form name="MListForm1" action="/ext/mlists/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/mlists/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="MListForm1" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add value="topicid"/>
	  	<% } %>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add><%= request.getParameter("topicid") %></tiles:add>
	  	<% } %>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:put name="actionPermission" value="add"/>
	  <tiles:put name="partyRoleActionPermission" value="add"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</form>