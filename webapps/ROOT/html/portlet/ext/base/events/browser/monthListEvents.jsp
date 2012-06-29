<script type="text/javascript" src="http://yui.yahooapis.com/combo?2.6.0/build/utilities/utilities.js&2.6.0/build/container/container_core-min.js"></script> 
<script type="text/javascript" src="/html/themes/sykiesweb/javascript/carousel.js"></script>
<%//= themeDisplay.getPathThemeJavascript() %>

<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%@ page import="com.ext.portlet.base.events.BsEventForm" %>
<%@ page import="java.util.Date" %>

<% 

String filePath = GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH); 
java.text.SimpleDateFormat date_format = new java.text.SimpleDateFormat(com.ext.util.CommonDefs.DATE_FORMAT);

Date now = (Date)request.getAttribute("bs_events_listing_criterion_date_now");
Date then = (Date)request.getAttribute("bs_events_listing_criterion_date_then");
String criterion_eventType = (String)request.getAttribute("bs_events_listing_criterion_eventType");
String roomName = (String)request.getAttribute("bs_events_listing_criterion_room");
String criterion_roomid = (String)request.getAttribute("bs_events_listing_criterion_roomid");
String topicName = (String)request.getAttribute("bs_events_listing_criterion_topic");
String criterion_topicid = (String)request.getAttribute("bs_events_listing_criterion_topicid");


List events = (List)request.getAttribute("events");
%>

<h3><%= LanguageUtil.get(pageContext, "bs.events.browser.list-from") + " " + BsEventForm.date_format.format(now) 
		+ " " + LanguageUtil.get(pageContext, "bs.events.browser.list-to") + " " + BsEventForm.date_format.format(then) + "<br>"+
		(Validator.isNotNull(criterion_eventType) ? " " + LanguageUtil.get(pageContext, "bs.events.browser.list-type") + " <i>'" + LanguageUtil.get(pageContext, "bs.events.event-type."+criterion_eventType) +"'</i>": "" ) +
		(Validator.isNotNull(roomName) ? " " + LanguageUtil.get(pageContext, "bs.events.browser.list-room") + " <i>'" + roomName +"'</i>": "" ) +
		(Validator.isNotNull(topicName) ? " " + LanguageUtil.get(pageContext, "bs.events.browser.list-topic") + " <i>'" + topicName +"'</i>": "") %></h3>
<br>
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









<script type="text/javascript">

/**
 * Custom button state handler for enabling/disabling button state. 
 * Called when the carousel has determined that the previous button
 * state should be changed.
 * Specified to the carousel as the configuration
 * parameter: prevButtonStateHandler
 **/
var handlePrevButtonState = function(type, args) {

    var enabling = args[0];
    var leftImage = args[1];
    if(enabling) {
        leftImage.src = "<%= themeDisplay.getPathThemeImage() %>/custom/left-enabled.gif";    
    } else {
        leftImage.src = "<%= themeDisplay.getPathThemeImage() %>/custom/left-disabled.gif";    
    }
    
};

/**
 * Custom button state handler for enabling/disabling button state. 
 * Called when the carousel has determined that the next button
 * state should be changed.
 * Specified to the carousel as the configuration
 * parameter: nextButtonStateHandler
 **/
var handleNextButtonState = function(type, args) {

    var enabling = args[0];
    var rightImage = args[1];
    
    if(enabling) {
        rightImage.src = "<%= themeDisplay.getPathThemeImage() %>/custom/right-enabled.gif";
    } else {
        rightImage.src = "<%= themeDisplay.getPathThemeImage() %>/custom/right-disabled.gif";
    }
    
};


/**
 * You must create the carousel after the page is loaded since it is
 * dependent on an HTML element (in this case 'mycarousel'.) See the
 * HTML code below.
 **/
