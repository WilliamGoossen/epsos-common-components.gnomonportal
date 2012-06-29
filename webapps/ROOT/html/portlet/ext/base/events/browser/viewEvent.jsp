<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<%@ page import="com.ext.portlet.base.events.BsEventForm" %>

<div class="event-view">

<% ViewResult view = (ViewResult) request.getAttribute("eventItem"); 
   //boolean enableRatings = true; //GetterUtil.getBoolean(prefs.getValue("enable-ratings", StringPool.BLANK), true);
   //boolean enableComments = true; //GetterUtil.getBoolean(prefs.getValue("enable-comments", StringPool.BLANK), true);

   ViewResult roomView = (ViewResult) request.getAttribute("roomItem");
   ViewResult buildingView = (ViewResult) request.getAttribute("buildingItem");
   String filePath = GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH);
   boolean allowDetailsEditing = true;
   // if it is a recurring event with a valid parent event DO NOT allow details editing
	if (view.getField12()!=null && ((Boolean)view.getField12()).booleanValue() && Validator.isNotNull(view.getField14())) {
		allowDetailsEditing = false;
	}
   /*
    To view periexei ta pedia:
	 	String[] fields = new String[] {
		1 "langs.mainid",
		2 "langs.lang",
		3 "langs.title",
		4 "langs.description",
		5 "langs.place",
		6 "langs.participants",
		7 "table1.eventType",
		8 "table1.eventDateStart",
		9 "table1.eventTime",
		10 "table1.eventDateEnd",
		11 "langs.image",
		12 "table1.repeating",
		13 "table1.cancelled",
		14 "table1.freeEntry",
		15 "table1.onlineReservations",
		16 "table1.mandatoryPayment",
		17 "langs.organizedBy",
		18 "table1.organizationType",
		19 "table1.eventEndTime",
		20 "table1.onlineReservationsHourLimit",
		21 "table1.evRoom.mainid",
		22 "table1.evBuilding.mainid"
		23 "table1.onlineProductsActive"
	    24"table1.evEventType.evEventTypeLanguage.name"}};
	*/
