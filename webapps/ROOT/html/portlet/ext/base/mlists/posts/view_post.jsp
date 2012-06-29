<%@ include file="/html/portlet/ext/base/mlists/init.jsp" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String mainid = ParamUtil.getString(request,"mainid");
%>

<liferay-ui:tabs
	names="attach-to-message"
	param="tab"
/>

<!-- Attachments List -->
<display:table id="attachment" name="attachments" requestURI="//ext/mlists/loadPost?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("attachment"); %>


<display:column titleKey="title" sortable="true" style="width:100%">
<b>
<c:choose>
	<c:when test="<%=gnItem.getField2()!=null%>">
		<%String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(gnItem.getField2().toString(), "page");%>
		<img align="left" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
		<a target="_blank" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>"><portlet:param name="struts_action" value="/ext/mlists/getPostFile"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>"><%= gnItem.getField2().toString() %></a>
		</img>
	</c:when>
	<c:otherwise>
		<%= gnItem.getField2().toString() %>
	</c:otherwise>
</c:choose>
</b>
</display:column>

		
<c:if test="<%= hasEdit || hasDelete %>">		
	<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
									<portlet:param name="struts_action" value="/ext/mlists/loadPostFile"/>
									<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
									<portlet:param name="postid" value="<%= mainid %>"/>
									<portlet:param name="loadaction" value="edit"/>
									<portlet:param name="redirect" value="<%=currentURL%>"/>
									</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.button.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
									<portlet:param name="struts_action" value="/ext/mlists/loadPostFile"/>
									<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
									<portlet:param name="postid" value="<%= mainid %>"/>
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

<br/>
<form name="BsMListPostFileForm" action="/ext/mlists/loadPostFile" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/mlists/loadPostFile" />
	<tiles:put name="buttonName" value="addButton" />
	<tiles:put name="buttonValue" value="add-attachment" />
	<tiles:put name="formName"   value="BsMListPostFileForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="postid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="add"/>
	  	<tiles:add><%=mainid%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="add"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
	<tiles:put name="postid" value="<%=mainid%>"/>
</tiles:insert>
</form>

<%
	java.util.HashMap params = new java.util.HashMap();

	params.put("mainid", request.getParameter("mlistid"));
	params.put("loadaction", "view");

	pageContext.setAttribute("paramsName", params);
%>
<br/>
<html:link styleClass="beta1" action="/ext/mlists/load" name="paramsName">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">
&nbsp;<%= LanguageUtil.get(pageContext, "back") %>
</html:link>




		<%--
		<display:column titleKey="filename" sortable="true" >
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/mlists/getPostFile"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="postid" value="<%= mainid %>"/><portlet:param name="loadaction" value="view"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>"><%= gnItem.getField2() %></a>
		</display:column>
		
		<display:column style="text-align: right">
			<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/mlists/loadPostFile"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="postid" value="<%= mainid %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>"></a>
			<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/mlists/loadPostFile"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="postid" value="<%= mainid %>"/>
						<portlet:param name="loadaction" value="delete"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
		</display:column>
		--%>