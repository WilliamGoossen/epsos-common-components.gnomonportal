<%@ include file="/html/portlet/ext/base/content/init.jsp" %>
<%@ page import="gnomon.hibernate.model.base.events.*" %>

<% 
String filePath = GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH); 
java.text.SimpleDateFormat date_format = new java.text.SimpleDateFormat(com.ext.util.CommonDefs.DATE_FORMAT);
long rootPlid = GetterUtil.getLong(prefs.getValue("show_rootPlid", StringPool.BLANK), -1);
%>
<%-- 

fields = new String[] {
		table1.eventType, 
		table1.published,
		table1.publishDateStart, 
		table1.eventDateStart, 
		table1.eventTime,
		table1.eventDateEnd, 
		langs.title, 
		langs.place, 
		langs.image,
		langs.description, 
		table1.repeating, 
		table1.recurrence,
		table1.remindBy, 
		table1.firstReminder,
		table1.secondReminder,
		table1.originalDate, 
		table1.endDate,
		table1.parentid,
		table1.cancelled;
};
--%>
<c:choose>
<c:when test="<%=CONTENT_EXISTS%>">
	<%
			List<ViewResult> viewList  = (java.util.List) request.getAttribute("itemsList");
	%>


<div id="latestcontent">


    <ul>
	<% for (ViewResult view: viewList) { %>
		
        <li><% if (view.getField11() != null && ((Boolean)view.getField11()).booleanValue()) { %>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/calendar.png" alt="<%= LanguageUtil.get(pageContext, "bs.events.recurrency") %>" title="<%= LanguageUtil.get(pageContext, "bs.events.recurrency") %>">
		<% } %><strong>
		<% if (rootPlid <= 0) { %>
			  	<a <% if (view.getField19 () != null && ((Boolean)view.getField19()).booleanValue()) { 
	out.print("title=\"" +LanguageUtil.get(pageContext, "bs.events.cancelled") + "\" style=\"text-decoration: line-through\" ");
	} %> href="<liferay-portlet:renderURL portletName="bs_events" windowState="<%=WindowState.NORMAL.toString()%>">
					<portlet:param name="struts_action" value="/ext/events/load"/>
					<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="view"/>
					<portlet:param name="eventStartDate" value="<%= view.getField4() != null ? date_format.format((Date)view.getField4()) : "" %>"/>
					<portlet:param name="eventEndDate" value="<%= view.getField6() != null ? date_format.format((Date)view.getField6()) : "" %>"/>
					<portlet:param name="redirect" value="<%= currentURL %>"/>
					</liferay-portlet:renderURL>">
					<% 
			  		String imageName = (view.getField9() != null? view.getField9().toString() : null);
			  		if (imageName != null && showImages) { %>
			  		    <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)view.getField9())%>" alt="<%= view.getField7().toString() %>" align="left" />
			  		<% } %>
			  		<%= date_format.format((java.util.Date)view.getField4()) %>&nbsp;-&nbsp; <%= view.getField7().toString() %>
				</a>
		<% } else { 
		
	PortletURLImpl pURL=null;
			
	 		if (portletRequest instanceof RenderRequest)
			{
				RenderRequestImpl req = (RenderRequestImpl)portletRequest;
				pURL = new PortletURLImpl(req, "bs_events", rootPlid, true);
			}
			else
			{
				ActionRequestImpl req = (ActionRequestImpl)portletRequest;
				pURL = new PortletURLImpl(req, "bs_events", rootPlid, true);
			}
	
			pURL.setPortletMode(PortletMode.VIEW);
			pURL.setWindowState(WindowState.NORMAL);
			pURL.setParameter("struts_action", "/ext/events/load");	
			pURL.setParameter("mainid" ,  view.getMainid().toString());
			pURL.setParameter("loadaction" , "view");
			pURL.setParameter("eventStartDate", (view.getField4() != null ? date_format.format((Date)view.getField4()) : ""));
			pURL.setParameter("eventEndDate", (view.getField6() != null ? date_format.format((Date)view.getField6()) : ""));
			pURL.setParameter("redirect" , currentURL);
		%>
		<a <% if (view.getField19 () != null && ((Boolean)view.getField19()).booleanValue()) { 
	out.print("title=\"" +LanguageUtil.get(pageContext, "bs.events.cancelled") + "\" style=\"text-decoration: line-through\" ");
	} %> href="<%= pURL.toString() %>">
					<% 
			  		String imageName = (view.getField9() != null? view.getField9().toString() : null);
			  		if (imageName != null && showImages) { %>
			  		    <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)view.getField9())%>" alt="<%= view.getField7().toString() %>" align="left" />
			  		<% } %>
			  		<%= date_format.format((java.util.Date)view.getField4()) %>&nbsp;-&nbsp; <%= view.getField7().toString() %>
				</a>
		<% } %>				
				</strong>
				<br>
					<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(view.getField10(),"")).trim(),200)%>
					
         </li>

	<% } %>

</ul>

</div>


</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>