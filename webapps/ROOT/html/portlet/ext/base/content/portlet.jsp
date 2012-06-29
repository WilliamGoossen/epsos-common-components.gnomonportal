<%@ include file="/html/portlet/ext/base/content/init.jsp" %>

<tiles:useAttribute id="tilesMainContent" name="portlet_main" classname="java.lang.String" ignore="true" />
<tiles:useAttribute id="tilesPortletCalendar" name="portlet_calendar" classname="java.lang.String" ignore="true" />

<%
	String struts_action = "/ext/content/list";
	GregorianCalendar d = new GregorianCalendar();
	String dayParam = ParamUtil.getString(request,"sel_day",d.get(Calendar.DAY_OF_MONTH)+"");
	String monthParam = ParamUtil.getString(request,"sel_month",d.get(Calendar.MONTH)+"");
	String yearParam = ParamUtil.getString(request,"sel_year",d.get(Calendar.YEAR)+"");
%>

<c:choose>
	<c:when test="<%= showCalendar && Validator.isNotNull(tilesMainContent) %>">
		<table border="0" cellpadding="0" cellspacing="5" width="100%">
		<tr style="vertical-align:top;">
			<td style="width:1%; white-space:nowrap;">
				<tiles:insert page="/html/portlet/ext/struts_includes/calendar.jsp" flush="true">
					<tiles:put name="struts_action" value="<%=struts_action%>" />
					<tiles:put name="action_type" value="action" />
					<tiles:put name="monthParam"><%= monthParam %></tiles:put>
					<tiles:put name="dayParam"><%= dayParam %></tiles:put>
					<tiles:put name="yearParam"><%= yearParam %></tiles:put>
				</tiles:insert>
			</td>
			
		  <% if (showCalendarVertical) { %>	
			  </tr>
			  <tr>
		  <% } else { %>
			  <td>&nbsp;
			  </td>
		  <% } %>		  
		  
			<td>
				<liferay-util:include page="<%= com.liferay.portal.struts.StrutsUtil.TEXT_HTML_DIR + tilesMainContent %>" />
			</td>
		</tr>
	  </table>
	</c:when>
	<c:otherwise>
		<liferay-util:include page="<%= com.liferay.portal.struts.StrutsUtil.TEXT_HTML_DIR + tilesMainContent %>" />
	</c:otherwise>
</c:choose>