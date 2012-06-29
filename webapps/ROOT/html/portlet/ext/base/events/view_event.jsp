<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<div class="event-view">

<% ViewResult view = (ViewResult) request.getAttribute("eventItem"); 
   String filePath = GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH);
   Boolean isParticipant=(Boolean)request.getAttribute("isParticipant");
   Boolean canParticipate=(Boolean)request.getAttribute("canParticipate");
   long companyId=PortalUtil.getCompanyId(request);
   String onlineeventtypes = PropsUtil.get(companyId, "presentation.event.type.permits.registration");

   String emailAddress = user.getEmailAddress();
   String participantName = user.getFullName();
   String registrationUrl="/ext/events/loadRegistration";
   Date now=new Date();
   Date eventDate=(Date)view.getField8();
   String startTime = (String)view.getField9();
   
   Date eventEndDate = (Date)view.getField10();
   String endTime = (String)view.getField19();
   java.util.Calendar endCal = java.util.Calendar.getInstance();
   endCal.setTime(eventEndDate);
   int endHours = 0;
   int endMinutes =0;
   try {
	   	String endhoursString = endTime.substring(0, endTime.indexOf(':'));
	   	String endminutesString = endTime.substring(endTime.indexOf(':')+1);
	   	endHours = Integer.valueOf(endhoursString);
	   	endMinutes = Integer.valueOf(endminutesString);
	   	endCal.set(java.util.Calendar.HOUR_OF_DAY, endHours);
	   	endCal.set(java.util.Calendar.MINUTE, endMinutes);
   } catch (Exception e) {}
   boolean isNotOver = endCal.getTime().getTime() - now.getTime() > 1000;
   
   if(view != null && view.getField7().toString().equals("onlineevent")){
	
	   registrationUrl="/ext/events/loadOnlineRegistration";
   }
   
   boolean allowDetailsEditing = true;
   // if it is a recurring event with a valid parent event DO NOT allow details editing
	if (view.getField12()!=null && ((Boolean)view.getField12()).booleanValue() && Validator.isNotNull(view.getField21())) {
		allowDetailsEditing = false;
	}
   //To view periexei ta pedia:
	 /*  String[] fields = new String[] {
		1 "langs.mainid",
		2 "langs.lang",
		3 "langs.title",
		4 "langs.description",
		5 "langs.place",
		6 "langs.participants",
		7 "table1.eventType",
		8 "table1.eventDateStart",
		9 "table1.eventTime",
		10"table1.eventDateEnd",
		11"langs.image",
		12"table1.repeating",
		13"table1.cancelled",
		14"table1.freeEntry",
		15"table1.onlineReservations",
		16"table1.mandatoryPayment",
		17"langs.organizedBy",
		18"table1.organizationType",
		19"table1.eventEndTime",
		20"table1.onlineReservationsHourLimit"
		21"parentEvent.mainid"
		22"table1.evRoom.evRoomLanguage.name"
		23"table1.evEventType.evEventTypeLanguage.name"};
	*/

%>

<c:choose>
	<c:when test="<%=view!=null%>">

 <c:if test="<%=view.getField3()!=null%>">
		<h1><%=StringUtils.check_null(view.getField3(),"")%></h1>
  	  </c:if>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
    
