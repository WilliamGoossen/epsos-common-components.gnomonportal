<%@ include file="/html/portlet/ext/base/events/init.jsp" %>
<%@ page import="com.ext.portlet.base.events.BsEventForm" %>
<%@ page import="java.util.Date" %>
<% 

if (instancePortletBrowseType == null || instancePortletBrowseType.equals("default")) {
	
	
String filePath = GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH); 
java.text.SimpleDateFormat date_format = new java.text.SimpleDateFormat(com.ext.util.CommonDefs.DATE_FORMAT);
boolean eventsNoRecurrentEventsInList = GetterUtil.getBoolean(prefs.getValue("eventsNoRecurrentEventsInList", StringPool.BLANK), false);
boolean onLineReservations = GetterUtil.getBoolean(PropsUtil.get("bs.events.online.reservations"), false);

Date now = (Date)request.getAttribute("bs_events_listing_criterion_date_now");
Date then = (Date)request.getAttribute("bs_events_listing_criterion_date_then");
String criterion_eventType = (String)request.getAttribute("bs_events_listing_criterion_eventType");
String bs_events_listing_criterion_eventType_name = (String)request.getAttribute("bs_events_listing_criterion_eventType_name");
String roomName = (String)request.getAttribute("bs_events_listing_criterion_room");
String criterion_roomid = (String)request.getAttribute("bs_events_listing_criterion_roomid");
String topicName = (String)request.getAttribute("bs_events_listing_criterion_topic");
String criterion_topicid = (String)request.getAttribute("bs_events_listing_criterion_topicid");
List events = (List)request.getAttribute("events");

boolean showSearchForm = false;
String searchForm = request.getParameter("searchForm");
if (Validator.isNull(searchForm))
	searchForm = (String)request.getAttribute("searchForm");
if (searchForm != null && searchForm.equals("true"))
	showSearchForm = true;

%>

<div class="events-browser-search">
  <div id="_bs_events_browser_search_form_div_" style="display : <%= (showSearchForm? "inline": "none") %>">
    <html:form action="/ext/eventsbrowser/search?actionURL=true" method="post" enctype="multipart/form-data" styleClass="uni-form">
      <c:if test="<%=Validator.isNotNull(redirect) %>">
        <input type="hidden" name="redirect" value="<%= redirect %>">
      </c:if>
      <input type="hidden" name="searchForm" value="true">
      <tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
        <tiles:put name="formName" value="BsEventSearchForm"/>
      </tiles:insert>
      <html:submit><%= LanguageUtil.get(pageContext, "search" ) %></html:submit>
    </html:form>
    <br>
    <a href="javascript: void(0);" onclick="Liferay.Util.toggle('_bs_events_browser_search_form_div_', true);Liferay.Util.toggle('_bs_events_browser_search_link_div_', true);"> <img src="<%= themeDisplay.getPathThemeImage()%>/common/close_search.png" alt="hide"> </a> </div>
  <div id="_bs_events_browser_search_link_div_" style="display : <%= (!showSearchForm? "inline": "none") %>"> <a href="javascript: void(0);" onclick="Liferay.Util.toggle('_bs_events_browser_search_form_div_', true);Liferay.Util.toggle('_bs_events_browser_search_link_div_', true);"> <%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_events_search") %>... </a> </div>
</div>
<% if (!showSearchForm) { %>
<div class="event-browser-dates"> <%= LanguageUtil.get(pageContext, "bs.events.browser.list-from") + " " + BsEventForm.date_format.format(now) 
		+ " " + LanguageUtil.get(pageContext, "bs.events.browser.list-to") + " " + BsEventForm.date_format.format(then) + "<br>"+
		(Validator.isNotNull(criterion_eventType) ? " " + LanguageUtil.get(pageContext, "bs.events.browser.list-type") + " <i>'" + bs_events_listing_criterion_eventType_name +"'</i>": "" ) +
		(Validator.isNotNull(roomName) ? " " + LanguageUtil.get(pageContext, "bs.events.browser.list-room") + " <i>'" + roomName +"'</i>": "" ) +
		(Validator.isNotNull(topicName) ? " " + LanguageUtil.get(pageContext, "bs.events.browser.list-topic") + " <i>'" + topicName +"'</i>": "") %>
  <% } %>
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
		table1.cancelled
		table1.freeEntry,
		table1.onlineReservations,
		table1.onlineProductsActive
};
--%>
</div>
<!-- Events List -->

<% if (events == null || events.size() == 0) { %>
	<%= LanguageUtil.get(pageContext, "no-events-found") %>
<% } %>