var carousel; // for ease of debugging; globals generally not a good idea
var pageLoad = function() 
{
    carousel = new YAHOO.extension.Carousel("mycarousel", 
        {
            numVisible:        3,
            animationSpeed:    0.15,
            scrollInc:         3,
            navMargin:         20,
            prevElement:     "prev-arrow",
            nextElement:     "next-arrow",
            size:              <%=events.size()%>,
            prevButtonStateHandler:   handlePrevButtonState,
            nextButtonStateHandler:   handleNextButtonState
        }
    );

};

YAHOO.util.Event.addListener(window, 'load', pageLoad);

</script>
<noscript></noscript>
    

<!-- Events List -->


<% if (events == null || events.size() == 0) { %>
	<%= LanguageUtil.get(pageContext, "no-events-found") %>
<% } %>



<% if (events != null && events.size() > 0) {

	// the number of events to show in a row
	int step = 50;
	
	// the index of the first event of the row e.g. 0 - 3 - 6 - 9 ... as you show them in groups of 3
	int startIndex = 0;
	String scroll_startIndex = request.getParameter("scroll_startIndex");
	if (Validator.isNotNull(scroll_startIndex)) {
		try {
			startIndex = Integer.parseInt(scroll_startIndex);
		} catch (Exception e) {}
	}
	%>
	
    
    
 
 
 <!-- Events - Monthly Carousel -->
<div id="mycarousel" class="carousel-component">
    <div class="carousel-prev">
        <img id="prev-arrow" class="left-button-image" src="<%= themeDisplay.getPathThemeImage() %>/custom/left-enabled.gif" alt="Previous Button"/>
    </div>
    <div class="carousel-next">
        <img id="next-arrow" class="right-button-image" src="<%= themeDisplay.getPathThemeImage() %>/custom/right-enabled.gif" alt="Next Button"/>
    </div>
    
    
    
    
    <div class="carousel-clip-region">
     <ul class="carousel-list">
        
    
    
    
	<% 
	
	for (int e=0; e<events.size(); e++) {
		if (e >= startIndex && e-startIndex < step) {
		ViewResult gnItem = (ViewResult)events.get(e);		
		
		
	%>







		<li id="mycarousel-item-1">
        <div>
        <a href="#">
                    <!--  event thumbnail, and link with event title -->
                    <a <% if (gnItem.getField19 () != null && ((Boolean)gnItem.getField19()).booleanValue()) { 
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
                    </portlet:actionURL>">
                    <c:if test="<%=gnItem.getField9()!=null%>">
                        <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + gnItem.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)gnItem.getField9())%>" alt="<%= gnItem.getField7().toString() %>"  />
                    </c:if>
                    <%= date_format.format((java.util.Date)gnItem.getField4()) %>&nbsp;-&nbsp; <%= gnItem.getField7().toString() %>
                    </a><br />

                    <!--  event thumbnail, and link with event title -->
        
        
      
		
        <!--  free entry or detailed schedule for online reservations -->
		<% if (gnItem.getField20() != null && ((Boolean)gnItem.getField20()).booleanValue()) { %>
			<div class="carousel-event-browser-free">
				<span><%=LanguageUtil.get(pageContext, "bs.events.freeEntry") %></span>
            </div>
		<% } else if (gnItem.getField21()!=null && ((Boolean)gnItem.getField21()).booleanValue() && gnItem.getField22()!=null && ((Boolean)gnItem.getField22()).booleanValue()) 
		{ %>
		<div class="carousel-events-browser-more"><a href="<portlet:actionURL>
            <portlet:param name="struts_action" value="/ext/eventsbrowser/loadSchedule"/>
            <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
            <portlet:param name="redirect" value="<%=currentURL%>"/>
            </portlet:actionURL>"><span><%=LanguageUtil.get(pageContext, "bs.events.detailed-schedule") %></span></a>
        </div>
		<% }  %>
		<br />
		
        </div>
        </li>




	

	
	
	
	
	<% }
	} %>






        
     </ul>
   </div>
   
</div>


	
	
<% } %>

      


