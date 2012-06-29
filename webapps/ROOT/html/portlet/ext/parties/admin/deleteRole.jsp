<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.form.delete-rol") %></h3>

<html:errors/>
<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="PartyRoleTypeForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true, true));
fields.addElement(new StrutsFormFields("langId","langId","text",true, true));
fields.addElement(new StrutsFormFields("lang","parties.admin.lang","text",false, true));
fields.addElement(new StrutsFormFields("name","parties.admin.partyroletype.name","text",false, true));
fields.addElement(new StrutsFormFields("description","parties.admin.partyroletype.description","text",false, true));
request.setAttribute("_vector_fields", fields);
%>
<html:form action="/ext/parties/admin/deleteRoleType?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.delete") %></html:submit>

</html:form>
<p><br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewRoleTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-rol") %></html:link></TD>
</TR></TABLE>

