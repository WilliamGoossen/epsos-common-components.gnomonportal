<%@ include file="/html/portlet/ext/base/news/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


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
	<tiles:put name="struts_action" value="/ext/news/list"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="hasEdit" value="<%=hasEdit%>"/>
	<tiles:put name="hasDelete" value="<%=hasDelete%>"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.news.BsNew"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/news/menu/list_menu.jsp"/>
	<tiles:put name="requestURI" value="//ext/news/list?actionURL=true"/>
	<tiles:put name="requestAttr" value="news"/>
	<tiles:put name="currentURL" value="<%=currentURL%>"/>
	
</tiles:insert>

	<%} 
	} else  {%>

<!-- News List -->
<display:table id="new" name="news" requestURI="//ext/news/list?actionURL=true" pagesize="10" sort="list" export="false" style="width: 100%;">
<display:setProperty name="paging.banner.placement" value="both" />
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("new"); %>
	<display:column>
	
    <div class="news_title">
		<%= gnItem.getField4().toString() %>
    </div>

    <div class="date_news" >
    <%= gnomon.business.DateUtils.convertDate(StringUtils.check_null(gnItem.getField3(),""),"yyyy-MM-dd HH:mm:ss","dd-MM-yyyy")%><br>
    </div>
    
	<%--StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField5(),"")).trim(),200)<br> --%>
	<%=StringUtils.check_null(gnItem.getField5(),"")%>
    <div style="text-align:right;">
    <a  href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/news/load"/>
			<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
			<portlet:param name="loadaction" value="view"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>"><%=LanguageUtil.get(pageContext, "more") %></a></b>
    </div>
	</display:column>




	<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
		<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
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
									<portlet:param name="struts_action" value="/ext/news/load"/>
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
									<portlet:param name="struts_action" value="/ext/news/load"/>
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
								<portlet:param name="struts_action" value="/ext/news/load"/>
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
								<portlet:param name="struts_action" value="/ext/news/load"/>
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

<form name="BsNewForm" action="/ext/news/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/news/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsNewForm" />
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

