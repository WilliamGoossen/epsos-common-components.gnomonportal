<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>


<liferay-util:include page="/html/portlet/ext/ecommerce/cart/cartSummary.jsp">
	<liferay-util:param name="openPanelIndex" value="0"/>
</liferay-util:include>


<script type="text/javascript">
	function <portlet:namespace />goNext() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "billing_info";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "update";
		submitForm(document.<portlet:namespace />fm);
	}
	function <portlet:namespace />goPrevious() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "";
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<%
String billingFirstName = "";
String billingLastName = "";
String billingCompany = "";
String billingAfm = "";
String billingDoy = "";
String billingEmailAddress = "";
String billingAddress = "";
String billingCity = "";
String billingZip = "";
String billingCountry = "";
String billingRegion = "";
String billingPhone = "";
String billingFax = "";
boolean shipToBilling = true;

String cmd = ParamUtil.getString(request, "cmd");
BillingInfo billingInfo = CheckoutUtil.getBillingInfo(request);

if (cmd.equals("update")) {
	billingFirstName = ParamUtil.getString(request, "billingFirstName");
	billingLastName = ParamUtil.getString(request, "billingLastName");
	billingCompany = ParamUtil.getString(request, "billingCompany");
	billingAfm = ParamUtil.getString(request, "billingAfm");
	billingDoy = ParamUtil.getString(request, "billingDoy");
	billingEmailAddress = ParamUtil.getString(request, "billingEmailAddress");
	billingAddress = ParamUtil.getString(request, "billingAddress");
	billingCity = ParamUtil.getString(request, "billingCity");
	billingZip = ParamUtil.getString(request, "billingZip");
	billingCountry = ParamUtil.getString(request, "billingCountry");
	billingRegion = ParamUtil.getString(request, "billingRegion");
	billingPhone = ParamUtil.getString(request, "billingPhone");
	billingFax = ParamUtil.getString(request, "billingFax");
	shipToBilling = GetterUtil.getBoolean(ParamUtil.getString(request, "shipToBilling", "true"));
} else {
	if ((billingInfo==null) && (themeDisplay.isSignedIn())) {
		billingInfo = OrderService.getInstance().getDefaultBillingInfoForUser(user, lang);
	}
	
	if (billingInfo!=null) {
		billingFirstName = billingInfo.getFirstName();
		billingLastName = billingInfo.getLastName();
		billingCompany = billingInfo.getCompany();
		billingAfm = billingInfo.getAfm();
		billingDoy = billingInfo.getDoy();
		billingEmailAddress = billingInfo.getEmailAddress();
		billingAddress = billingInfo.getAddress();
		billingCity = billingInfo.getCity();
		billingZip = billingInfo.getZip();
		billingCountry = billingInfo.getCountry();
		billingRegion = billingInfo.getRegion();
		billingPhone = billingInfo.getPhone();
		billingFax = billingInfo.getFax();
		shipToBilling = billingInfo.isShipToBilling();		
	}
}
%>

<liferay-ui:error exception="<%= BillingCityException.class %>" message="please-enter-a-valid-city" />
<liferay-ui:error exception="<%= BillingCountryException.class %>" message="please-enter-a-valid-country" />
<liferay-ui:error exception="<%= BillingAfmException.class %>" message="please-enter-a-valid-afm" />
<liferay-ui:error exception="<%= BillingDoyException.class %>" message="please-enter-a-valid-doy" />
<liferay-ui:error exception="<%= BillingEmailAddressException.class %>" message="please-enter-a-valid-email-address" />
<liferay-ui:error exception="<%= BillingAddressException.class %>" message="please-enter-a-valid-address" />
<liferay-ui:error exception="<%= BillingFirstNameException.class %>" message="please-enter-a-valid-first-name" />
<liferay-ui:error exception="<%= BillingLastNameException.class %>" message="please-enter-a-valid-last-name" />
<liferay-ui:error exception="<%= BillingPhoneException.class %>" message="please-enter-a-valid-phone" />
<liferay-ui:error exception="<%= BillingStateException.class %>" message="please-enter-a-valid-state" />
<liferay-ui:error exception="<%= BillingStreetException.class %>" message="please-enter-a-valid-street" />
<liferay-ui:error exception="<%= BillingZipException.class %>" message="please-enter-a-valid-zip" />


<form class="uni-form" action="<%=submitURL%>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="" type="hidden" /> 
<input name="<portlet:namespace/>page" id="<portlet:namespace/>page" value="" type="hidden" />

<fieldset >

<legend><%=LanguageUtil.get(pageContext,"billing-information") %></legend>