<div class="portlet-section-header">
					<table border="0" align="right" cellpadding="3" cellspacing="3">



		<tr>
        <td align="left" valign="top">
        <c:if test="<%=view.getField11()!=null%>">
	    <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)view.getField11())%>" alt="<%= view.getField3().toString() %>" align="left" style="padding-top:2px; padding-right:5px;" />	  </c:if>
        </td>
        <td><table><tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.pote") %> : </strong></div></td>
		  <td>&nbsp;<c:if test="<%=view.getField8()!=null%>"><%=LanguageUtil.get(pageContext, "bs.events.apo") %> <strong> <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField8())%></strong></c:if>
		  <c:if test="<%=view.getField10()!=null%>"> <%=LanguageUtil.get(pageContext, "bs.events.eos") %> <strong><%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField10())%></strong></c:if><br />
				<c:if test="<%=view.getField9()!=null%>"><%=LanguageUtil.get(pageContext, "bs.events.time") %> <%=StringUtils.check_null(view.getField9(),"")%>	</c:if>				</td>
	  </tr>

	  <c:if test="<%=view.getField5()!=null%>">
	  <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.pou") %> : </strong></div></td>
		  <td>&nbsp;<%=StringUtils.check_null(view.getField5(),"")%>		  </td>
	  </tr>
	  </c:if>
	  <c:if test="<%=view.getField22()!=null%>">
	  <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.place") %> : </strong></div></td>
		  <td>&nbsp;<%=StringUtils.check_null(view.getField22(),"")%>		  </td>
	  </tr>
	  </c:if>

<%--
	  <c:if test="<%=view.getField6()!=null && !eventsYellowPagesEnable %>">
	   <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.symmetexontes") %> : </strong></div></td>
		  <td>&nbsp;<%=StringUtils.check_null(view.getField6(),"")%>		  </td>
	  </tr>
	  </c:if>

	  <c:if test="<%=view.getField7()!=null%>">
	    <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.type") %> : </strong></div></td>
		  <td>&nbsp;<%=LanguageUtil.get(pageContext, "bs.events.event-type."+StringUtils.check_null(view.getField7(),""))%>		  </td>
	   </tr>
	  </c:if>
--%>	  
	<c:if test="<%=view.getField23()!=null%>">
	    <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.type") %> : </strong></div></td>
		  <td>&nbsp;<%=view.getField23()%></td>
	   </tr>
	  </c:if>
	  <c:if test="<%=(view.getField21()!=null && !view.getField21().toString().equals("") 
			          && isParticipant != null && isParticipant==true 
			          && isNotOver)%>">
	    <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.url") %> : </strong></div></td>
		  <td>&nbsp;<a href="<%=LanguageUtil.get(pageContext, StringUtils.check_null(view.getField21(),""))+ "&email=" + emailAddress +"&participantName=" + participantName%>"><%=LanguageUtil.get(pageContext, StringUtils.check_null(view.getField21(),""))%></a>		  </td>
	   </tr>
	  </c:if>
	  
	  <c:if test="<%=view.getField12()!=null && ((Boolean)view.getField12()).booleanValue() %>">
	    <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.recurrency") %> : </strong></div></td>
		  <td>&nbsp;<%=LanguageUtil.get(pageContext, "bs.events.recurrency."+view.getField12())%>		  </td>
	   </tr>
	  </c:if>
	  <c:if test="<%=view.getField13()!=null && ((Boolean)view.getField13()).booleanValue() %>">
	    <tr>
	      <td>&nbsp;</td>
    	  <td valign="top" nowrap="nowrap"><strong><%=LanguageUtil.get(pageContext, "bs.events.cancelled") %></strong></td>
	   </tr>
	  </c:if>
	  </table></td></tr>
</table>
	</div>	</td>
  </tr>
  <tr>
    <td><br >
	<c:if test="<%=view.getField4()!=null%>"><%=StringUtils.check_null(view.getField4(),"")%></c:if>
    
  </td>
  </tr>
</table>

<br />


	</c:when>
	<c:otherwise>
		<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
	</c:otherwise>
</c:choose>

<%
String mainid = ParamUtil.getString(request,"mainid");
List attachments = (List)request.getAttribute("attachments");
List relatedYellowPages = (List)request.getAttribute("relatedYellowPages");
List relatedParties = (List)request.getAttribute("relatedParties");

