<%@ include file="/html/portlet/ext/topics/init.jsp" %>

<%
List topicList = (List) request.getAttribute("topicList");
ViewResult rootTopic = (ViewResult) request.getAttribute("rootTopic");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<br>

<!-- Action Types List -->
<display:table id="topic" name="topicList" requestURI="//ext/topics/view" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
	<% ViewResult gnTopic = (ViewResult) pageContext.getAttribute("topic"); %>
	<display:column class="gamma1" titleKey="gn.topics.topic.name" sortable="true" >
		<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/view"/><portlet:param name="mainid" value="<%= gnTopic.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>"><%= gnTopic.getField1().toString() %></a>
	</display:column>
	<%--
	<display:column style="text-align: right">
		<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/load"/><portlet:param name="mainid" value="<%= gnTopic.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/></portlet:actionURL>">
		<img src="/html/themes/classic/images/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>"></a>
		<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/load"/><portlet:param name="mainid" value="<%= gnTopic.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/></portlet:actionURL>">
		<img src="/html/themes/classic/images/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
		
		
		
		
	</display:column>
	--%>

	<c:if test="<%= hasEdit || hasDelete %>">
	<display:column style="text-align: right; white-space:nowrap;">
	<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnTopic.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
	<br>
	
	
	
	
	<div id="browse:actionsMenu_1_<%=gnTopic.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
		<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
		<tbody>
		<c:if test="<%= hasEdit %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/topics/load"/>
						<portlet:param name="mainid" value="<%= gnTopic.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
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
						<portlet:param name="struts_action" value="/ext/topics/load"/>
						<portlet:param name="mainid" value="<%= gnTopic.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="delete"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
				</a>
			</td>
						
		</tr>
		</c:if>
		
		
				<c:if test="<%= GnTopicPermission.contains(permissionChecker, gnTopic.getMainid(), ActionKeys.PERMISSIONS) %>">
						<tr>
						<td>
					<liferay-security:permissionsURL
						modelResource="gnomon.hibernate.model.gn.GnTopic"
						modelResourceDescription="<%=gnTopic.getField1().toString() %>"
						resourcePrimKey="<%= String.valueOf(gnTopic.getMainid()) %>"
						var="permissionsURL"
					/>

					<liferay-ui:icon image="permissions" url="<%= permissionsURL %>" />
					</td>
					<td>
						<a href="<%= permissionsURL %>" ><%=LanguageUtil.get(pageContext, "gn.link.permissions") %> </a>
					</td>
				</tr>
				</c:if>
		
		
		</tbody>
		</table>
	</div>
	</display:column>
	</c:if>

</display:table>

<br/>
<c:if test="<%= rootTopic!=null %>">
	<form name="GnTopicForm" action="/ext/topics/load" method="post">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/topics/load" />
		  <tiles:put name="buttonName" value="addButton" />
		  <tiles:put name="buttonValue" value="gn.button.add" />
		  <tiles:put name="formName"   value="GnTopicForm" />
		  <tiles:putList name="actionParamList">
		  	<tiles:add value="parentid"/>
		  	<tiles:add value="redirect"/>
		  </tiles:putList>
		 	<tiles:putList name="actionParamValueList">
		  	<tiles:add><%=rootTopic.getMainid().toString()%></tiles:add>
		  	<tiles:add><%=currentURL%></tiles:add>
		  </tiles:putList>
		  <tiles:put name="actionParam" value="loadaction"/>
		  <tiles:put name="actionParamValue" value="add"/>
		  <tiles:put name="actionPermission" value="add"/>
		  <tiles:put name="partyRoleActionPermission" value="add"/>
		  <tiles:put name="portletId" value="<%=portletID %>"/>
		</tiles:insert>
	</form>

	<%-- 
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/load"/><portlet:param name="loadaction" value="add"/><portlet:param name="parentid" value="<%=rootTopic.getMainid().toString()%>"/></portlet:actionURL>">
	<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>
	<br/><br/>
	 --%>
	<br/>
	<c:if test="<%= rootTopic.getField3() != null %>">
		<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/view"/><portlet:param name="mainid" value="<%=rootTopic.getField3().toString()%>"/></portlet:actionURL>">
		<img src="/html/themes/classic/images/common/back.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.list") %>">&nbsp;<%=LanguageUtil.get(pageContext, "back") %></a>
	</c:if>

	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/view"/></portlet:actionURL>">
	<img src="/html/themes/classic/images/common/top.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.root") %>">&nbsp;<%=LanguageUtil.get(pageContext, "home") %></a>
</c:if>

<c:if test="<%= rootTopic==null %>">
	<form name="GnTopicForm" action="/ext/topics/load" method="post">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/topics/load" />
		  <tiles:put name="buttonName" value="addButton" />
		  <tiles:put name="buttonValue" value="gn.button.add" />
		  <tiles:put name="formName"   value="GnTopicForm" />
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
	
	<%--
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/topics/load"/><portlet:param name="loadaction" value="add"/></portlet:actionURL>">
	<img src="/html/themes/classic/images/common/add_article.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.add") %>">&nbsp;<%=LanguageUtil.get(pageContext, "gn.button.add") %></a>
	--%>
</c:if>