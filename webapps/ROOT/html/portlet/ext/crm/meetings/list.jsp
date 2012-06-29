<%@ include file="/html/portlet/ext/crm/meetings/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<%
String crmPartyId = request.getParameter("crmPartyId");
if (Validator.isNull(crmPartyId)) 
	crmPartyId = (String) request.getAttribute("crmPartyId");
if (crmPartyId == null) 
	crmPartyId = "";
request.setAttribute("crmPartyId", crmPartyId);

String supplierPartyId = request.getParameter("supplierPartyId");
if (Validator.isNull(supplierPartyId))
	supplierPartyId = (String) request.getAttribute("supplierPartyId");
if (supplierPartyId == null)
	supplierPartyId = "";
request.setAttribute("supplierPartyId", supplierPartyId);

java.util.GregorianCalendar d = new java.util.GregorianCalendar();
String dayParam = ParamUtil.getString(request,"sel_day",d.get(Calendar.DAY_OF_MONTH)+"");
String monthParam = ParamUtil.getString(request,"sel_month",d.get(Calendar.MONTH)+"");
String yearParam = ParamUtil.getString(request,"sel_year",d.get(Calendar.YEAR)+"");
String searchFormString = ParamUtil.getString(request, "searchForm", "form");


if (searchFormString != null && searchFormString.equals("calendar")) { %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<tiles:insert page="/html/portlet/ext/crm/meetings/calendar.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/crm/meetings/list" />
	<tiles:put name="action_type" value="action" />
	<tiles:put name="monthParam"><%= monthParam %></tiles:put>
	<tiles:put name="dayParam"><%= dayParam %></tiles:put>
	<tiles:put name="yearParam"><%= yearParam %></tiles:put>
</tiles:insert>
<br>
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.search.form") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<portlet:param name="searchForm" value="form"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.search.form") %>">
<%= LanguageUtil.get(pageContext, "crm.meeting.search.form") %></a>
&nbsp;&nbsp;
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.search.week") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<portlet:param name="searchForm" value="week"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.search.week") %>">
<%= LanguageUtil.get(pageContext, "crm.meeting.search.week") %></a><br>
<br>

<br>

<display:table id="item" name="crm_meetings" requestURI="//ext/crm/meetings/list?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<display:column property="field1" titleKey="crm.meeting.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field2" titleKey="crm.meeting.meetingDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field3" titleKey="crm.meeting.subject" sortable="true"/>
<display:column property="field4" titleKey="crm.meeting.creatorId" sortable="true"/>
<display:column titleKey="crm.meeting.supplierPartyId" sortable="true">
<% if (Validator.isNotNull(gnItem.getField6()) && Validator.isNotNull(gnItem.getField8())) { %>
<a title="<%= gnItem.getField6().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField8().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField6().toString() %>
</a>
<% } %>
</display:column>
<display:column titleKey="crm.meeting.crmPartyId" sortable="true">
<% if (Validator.isNotNull(gnItem.getField5()) && Validator.isNotNull(gnItem.getField7())) { %>
<a title="<%= gnItem.getField5().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField7().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField5().toString() %>
</a>
<% } %>
</display:column>
<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="edit"/>
								<portlet:param name="searchForm" value="<%= searchFormString %>"/>
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
								<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="searchForm" value="<%= searchFormString %>"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
			</c:if>	
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>"></a>
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/meetings/listComments"/>
								<portlet:param name="meetingid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="searchForm" value="<%= searchFormString %>"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>
						</a>
					</td>
				</tr>
			
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="searchForm" value="<%= searchFormString %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
<% if (Validator.isNotNull(crmPartyId)) { %>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<% } %>
<% if (Validator.isNotNull(supplierPartyId)) { %>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<% } %>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>


<% } else if (searchFormString == null || searchFormString.equals("form")) { %>	
			
<html:form action="/ext/crm/meetings/list" method="post" styleClass="uni-form">
	<input type="hidden" name="searchForm" value="form">
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
		<tiles:put name="formName" value="SearchCrMeetingForm"/>
	</tiles:insert>

	<div class="button-holder">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "crm.button.search") %>">
	</div>
</html:form>
<br>
<% if (Validator.isNotNull(crmPartyId) || Validator.isNotNull(supplierPartyId)) { %>
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.search.calendar") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<portlet:param name="searchForm" value="calendar"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.search.calendar") %>">
<%= LanguageUtil.get(pageContext, "crm.meeting.search.calendar") %></a>
&nbsp;&nbsp;
<a title="<%= LanguageUtil.get(pageContext, "crm.meeting.search.week") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/list"/>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<portlet:param name="searchForm" value="week"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/search.png" alt="<%= LanguageUtil.get(pageContext, "crm.meeting.search.week") %>">
<%= LanguageUtil.get(pageContext, "crm.meeting.search.week") %></a><br>
<br>
<% } %>
<br>

<display:table id="item" name="crm_meetings" requestURI="//ext/crm/meetings/list?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<display:column property="field1" titleKey="crm.meeting.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field2" titleKey="crm.meeting.meetingDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field3" titleKey="crm.meeting.subject" sortable="true"/>
<display:column property="field4" titleKey="crm.meeting.creatorId" sortable="true"/>
<display:column titleKey="crm.meeting.supplierPartyId" sortable="true">
<% if (Validator.isNotNull(gnItem.getField6()) && Validator.isNotNull(gnItem.getField8())) { %>
<a title="<%= gnItem.getField6().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField8().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField6().toString() %>
</a>
<% } %>
</display:column>
<display:column titleKey="crm.meeting.crmPartyId" sortable="true">
<% if (Validator.isNotNull(gnItem.getField5()) && Validator.isNotNull(gnItem.getField7())) { %>
<a title="<%= gnItem.getField5().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField7().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField5().toString() %>
</a>
<% } %>
</display:column>

<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="edit"/>
								<portlet:param name="searchForm" value="<%= searchFormString %>"/>
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
								<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="searchForm" value="<%= searchFormString %>"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
				</c:if>
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>"></a>
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/meetings/listComments"/>
								<portlet:param name="meetingid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="searchForm" value="<%= searchFormString %>"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "crm.meeting.comment.list") %>
						</a>
					</td>
				</tr>
		
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/meetings/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="searchForm" value="<%= searchFormString %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
<% if (Validator.isNotNull(crmPartyId)) { %>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<% } %>
<% if (Validator.isNotNull(supplierPartyId)) { %>
<portlet:param name="supplierPartyId" value="<%= supplierPartyId %>"/>
<% } %>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>


<% } else if (searchFormString != null && searchFormString.equals("week")) { %>	

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<tiles:insert page="/html/portlet/ext/crm/meetings/week.jsp" flush="true"/>


<% } %>





