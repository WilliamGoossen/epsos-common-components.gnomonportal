<%@ include file="/html/portlet/ext/base/civitems/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<!-- CivItems List -->
<display:table id="civitem" name="civitems" requestURI="//ext/civitems/list?actionURL=true" pagesize="10" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("civitem"); %>
<display:column titleKey="title" sortable="true" style="width:100%">
<a href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/civitems/load"/>
		<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
		<portlet:param name="loadaction" value="view"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>"><%= gnItem.getField6().toString() %></a>
</display:column>

<%--display:column property="field3" titleKey="bs.civitems.code" sortable="true"/--%>
<%long userid=PortalUtil.getUserId(request); 
	String providerId="0";
	if(gnItem!=null){
		providerId=gnItem.getField8().toString();		
	}
%>

<c:if test="<%= (hasPublish || hasEdit || hasDelete) || (userid==Long.valueOf(providerId))%>">
<display:column style="white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img alt="icon" src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="2" cellspacing="2">
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
							<portlet:param name="struts_action" value="/ext/civitems/load"/>
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
							<portlet:param name="struts_action" value="/ext/civitems/load"/>
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
	<c:if test="<%= (hasEdit || (userid==Long.valueOf(providerId)))%>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/civitems/load"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="edit"/>
						<portlet:param name="redirect" value="<%=currentURL%>"/>
						</portlet:actionURL>">
				<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
				</a>
			</td>
		</tr>
	</c:if>
	<c:if test="<%= (hasDelete || (userid==Long.valueOf(providerId)))%>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
			</td>
			<td>
				<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
						<portlet:param name="struts_action" value="/ext/civitems/load"/>
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

<% if (PortletPermissionUtil.contains(permissionChecker, plid, "bs_civitems", "add")) { %>
<form name="BsCivItemForm" action="/ext/civitems/load" method="post">
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "gn.button.add") %></legend>
	<span><%= LanguageUtil.get(pageContext, "bs.civitems.metadata.type") %></span>
	<select name="metadataClassId">
		<option name="" value=""></option>
	<%
		java.util.List classes = gnomon.hibernate.GnPersistenceService.getInstance(null).listObjects(null, 
			gnomon.hibernate.model.gn.kms.GnKmsClass.class, 
			"table1.className like 'bs.civitems.metadata.%' and table1.mainid in (select c.gnKmsClass.mainid from gnomon.hibernate.model.gn.kms.GnKmsClassAspect c where c.companyId = "+
			com.liferay.portal.util.PortalUtil.getCompanyId(request)+")", "table1.className");
		if (classes != null && classes.size() > 0) 
		{
			for (int i=0; i<classes.size(); i++)
			{
				gnomon.hibernate.model.gn.kms.GnKmsClass kmsClass = (gnomon.hibernate.model.gn.kms.GnKmsClass)classes.get(i);
				%>
				<option name="<%= kmsClass.getClassName() %>" value="<%= kmsClass.getMainid() %>"><%= LanguageUtil.get(pageContext, kmsClass.getClassName()) %></option>
				<%
			}
		}
		%>
	</select>
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/civitems/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsCivItemForm" />
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
</fieldset>	
</form>
<% } %>
