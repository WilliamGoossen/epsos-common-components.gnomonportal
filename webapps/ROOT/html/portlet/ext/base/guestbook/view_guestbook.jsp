<%@ include file="/html/portlet/ext/base/guestbook/init.jsp" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<%--<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>--%>


<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<%

TitleData titleData = null;
if (tileAttribute != null)
	titleData = (TitleData)request.getAttribute(tileAttribute);
else
	titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE);

if (titleData != null)
{ %>
<br/>

		<b><%= titleData.getDisplayValue(0).toString() %></b>
<br/>
		<%= titleData.getDisplayValue(1).toString() %>

<br/><br/>
		<%= titleData.getDisplayValue(2).toString() %>

<br/>
<% }%>

<c:if test="<%= hasEdit || hasDelete %>">
<br/>
<form name="BsCommentForm" action="/ext/guestbook/load" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/guestbook/load" />
	<tiles:put name="buttonName" value="editButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" />
	<tiles:put name="formName"   value="BsCommentForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="edit"/>
	  	<tiles:add><%=titleData.getValue("mainid")%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="edit"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/guestbook/load" />
	<tiles:put name="buttonName" value="deleteButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" />
	<tiles:put name="formName"   value="BsCommentForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="delete"/>
	  	<tiles:add><%=titleData.getValue("mainid")%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="delete"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

</form>

</c:if>

<br/>
		<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" alt="back" align="middle">&nbsp;<a <%=Validator.isNull(redirect)? "onClick=\"history.go(-1);\"":"href=\"" + redirect + "\"" %>>
		<%= LanguageUtil.get(pageContext, "back") %></a>
		
<br><br>

	<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
		<tiles:put name="className" value="<%= gnomon.hibernate.model.base.guestbook.BsGuestbook.class.getName() %>"/>
		<tiles:put name="primaryKey" value="<%= titleData.getValue("mainid").toString() %>"/>
		<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
	</tiles:insert>			
