<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<html:form action="/ext/parties/contacts/emailContacts?actionURL=true" method="post" styleClass="uni-form" enctype="multipart/form-data">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="EmailContactsForm"/>
</tiles:insert>

 <div class="button-holder">
<html:submit><%= LanguageUtil.get(pageContext, "send") %></html:submit>
</div>

</html:form>

<%@ include file="/html/portlet/ext/parties/contacts/util/back.jspf" %>