<div class="col block-labels">

	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingFirstName"><em>*</em><liferay-ui:message key="first-name" /></label>
		<input name="<portlet:namespace/>billingFirstName" id="<portlet:namespace/>billingFirstName" value="<%=billingFirstName%>" size="35" maxlength="30" type="text" class="textInput" />
	</div>
    
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingLastName"><em>*</em><liferay-ui:message key="last-name" /></label>
		<input name="<portlet:namespace/>billingLastName" id="<portlet:namespace/>billingLastName" value="<%=billingLastName%>" size="35" maxlength="30" type="text" class="textInput" />
	</div>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingCompany" ><liferay-ui:message key="company" /></label>
		<input name="<portlet:namespace/>billingCompany" id="<portlet:namespace/>billingCompany" value="<%=billingCompany%>" size="35" maxlength="50" type="text" class="textInput" />
		<p class="formHint"><span> <liferay-ui:message key="if-defined-it-will-be-used-on-the-invoice" /></span></p>
	</div>	
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingAfm" ><em>*</em><liferay-ui:message key="afm" /></label>
		<input name="<portlet:namespace/>billingAfm" id="<portlet:namespace/>billingAfm" value="<%=billingAfm%>" size="35" maxlength="50" type="text" class="textInput" />
	</div>
	
    <div class="ctrl-holder">
		<label for="<portlet:namespace/>billingDoy"><em>*</em><liferay-ui:message key="doy" /></label>
		<input name="<portlet:namespace/>billingDoy" id="<portlet:namespace/>billingDoy" value="<%=billingDoy%>" size="35" maxlength="50" type="text" class="textInput" />
		<p class="formHint"><span><liferay-ui:message key="if-the-invoice-should-be-issued-for-a-company-please-enter-the-companys-tax-number" /></span></p>
    </div>
            
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingEmailAddress" ><em>*</em><liferay-ui:message key="email-address" /></label>
		<input name="<portlet:namespace/>billingEmailAddress" id="<portlet:namespace/>billingEmailAddress" value="<%=billingEmailAddress%>" size="40" maxlength="50" type="text" />
	</div>

</div>

<div class="col block-labels">

	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingAddress"><em>*</em><liferay-ui:message key="address" /></label>
		<input name="<portlet:namespace/>billingAddress" id="<portlet:namespace/>billingAddress" value="<%=billingAddress%>" size="35" maxlength="50" type="text" class="textInput" />
	</div>

	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingCity"><em>*</em> <liferay-ui:message key="city" /></label>
		<input name="<portlet:namespace/>billingCity" id="<portlet:namespace/>billingCity" value="<%=billingCity%>" size="35" maxlength="50" type="text" />
	</div>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingZip"><em>*</em> <liferay-ui:message key="zip" /></label>
		<input name="<portlet:namespace/>billingZip" id="<portlet:namespace/>billingZip" value="<%=billingZip%>" size="35" maxlength="50" type="text" />
	</div>
	
	<%
	List<PaCountryLanguage> countries = (List<PaCountryLanguage>)GnPersistenceService.getInstance(null).listObjects(null, PaCountryLanguage.class, "table1.lang='"+lang +"'");
	%>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingCountry" ><em>*</em><liferay-ui:message key="country" /></label>
		<%--<input name="<portlet:namespace/>billingCountry" id="<portlet:namespace/>billingCountry" value="<%=billingCountry%>" size="35" maxlength="50" type="text" />--%>
		<select name="<portlet:namespace/>billingCountry" id="<portlet:namespace/>billingCountry" class="selectInput">
			<%
			for (int i=0; countries!=null && i<countries.size(); i++) {
				PaCountryLanguage country = countries.get(i);
			%>
				<option <%= country.getName().equalsIgnoreCase(billingCountry) ? "selected" : "" %> value="<%=country.getName()%>"><%=country.getName()%></option>				
			<%
			}
			%>
		</select>
    </div>

	<%--
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingRegion" ><em>*</em><liferay-ui:message key="region" /></label>
		<select name="<portlet:namespace/>billingRegion" id="<portlet:namespace/>billingRegion" class="selectInput"></select>
	</div>
	--%>

	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingPhone" ><em>&nbsp;</em><liferay-ui:message key="phone" /></label>
		<input name="<portlet:namespace/>billingPhone" id="<portlet:namespace/>billingPhone" value="<%=billingPhone%>" size="35" maxlength="50" type="text" class="textInput" />
    </div>
    
   	<div class="ctrl-holder">		
		<label for="<portlet:namespace/>billingFax" ><em>&nbsp;</em><liferay-ui:message key="fax" /></label>
		<input name="<portlet:namespace/>billingFax" id="<portlet:namespace/>billingFax" value="<%=billingFax%>" size="35" maxlength="50" type="text" class="textInput" />
	</div>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>shipToBilling" >
			<input name="<portlet:namespace/>shipToBilling" id="<portlet:namespace/>shipToBillingTrue" value="true" <%=(shipToBilling? "checked=\"checked\"": "")%> type="radio"> 
			<liferay-ui:message key="ship-to-billing-address" />
		</label>
	</div>
    
   	<div class="ctrl-holder">
		<label for="<portlet:namespace/>shipToBilling" >
			<input name="<portlet:namespace/>shipToBilling" id="<portlet:namespace/>shipToBillingFalse" value="false" <%=(!shipToBilling? "checked=\"checked\"": "")%> type="radio"> 
			<liferay-ui:message key="ship-to-different-address" />
		</label>
	</div>

</div>

</fieldset>

<div class="block-labels" style="text-align:right;">

	<div class="buttonHolder1">
		<input type="button" class="resetButton" value="<liferay-ui:message key="back" />" onClick="<portlet:namespace />goPrevious();"/>
		<input type="button" class="primaryAction" value="<liferay-ui:message key="next" />" onClick="<portlet:namespace />goNext();"/>
	</div>

</div>

</form>

<br /><br />

<script type="text/javascript">
	Liferay.Util.focusFormField(document.<portlet:namespace />fm.<portlet:namespace />billingFirstName);
</script>