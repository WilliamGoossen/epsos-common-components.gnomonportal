<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%
boolean showRooms = GetterUtil.getBoolean(prefs.getValue("showOnlyRooms", StringPool.BLANK), false);

if (!showRooms) {
%>
<!--<h2><%= LanguageUtil.get(pageContext, "bs.events.building.list") %></h2>-->

<% 
String filePath = GetterUtil.getString(PropsUtil.get("base.events.buildings.store"), CommonDefs.DEFAULT_STORE_PATH); 
%>

<%--
		fields = new String[] {"langs.name", "table1.buildingCode", "table1.imageFile", "langs.description" };
--%>

<!-- News List -->
<display:table id="building" name="buildings" requestURI="//ext/eventlocations/listLocations?actionURL=true" pagesize="5" sort="list" export="false" style=" width:100%; border-spacing: 0">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("building"); %>
	<display:column titleKey="bs.events.building.name" sortable="false" >
     <div class="location_title">
     <a title="<%= gnItem.getField1().toString() %>" href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/eventlocations/loadLocation"/>
			<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
			<portlet:param name="loadaction" value="view"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
			<span><%= StringUtils.check_null(gnItem.getField1(),"") + (Validator.isNotNull(gnItem.getField2()) ? " ("+gnItem.getField2()+")" : "") %></span></a>
      </div>
    <div class="location_content">
    <div class="location_photo">
	<a title="<%= gnItem.getField1().toString() %>" href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/eventlocations/loadLocation"/>
			<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
			<portlet:param name="loadaction" value="view"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
           <% if (gnItem.getField3()!=null) { %>
				<img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + gnItem.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField3())%>" alt="<%= gnItem.getField1().toString() %>" />
			<% } %></a></div>
     
      <div class="location_description">  
	<%= StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField4(),"")).trim(),300) %></div>
    </div>
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
								<portlet:param name="struts_action" value="/ext/eventlocations/loadLocation"/>
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
								<portlet:param name="struts_action" value="/ext/eventlocations/loadLocation"/>
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

<form name="EvBuildingForm" action="/ext/news/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/eventlocations/loadLocation" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="EvBuildingForm" />
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




<!--  ROOMS in Building -->
<% } else {

//String[] fields = new String[] {"langs.name", "table1.roomCode", "table1.imageFile", "langs.description" };
List rooms = (List)request.getAttribute("roomsList");
String roomFilePath = GetterUtil.getString(PropsUtil.get("base.events.rooms.store"), CommonDefs.DEFAULT_STORE_PATH);
if (hasAdd || (rooms != null && rooms.size() > 0)) {
%>
<%-- <%= LanguageUtil.get(pageContext, "bs.events.room.list") %> --%>

<%
if (rooms != null && rooms.size() > 0) {
	%>
<display:table id="room" name="roomsList" requestURI="//ext/eventlocations/loadLocation?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("room"); %>

<display:column titleKey="bs.events.room.name" sortable="true" >
<div class="location_title">
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/eventlocations/loadRoom"/>
<portlet:param name="loadaction" value="view"/>
<portlet:param name="mainid" value="<%= gnItem.getMainid().toString()%>"/>
</portlet:actionURL>">
<span>
<%= gnItem.getField1().toString() + (Validator.isNotNull(gnItem.getField2()) ? " ("+gnItem.getField2()+")" : "")%>
</span>
</a>
</div>
<div class="location_content">
<div class="location_photo">
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/eventlocations/loadRoom"/>
<portlet:param name="loadaction" value="view"/>
<portlet:param name="mainid" value="<%= gnItem.getMainid().toString()%>"/>
</portlet:actionURL>">
<% if (gnItem.getField3()!=null) { %>
	<img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + roomFilePath + gnItem.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField3())%>" alt="<%= gnItem.getField1().toString() %>"   align="left" />
<% } %>
</a>
</div>
<div class="location_description">
<%= StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField4(),"")).trim(),300) %>
</div>
</div>
</display:column>

<c:if test="<%= (hasEdit || hasDelete) %>">
<display:column style="text-align: right; white-space:nowrap;">

<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_2_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>


<div id="browse:actionsMenu_2_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasEdit %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/eventlocations/loadRoom"/>
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
				<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/eventlocations/loadRoom"/>
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
<% } %>
<br>

<% } %>

<% } %>