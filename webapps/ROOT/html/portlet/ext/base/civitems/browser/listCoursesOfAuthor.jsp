<%@ include file="/html/portlet/ext/fof/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%@page import="gnomon.hibernate.PartiesService"%>
<%@page import="gnomon.hibernate.model.parties.PaPerson"%>
<%@page import="gnomon.hibernate.model.parties.PaEmailAddress"%>

<%
//String emailaddress=(String)request.getAttribute("authorEmail");
String authorId=(String)request.getAttribute("authorId");
String titleText = "";
%>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<div class="provider_info">
<%
String providerProfileMainId = 
	FOFServices.getProviderProfileMainId(authorId,request);
Hashtable<String, String> params = new Hashtable<String, String>();
params.put("struts_action", "/ext/fof/provider_profile/load");
params.put("mainid", providerProfileMainId);
params.put("loadaction", "view");
String lookupUrlProvider = 
	FOFServices.createUrl(params, WindowState.MAXIMIZED, "FOF_MANAGE_PROVIDER_PROFILE", plid, true, request);

String providerName=(String)request.getAttribute("providerName");
%>
<%=LanguageUtil.get(pageContext,"fof.course_list.authorName")%>:	  <%=providerName %>
<br>
<div class="provider_links">
<a href="<%=lookupUrlProvider %>"><span>
<%=LanguageUtil.get(pageContext, "fof.course_list.Providers_profile") %></span></a>



<% PaPerson paPer= PartiesService.getInstance().getPaPerson(new Long (authorId)); 
List em= (List)GnPersistenceService.getInstance(null).listAllObjects(null,PaEmailAddress.class,"PA__mainid='"+paPer.getMainid().toString()+"'",null,-1);
if (em!=null && !em.isEmpty()){
	String emailaddress=((PaEmailAddress)em.get(0)).getEmailAddress();
	if(emailaddress!=null && !emailaddress.equals(""))
		emailaddress="mailto:"+emailaddress;
%>

<a href="<%=emailaddress %>">
<span><%=LanguageUtil.get(pageContext, "fof.course_list.contact_provider") %></span></a>
<%} %></div></div>
<br>
<br>

<br>

<h1 ><%= LanguageUtil.get(pageContext, titleText) %></h1>
<br>
<%
params = new Hashtable<String, String>();
params.put("struts_action", "/ext/civitemsbrowser/listCoursesOfAuthor");
params.put("authorId", authorId);
String lookupUrl = 
	FOFServices.createUrl(params, null, portletID, plid, true, request);
%>
<form name="FOFTitleCourseSearchForm" styleClass="uni-form"  action="<%=lookupUrl %>" method="post">
<%
String searchName = request.getParameter("searchName");
searchName = (searchName == null) ? "" : searchName;
%>
<div class="inline-labels">
<div class="ctrl-holder">
<label for="fofCourseTitle"><%= LanguageUtil.get(pageContext, "fof.course_name") %></label>
<input type="text" name="searchName" value="<%=searchName %>">
<input type="submit" value="<%=LanguageUtil.get(pageContext, "gn.button.search") %>" /> 
</div> 
</div>	
</form>

<!-- CivItems List -->
<display:table id="civitem" name="civitems" requestURI="//ext/fof/course_list/list_by_author/listCoursesOfAuthor?actionURL=true" pagesize="10" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("civitem"); %>
<display:column titleKey="title" sortable="true" style="width:100%">
<a href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/civitemsbrowser/load"/>
		<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
		<portlet:param name="loadaction" value="view"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>"><%= gnItem.getField6().toString() %></a>
</display:column>

<%--display:column property="field3" titleKey="bs.civitems.code" sortable="true"/--%>



</display:table>
<br/><br/>


