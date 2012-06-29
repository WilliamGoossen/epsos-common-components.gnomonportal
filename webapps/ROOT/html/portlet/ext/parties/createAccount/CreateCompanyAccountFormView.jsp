<%@ include file="/html/portlet/my_account/init.jsp" %>


<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="java.util.Vector" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.parties.createAccount.CreateAccountForm" %>


<%= LanguageUtil.get(pageContext, "my_account.user.signup.company.2ndPage") %>


<%
try{
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();
	boolean companyFoundByAfm = false;
	
	CreateAccountForm formBean = (CreateAccountForm)request.getAttribute("CreateAccountForm");
	formBean.setPageNum(1);
	
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="CreateAccountForm";

fields.addElement(new StrutsFormFields("lang","lang","text",true, true));
fields.addElement(new StrutsFormFields("userType","userType","text",true, true));

fields.addElement(new StrutsFormFields("pageNum","pageNum","text",true, true));

fields.addElement(new StrutsFormFields("firstName","egov.accounts.user.firstname","text",true, true));
fields.addElement(new StrutsFormFields("lastName","egov.accounts.user.familyname","text",true, true));
fields.addElement(new StrutsFormFields("gender","egov.accounts.user.gender","text",true, true));
fields.addElement(new StrutsFormFields("birthday","egov.accounts.user.birthday","text",true, true));
fields.addElement(new StrutsFormFields("userId","egov.accounts.user.userid","text",true, true));
fields.addElement(new StrutsFormFields("emailAddress","egov.accounts.user.emailaddress","text",true, true));
fields.addElement(new StrutsFormFields("companyFoundId","companyFoundId","text",true, true));

if (!companyFoundByAfm){
new_field = new StrutsFormFields("compTypeid","egov.accounts.user.companyType","select",false);
new_field.setCollectionProperty("compTypeIds");
new_field.setCollectionLabel("compTypeNames");
fields.addElement(new_field);
}else{
}

new_field = new StrutsFormFields("companyName","egov.accounts.user.companyName","text",false, companyFoundByAfm);
new_field.setRequired(true);
fields.addElement(new_field);

new_field = new StrutsFormFields("compAfm","egov.accounts.user.compAfm","text",false, companyFoundByAfm);
new_field.setRequired(true);
fields.addElement(new_field);

new_field = new StrutsFormFields("compAfmRegAuth","egov.accounts.user.compAfmReqAuth","text",false, companyFoundByAfm);
new_field.setRequired(true);
fields.addElement(new_field);

if (!companyFoundByAfm){
new_field = new StrutsFormFields("compCountryid","egov.accounts.user.companyCountry","select",false);
new_field.setCollectionProperty("compCountryIds");
new_field.setCollectionLabel("compCountryNames");
fields.addElement(new_field);
}else{
}

new_field = new StrutsFormFields("compAddress","egov.accounts.user.compAddress","text",false, companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compEmail","egov.accounts.user.compEmail","text",false, companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compWeb","egov.accounts.user.compWeb","text",false, companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compPhoneNumber","egov.accounts.user.compPhoneNumber","text",false, companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compFax","egov.accounts.user.compFax","text",false, companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compAreaOfExp","egov.accounts.user.compAreaOfExp","text",false, companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compNumberOfEmployees","egov.accounts.user.compNumberOfEmployees","select",false);
new_field.setCollectionProperty("compNumberOfEmployeesValues");
new_field.setCollectionLabel("compNumberOfEmployeesLabels");
fields.addElement(new_field);

request.setAttribute("_vector_fields", fields);
%>

<html:form action="/my_account/create_account_company?actionURL=true" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>


<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "egov.accounts.button.save") %></html:submit> 

</html:form>


<%
}catch(Exception ex){
	ex.printStackTrace();
}%>


