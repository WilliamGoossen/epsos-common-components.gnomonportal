<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>

<%@ page import="gnomon.hibernate.model.parties.PaCountry" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<% 
String windowState = ((RenderRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST)).getWindowState().toString();
boolean popUpWindowState = windowState != null && windowState.equals(LiferayWindowState.POP_UP.toString());

String filePath = GetterUtil.getString(PropsUtil.get("base.yellowpages.store"), CommonDefs.DEFAULT_STORE_PATH); 
ViewResult view = (ViewResult) request.getAttribute("yellowpageItem"); %>

<table border="0" >

<% if (Validator.isNotNull(view.getField6())) { %>
    <tr>
    <td>
   <!-- <a href="javascript:openDialog('<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + view.getField6() %>', '500', '400');">-->
    <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + (String)view.getField6()%>" alt="<%= view.getField4().toString() %>" align="left" style="padding-right:10px;" />
    <!--</a>
    &nbsp;&nbsp;-->
    </td>
    <td style="vertical-align:top;">
    
        <strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.title")%> : </strong>
        <br>
        <%= (Validator.isNotNull(view.getField4()) ? view.getField4().toString() : "") %>
        <br><br>

    
        <strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.contact")%> : </strong>
        <br><br>

        <%= (Validator.isNotNull(view.getField7()) ? view.getField7().toString() : "") %>
        <% if (Validator.isNotNull(view.getField20())) { 
            ViewResult countryView = GnPersistenceService.getInstance(null).getObjectWithLanguage(PaCountry.class, (Integer)view.getField20(), GeneralUtils.getLocale(request), new String[]{"langs.name"});
            if (countryView != null)
                out.print(", "+countryView.getField1());
        %>
        <% }  %>
        <%= (Validator.isNotNull(view.getField8()) ? ", "+view.getField8().toString() : "") %>
        <%= (Validator.isNotNull(view.getField9()) ? ", Fax:"+view.getField9().toString() : "") %>
        <%= (Validator.isNotNull(view.getField10()) ? ", "+view.getField10().toString() : "") %>
        <%= (Validator.isNotNull(view.getField11()) ? ", <a target=\"_new\" href=\"http://"+view.getField11().toString()+"\">"+view.getField11().toString()+"</a>" : "") %>
        <br><br>


		<% if (Validator.isNotNull(view.getField17())) { %>
            <strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.responsible")%> : </strong>
            <br>
            <%= (Validator.isNotNull(view.getField18())? view.getField18().toString()+" : " : "") %>
            <%= view.getField17().toString() %>
        <% } %>
        

    </td>
    </tr>
<% } %>
</table>

<strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.productsServices")%> : </strong>
<br>
<%= (Validator.isNotNull(view.getField5())? view.getField5().toString() : "") %>
<br>
<br>
<% if (Validator.isNotNull(view.getField19())) { %>
    <strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.interestedIn")%> : </strong>
    <br>
    <%= view.getField19().toString() %>
    <% } %>
<br>
<br>
<% if (Validator.isNotNull(view.getField12())) { %>
    <strong><%= LanguageUtil.get(pageContext, "bs.yellowpages.contact2")%> : </strong> <br>
    <%= (Validator.isNotNull(view.getField12()) ? view.getField12().toString() : "") %>
    <%= (Validator.isNotNull(view.getField13()) ? ", "+view.getField13().toString() : "") %>
    <%= (Validator.isNotNull(view.getField14()) ? ", Fax:"+view.getField14().toString() : "") %>
    <%= (Validator.isNotNull(view.getField15()) ? ", "+view.getField15().toString() : "") %>
    <%= (Validator.isNotNull(view.getField16()) ? ", <a target=\"_new\" href=\"http://"+view.getField16().toString()+"\">"+view.getField16().toString()+"</a>" : "") %>
<% } %>





<BR><br>
<br>


<%
String showMap = request.getParameter("showMap");
boolean showMapFlag = (showMap == null || showMap.equals("true"));
if(showMapFlag && GetterUtil.getBoolean(PropsUtil.get("bs.yellowpage.use.googlemaps"),false)){
	String lon = "";
	String lat = "";
	if (view != null) {
		lon = (String)view.getField22();
		lat = (String)view.getField23();
	}
	lon = (lon == null) ? "" : lon;
	lat = (lat == null) ? "" : lat;

%>
<div class="yp_viewgooglemap">
<jsp:include page="/html/portlet/ext/base/yellowpages/googlemaps.jsp"></jsp:include>
  <body onLoad="load()" onUnload="GUnload()">
    <div id="map" style="width: 520px; height: 300px"></div>
  </body>
</div>

<INPUT SIZE=13 TYPE="hidden" ID="latbox" NAME="lat" value="<%=lat %>" >
<INPUT SIZE=13 TYPE="hidden" ID="lonbox" NAME="lon" value="<%=lon %>" >
<% }  %>




<c:if test="<%= !popUpWindowState && (hasEdit || hasDelete) %>">
<br/><br/>
<form name="BsYellowPageForm" action="/ext/yellowpages/load" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/yellowpages/load" />
	<tiles:put name="buttonName" value="editButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" />
	<tiles:put name="formName"   value="BsYellowPageForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="edit"/>
	  	<tiles:add><%=view.getMainid().toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="edit"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/yellowpages/load" />
	<tiles:put name="buttonName" value="deleteButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" />
	<tiles:put name="formName"   value="BsYellowPageForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="delete"/>
	  	<tiles:add><%=view.getMainid().toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="delete"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>
</form>

<br/>
</c:if>


<c:if test="<%= !popUpWindowState %>">

<br/><br/>

<div style="text-align:left;">
	<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" alt="back" align="absmiddle">
    <html:link page="/ext/yellowpages/list" ><%= LanguageUtil.get(pageContext, "back") %></html:link>
</div>
		

</c:if>
<br><br>

	<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
		<tiles:put name="className" value="<%= gnomon.hibernate.model.base.yellowpages.BsYellowPage.class.getName() %>"/>
		<tiles:put name="primaryKey" value="<%= view.getMainid().toString() %>"/>
		<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
	</tiles:insert>	
	
<%--  ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.yellowpages.BsYellowPage.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		url='<%= themeDisplay.getPathMain() + "/ext/yellowpages/rate" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/yellowpages/edit_discussion" />
	</portlet:actionURL>
	
	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= gnomon.hibernate.model.base.yellowpages.BsYellowPage.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(PortalUtil.getCompanyId(request)) %>"
		subject="<%= view.getField4().toString() %>"
		redirect="<%= currentURL + "&tab=comments" %>"
	/>
</c:if>	