if ( (attachments != null && attachments.size() > 0) ||  
		(relatedYellowPages != null && relatedYellowPages.size() > 0 ) ||
		(relatedParties != null && relatedParties.size() > 0) ||
		hasAdd && allowDetailsEditing 
		) { 
%>

<br />

<liferay-ui:tabs
	names="bs.events.yellowpages.list,attach-files"
	param="tab"
	refresh="false"
>

<% if (eventsYellowPagesEnable) { %>

<!--  YELLOWPAGES PARTICIPANTS -->

<liferay-ui:section>

<display:table id="relatedYellowPage" name="relatedYellowPages" requestURI="//ext/events/loadPost?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult ypItem = (ViewResult) pageContext.getAttribute("relatedYellowPage"); %>

<display:column titleKey="bs.yellowpages.title" sortable="true" >
<a href="<liferay-portlet:actionURL portletName="bs_yellowpages" windowState="maximized">
<liferay-portlet:param name="struts_action" value="/ext/yellowpages/load"/>
<liferay-portlet:param name="loadaction" value="view"/>
<liferay-portlet:param name="mainid" value="<%= ypItem.getField1().toString()%>"/>
</liferay-portlet:actionURL>">
<%= ypItem.getField2().toString() %>
</a>
</display:column>
<%--<display:column property="field4" titleKey="bs.events.yellowpages.title" sortable="true" />--%>
<display:column property="field5" titleKey="bs.events.yellowpages.description" sortable="true" />
<display:column property="field7" titleKey="bs.yellowpages.phone" sortable="true" />
<display:column property="field8" titleKey="bs.yellowpages.email" sortable="true" />
<display:column property="field9" titleKey="bs.yellowpages.countryid" sortable="true" />


<c:if test="<%= (hasEdit || hasDelete) && allowDetailsEditing %>">
<display:column style="text-align: right; white-space:nowrap;">

<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_2_<%=ypItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>

<div id="browse:actionsMenu_2_<%=ypItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasEdit %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/events/loadEventYellowPage"/>
						<portlet:param name="mainid" value="<%= ypItem.getMainid().toString() %>"/>
						<portlet:param name="eventid" value="<%= mainid %>"/>
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
						<portlet:param name="struts_action" value="/ext/events/loadEventYellowPage"/>
						<portlet:param name="mainid" value="<%= ypItem.getMainid().toString() %>"/>
						<portlet:param name="eventid" value="<%= mainid %>"/>
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

<c:if test="<%= hasAdd && allowDetailsEditing %>">
<form name="BsEventYellowPageForm" action="/ext/events/loadEventYellowPage" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/events/loadEventYellowPage" />
	<tiles:put name="buttonName" value="addButtonYellowPage" />
	<tiles:put name="buttonValue" value="gn.button.add" />
	<tiles:put name="formName"   value="BsEventYellowPageForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="eventid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="add"/>
	  	<tiles:add><%=mainid%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
	<tiles:put name="actionPermission" value="add"/>
	<tiles:put name="portletId" value="<%=portletID %>"/>
</tiles:insert>
</form>
</c:if>

</liferay-ui:section>

<% } else { 
	String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
%>

<!--  PARTIES PARTICIPANTS -->

<liferay-ui:section>

<display:table id="relatedParty" name="relatedParties" requestURI="//ext/events/loadPost?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult partyItem = (ViewResult) pageContext.getAttribute("relatedParty"); %>

<display:column title="<%= htmlTitle %>" sortable="true">
<% if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_PERSON )) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/person.gif">
<%}else if (partyItem.getField9() != null && partyItem.getField9().toString().equals(com.ext.portlet.parties.lucene.PartiesLuceneUtilities.PARTY_TYPE_ORGANIZATION)) {%>
	<img src="<%= themeDisplay.getPathThemeImage() %>/orgchart/department.gif">
<%} else { %>
	<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/icons/group.gif">
<% } %> 	
</display:column>
<%--
<display:column titleKey="contacts.group.name" sortable="true" sortProperty="field15">
<% if (partyItem.getField16() != null && !partyItem.getField16().equals(partyItem.getMainid())) { %>
<i><%= partyItem.getField15() %></i>
<% } else if (partyItem.getField16() != null && partyItem.getField16().equals(partyItem.getMainid())) { %>
<b><%= partyItem.getField15() %></b>
<% } else { %>
-
<% } %>
</display:column>
--%>
<display:column titleKey="contacts.search.name" sortable="true" >
<% if (hasAdmin) { %>
<a title="<%= partyItem.getField1().toString() %>" href="<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>">
<% } %>
<%= partyItem.getField1().toString() %>
<% if (hasAdmin) { %>
</a>
<% } %>
</display:column>
<display:column titleKey="contacts.search.email" sortable="true">
<%= partyItem.getField2() != null ? partyItem.getField2().toString() : "-" %>
</display:column>
<display:column titleKey="contacts.search.phone" sortable="true" >
<%= partyItem.getField5() != null ? partyItem.getField5().toString() : "-" %>
</display:column>
<%--
<display:column titleKey="bs.events.parties.name" sortable="true" >
<%= partyItem.getField13() != null ? partyItem.getField13().toString() : "-" %>
</display:column>
--%>
<%-- <display:column property="field10" titleKey="contacts.search.company" sortable="true" /> --%>
<%-- <display:column property="field14" titleKey="bs.events.parties.description" sortable="true" /> --%>

