<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>
<%@ page import="gnomon.hibernate.model.gn.GnContentTopic" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<%
String loadaction = request.getParameter("loadaction");
List yellowpagesList = (List)request.getAttribute("yellowpagesList");

%>

<table>
<tr>
<td valign="top">
	<%if(GetterUtil.getBoolean(PropsUtil.get("bs.yellowpage.use.googlemaps"),false)){%>
    <jsp:include page="/html/portlet/ext/base/yellowpages/googlemaps_view.jsp"></jsp:include>
     <body onLoad="load()" onUnload="GUnload()">
    <div id="map" style="width: 400px; height: 400px"></div>
    </body>
    <INPUT SIZE=13 TYPE="hidden" ID="latbox" NAME="lat" value="" >
    <INPUT SIZE=13 TYPE="hidden" ID="lonbox" NAME="lon" value="" >
    <% }  %>

</td>
<td valign="top">

<html:form action="/ext/base/yellowpages/browserGoogle/search?actionURL=true" method="post">
	<input type="hidden" name="loadaction" value="search">
<div>
    <tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true">
        <tiles:put name="attributeName" value="topic_tree_descr"/>
    </tiles:insert>
</div>
<BR>
<%
String[] topicMultiSelectIds = request.getParameterValues("topicMultiSelectIds");
if (Validator.isNotNull(loadaction) && (topicMultiSelectIds == null || topicMultiSelectIds.length == 0)) {
%>
    <span class="portlet-msg-error" >
    <%=LanguageUtil.get(pageContext, "bs.yellowpages.googleSearch.pleaseSelectTopic") %>
    </span>
<%} %>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "bs.related.content.search") %></html:submit> 
</html:form>


</td>
</tr>
</table>
<BR><BR>

<% 
String filePath = GetterUtil.getString(PropsUtil.get("base.yellowpages.store"), CommonDefs.DEFAULT_STORE_PATH); 
String lang=GeneralUtils.getLocale(request);

String selTopicNames = (String)request.getAttribute("selTopicNames");
%>

<%if (Validator.isNotNull(selTopicNames)){ %>
    <span class="portlet-msg-info" >
		<%=LanguageUtil.get(pageContext, "bs.yellowpages.selectedTopicsForSearch") %><BR>
        <%=selTopicNames %>
    </span>
<%} %>


<%

if (Validator.isNotNull(loadaction)){
	

if (yellowpagesList == null || yellowpagesList.isEmpty()){ %>
<BR>
<%=LanguageUtil.get(pageContext, "bs.yellowpages.noRecordsFound") %>
<%}else{ %>
<display:table  id="listItem" name="yellowpagesList" style=" width:100%;" pagesize="25" >
<%
ViewResult aVrItem = (ViewResult)listItem;
Integer mainId = null;
String title = "";
String address = "";
String lat = "";
String lng = "";
String img = "";
String phone = "";
String fax = "";
boolean showOnMap = false;
String topicsCommaSep = "";
if (aVrItem != null) {
	mainId = (Integer)aVrItem.getMainid();
	title = (String)aVrItem.getField1();
	address = (String)aVrItem.getField2();
	lat = (String)aVrItem.getField3();
	lng = (String)aVrItem.getField4();
	showOnMap  = Validator.isNotNull(lat) && Validator.isNotNull(lng);
	
	img = (String)aVrItem.getField5();
	phone = (String)aVrItem.getField6();
	fax = (String)aVrItem.getField7();
	
	List tmpList = com.ext.portlet.base.yellowpages.services.YellowPageService.getInstance().listTopicsOfYellowPage(mainId, lang);
	topicsCommaSep = Utils.createCharSeparatedListOfField(tmpList, "getField1", ",", false, false);
	
}
%>
<display:column>
      <div class="yp_photo">
      <c:if test="<%=img!=null%>"> <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + mainId + "/" + gnomon.business.GeneralUtils.createThumbnailPath(img)%>" alt="<%= title %>"   align="left" /> </c:if>
    </div>
</display:column>

<display:column>
     <div class="yp_title">
     <c:if test="<%=title!=null%>">
     	<%=LanguageUtil.get(pageContext, "bs.yellowpages.title") %> : 
<!--     	<a href=""
     		onclick="openDialog('<liferay-portlet:actionURL portletName="bs_yellowpages" windowState="<%=LiferayWindowState.POP_UP.toString()%>" >
			<liferay-portlet:param name="struts_action" value="/ext/yellowpages/load"/>
			<liferay-portlet:param name="mainid" value="<%= mainId.toString() %>"/>
			<liferay-portlet:param name="loadaction" value="view"/>
			<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
			</liferay-portlet:actionURL>', 600,350);return false;">
		<%= title %>
		</a><br>-->
        
        
        <a href="<liferay-portlet:actionURL portletName="bs_yellowpages" windowState="<%=LiferayWindowState.POP_UP.toString()%>" >
           <liferay-portlet:param name="struts_action" value="/ext/yellowpages/load"/>
           <liferay-portlet:param name="mainid" value="<%= mainId.toString() %>"/>
           <liferay-portlet:param name="loadaction" value="view"/>
           <liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
           </liferay-portlet:actionURL>&KeepThis=true&TB_iframe=true&height=500&width=600" 
           class="thickbox">
          <%= title %>
         </a><br>

        
        
        
	  </c:if>
      </div>
      
      <c:if test="<%=address!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.address") + ": " + address + " "%></c:if>
      <br>
      <c:if test="<%=phone!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.phone") + ": " + phone + " "%></c:if>
      <c:if test="<%=fax!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.fax") + ": " + fax + " "%></c:if>
    </div>

 </display:column>

<!--  display:column media="html" titleKey="bs.yellowpages.google.showOnMap" >
<input type="checkbox" < % =(showOnMap) ? "checked" : "" % > disabled >
< / display:column -->


</display:table>
</div>
<%} %>

<%} %>

<%if(GetterUtil.getBoolean(PropsUtil.get("bs.yellowpage.use.googlemaps"),false)){%>
<script type="text/javascript">

var bodyEl = document.body;

try{
	
if (bodyEl != undefined) {	
	var oldWinOnLoad = window.onload;
	if (oldWinOnLoad != undefined) {
		// Because of the treeview, change the body onload 
		// so that it calls the previous version (loading the tree view) 
		// and afterwards it calls the load() for the google
		var newOnLoadFunction = new Function("oldWinOnLoad();load();");
		window.onload = newOnLoadFunction;
	}
}else{
	//alert('undefined');
}
}catch(ex){
	alert(ex.message);
}

//load();
</script>
<%} %>
