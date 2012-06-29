<%@ include file="/html/portlet/ext/base/guestbook/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
java.text.SimpleDateFormat date_format = new java.text.SimpleDateFormat(com.ext.util.CommonDefs.DATE_TIME_FORMAT);
%>
<!-- Comment List -->
<display:table id="comment" name="comments" requestURI="//ext/guestbooks/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("comment"); %>
	<display:column titleKey="title" sortable="false"  >
	<b>
	<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/guestbook/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="view"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>"><%= gnItem.getField3().toString() %></a>
	</b>
	<br/>
	<%//=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField4(),"")).trim(),300)%>
	</display:column>
	<display:column>
	<%= Validator.isNotNull(gnItem.getField5()) ? date_format.format((java.util.Date)gnItem.getField5()) : "" %>
	</display:column>
	<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
	<display:column style="text-align: right; white-space:nowrap;">
	<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
	<br>
	<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
		<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
		<tbody>
		<c:if test="<%= hasPublish %>">
			<c:choose>
			<c:when test="<%=gnItem.getField1().toString().equals("false")%>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/redCheckMark.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/guestbook/load"/>
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
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/redActionDelete.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.reject") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/guestbook/load"/>
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
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/guestbook/load"/>
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
					<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/guestbook/load"/>
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

<form name="BsCommentForm" action="/ext/guestbook/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/guestbook/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsCommentForm" />
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