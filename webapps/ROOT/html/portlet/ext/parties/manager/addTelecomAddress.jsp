<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.add-telecom-address") %></h3>



<html:form action="/ext/parties/manager/addTelecomAddress?actionURL=true" method="post">
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

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "parties.button.add") %></html:submit> 


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

disableLiferayFields();
</script>
</html:form>

<%@ include file="/html/portlet/ext/parties/manager/addressFooter.jsp" %>



