<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%
String urlAction = "/ext/parties/contacts/addLiferayUser?actionURL=true";
String buttonText = "parties.button.add";
%>
<h2><%= LanguageUtil.get(pageContext, "parties.manager.person.createuser") %></h2>

<html:form action="<%= urlAction %>" method="post" styleClass="uni-form">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="AddLiferayUserForm"/>
</tiles:insert>

<% if (buttonText != null) { %>
 <div class="button-holder">
<html:submit><%= LanguageUtil.get(pageContext, buttonText) %></html:submit>
</div>
<%  } %>

</html:form>

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>