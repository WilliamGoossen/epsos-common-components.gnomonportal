<%@ include file="/html/portlet/ext/base/smslists/init.jsp" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>


<c:if test="<%= hasAdmin %>">
<%
String tab = ParamUtil.getString(request, "tab", "posts");
String mainid = ParamUtil.getString(request,"mainid");
%>

<liferay-ui:tabs
	names="posts,subscribers"
	param="tab"
	url="<%= currentURL %>"
/>

<c:choose>
	<c:when test='<%= tab.equals("subscribers") %>'>
		<!-- Subscribers List -->
		<display:table id="subscriber" name="subscribers" requestURI="//ext/smslists/load?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0; text-align:left">
			<% BsSmslistSubscriber gnItem = (BsSmslistSubscriber) pageContext.getAttribute("subscriber"); %>
			<display:column titleKey="email" sortable="true" style="width:100%">
				<%= gnItem.getUserPhoneNumber() %> <%= (gnItem.getUserid() != null) ?  "( "+gnItem.getUserid()+" )" : "" %> 
			</display:column>
			<display:column titleKey="bs.smslists.subscriber.user-fullName" sortable="true" style="width:100%">
				<%= (gnItem.getUserFullName() != null) ? gnItem.getUserFullName(): "" %>
			</display:column>
			<display:column titleKey="active" sortable="true" >
				<%= gnItem.getActive() %>
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
										<portlet:param name="struts_action" value="/ext/smslists/loadSubscriber"/>
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
										<portlet:param name="struts_action" value="/ext/smslists/loadSubscriber"/>
										<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
										<portlet:param name="smslistid" value="<%=mainid%>"/>
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
		<form name="BsSmsListSubscriberForm" action="/ext/smslists/loadSubscriber" method="post">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
			<tiles:put name="action"  value="/ext/smslists/loadSubscriber" />
			<tiles:put name="buttonName" value="addButton" />
			<tiles:put name="buttonValue" value="gn.button.add" />
			<tiles:put name="formName"   value="BsSmsListSubscriberForm" />
			<tiles:putList name="actionParamList">
			  	<tiles:add value="loadaction"/>
			  	<tiles:add value="smslistid"/>
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
		</tiles:insert>
		</form>
	</c:when>

	<c:otherwise>
		<%
		String sendSmsResponseMsg = null;
		sendSmsResponseMsg = (String)request.getAttribute("sendSmsResponseMsg");
		if (sendSmsResponseMsg != null){
		%>
		<liferay-ui:success key="request_processed" message="<%=sendSmsResponseMsg%>" />
		<%}%>
	
		<!-- Posts List -->
		<display:table id="post" name="posts" requestURI="//ext/smslists/load?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
			<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("post"); %>
			<display:column titleKey="title" sortable="true" style="width:100%">
				<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/smslists/loadPost"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="smslistid" value="<%= mainid %>"/>
						<portlet:param name="loadaction" value="view"/>
						<portlet:param name="smslistid" value="<%=mainid%>"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>"><%= gnItem.getField1() %></a>
			</display:column>

			
			<c:if test="<%= hasAdmin || hasEdit || hasDelete %>">
			<display:column style="text-align: right; white-space:nowrap;">
			<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
			<br>
			<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
				<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
				<tbody>
					<c:if test="<%= hasAdmin %>">
						<c:choose>
							<c:when test="<%=gnItem.getField4()==null || gnItem.getField4().toString().equals("false")%>">
								<tr>
									<td>
										&nbsp;
									</td>
									<td>
										<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
												<portlet:param name="struts_action" value="/ext/smslists/loadPostSend"/>
												<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
												<portlet:param name="loadaction" value="edit"/>
												<portlet:param name="redirect" value="<%=currentURL%>"/>
												</portlet:actionURL>">
										<%=LanguageUtil.get(pageContext, "bs.smslists.posts.send-post") %>
										</a>
									</td>
								</tr>
							</c:when>
							<c:otherwise>
								<tr>
									<td>
										&nbsp;
									</td>
									<td>
										<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
												<portlet:param name="struts_action" value="/ext/smslists/loadPostSend"/>
												<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
												<portlet:param name="loadaction" value="edit"/>
												<portlet:param name="redirect" value="<%=currentURL%>"/>
												</portlet:actionURL>">
										<%=LanguageUtil.get(pageContext, "bs.smslists.posts.re-send-post") %>
										</a>
									</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</c:if>
					<c:if test="<%= hasEdit %>">
						<tr>
							<td>
								<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>">
							</td>
							<td>
								<a href="<portlet:actionURL>
										<portlet:param name="struts_action" value="/ext/smslists/loadPost"/>
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
										<portlet:param name="struts_action" value="/ext/smslists/loadPost"/>
										<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
										<portlet:param name="smslistid" value="<%=mainid%>"/>
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
		<form name="BsSmsListPostForm" action="/ext/smslists/loadPost" method="post">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
			<tiles:put name="action"  value="/ext/smslists/loadPost" />
			<tiles:put name="buttonName" value="addButton" />
			<tiles:put name="buttonValue" value="gn.button.add" />
			<tiles:put name="formName"   value="BsSmsListPostForm" />
			<tiles:putList name="actionParamList">
			  	<tiles:add value="loadaction"/>
			  	<tiles:add value="smslistid"/>
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
		</tiles:insert>
		</form>
	</c:otherwise>
</c:choose>
<br/>
</c:if>

<html:link styleClass="beta1" action="/ext/smslists/list"><img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "back") %></html:link>

<%--
<display:column style="text-align: right">
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/smslists/loadPost"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="smslistid" value="<%= mainid %>"/><portlet:param name="loadaction" value="edit"/><portlet:param name="smslistid" value="<%=mainid%>"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>"></a>
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/smslists/loadPost"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="smslistid" value="<%= mainid %>"/><portlet:param name="loadaction" value="delete"/><portlet:param name="smslistid" value="<%=mainid%>"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>
--%>
<%--
<display:column style="text-align: right">
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/smslists/loadSubscriber"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="edit"/><portlet:param name="smslistid" value="<%=mainid%>"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>"></a>
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/smslists/loadSubscriber"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="delete"/><portlet:param name="smslistid" value="<%=mainid%>"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>
--%>