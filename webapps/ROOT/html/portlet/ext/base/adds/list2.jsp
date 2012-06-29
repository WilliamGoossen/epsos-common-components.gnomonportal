<%@ include file="/html/portlet/ext/base/adds/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<% String filePath = GetterUtil.getString(PropsUtil.get("base.news.store"), CommonDefs.DEFAULT_STORE_PATH); %>

<%--
		fields = new String[] {"table1.published",
							   "table1.publishDateStart",
							   "table1.newDate",
							   "langs.title",
							   "langs.description",
							   "langs.image"
							   };
--%>
<%--
<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
<tiles:put name="struts_action" value="/ext/news/list"/>
<tiles:put name="contentClass" value="gnomon.hibernate.model.base.news.BsNew"/>
</tiles:insert>
--%>
<%
if(instancePortletBrowseType.equals("metadata")) {%>

	<% if (request.getParameter("metadataid")!=null ) {%>

	<tiles:insert page="/html/portlet/ext/struts_includes/listMetadataContent.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/adds/list"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="hasEdit" value="<%=hasEdit%>"/>
	<tiles:put name="hasDelete" value="<%=hasDelete%>"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.news.BsNew"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/adds/menu/list_menu.jsp"/>
	<tiles:put name="requestURI" value="//ext/adds/list?actionURL=true"/>
	<tiles:put name="requestAttr" value="news"/>
	<tiles:put name="currentURL" value="<%=currentURL%>"/>

</tiles:insert>

	<%}
	} else  {%>

<!-- adds List -->
<display:table id="new" name="news" requestURI="//ext/adds/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("new"); %>
	<display:column titleKey="title" sortable="false" >
    
    
    
        
	<strong><a href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/adds/load"/>
			<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
			<portlet:param name="loadaction" value="view"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
			
            <c:if test="<%=gnItem.getField6()!=null%>">
			<img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + gnItem.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField6())%>" alt="<%= gnItem.getField4().toString() %>" align="left" />
			</c:if>
            
			<%= gnomon.business.DateUtils.convertDate(StringUtils.check_null(gnItem.getField3(),""),"yyyy-MM-dd HH:mm:ss","dd-MM-yyyy")%>&nbsp;-&nbsp; <%= gnItem.getField4().toString() %></a></strong>
            
            <br>
            
	<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField5(),"")).trim(),200)%>
	</display:column>


	<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
		<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
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
									<portlet:param name="struts_action" value="/ext/adds/load"/>
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
									<portlet:param name="struts_action" value="/ext/adds/load"/>
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
								<portlet:param name="struts_action" value="/ext/adds/load"/>
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
								<portlet:param name="struts_action" value="/ext/adds/load"/>
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

<%}%>

<br/><br/>

<form name="BsAddsForm" action="/ext/adds/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/adds/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsAddsForm" />
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

