<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<h3  class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.update-telecom-address") %></h3>

<%
StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="TelecomAddressForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("partyid","partyid","text",true));
new_field = new StrutsFormFields("countryCode","parties.addresses.telecom.countrycode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("nationalDialingPrefix","parties.addresses.telecom.nationaldialingprefix","text",false));
new_field = new StrutsFormFields("areaCode","parties.addresses.telecom.areacode","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("number","parties.addresses.telecom.number","text",false);
new_field.setRequired(true);
fields.addElement(new_field);
fields.addElement(new StrutsFormFields("extension","parties.addresses.telecom.extension","text",false));
fields.addElement(new StrutsFormFields("physicalType","parties.addresses.telecom.physicaltype","text",false));
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/manager/updateTelecomAddress?actionURL=true" method="post">
<bean:define id="addressId" name="TelecomAddressForm" property="mainid"/>

<html:hidden  property="mainid" />
<html:hidden  property="partyid" />

<table>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.physicaltype") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="physicalType" /><span class="gamma1-neg-alert"> *</span></td>
 <td><html:errors property="physicalType"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.phonenumber") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="phoneNumber" /><span class="gamma1-neg-alert"> *</span></td>
 <td><html:errors property="phoneNumber"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.analyzenumber") %></b></span></td>
 <td><html:checkbox styleClass="gamma1-FormArea" property="analyzeNumber" onclick="return disableLiferayFields();"/></td>
 <td><html:errors property="analyzeNumber"/></td> 
</tr>

<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.countrycode") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="countryCode" onchange="return updatePhoneNumber();"/></td>
 <td><html:errors property="countryCode"/></td> 
</tr>

<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.nationaldialingprefix") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="nationalDialingPrefix" onchange="return updatePhoneNumber();"/></td>
 <td><html:errors property="nationalDialingPrefix"/></td> 
</tr>


<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.areacode") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="areaCode" onchange="return updatePhoneNumber();"/></td>
 <td><html:errors property="areaCode"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.number") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="number" onchange="return updatePhoneNumber();"/></td>
 <td><html:errors property="number"/></td> 
</tr>
<tr>
 <td><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, "parties.addresses.telecom.extension") %></b></span></td>
 <td><html:text styleClass="gamma1-FormArea" property="extension" onchange="return updatePhoneNumber();"/></td>
 <td><html:errors property="extension"/></td> 
</tr>
</table>


<script language="JavaScript">
function disableLiferayFields()
{
	if (document.TelecomAddressForm.elements["analizeNumber"].checked)
	{
		document.TelecomAddressForm.elements["countryCode"].readOnly = false;
		document.TelecomAddressForm.elements["nationalDialingPrefix"].readOnly = false;
		document.TelecomAddressForm.elements["areaCode"].readOnly = false;
		document.TelecomAddressForm.elements["number"].readOnly = false;
		document.TelecomAddressForm.elements["extension"].readOnly = false;
		
		document.TelecomAddressForm.elements["phoneNumber"].readOnly = true;
	}
	else
	{
		document.TelecomAddressForm.elements["countryCode"].readOnly = true;
		document.TelecomAddressForm.elements["nationalDialingPrefix"].readOnly = true;
		document.TelecomAddressForm.elements["areaCode"].readOnly = true;
		document.TelecomAddressForm.elements["number"].readOnly = true;
		document.TelecomAddressForm.elements["extension"].readOnly = true;
		
		document.TelecomAddressForm.elements["phoneNumber"].readOnly = false;
	}
	return true;
}

function updatePhoneNumber(){
	var countryCode = document.TelecomAddressForm.elements["countryCode"].value;
	var nationalDialingPrefix = document.TelecomAddressForm.elements["nationalDialingPrefix"].value;
	var areaCode = document.TelecomAddressForm.elements["areaCode"].value;
	var number = document.TelecomAddressForm.elements["number"].value;
	var extension =	document.TelecomAddressForm.elements["extension"].value;
	
	document.TelecomAddressForm.elements["phoneNumber"].value = countryCode+ ' ' + nationalDialingPrefix + ' ' + areaCode + ' ' + number + ' ' + extension;

	return true;
}
</script>

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit> 
<br><br>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/manager/listRelatedGeographicAddresses" />
  <tiles:put name="buttonName" value="listRelatedButton" />
  <tiles:put name="buttonValue" value="parties.button.list-related-geographic" />
  <tiles:put name="formName"   value="TelecomAddressForm" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="mainid"/>
  	<tiles:add value="partyid"/>
  	<tiles:add value="listaction"/>  	  	
  	<tiles:add value="related"/>  
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%= addressId %></tiles:add>
  	<tiles:add><%= titleData.getValue("partyid").toString() %></tiles:add>  	
  	<tiles:add value="GeographicAddresses"/>
  	<tiles:add value="true"/>  
  </tiles:putList>
</tiles:insert>

</html:form>

<%@ include file="/html/portlet/ext/parties/manager/addressFooter.jsp" %>



