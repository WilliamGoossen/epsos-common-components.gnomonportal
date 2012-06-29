<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>

<%
String faqId = (String)request.getAttribute("faqId");
%>
<H1 class="title1">
<%=LanguageUtil.get(pageContext, "bs.faq.contactPerson.list") %>
</H1>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<display:table name="faqContactPersonsList" id="listItem">
<%ViewResult gnItem = (ViewResult)listItem;%>
	<display:column property="field3" titleKey="bs.faq.contactPerson.person" />
	<c:if test="<%= hasDelete %>">
	<display:column media="html">
		<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/faq/deleteContactPerson"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
		<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>">
		</a>
		
	</display:column>
	</c:if>
</display:table>


<form name="BsFaqContactPersonForm" action="/ext/faq/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/faq/loadContactPerson" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsFaqContactPersonForm" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  	<% if (Validator.isNotNull(faqId)) { %>
	  		<tiles:add value="faqId"/>
	  	<% } %>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  	<% if (Validator.isNotNull(faqId)) { %>
	  		<tiles:add><%= faqId %></tiles:add>
	  	<% } %>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:put name="actionPermission" value="add"/>
	  <tiles:put name="partyRoleActionPermission" value="add"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</form>
<BR>

<html:link styleClass="beta1" action="/ext/faq/list"><img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "back") %></html:link>

			