<c:if test="<%= (hasEdit || hasDelete ) && allowDetailsEditing %>">
<display:column style="text-align: right; white-space:nowrap;">
<% if (partyItem.getField16() == null || partyItem.getField16().equals(partyItem.getMainid())) { %>
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_3_<%=partyItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>

<div id="browse:actionsMenu_3_<%=partyItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasEdit %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/events/loadEventParty"/>
						<portlet:param name="mainid" value="<%= partyItem.getField12().toString() %>"/>
						<portlet:param name="eventid" value="<%= mainid %>"/>
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
						<portlet:param name="struts_action" value="/ext/events/loadEventParty"/>
						<portlet:param name="mainid" value="<%= partyItem.getField12().toString() %>"/>
						<portlet:param name="eventid" value="<%= mainid %>"/>
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
<% } %>
</display:column>
</c:if>

</display:table>
<%//= hasAdd && allowDetailsEditing %>
<c:if test="<%= hasAdd && allowDetailsEditing %>">
<form name="BsEventPartyForm" action="/ext/events/loadEventParty" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/events/loadEventParty" />
	<tiles:put name="buttonName" value="addButtonParty" />
	<tiles:put name="buttonValue" value="gn.button.add" />
	<tiles:put name="formName"   value="BsEventPartyForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="eventid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="add"/>
	  	<tiles:add><%=mainid%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
	<tiles:put name="actionPermission" value="add"/>
	<tiles:put name="portletId" value="<%=portletID %>"/>
</tiles:insert>
</form>
</c:if>

</liferay-ui:section>

<% }  %>


<liferay-ui:section>
<!-- Attachments List -->
<display:table id="attachment" name="attachments" requestURI="//ext/events/loadPost?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("attachment"); %>

<display:column titleKey="title" sortable="false" >
<b>
<c:choose>
	<c:when test="<%=gnItem.getField2()!=null%>">
		<%String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(gnItem.getField2().toString(), "page");%>
		<img align="left" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
		<a target="_blank" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>"><portlet:param name="struts_action" value="/ext/events/getFile"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>"><%= gnItem.getField2().toString() %></a>
		</img>
	</c:when>
	<c:otherwise>
		<%= gnItem.getField2().toString() %>
	</c:otherwise>
</c:choose>
</b>
</display:column>
<%--
<display:column titleKey="filename" sortable="true" >
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/events/getFile"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="postid" value="<%= mainid %>"/><portlet:param name="loadaction" value="view"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>"><%= gnItem.getField2() %></a>
</display:column>

<display:column style="text-align: right">
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/events/loadFile"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="postid" value="<%= mainid %>"/><portlet:param name="loadaction" value="edit"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>"></a>
	<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/events/loadFile"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="postid" value="<%= mainid %>"/><portlet:param name="loadaction" value="delete"/><portlet:param name="redirect" value="<%=currentURL%>"/></portlet:actionURL>">
	<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>"></a>
