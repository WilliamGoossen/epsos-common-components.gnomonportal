<%@ include file="/html/portlet/ext/base/civitems/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.kms.GnKmsClass" %>
<div class="civitem-view">
<% ViewResult view = (ViewResult) request.getAttribute("civitemItem"); 
   String filePath = GetterUtil.getString(PropsUtil.get("base.civitems.store"), CommonDefs.DEFAULT_STORE_PATH);
   String metaDataClassName = "gnomon.hibernate.model.base.civitems.BsCivItem";
   if (view.getField8() != null) {
	   GnKmsClass gnKmsClass = (GnKmsClass)GnPersistenceService.getInstance(null).getObject(GnKmsClass.class, (Integer)view.getField8());
	   if (gnKmsClass != null)
		   metaDataClassName = gnKmsClass.getClassName();
   }

   //To view periexei ta pedia:
	 //  String[] fields = new String[] {
		// 1:  "langs.mainid",
		// 2: "langs.lang",
		// 3: "langs.title",
		// 4: "langs.description",
		// 5: "table1.code",
		// 6: "table1.imageFile",
		// 7: "table1.attachmentFile" };
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
	        <c:if test="<%=view.getField6()!=null%>">
		    <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + /*view.getMainid() +*/ "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)view.getField6())%>" alt="<%= view.getField3().toString() %>" align="left" style="padding-top:2px; padding-right:5px;" />	  </c:if>
	        </td>
	        <td></td>
	        </tr>
		</table>
	</div>	
	</td>
  </tr>
  <tr>
    <td><br>
	<c:if test="<%=view.getField4()!=null%>"><%=StringUtils.check_null(view.getField4(),"")%></c:if>
  </td>
  </tr>
  
<% if (Validator.isNotNull(metaDataClassName)) {  %>
	<tr>
	  <td>
	  <div class="uni-form">
		<tiles:insert page="/html/portlet/ext/struts_includes/metaData_div.jsp" flush="true">
			<tiles:put name="formName" value="BsCivItemForm"/>
			<tiles:put name="className"><%= metaDataClassName %></tiles:put>
			<tiles:put name="primaryKey" value="<%= view.getMainid().toString() %>"/>
			<tiles:put name="readOnly" value="true"/>
		</tiles:insert>
		</div>
	</td>
	</tr>
<% } %>  
  
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
%>

<br />

<% if (attachments != null && attachments.size() > 0) { %>
<liferay-ui:tabs
	names="attach-files"
	param="tab"
/>

<!-- Attachments List -->
<display:table id="attachment" name="attachments" requestURI="//ext/civitems/load?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("attachment"); %>

<display:column titleKey="title" sortable="false" >
<b>
<c:choose>
	<c:when test="<%=gnItem.getField2()!=null%>">
		<%String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(gnItem.getField2().toString(), "page");%>
		<img align="left" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
		<a target="_blank" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>"><portlet:param name="struts_action" value="/ext/civitems/getFile"/><portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/><portlet:param name="loadaction" value="view"/></portlet:actionURL>"><%= gnItem.getField2().toString() %></a>
		</img>
	</c:when>
	<c:otherwise>
		<%= gnItem.getField2().toString() %>
	</c:otherwise>
</c:choose>
</b>
</display:column>

<c:if test="<%= hasEdit || hasDelete %>">
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
						<portlet:param name="struts_action" value="/ext/civitems/loadFile"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="civitemid" value="<%= mainid %>"/>
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
						<portlet:param name="struts_action" value="/ext/civitems/loadFile"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="civitemid" value="<%= mainid %>"/>
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
<% } %>
<br/>
<form name="BsCivItemFileForm" action="/ext/civitems/loadFile" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/civitems/loadFile" />
	<tiles:put name="buttonName" value="addButton" />
	<tiles:put name="buttonValue" value="add-attachment" />
	<tiles:put name="formName"   value="BsCivItemFileForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="civitemid"/>
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
	<tiles:put name="civitemid" value="<%=mainid%>"/>
</tiles:insert>
</form>
<HR />
<br/>
<c:choose>
<c:when test="<%=Validator.isNull(redirect)%>">
	<html:link styleClass="beta1" action="/ext/civitems/list">
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

<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
	<tiles:put name="className" value="<%= gnomon.hibernate.model.base.civitems.BsCivItem.class.getName() %>"/>
	<tiles:put name="primaryKey" value="<%=mainid%>"/>
	<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
</tiles:insert>

<%--  ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.civitems.BsCivItem.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		url='<%= themeDisplay.getPathMain() + "/ext/civitems/rate" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/civitems/edit_discussion" />
	</portlet:actionURL>
	
	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= gnomon.hibernate.model.base.civitems.BsCivItem.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(PortalUtil.getCompanyId(request)) %>"
		subject="<%= view.getField3().toString() %>"
		redirect="<%= currentURL + "&tab=comments" %>"
	/>
</c:if>
