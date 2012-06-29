<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<% String filePath = GetterUtil.getString(PropsUtil.get("base.yellowpages.store"), CommonDefs.DEFAULT_STORE_PATH); %>

<%--
		fields = new String[] {"table1.published",
							   "table1.publishDateStart",
							   "table1.entryDate",
							   "langs.title",
							   "langs.description",
							   "langs.image"
							   };
--%>
<%--
<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
<tiles:put name="struts_action" value="/ext/yellowpages/list"/>
<tiles:put name="contentClass" value="gnomon.hibernate.model.base.yellowpages.BsYellowPage"/>
</tiles:insert>
--%>

<%
if(instancePortletBrowseType.equals("metadata")) {%>

	<% if (request.getParameter("metadataid")!=null ) {%>

	<tiles:insert page="/html/portlet/ext/struts_includes/listMetadataContent.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/yellowpages/list"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="hasEdit" value="<%=hasEdit%>"/>
	<tiles:put name="hasDelete" value="<%=hasDelete%>"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.yellowpages.BsYellowPage"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/yellowpages/menu/list_menu.jsp"/>
	<tiles:put name="requestURI" value="//ext/yellowpages/list?actionURL=true"/>
	<tiles:put name="requestAttr" value="yellowpages"/>
	<tiles:put name="currentURL" value="<%=currentURL%>"/>

</tiles:insert>

	<%}
}%>

<!-- YellowPages List -->
<display:table id="yp" name="yellowpages" requestURI="//ext/yellowpages/list?actionURL=true" pagesize="25" sort="list" export="false" style="width: 100%;">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("yp");  %>
	
	<display:column>
		<%  request.setAttribute("yellowpageItem", gnItem); %>
        <jsp:include page="yellowpageTile.jsp" flush="true"/>
	</display:column>


	<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
		<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
			<tbody>
            <%
            String assignedUserId = gnItem.getField18()!=null? gnItem.getField18().toString(): "";
            %>
            <c:if test="<%= isWebSpaceEnabled && hasEdit && Validator.isNull(assignedUserId)%>">
                <tr>
                    <td>
                        <img src="<%= themeDisplay.getPathThemeImage() %>/base/create_web_space.gif" border="0" alt="">
                    </td>
                    <td>
                        <a href="<portlet:renderURL>
                                <portlet:param name="struts_action" value="/ext/yellowpages/editUA"/>
                                <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
                                <portlet:param name="loadaction" value="edit"/>
                                <portlet:param name="redirect" value="<%=currentURL%>"/>
                                </portlet:renderURL>">
                        <%=LanguageUtil.get(pageContext, "bs.yellowpages.ua.assign-user") %>
                        </a>
                    </td>
                </tr>
            </c:if>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
								<portlet:param name="struts_action" value="/ext/yellowpages/load"/>
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
								<portlet:param name="struts_action" value="/ext/yellowpages/load"/>
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

<form name="BsYellowPageForm" action="/ext/yellowpages/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/yellowpages/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsYellowPageForm" />
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

