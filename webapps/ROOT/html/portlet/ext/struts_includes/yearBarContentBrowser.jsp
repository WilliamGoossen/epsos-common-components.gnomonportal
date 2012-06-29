<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.ext.portlet.cms.generic.lucene.LuceneUtilities" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%@ page import="com.liferay.portlet.RenderRequestImpl" %>
<%@ page import="com.liferay.portlet.ActionRequestImpl" %>

<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.ArrayList" %>

<tiles:useAttribute id="struts_action" name="struts_action" classname="java.lang.String"/>
<tiles:useAttribute id="tilesParamList" name="actionParamList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="tilesParamValueList" name="actionParamValueList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="contentClassName" name="contentClass" classname="java.lang.String"/>

<%  
	String lang = GeneralUtils.getLocale(request);
	PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
	String portletId = null;
	PortletPreferences prefs = null;
	if (portletRequest instanceof RenderRequest)
	{
		RenderRequestImpl req = (RenderRequestImpl)portletRequest;
		portletId = req.getPortletName();
		prefs= req.getPreferences();
	}
	else
	{
		ActionRequestImpl req = (ActionRequestImpl)portletRequest;
		portletId = req.getPortletName();
		prefs = req.getPreferences();
	}
	String portletResource = ParamUtil.getString(request, "portletResource");
	if (Validator.isNotNull(portletResource)) {
	    prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
	}
	String portletInstanceTopicId = prefs.getValue("topic-id", StringPool.BLANK);
	String portletInstanceMinYear = prefs.getValue("years_startYear",  StringPool.BLANK);
	int minYear = 0;
	try { minYear = Integer.parseInt(portletInstanceMinYear); } catch (Exception int1) {}
	boolean portletInstanceYearsShowFuture = GetterUtil.getBoolean(prefs.getValue("years_showFuture", "true"), true);
	boolean portletInstanceYearsShowEmptyYears = GetterUtil.getBoolean(prefs.getValue("years_showEmptyYears", "true"), true);

	
	
    String bar_year = request.getParameter("bar_year");
    if (Validator.isNull(bar_year)) bar_year = (String)request.getAttribute("bar_year");
    if (Validator.isNull(bar_year)) bar_year = ""; 
	Calendar cal = Calendar.getInstance();
	int yearNow = cal.get(Calendar.YEAR);
	int startingYear = yearNow;
	String startingYearString = request.getParameter("starting_year");
	if (Validator.isNotNull(startingYearString))
	{
		try {startingYear = Integer.parseInt(startingYearString); } catch (Exception numE) {}
	}
	
   
	String[] years = new String[10];
	String[] yearCounters = new String[10];
	for (int i=0;i<10;i++)
	{
		int yearNum = startingYear-9+i;
		if (yearNum >= minYear)
			years[i] = ""+ yearNum;
		else
			years[i] = "";
		if (Validator.isNotNull(years[i])) { 
			List<String> foundIds = LuceneUtilities.searchLuceneFormBean(request, lang, Class.forName(contentClassName), (Validator.isNotNull(portletInstanceTopicId) ? portletInstanceTopicId : null), null, null, ""+years[i], null);
			if (foundIds != null)
				yearCounters[i] = ""+foundIds.size();
			else
				yearCounters[i] = "0";
		}
		else
			yearCounters[i] = "0";
	}
	
	%>
	<fieldset style="white-space: nowrap;">
	<TABLE WIDTH="100%" style="white-space: nowrap;">
	<TR>
	<% if (startingYear-10 >= minYear) { %>
	<TD>
	<a href="<portlet:actionURL>
			  	  <portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
				  <%
					if (tilesParamList != null && tilesParamList.size() > 0) {
						for (int t=0; t<tilesParamList.size(); t++){
						%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
						<%
						}
					}
					%>
					<portlet:param name="starting_year" value="<%= ""+(startingYear-10) %>"/>
					<% if (Validator.isNotNull(portletInstanceTopicId)) { %>
					<portlet:param name="topicid" value="<%= portletInstanceTopicId %>"/>
					<% } %>
					</portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="-10">
	</a>
	</TD>
	<% } %>
	<%
	for (int y=0; y<years.length; y++) {
		String year = years[y];
		if (Validator.isNull(year)) continue;
		%><TD><%
		if (bar_year != null && year.equals(bar_year)) { %>
		<strong>
		<% } 
		if (!yearCounters[y].equals("0")) {
		%>
		<a title="<%= year %>" 
		    href="<portlet:actionURL>
			  	  <portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
				  <%
					if (tilesParamList != null && tilesParamList.size() > 0) {
						for (int t=0; t<tilesParamList.size(); t++){
						%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
						<%
						}
					}
					%>
					<portlet:param name="bar_year" value="<%= year %>"/>
					<portlet:param name="starting_year" value="<%= ""+startingYear %>"/>
					<% if (Validator.isNotNull(portletInstanceTopicId)) { %>
					<portlet:param name="topicid" value="<%= portletInstanceTopicId %>"/>
					<% } %>
					</portlet:actionURL>"><%= year + " (" + yearCounters[y] + ")" %></a>
		<% } else if (portletInstanceYearsShowEmptyYears) { %>
		<%= year %>
		<% }  %>					
		<% if (bar_year != null && year.equals(bar_year)) { %>
		</strong>
		<% } %>
		</TD>  
	<% } %>
	<% if (startingYear+10 <= yearNow || portletInstanceYearsShowFuture) { %>
	<TD>
	<a href="<portlet:actionURL>
			  	  <portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
				  <%
					if (tilesParamList != null && tilesParamList.size() > 0) {
						for (int t=0; t<tilesParamList.size(); t++){
						%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
						<%
						}
					}
					%>
					<portlet:param name="starting_year" value="<%= ""+(startingYear+10) %>"/>
					<% if (Validator.isNotNull(portletInstanceTopicId)) { %>
					<portlet:param name="topicid" value="<%= portletInstanceTopicId %>"/>
					<% } %>
					</portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/forward.png" alt="+10">
	</a>
	</TD>
	<% } %>
	</TR>
	</TABLE>
	</fieldset>

