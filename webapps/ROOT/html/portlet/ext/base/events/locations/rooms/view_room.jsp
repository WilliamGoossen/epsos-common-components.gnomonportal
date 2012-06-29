<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<!--<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>-->

<div class="journal-content-article" id="location-view">

<% 
String filePath = GetterUtil.getString(PropsUtil.get("base.events.rooms.store"), CommonDefs.DEFAULT_STORE_PATH);
ViewResult view = (ViewResult) request.getAttribute("roomItem"); 
%>
<%-- 
		String[] fields = new String[] {"langs.mainid",
										"table1.roomCode",
									    "table1.imageFile",
									    "table1.mapImageFile",
										"langs.name", 
										"langs.lang",
										"langs.description"};
--%>
<div class="location-view-content">
<c:if test="<%=view.getField3()!=null%>">
<div class="location-view-photo">
	<img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + StringUtils.check_null(view.getField3(),"")%>" 
	alt="<%= view.getField5() %>" hspace="5" vspace="5" align="left" />
   </div>
</c:if>

<c:if test="<%=view.getField4()!=null%>">
	<img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + StringUtils.check_null(view.getField4(),"")%>" 
	alt="<%= view.getField5() %>" hspace="5" vspace="5" align="right" />
</c:if>

<div class="location-view-title">
<%= view.getField5().toString() + (Validator.isNotNull(view.getField2()) ? " (" + view.getField2()+")" : "")%>
</div>

<div class="location-view-description">
<%=view.getField7().toString()%>
</div>
</div>

<br/>

		<c:choose>
			<c:when test="<%=Validator.isNull(redirect)%>">
            <div class="location-view-back">
				<a href="#" onClick="history.go(-1);"> 
				<%= LanguageUtil.get(pageContext, "back") %>
				</a>
                </div>
			</c:when>
		
        <c:otherwise>
         <div class="location-view-back">
				<a <%="href=\"" + redirect + "\"" %>> 
				<%= LanguageUtil.get(pageContext, "more") %>
				</a>	
            </div>		
		</c:otherwise>
		</c:choose>
	

<br>
</div>

<!--  ZONES in ROOM -->
<%
//String[] fields = new String[] {"langs.name", "table1.zoneCode", langs.description" };
List zones = (List)request.getAttribute("zonesList");
if (hasAdd || hasEdit) {
%>
<fieldset>
<legend>
<%= LanguageUtil.get(pageContext, "bs.events.zone.list") %>
</legend>

<%
if (zones != null && zones.size() > 0) {
	%>
<display:table id="zone" name="zonesList" requestURI="//ext/eventlocations/loadRoom?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("zone"); %>

<display:column titleKey="bs.events.zone.name" sortable="true" >
<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/eventlocations/loadZone"/>
<portlet:param name="loadaction" value="view"/>
<portlet:param name="mainid" value="<%= gnItem.getMainid().toString()%>"/>
</portlet:actionURL>">
<%= gnItem.getField1().toString() + (Validator.isNotNull(gnItem.getField2()) ? " ("+gnItem.getField2()+")" : "")%>
</a>
<br>
<%= StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField3(),"")).trim(),300) %>
</display:column>

<c:if test="<%= (hasEdit || hasDelete) %>">
<display:column style="text-align: right; white-space:nowrap;">

<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_2_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>

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
						<portlet:param name="struts_action" value="/ext/eventlocations/loadZone"/>
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
						<portlet:param name="struts_action" value="/ext/eventlocations/loadZone"/>
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
<c:if test="<%= hasAdd %>">
<form name="EvZoneForm" action="/ext/eventlocations/loadZone" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/eventlocations/loadZone" />
	<tiles:put name="buttonName" value="addButtonZone" />
	<tiles:put name="buttonValue" value="gn.button.add" />
	<tiles:put name="formName"   value="EvZoneForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="roomid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="add"/>
	  	<tiles:add><%=view.getMainid().toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
	<tiles:put name="actionPermission" value="add"/>
	<tiles:put name="portletId" value="<%=portletID %>"/>
</tiles:insert>
</form>
</c:if>
</fieldset>
<% } %>	