<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<h2><%= LanguageUtil.get(pageContext, "bs.events.tickettype.list") %></h2>

<% 
String filePath = GetterUtil.getString(PropsUtil.get("base.events.tickettype.store"), CommonDefs.DEFAULT_STORE_PATH); 
%>

<%--
	fields = new String[] {"langs.name", "table1.ticketTypeCode", "table1.defaultDiscount", "langs.description" };
--%>

<!-- News List -->
<display:table id="tickettype" name="tickettypes" requestURI="//ext/eventtickettypes/listTicketTypes?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("tickettype"); %>
	<display:column titleKey="bs.events.tickettype.name" sortable="false" >
	<strong><a title="<%= gnItem.getField1().toString() %>" href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/eventtickettypes/loadTicketType"/>
			<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
			<portlet:param name="loadaction" value="view"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
			<%= StringUtils.check_null(gnItem.getField1(),"") + (Validator.isNotNull(gnItem.getField2()) ? " ("+gnItem.getField2()+")" : "") %></a></strong>
            <br>
            
	<%= StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField4(),"")).trim(),300) %>
	</display:column>
	<display:column titleKey="bs.events.tickettype.discount" sortable="false" >
	<%= (Validator.isNotNull(gnItem.getField3()) ? ((java.math.BigDecimal)gnItem.getField3()).setScale(2, java.math.BigDecimal.ROUND_HALF_UP).toString() + "%" : "")%>
	</display:column>
	<% if (hasEdit || hasDelete) { %>
	<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
								<portlet:param name="struts_action" value="/ext/eventtickettypes/loadTicketType"/>
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
								<portlet:param name="struts_action" value="/ext/eventtickettypes/loadTicketType"/>
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
	<% } %>
</display:table>



<br/><br/>

<form name="EvTicketTypeForm" action="/ext/news/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/eventtickettypes/loadTicketType" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="EvTicketTypeForm" />
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

<br>