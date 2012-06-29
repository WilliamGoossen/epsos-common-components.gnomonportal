<%@ include file="/html/portlet/my_account/init.jsp" %>


<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="java.util.Vector" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.util.CommonUtil" %>


<%= LanguageUtil.get(pageContext, "egov.accounts.company.found-company-for-afm-proceede") %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<BR>

<%
try{
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();

	boolean companyFoundByAfm = true;
	
	
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
	fields.addElement(new StrutsFormFields("compTypeid","compTypeid","text",true, true));
	fields.addElement(new StrutsFormFields("compTypeName","egov.accounts.user.companyType","plain_text",true, true));
}

new_field = new StrutsFormFields("companyName","egov.accounts.user.companyName","plain_text",false,companyFoundByAfm);
new_field.setRequired(true);
fields.addElement(new_field);

new_field = new StrutsFormFields("compAfm","egov.accounts.user.compAfm","plain_text",false,companyFoundByAfm);
new_field.setRequired(true);
fields.addElement(new_field);

new_field = new StrutsFormFields("compAfmRegAuth","egov.accounts.user.compAfmReqAuth","plain_text",false,companyFoundByAfm);
new_field.setRequired(true);
fields.addElement(new_field);

if (!companyFoundByAfm){
	new_field = new StrutsFormFields("compCountryid","egov.accounts.user.companyCountry","select",false);
	new_field.setCollectionProperty("compCountryIds");
	new_field.setCollectionLabel("compCountryNames");
	fields.addElement(new_field);
}else{
	fields.addElement(new StrutsFormFields("compCountryid","compCountryid","text",true, true));
	fields.addElement(new StrutsFormFields("compCountryName","egov.accounts.user.companyCountry","plain_text",true, true));
}

new_field = new StrutsFormFields("compAddress","egov.accounts.user.compAddress","plain_text",false,companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compEmail","egov.accounts.user.compEmail","plain_text",false,companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compWeb","egov.accounts.user.compWeb","plain_text",false,companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compPhoneNumber","egov.accounts.user.compPhoneNumber","plain_text",false,companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compFax","egov.accounts.user.compFax","plain_text",false,companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compAreaOfExp","egov.accounts.user.compAreaOfExp","plain_text",false,companyFoundByAfm);
fields.addElement(new_field);

new_field = new StrutsFormFields("compNumberOfEmployees","egov.accounts.user.compNumberOfEmployees","plain_text",false,companyFoundByAfm);
fields.addElement(new_field);

request.setAttribute("_vector_fields", fields);
%>

<html:form action="/my_account/create_account_company?actionURL=true" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>

<%
	java.util.Hashtable parameters = new java.util.Hashtable();
	parameters.put("struts_action", "/my_account/create_account_dispatch_usertype");
	String newUrl = CommonUtil.getActionUrl(request, parameters);
%>


<input type="button" class="portlet-form-button" 
	value="<%= LanguageUtil.get(pageContext, "egov.accounts.button.back") %>" 
	onclick="changeSubmitUrl('CreateAccountForm', '<%=newUrl%>')">


<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "egov.accounts.button.save") %></html:submit> 

</html:form>

<script>
function changeSubmitUrl(formName, newUrl){
	try{
		var formEl = document.getElementsByName(formName)[0];
		//alert('OLD formEl.action = '+formEl.action)
		//alert('newUrl = '+newUrl)
		
		formEl.action = newUrl;
		formEl.submit();
	}catch(ex){
		alert(ex.message);
	}
}
</script>
<%
}catch(Exception ex){
	ex.printStackTrace();
}%>


