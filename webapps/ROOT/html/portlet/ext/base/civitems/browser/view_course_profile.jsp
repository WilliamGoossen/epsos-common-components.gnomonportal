<%@ include file="/html/portlet/ext/base/civitems/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.kms.GnKmsClass" %>
<%@ page import="com.ext.portlet.fof.services.FOFServices"%>


<%@page import="gnomon.hibernate.PartiesService"%>
<%@page import="gnomon.hibernate.model.parties.PaPerson"%>
<%@page import="gnomon.hibernate.model.parties.PaEmailAddress"%>

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
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<div class="provider_info">
<%
String providerProfileMainId = 
	FOFServices.getProviderProfileMainId(view.getField9().toString(),request);
Hashtable<String, String> params = new Hashtable<String, String>();
params.put("struts_action", "/ext/fof/provider_profile/load");
params.put("mainid", providerProfileMainId);
params.put("loadaction", "view");
String lookupUrl = 
	FOFServices.createUrl(params, WindowState.MAXIMIZED, "FOF_MANAGE_PROVIDER_PROFILE", plid, true, request);

String providerName=(String)request.getAttribute("providerName");
%>
<%=LanguageUtil.get(pageContext,"fof.course_list.authorName")%>:	  <%=providerName %>
<br>
<div class="provider_links">
<a href="<%=lookupUrl %>"><span>
<%=LanguageUtil.get(pageContext, "fof.course_list.Providers_profile") %></span></a>



<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/civitemsbrowser/listCoursesOfAuthor"/><portlet:param name="authorId" value="<%= view.getField9().toString() %>"/></portlet:actionURL>"><span>
<%=LanguageUtil.get(pageContext, "fof.course_list.More_Courses_of_same_provider") %></span></a>


<% PaPerson paPer= PartiesService.getInstance().getPaPerson(new Long (view.getField9().toString())); 
List em= (List)GnPersistenceService.getInstance(null).listAllObjects(null,PaEmailAddress.class,"PA__mainid='"+paPer.getMainid().toString()+"'",null,-1);
if (em!=null && !em.isEmpty()){
	String emailaddress=((PaEmailAddress)em.get(0)).getEmailAddress();
	if(emailaddress!=null && !emailaddress.equals(""))
		emailaddress="mailto:"+emailaddress;
%>

<a href="<%=emailaddress %>">
<span><%=LanguageUtil.get(pageContext, "fof.course_list.contact_provider") %></span></a>
<%} %>
</div>
</div>
<br>
<br>

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
			<tiles:put name="readOnlyStyle" value="block"/>
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
<HR />
<br/>
<c:choose>
<c:when test="<%=Validator.isNull(redirect)%>">
	<div class="button-back">
	<html:link styleClass="beta1" action="/ext/civitems/list">
	<%=LanguageUtil.get(pageContext,"back")%>
	</html:link>
    </div>
</c:when>
<c:otherwise>
	<div class="button-back">
	<a href="<%=redirect%>" class="beta1">
	<%=LanguageUtil.get(pageContext,"back")%>
	</a>
    </div>
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