%>

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
				<c:if test="<%=view.getField9()!=null%>">
				<%=LanguageUtil.get(pageContext, "bs.events.eventStartTime") %> 
				<%=StringUtils.check_null(view.getField9(),"")%>	</c:if><br>
				<c:if test="<%=view.getField19()!=null%>">
				<%=LanguageUtil.get(pageContext, "bs.events.eventEndTime") %> 
				<%=StringUtils.check_null(view.getField19(),"")%>	</c:if>					
				</td>
	  </tr>

	  <c:if test="<%=roomView !=null && buildingView != null %>">
	  <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.place") %> : </strong></div></td>
		  <td>&nbsp;<%= buildingView.getField1() + (Validator.isNotNull(buildingView.getField2()) ? " ("+buildingView.getField2()+")" : "") + "<br>" +
		  				roomView.getField1() + (Validator.isNotNull(roomView.getField2()) ? " ("+roomView.getField2()+")" : "")%>		  </td>
	  </tr>
	  </c:if>

	  <c:if test="<%=view.getField7()!=null%>">
	    <tr>
    	  <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.type") %> : </strong></div></td>
		  <td>&nbsp;<%=view.getField24()%></td>
	   </tr>
	  </c:if>
	  <c:if test="<%=view.getField13()!=null && ((Boolean)view.getField13()).booleanValue() %>">
	    <tr>
	      <td>&nbsp;</td>
    	  <td valign="top" nowrap="nowrap"><strong><%=LanguageUtil.get(pageContext, "bs.events.cancelled") %></strong></td>
	   </tr>
	  </c:if>
	  <c:if test="<%=view.getField18()!=null%>">
	    <tr>
	      <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.organizationType") %> : </strong></div></td>
    	  <td valign="top" nowrap="nowrap">
    	  <% switch ((Integer)view.getField18()) {
    	  case BsEventForm.ORGANIZATION_INTERNAL: out.print(LanguageUtil.get(pageContext, "bs.events.organizationType.internal")); break;
    	  case BsEventForm.ORGANIZATION_SHARED: out.print(LanguageUtil.get(pageContext, "bs.events.organizationType.shared")); break;
    	  case BsEventForm.ORGANIZATION_EXTERNAL: out.print(LanguageUtil.get(pageContext, "bs.events.organizationType.external")); break;
    	  }
    	  %></td>
	   </tr>
	  </c:if>
	  <c:if test="<%=view.getField17()!=null%>">
	    <tr>
	      <td valign="top" nowrap="nowrap"><div align="right"><strong><%=LanguageUtil.get(pageContext, "bs.events.organizedBy") %> : </strong></div></td>
    	  <td valign="top" nowrap="nowrap"><%= view.getField17() %></td>
	   </tr>
	  </c:if>
	  
	   <c:if test="<%=view.getField15()!=null && ((Boolean)view.getField15()).booleanValue() && view.getField23()!=null && ((Boolean)view.getField23()).booleanValue()%>">
	    <tr>
	      <td align="right"><img align="right" src="<%= themeDisplay.getPathThemeImage() %>/common/calendar.png" alt="<%=LanguageUtil.get(pageContext, "bs.events.detailed-schedule") %>"></td>
    	  <td valign="top" nowrap="nowrap"><strong>
    	  <a href="<portlet:actionURL>
			<portlet:param name="struts_action" value="/ext/eventsbrowser/loadSchedule"/>
			<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			</portlet:actionURL>">
    	  <%=LanguageUtil.get(pageContext, "bs.events.detailed-schedule") %>
    	  </a></strong></td>
	   </tr>
	  </c:if>
	  
	  </table></td></tr>
	</table>
	</div>	
	
	
	<c:if test="<%=view.getField14()!=null && ((Boolean)view.getField14()).booleanValue()%>">
	    <div class="event-view-free"><span><%=LanguageUtil.get(pageContext, "bs.events.freeEntry") %></span></div>
	  </c:if>
	  
	<c:if test="<%=view.getField4()!=null%>">
	<br><br>
	<div class="event-view-description"><%=StringUtils.check_null(view.getField4(),"")%></div>
    </c:if>
    
	</td>
  </tr>
</table>


<%
String mainid = ParamUtil.getString(request,"mainid");
List attachments = (List)request.getAttribute("attachments");
List relatedParties = (List)request.getAttribute("relatedParties");
%>

<% 
	String htmlTitle="<img src=\""+ themeDisplay.getPathThemeImage()+"/orgchart/person.gif\">";
%>

<!--  PARTIES PARTICIPANTS -->

<% if (relatedParties != null && relatedParties.size() > 0) { %>
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "bs.events.yellowpages.list") %></legend>

<display:table id="relatedParty" name="relatedParties" requestURI="//ext/eventsbrowser/load?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
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
<display:column titleKey="contacts.search.name" sortable="true" >
<a title="<%= partyItem.getField1().toString() %>" href="<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= partyItem.getMainid().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>">
<%= partyItem.getField1().toString() %>
</a>
</display:column>
<display:column titleKey="bs.events.parties.name" sortable="true" >
<%= partyItem.getField13() != null ? partyItem.getField13().toString() : "-" %>
</display:column>
</display:table>
</fieldset>
<% }  %>

<% if (attachments != null && attachments.size() > 0) { %>

<fieldset>
<legend><%= LanguageUtil.get(pageContext, "attach-files") %></legend>

<!-- Attachments List -->
<display:table id="attachment" name="attachments" requestURI="//ext/eventsbrowser/load?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
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
</display:table>

</fieldset>

<% } %>

</div>


<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
	<tiles:put name="className" value="<%= BsEvent.class.getName() %>"/>
	<tiles:put name="primaryKey" value="<%=mainid%>"/>
</tiles:insert>

<%--  product ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.events.BsEvent.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		url='<%= themeDisplay.getPathMain() + "/ext/eventsbrowser/rate_event" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/eventsbrowser/edit_event_discussion" />
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
<div class="event-view-back">
				<a href="#" onClick="history.go(-1);"> 
				<%= LanguageUtil.get(pageContext, "back") %>
				</a>
                </div>	
	