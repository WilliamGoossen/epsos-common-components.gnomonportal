<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
ViewResult yellowpageItem = (ViewResult)request.getAttribute("yellowpageItem");
String lon = "";
String lat = "";
if (yellowpageItem != null) {
	lon = (String)yellowpageItem.getField22();
	lat = (String)yellowpageItem.getField23();
}
lon = (lon == null) ? "" : lon;
lat = (lat == null) ? "" : lat;

String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/yellowpages/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "bs.yellowpages.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/yellowpages/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.yellowpages.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/yellowpages/add?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "bs.yellowpages.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/yellowpages/add?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "bs.yellowpages.add-translation";
}
%>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form" enctype="multipart/form-data">

<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="BsYellowPageForm"/>
<tiles:put name="useTabs" value="false"/>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/struts_includes/metaData_div.jsp" flush="true">
	<tiles:put name="formName" value="BsYellowPageForm"/>
	<tiles:put name="className" value="gnomon.hibernate.model.base.yellowpages.BsYellowPage"/>
	<% com.ext.portlet.base.yellowpages.BsYellowPageForm formBean = (com.ext.portlet.base.yellowpages.BsYellowPageForm) request.getAttribute("BsYellowPageForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
</tiles:insert>

<%
if(GetterUtil.getBoolean(PropsUtil.get("bs.yellowpage.use.googlemaps"),false))
	{
	%>
<jsp:include page="/html/portlet/ext/base/yellowpages/googlemaps.jsp"></jsp:include>
  <body onload="load()" onunload="GUnload()">
    <div id="map" style="width: 600px; height: 600px"></div>
  </body>
  
<INPUT SIZE=13 TYPE="hidden" ID="latbox" NAME="lat" value="<%=lat %>" >
<INPUT SIZE=13 TYPE="hidden" ID="lonbox" NAME="lon" value="<%=lon %>" >
<% }  %>

<div class="button-holder">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="BsYellowPageForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/yellowpages/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="BsYellowPageForm" />
		  <tiles:put name="confirm" value="gn.messages.are-you-sure-you-want-to-delete-this-translation"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
</div>


</html:form>


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2"><%= LanguageUtil.get(pageContext, "gn.translations" ) %></h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/yellowpages/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/yellowpages/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>
