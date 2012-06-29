<%@ include file="/html/portlet/my_account/init.jsp" %>


<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="java.util.Vector" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%= LanguageUtil.get(pageContext, "my_account.user.signup.intro.html") %>





<%
try{
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();

StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="CreateAccountForm";

fields.addElement(new StrutsFormFields("lang","lang","text",true, true));

StrutsFormFields selectField = new StrutsFormFields("userType","egov.accounts.user.usertype","select",false, false);
selectField.setCollectionProperty("userTypeValues");
selectField.setCollectionLabel("userTypeLabels");
fields.addElement(selectField);

new_field = new StrutsFormFields("firstName","egov.accounts.user.firstname","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("lastName","egov.accounts.user.familyname","text",false);
new_field.setRequired(true);
fields.addElement(new_field);

new_field = new StrutsFormFields("nickName","egov.accounts.user.nickname","text",false);
fields.addElement(new_field);

selectField = new StrutsFormFields("gender","egov.accounts.user.gender","select",false, false);
selectField.setCollectionProperty("genderValues");
selectField.setCollectionLabel("genderLabels");
fields.addElement(selectField);

new_field = new StrutsFormFields("birthday","egov.accounts.user.birthday","date",false, false);
new_field.setDateFormat("%d/%m/%Y");
fields.addElement(new_field);

new_field = new StrutsFormFields("userId","egov.accounts.user.userid","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
			
new_field = new StrutsFormFields("emailAddress","egov.accounts.user.emailaddress","text",false);
new_field.setRequired(true);
fields.addElement(new_field);

request.setAttribute("_vector_fields", fields);

//request.setAttribute(namespace+CommonDefs.ATTR_FORM_FIELDS_NO_TABLE_FLAG, "true");
%>

<html:form action="/my_account/create_account_dispatch_usertype?actionURL=true" method="post">
<liferay-ui:error exception="<%= CaptchaTextException.class %>" message="text-verification-failed" />
<liferay-ui:error exception="<%= ContactFirstNameException.class %>" message="please-enter-a-valid-first-name" />
<liferay-ui:error exception="<%= ContactLastNameException.class %>" message="please-enter-a-valid-last-name" />
<liferay-ui:error exception="<%= DuplicateUserEmailAddressException.class %>" message="the-email-address-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= DuplicateUserIdException.class %>" message="the-user-id-you-requested-is-already-taken" />
<liferay-ui:error exception="<%= ReservedUserEmailAddressException.class %>" message="the-email-address-you-requested-is-reserved" />
<liferay-ui:error exception="<%= ReservedUserIdException.class %>" message="the-user-id-you-requested-is-reserved" />
<liferay-ui:error exception="<%= UserEmailAddressException.class %>" message="please-enter-a-valid-email-address" />
<liferay-ui:error exception="<%= UserIdException.class %>" message="please-enter-a-valid-user-id" />

<liferay-ui:error exception="<%= com.ext.portlet.parties.createAccount.LiferayCompanyNotFoundException.class %>" message="no-party-for-liferay-company-found" />


<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>


<BR>
<%= LanguageUtil.get(pageContext, "my_account.user.signup.intro2.html") %>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "egov.accounts.button.save") %></html:submit> 

</html:form>


<%
}catch(Exception ex){
	ex.printStackTrace();
}%>

