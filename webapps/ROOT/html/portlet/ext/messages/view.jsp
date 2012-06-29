<%@ include file="/html/portlet/ext/messages/init.jsp" %>

<%@ page import="gnomon.hibernate.model.gn.GnNotification" %>

<h3><%= LanguageUtil.get(pageContext, "gn.messages.list") %></h3>

<% List itemsList = (List)request.getAttribute("itemsList"); 
String newMessages = (String)request.getAttribute("newMessages");
boolean showMessageList=false;

String showList=request.getParameter("showMessageList");

if(Validator.isNotNull(showList) && showList.equals("true"))
	showMessageList=true;


if(showMessageList==false) {
	if (Validator.isNull(newMessages)) { %>

<div class="portlet-msg-alert">
<%= LanguageUtil.get(pageContext, "gn.messages.no-new-messages.found") %>
</div>
<br>
<a href="<portlet:renderURL windowState="maximized"><portlet:param name="struts_action" value="/ext/portalMessages/view"/>
<portlet:param name="showMessageList" value="true"/></portlet:renderURL>">
<%= LanguageUtil.get(pageContext, "gn.messages.all-messages") %>
</a>

<%} else {%>
<div class="portlet-msg-alert">
<a href="<portlet:renderURL windowState="maximized"><portlet:param name="struts_action" value="/ext/portalMessages/view"/>
<portlet:param name="showMessageList" value="true"/></portlet:renderURL>">
<%= LanguageUtil.get(pageContext, "gn.messages.new-messages.found") %>  (<%=newMessages%>)
</a>
</div>

<%} %>


<% } else { 

if (itemsList == null || itemsList.size() == 0) { %>
<br>
<%= LanguageUtil.get(pageContext, "gn.messages.no-messages.found") %>
<% } %>

<display:table id="item" name="itemsList" requestURI="//ext/messages/view?actionURL=true" pagesize="50" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">

<% GnNotification gnItem = (GnNotification)pageContext.getAttribute("item"); %>

<display:column property="sendDate" titleKey="gn.messages.sentDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"  />
<display:column property="sentFromName" titleKey="gn.messages.fromName" sortable="true"/>
<display:column titleKey="gn.messages.subject" sortable="true" sortProperty="subject">
<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/portalMessages/load"/>
<portlet:param name="messageid" value="<%= gnItem.getMainid().toString() %>"/></portlet:actionURL>">
<%= gnItem.getSubject() %>
</a>
</display:column>
<!--display:column property="body" titleKey="gn.messages.body" sortable="true"/-->
<display:column sortable="true" sortProperty="sentFlag">
<% if (gnItem.getSentFlag() == null || !gnItem.getSentFlag().equals(gnomon.services.MailNotificationJob.SENT)) { %>
<a title="<%= LanguageUtil.get(pageContext, "gn.messages.mark-as-read") %>" 
    href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/portalMessages/markAsRead"/><portlet:param name="messageid" value="<%= gnItem.getMainid().toString() %>"/></portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/disabled.gif" alt="<%= LanguageUtil.get(pageContext, "gn.messages.new") %>">
</a>
<% } else { %>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/enabled.gif" title="<%= LanguageUtil.get(pageContext, "gn.messages.read") %>" alt="<%= LanguageUtil.get(pageContext, "gn.messages.read") %>">
<% } %>
</display:column>

</display:table>

<br><br>

<%
boolean showSearchForm = false;
String searchForm = request.getParameter("search");
if (Validator.isNull(searchForm))
	searchForm = (String)request.getAttribute("search");
if (searchForm != null && searchForm.equals("true"))
	showSearchForm = true;
%>

<a href="javascript: void(0);" onclick="Liferay.Util.toggle('_searchFormDiv', true);"> 
<%= LanguageUtil.get(pageContext, "search") %>...
</a> 

<div id="_searchFormDiv" style="display : <%= (showSearchForm? "inline": "none") %>">

<html:form action="/ext/portalMessages/view?actionURL=true" method="post" styleClass="uni-form">
<fieldset>
<input type="hidden" name="search" value="true">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="SearchPortalMessagesForm"/>
</tiles:insert>

<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">
</div>

</fieldset>

</html:form>
</div>
<br/>
<br/>
<br/>
<a href="<portlet:renderURL windowState="normal"><portlet:param name="struts_action" value="/ext/portalMessages/view"/>
<portlet:param name="showMessageList" value="false"/></portlet:renderURL>">
<%= LanguageUtil.get(pageContext, "back") %>
</a>
<%} %>