<% int counter = 0; %>
<display:table id="event" name="events" requestURI="//ext/eventsbrowser/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
  <% ViewResult gnItem = (ViewResult) pageContext.getAttribute("event"); 
   if (gnItem != null) counter++; %>
  dsfd
  <display:column titleKey="title" sortable="true">
    <div class="event-browser-date"> <%= date_format.format((java.util.Date)gnItem.getField4()) %> </div>
    <div class="event-browser-photo">
      <c:if test="<%=gnItem.getField9()!=null%>"> <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + gnItem.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField9())%>" alt="<%= gnItem.getField7().toString() %>" align="center" /> </c:if>
    </div>
    <div class="event-browser-content">
      <div class="event-browser-title_link"> <a <% if (gnItem.getField19 () != null && ((Boolean)gnItem.getField19()).booleanValue()) { 
	out.print("title=\"" +LanguageUtil.get(pageContext, "bs.events.cancelled") + "\" style=\"text-decoration: line-through\" ");
	} %> href="<portlet:actionURL>
	<portlet:param name="struts_action" value="/ext/eventsbrowser/load"/>
        <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
        <portlet:param name="loadaction" value="view"/>
        <portlet:param name="eventStartDate" value="<%= date_format.format((Date)gnItem.getField4()) %>"/>
        <portlet:param name="eventEndDate" value="<%= date_format.format((Date)gnItem.getField6()) %>"/>
        <portlet:param name="redirect" value="<%=currentURL%>"/>
        <% if (Validator.isNotNull(criterion_eventType)) { %>
        <portlet:param name="criterion_eventType" value="<%= criterion_eventType %>"/>
        <% } %>
        <% if (Validator.isNotNull(criterion_roomid)) { %>
        <portlet:param name="criterion_roomid" value="<%= criterion_roomid %>"/>
        <% } %>
        <% if (Validator.isNotNull(criterion_topicid)) { %>
        <portlet:param name="criterion_topicid" value="<%= criterion_topicid %>"/>
        <% } %>
        </portlet:actionURL>
        "> <%= gnItem.getField7().toString() %> </a> </div>
      <div class="event-browser-title"> <%= gnItem.getField7().toString() %> </div>
      <div class="event-browser-date"> <%= date_format.format((java.util.Date)gnItem.getField4()) %> </div>
      <div class="event-browser-description"> <%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField10(),"")).trim(),200)%> </div>
    </div>
    <div class="event-browser-more"> <a <% if (gnItem.getField19 () != null && ((Boolean)gnItem.getField19()).booleanValue()) { 
	out.print("title=\"" +LanguageUtil.get(pageContext, "bs.events.cancelled") + "\" style=\"text-decoration: line-through\" ");
	} %> href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/eventsbrowser/load"/>
      <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
      <portlet:param name="loadaction" value="view"/>
      <portlet:param name="eventStartDate" value="<%= date_format.format((Date)gnItem.getField4()) %>"/>
      <portlet:param name="eventEndDate" value="<%= date_format.format((Date)gnItem.getField6()) %>"/>
      <portlet:param name="redirect" value="<%=currentURL%>"/>
      <% if (Validator.isNotNull(criterion_eventType)) { %>
      <portlet:param name="criterion_eventType" value="<%= criterion_eventType %>"/>
      <% } %>
      <% if (Validator.isNotNull(criterion_roomid)) { %>
      <portlet:param name="criterion_roomid" value="<%= criterion_roomid %>"/>
      <% } %>
      <% if (Validator.isNotNull(criterion_topicid)) { %>
      <portlet:param name="criterion_topicid" value="<%= criterion_topicid %>"/>
      <% } %>
      </portlet:actionURL>
      "> <%=LanguageUtil.get(pageContext, "more") %> </a> </div>
  <!--</display:column>
  <display:column>-->
    <% if (gnItem.getField20() != null && ((Boolean)gnItem.getField20()).booleanValue()) { %>
    <div class="event-browser-free"><span><%=LanguageUtil.get(pageContext, "bs.events.freeEntry") %></span></div>
    <% } else if (gnItem.getField21()!=null && ((Boolean)gnItem.getField21()).booleanValue() && gnItem.getField22()!=null && ((Boolean)gnItem.getField22()).booleanValue()) { %>
    <!-- <img align="right" src="<%= themeDisplay.getPathThemeImage() %>/common/calendar.png" alt="<%=LanguageUtil.get(pageContext, "bs.events.detailed-schedule") %>">-->
    <div class="events-browser-more"><a href="<portlet:actionURL>
	<portlet:param name="struts_action" value="/ext/eventsbrowser/loadSchedule"/>
      <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
      <portlet:param name="redirect" value="<%=currentURL%>" />
      </portlet:actionURL>
      " title="<%=LanguageUtil.get(pageContext, "bs.events.detailed-schedule") %>"> <span><%=LanguageUtil.get(pageContext, "bs.events.detailed-schedule") %></span></a> </div>
    <% }  %>
    </div>
  </display:column>
</display:table>
<br/>
<% } else if (instancePortletBrowseType.equals("month")) {
%>
<jsp:include page="/html/portlet/ext/base/events/browser/monthListEvents.jsp" flush="true"/>
<%	
} else if (instancePortletBrowseType.equals("week")) {
%>
<jsp:include page="/html/portlet/ext/base/events/browser/weekListEvents.jsp" flush="true"/>
<% } %>
