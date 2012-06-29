<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.liferay.portal.kernel.language.LanguageUtil" %>
<%@ page import="com.ext.portlet.parties.events.*" %>

<%
try {

List eventsList = EventsJspHelper.listEvents(request);
request.setAttribute("eventsList", eventsList);

portletName= LanguageUtil.get(pageContext, "parties.events.list.title") ;
%>

<!-- Events List -->
<form name="Parties_Events_List_Form" action="<liferay-portlet:renderURL portletName="PA_PARTIES_MANAGER"  windowState="<%= LiferayWindowState.POP_UP.toString() %>">
							<liferay-portlet:param name="struts_action" value="/ext/parties/manager/viewEvent"/>
							</liferay-portlet:renderURL>" method="post">

<display:table id="events" name="eventsList" requestURI="//ext/parties/manager/listEvents" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.events.list.events") %></b></display:caption>
<display:column><input type="radio" name="eventid" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("events")).getField1().toString()%>" checked></display:column>
<display:column  property="field2" titleKey="parties.manager.party.description" sortable="true"  />
<display:column  titleKey="parties.events.eventtype" sortable="true" ><%= LanguageUtil.get(pageContext, "parties.events.eventtype."+((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("events")).getField3().toString().trim()) %></display:column>
<display:column property="field4" titleKey="parties.events.eventdate" sortable="true"  decorator="com.ext.portlet.parties.events.DateTimeColumnDecorator"/>
</display:table>

<br>
<% if (eventsList.size() > 0 ) { %>

<input type="submit" class="gamma1-FormButton" name="submit" value="<%= LanguageUtil.get(pageContext, "parties.events.button.view") %>">

<% } %>

<input type="button" class="gamma1-FormButton" value="<%= LanguageUtil.get(pageContext, "parties.events.button.close") %>" onClick="window.close();">

</form>


<%} catch (Exception e) { e.printStackTrace(); } %>