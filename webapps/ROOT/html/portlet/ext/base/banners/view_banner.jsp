<%@ include file="/html/portlet/ext/base/banners/init.jsp" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>


<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<%

TitleData titleData = null;
if (tileAttribute != null)
	titleData = (TitleData)request.getAttribute(tileAttribute);
else
	titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE);

if (titleData != null)
{ 
String imgPath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.banners.store"), CommonDefs.DEFAULT_STORE_PATH);
imgPath += titleData.getValue("mainid") + "/";
%>

<a href="<%=titleData.getDisplayValue(1) %>" border="0">
<% if  (titleData.getDisplayValue(3).toString().endsWith("swf")) {%>
<object>
	<param name="movie" value="<%= "/"+imgPath + titleData.getDisplayValue(3).toString() %>">
	<param name="wmode" value="opaque"/>
	<param name="loop" value="true"/>
	<param name="base" value="."/>
<embed src="<%= "/"+imgPath + titleData.getDisplayValue(3).toString() %>"
	   loop="true" base="." wmode="opaque"></embed>
</object>
<% } else { %>
<img src='<%= "/"+imgPath + titleData.getDisplayValue(3).toString()%>' />
<% } %>
</a>

<br/><br/>

<c:if test="<%= hasEdit || hasDelete %>">
<form name="BsBannerForm" action="/ext/banners/load" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/banners/load" />
	<tiles:put name="buttonName" value="editButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" />
	<tiles:put name="formName"   value="BsBannerForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="edit"/>
	  	<tiles:add><%=titleData.getValue("mainid").toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="edit"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/banners/load" />
	<tiles:put name="buttonName" value="deleteButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" />
	<tiles:put name="formName"   value="BsBannerForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="delete"/>
	  	<tiles:add><%=titleData.getValue("mainid").toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="delete"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

</form>
</c:if>
<% }%>

<br/>

<br>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<a <%=Validator.isNull(redirect)? "onClick=\"history.go(-1);\"":"href=\"" + redirect + "\"" %>> 
		<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "back") %>
		</a>
	</td>
</tr>
</table>

<br><br>

<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
	<tiles:put name="className" value="<%= gnomon.hibernate.model.base.banners.BsBanner.class.getName() %>"/>
	<tiles:put name="primaryKey" value="<%= titleData.getValue("mainid").toString() %>"/>
	<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
</tiles:insert>


<%--  ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.banners.BsBanner.class.getName() %>"
		classPK="<%=  Integer.parseInt(titleData.getValue("mainid").toString()) %>"
		url='<%= themeDisplay.getPathMain() + "/ext/banners/rate" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/banners/edit_discussion" />
	</portlet:actionURL>
	
	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= gnomon.hibernate.model.base.banners.BsBanner.class.getName() %>"
		classPK="<%= (Integer)Integer.parseInt(titleData.getValue("mainid").toString()) %>"
		userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(PortalUtil.getCompanyId(request)) %>"
		subject="<%= titleData.getValue("title").toString() %>"
		redirect="<%= currentURL + "&tab=comments" %>"
	/>
</c:if>


