<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>

<%--
<tiles:insert page="/html/portlet/ext/base/yellowpages/browser/alphabetTile.jsp" flush="true"/>
--%>

<% String filePath = GetterUtil.getString(PropsUtil.get("base.yellowpages.store"), CommonDefs.DEFAULT_STORE_PATH); %>

<%
StrutsFormFields new_field=null;
java.util.Vector fields=new java.util.Vector();
String curFormName="YellowPageSearchForm";

new_field = new StrutsFormFields("title","bs.yellowpages.title","text",false,false);
fields.addElement(new_field);

new_field = new StrutsFormFields("topicId","gn.topics.for-content","select",false,false);
new_field.setCollectionProperty("topicIds");
new_field.setCollectionLabel("topicNames");
fields.addElement(new_field);

request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/base/yellowpages/browser/search?actionURL=true" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="search">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
	<input type="hidden" name="search" value="false">
	<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "bs.related.content.search") %></html:submit> 
</html:form>

<br />



<%   
String lang=GeneralUtils.getLocale(request);


String loadaction = request.getParameter("loadaction");
List yellowpagesList = (List)request.getAttribute("itemsList");

if (Validator.isNotNull(loadaction)){

if (yellowpagesList == null || yellowpagesList.isEmpty()){ %>
<BR>	
<%=LanguageUtil.get(pageContext, "bs.yellowpages.noRecordsFound") %>
<%}else{ %>
<div class="yellowpages">
<display:table id="item" name="itemsList" requestURI="//ext/base/yellowpages/browser/search?actionURL=true" pagesize="20" sort="list" defaultsort="3" export="false" style="width: 100%;">   
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
      <c:if test="<%=yellowpageItem.getField6()!=null%>"> <img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + yellowpageItem.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath((String)yellowpageItem.getField6())%>" alt="<%= yellowpageItem.getField4().toString() %>" align="left" /> </c:if>
    </div>

 </display:column>

<display:column>
     <div class="yp_title">
      <c:if test="<%=yellowpageItem.getField4()!=null%>">
<!--     	<a href=""
     	onclick="openDialog('<liferay-portlet:actionURL portletName="bs_yellowpages" windowState="<%=LiferayWindowState.POP_UP.toString()%>" >
			<liferay-portlet:param name="struts_action" value="/ext/yellowpages/load"/>
			<liferay-portlet:param name="mainid" value="<%= yellowpageItem.getMainid().toString() %>"/>
			<liferay-portlet:param name="loadaction" value="view"/>
			<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
			</liferay-portlet:actionURL>', 800,550);return false;"><%= yellowpageItem.getField4() %>
		</a>
        
       --> 
        
        <a href="<liferay-portlet:actionURL portletName="bs_yellowpages" windowState="<%=LiferayWindowState.POP_UP.toString()%>" >
           <liferay-portlet:param name="struts_action" value="/ext/yellowpages/load"/>
           <liferay-portlet:param name="mainid" value="<%= yellowpageItem.getMainid().toString() %>"/>
           <liferay-portlet:param name="loadaction" value="view"/>
           <liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
           </liferay-portlet:actionURL>&KeepThis=true&TB_iframe=true&height=500&width=600" 
           class="thickbox">
          <%= yellowpageItem.getField4() %>
         </a>
        
        

	  </c:if>
      </div>  
 
      <c:if test="<%=yellowpageItem.getField7()!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.address") + ": " + yellowpageItem.getField7() + " "%></c:if>
      <br />

      <c:if test="<%=yellowpageItem.getField8()!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.phone") + ": " + yellowpageItem.getField8() + " "%></c:if>
      <c:if test="<%=yellowpageItem.getField9()!=null%>"><%= LanguageUtil.get(pageContext, "bs.yellowpages.fax") + ": " + yellowpageItem.getField9() + " "%></c:if>


 </display:column>


</display:table>
</div>
<% } %>
<% } %>




<% if (Validator.isNotNull(redirect) && !redirect.equals("null")) {%>
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle"><a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "yellowpages.button.back") %></a>
<% } %>
