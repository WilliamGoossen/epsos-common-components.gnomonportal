<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>
<%@ page import="com.ext.portlet.base.faq.contactPerson.BsFaqContactPersonForm" %>

<%
BsFaqContactPersonForm aFormBean = (BsFaqContactPersonForm)request.getAttribute("BsFaqContactPersonForm");
Integer faqId = aFormBean.getFaqId();
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/faq/addContactPerson?actionURL=true";
String buttonText = "gn.button.add";
String titleText = "bs.faq.contactPerson.add";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/faq/deleteContactPerson?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.faq.contactPerson.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/faq/addContactPerson?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "bs.faq.contactPerson.add";
}
%>
<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName" value="BsFaqContactPersonForm"/>
	<tiles:put name="noTable" value="true"/>
	<tiles:put name="tileAttribute" value="<%=CommonDefs.ATTR_FORM_FIELDS%>"/>
</tiles:insert>
</table>
<BR>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

</html:form>
<BR>
<%
Hashtable params = new Hashtable();
if (faqId != null) params.put("faqId", faqId.toString());
request.setAttribute("backParams", params);
%>
<html:link styleClass="beta1" action="/ext/faq/listContactPersons" name="backParams">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">
&nbsp;<%= LanguageUtil.get(pageContext, "back") %>
</html:link>


