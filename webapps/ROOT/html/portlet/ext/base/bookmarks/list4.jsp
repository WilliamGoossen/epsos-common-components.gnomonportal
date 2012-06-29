<%@ include file="/html/portlet/ext/base/bookmarks/init.jsp" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<!-- Bookmarks List -->
<display:table id="bookmark" name="bookmarks" requestURI="//ext/bookmarks/list?actionURL=true"  sort="list" export="false" style="width: 100%;">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("bookmark"); %>

<display:column   >
	<strong>
	<c:choose>
	<c:when test="<%=gnItem.getField6()!=null && Validator.isNotNull(gnItem.getField6().toString()) %>">
		<a href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/bookmarks/goto" />
			<portlet:param name="loc" value="<%=gnItem.getField6().toString()%>" />
			<portlet:param name="mainid" value="<%=gnItem.getMainid()+""%>" />
			</portlet:actionURL>"
			target="<%=gnItem.getField4().toString()%>">
			<%= gnItem.getField5().toString() %>
		</a>
	</c:when>
	<c:otherwise>
		<%= gnItem.getField5().toString() %>
	</c:otherwise>
	</c:choose>
	</strong>
	<br/>
	<%= StringUtils.check_null(gnItem.getField7(),gnItem.getField7().toString()) %>
</display:column>


<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="middle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasPublish %>">
		<c:choose>
		<c:when test="<%=gnItem.getField1().toString().equals("false")%>">
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/plum/iconDocumentApprove.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
				</td>
				<td>
					<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
							<portlet:param name="struts_action" value="/ext/bookmarks/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="edit"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "gn.link.approve") %>
					</a>
				</td>
			</tr>
		</c:when>
		<c:when test="<%=gnItem.getField1().toString().equals("true")%>">
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/plum/iconDocumentReject.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.reject") %>">
				</td>
				<td>
					<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
							<portlet:param name="struts_action" value="/ext/bookmarks/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="edit"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "gn.link.reject") %>
					</a>
				</td>
			</tr>
		</c:when>
		</c:choose>
	</c:if>
	<c:if test="<%= hasEdit %>">
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
		</td>
		<td>
			<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
					<portlet:param name="struts_action" value="/ext/bookmarks/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
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
					<portlet:param name="struts_action" value="/ext/bookmarks/load"/>
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

<br/>

<form name="BsBookmarkForm" action="/ext/bookmarks/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/bookmarks/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsBookmarkForm" />
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