</display:column>
--%>

<c:if test="<%= ( hasEdit || hasDelete ) && allowDetailsEditing %>">
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasEdit %>">
		<tr>
			<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
			</td>
			<td>
				<a href="<portlet:actionURL>
						<portlet:param name="struts_action" value="/ext/events/loadFile"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="postid" value="<%= mainid %>"/>
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
						<portlet:param name="struts_action" value="/ext/events/loadFile"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="postid" value="<%= mainid %>"/>
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

<c:if test="<%= hasAdd && allowDetailsEditing %>">
<form name="BsEventFileForm" action="/ext/events/loadFile" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/events/loadFile" />
	<tiles:put name="buttonName" value="addButtonFile" />
	<tiles:put name="buttonValue" value="add-attachment" />
	<tiles:put name="formName"   value="BsEventFileForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="eventid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="add"/>
	  	<tiles:add><%=mainid%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="add"/>
	<tiles:put name="portletId" value="<%=portletID %>"/>
	<tiles:put name="eventid" value="<%=mainid%>"/>
</tiles:insert>
</form>
</c:if>
</liferay-ui:section>


</liferay-ui:tabs>

<% } %>

<br/>
<HR />
<br/>
<c:choose>
<c:when test="<%=Validator.isNull(redirect)%>">
	<html:link styleClass="beta1" action="/ext/events/list">
	<%= LanguageUtil.get(pageContext, "more") %>
	</html:link>
</c:when>
<c:otherwise>
	<a href="<%=redirect%>" class="beta1">
	<%= LanguageUtil.get(pageContext, "more") %>
	</a>
</c:otherwise>
</c:choose>
</div>

<br><br>
<%
if (Validator.isNotNull(PropsUtil.get("presentation.event.type.permits.registration"))) {
String[] aStringArr=PropsUtil.get("presentation.event.type.permits.registration").split(",");
Arrays.sort(aStringArr);
long timeInterval = 14400000; // 4 hours
java.util.Calendar cal = java.util.Calendar.getInstance();
cal.setTime(eventDate);
int hours = 0;
int minutes =0;
try {
	String hoursString = startTime.substring(0, startTime.indexOf(':'));
	String minutesString = startTime.substring(startTime.indexOf(':')+1);
	hours = Integer.valueOf(hoursString);
	minutes = Integer.valueOf(minutesString);
	cal.set(java.util.Calendar.HOUR_OF_DAY, hours);
	cal.set(java.util.Calendar.MINUTE, minutes);
} catch (Exception e) {}

if (view.getField7() != null && Arrays.binarySearch(aStringArr, view.getField7().toString())>=0 && 
		cal.getTime().getTime() - now.getTime() >= timeInterval
		&& !isParticipant && canParticipate) { %>
<br>
<a href="<portlet:actionURL>
			<portlet:param name="struts_action" value="<%=registrationUrl %>"/>
			<portlet:param name="eventid" value="<%= view.getMainid().toString() %>"/>
			<portlet:param name="redirect" value="<%= currentURL %>"/>
			<portlet:param name="loadaction" value="add"/>
			<portlet:param name="formName" value="BsOnlineEventRegistrationForm"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/task.gif">
<%= LanguageUtil.get(pageContext, "bs.events.registration") %></a>
<br><br>
<% } 
}%>



<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
	<tiles:put name="className" value="<%= BsEvent.class.getName() %>"/>
	<tiles:put name="primaryKey" value="<%=mainid%>"/>
	<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
</tiles:insert>


<%--  ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.events.BsEvent.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		url='<%= themeDisplay.getPathMain() + "/ext/events/rate_event" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/events/edit_event_discussion" />
	</portlet:actionURL>
	
	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= gnomon.hibernate.model.base.events.BsEvent.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(PortalUtil.getCompanyId(request)) %>"
		subject="<%= view.getField3().toString() %>"
		redirect="<%= currentURL + "&tab=comments" %>"
	/>
</c:if>
	