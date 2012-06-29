<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.portlet.base.faq.BsFaqForm" %>

<%--<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>--%>


<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<%
BsFaqForm aFormBean = (BsFaqForm)request.getAttribute("BsFaqForm");
String faqCode = (aFormBean != null) ? aFormBean.getFaqCode() : "";
faqCode = (faqCode == null) ? "" : faqCode;

TitleData titleData = null;
if (tileAttribute != null)
	titleData = (TitleData)request.getAttribute(tileAttribute);
else
	titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE);

if (titleData != null)
{ %>
<br/>
		<b><%= faqCode %></b><br/>
		<b><%= titleData.getDisplayValue(0).toString() %></b>
<br/>
		<%= titleData.getDisplayValue(1).toString() %>
<br/>
		
	
<br/><br/>
<% }%>


<%
Hashtable params = new Hashtable();
if (aFormBean != null && aFormBean.getMainid() != null) params.put("faqId", aFormBean.getMainid().toString());
request.setAttribute("contPersParams", params);
%>				
<html:link styleClass="beta1" action="/ext/faq/listContactPersons" name="contPersParams">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_users.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
&nbsp;<%= LanguageUtil.get(pageContext, "bs.faq.contactPerson.list") %>
</html:link>
<BR><BR>


<c:if test="<%= hasEdit || hasDelete %>">
<br/>
<form name="BsFaqForm" action="/ext/faq/load" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/faq/load" />
	<tiles:put name="buttonName" value="editButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" />
	<tiles:put name="formName"   value="BsFaqForm" />
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
	<tiles:put name="action"  value="/ext/faq/load" />
	<tiles:put name="buttonName" value="deleteButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" />
	<tiles:put name="formName"   value="BsFaqForm" />
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
		
<br><br>

	<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
		<tiles:put name="className" value="<%= gnomon.hibernate.model.base.faq.BsFaq.class.getName() %>"/>
		<tiles:put name="primaryKey" value="<%= titleData.getValue("mainid").toString() %>"/>
		<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
	</tiles:insert>		

<br><br>
	<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" alt="back" align="middle">&nbsp;<a <%=Validator.isNull(redirect)? "onClick=\"history.go(-1);\"":"href=\"" + redirect + "\"" %>> 
	<%= LanguageUtil.get(pageContext, "back") %></a>
