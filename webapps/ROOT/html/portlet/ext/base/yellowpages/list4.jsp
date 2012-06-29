<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>


<%--
<tiles:insert page="/html/portlet/ext/struts_includes/topicContentBrowser.jsp" flush="true">
<tiles:put name="struts_action" value="/ext/yellowpages/list"/>
<tiles:put name="contentClass" value="gnomon.hibernate.model.base.yellowpages.BsYellowPage"/>
</tiles:insert>
--%>
<%
if(instancePortletBrowseType.equals("metadata")) {%>
	
	<% if (request.getParameter("metadataid")!=null ) {%>
	
	<tiles:insert page="/html/portlet/ext/struts_includes/listMetadataContent.jsp" flush="true">
	<tiles:put name="struts_action" value="/ext/yellowpages/list"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="hasEdit" value="<%=hasEdit%>"/>
	<tiles:put name="hasDelete" value="<%=hasDelete%>"/>
	<tiles:put name="hasPublish" value="<%=hasPublish%>"/>
	<tiles:put name="contentClass" value="gnomon.hibernate.model.base.yellowpages.BsYellowPage"/>
	<tiles:put name="commandSpace" value="/html/portlet/ext/base/yellowpages/menu/list_menu.jsp"/>
	<tiles:put name="requestURI" value="//ext/yellowpages/list?actionURL=true"/>
	<tiles:put name="requestAttr" value="yellowpages"/>
	<tiles:put name="currentURL" value="<%=currentURL%>"/>
	
</tiles:insert>

	<%}
}%>

<%
String filePath = GetterUtil.getString(PropsUtil.get("base.yellowpages.store"), CommonDefs.DEFAULT_STORE_PATH);
String lang=GeneralUtils.getLocale(request);
%>
<!-- YellowPages List -->
<div class="yellowpages">

<display:table id="item" name="yellowpages" requestURI="//ext/yellowpages/list?actionURL=true" pagesize="15" sort="list" defaultsort="3" export="false" style=" width:100%;">   
<% 
ViewResult yellowpageItem = (ViewResult)pageContext.getAttribute("item");
Integer mainId = null;
String topicsCommaSep = "";
if (yellowpageItem != null) {
	mainId = (Integer)yellowpageItem.getMainid();
	List tmpList = com.ext.portlet.base.yellowpages.services.YellowPageService.getInstance().listTopicsOfYellowPage(mainId, lang);
	topicsCommaSep = Utils.createCharSeparatedListOfField(tmpList, "getField1", ",", false, false);
}
%>
<display:column>
     <div class="yp_photo">
      <c:if test="<%=yellowpageItem.getField6()!=null%>"> <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + yellowpageItem.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)yellowpageItem.getField6())%>" alt="<%= yellowpageItem.getField4().toString() %>"   align="left" /> </c:if>
    </div>

 </display:column>
<display:column>
     <div class="yp_content">
      <c:if test="<%=yellowpageItem.getField4()!=null%>">
     	<%//=LanguageUtil.get(pageContext, "bs.yellowpages.title") %>
     	<a href="<liferay-portlet:actionURL portletName="bs_yellowpages " >
			<liferay-portlet:param name="struts_action" value="/ext/yellowpages/load"/>
			<liferay-portlet:param name="mainid" value="<%= yellowpageItem.getMainid().toString() %>"/>
			<liferay-portlet:param name="loadaction" value="view"/>
			<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
			</liferay-portlet:actionURL>">
		<span class="yp_title"><%= yellowpageItem.getField4() %></span>
		</a><br>
	  </c:if>  
      <c:if test="<%=yellowpageItem.getField7()!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.address") + ": " + yellowpageItem.getField7() + " "%></c:if>
      <br />

      <c:if test="<%=yellowpageItem.getField8()!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.phone") + ": " + yellowpageItem.getField8() + " "%></c:if>
      <c:if test="<%=yellowpageItem.getField9()!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.fax") + ": " + yellowpageItem.getField9() + " "%></c:if>
    </div>

 </display:column>

</display:table>

</div>


<br/><br/>

<form name="BsYellowPageForm" action="/ext/yellowpages/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/yellowpages/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsYellowPageForm" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add value="topicid"/>
	  	<% } %>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add><%= request.getParameter("topicid") %></tiles:add>
	  	<% } %>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:put name="actionPermission" value="add"/>
	  <tiles:put name="partyRoleActionPermission" value="add"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</form>

