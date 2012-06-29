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

<fieldset class="blockLabels">




	<legend><%=LanguageUtil.get(pageContext,"billing-information") %></legend>
	
	<c:if test="<%= themeDisplay.isSignedIn() %>">
		<%
			PartiesService partySrv = PartiesService.getInstance();
			PaPerson person = partySrv.getPaPerson(user.getUserId());
			List<ViewResult> addressesList = partySrv.listPartyGeographicAddresses(person.getMainid(), lang);
		%>
		<c:if test="<%= addressesList!=null && addressesList.size()>0 %>">
			<div class="ctrl-holder">
				<label for="<portlet:namespace/>storedAddress"><liferay-ui:message key="stored-address" /></label>
				<select onChange="<portlet:namespace />populateFormFields();" style="background-color: rgb(255, 255, 160);" name="<portlet:namespace/>storedAddress" id="<portlet:namespace/>storedAddress" class="selectInput">
					<option value=""><liferay-ui:message key="please-select" /></option>
					
					<% for (ViewResult address: addressesList) { %>
						
						<option value="<%=address.getMainid() %>"><%=ViewResultUtil.toString(address.getField4()) %></option>	
						
					<% } %>
							
				</select>
			</div>
		</c:if>
	</c:if>
	
	
	<%--
	<div class="ctrl-holder">
		<p class="label">
		  Date of Birth
		</p>
		<div class="multiField">
			<label for="dob_month2" class="blockLabel">Month <select id="dob_month2" name="dob_month2"><option value="1">January</option></select></label>
			
			<label for="dob_day2" class="blockLabel">Day <select id="dob_day2" name="dob_day2"><option value="1">1</option></select></label>
			<label for="dob_year2" class="blockLabel">Year <select id="dob_year2" name="dob_year2"><option value="1">1908</option></select></label>
		</div>
		<p class="formHint">Don't lie!</p>
	</div>
	
	<div class="ctrl-holder">
		<label for="state">State / Province</label>
		<select style="background-color: rgb(255, 255, 160);" name="state" id="state" class="selectInput">
			<option value="">Please select</option>
			<option value="-1">Other</option>
			
			<option value="AK">Alaska</option><option value="AL">Alabama</option><option value="AR">Arkansas</option><option value="AZ">Arizona</option><option value="CA">California</option><option value="CO">Colorado</option><option value="CT">Connecticut</option><option value="DC">District of Columbia</option><option value="DE">Delaware</option><option value="FL">Florida</option><option value="GA">Georgia</option><option value="HI">Hawaii</option><option value="IA">Iowa</option><option value="ID">Idaho</option><option value="IL">Illinois</option><option value="IN">Indiana</option><option value="KS">Kansas</option><option value="KY">Kentucky</option><option value="LA">Louisiana</option><option value="MA">Massachusetts</option><option value="MD">Maryland</option><option value="ME">Maine</option><option value="MI">Michigan</option><option value="MN">Minnesota</option><option value="MO">Missouri</option><option value="MS">Mississippi</option><option value="MT">Montana</option><option value="NC">North Carolina</option><option value="ND">North Dakota</option><option value="NE">Nebraska</option><option value="NH">New Hampshire</option><option value="NJ">New Jersey</option><option value="NM">New Mexico</option><option value="NV">Nevada</option><option value="NY">New York</option><option value="OH">Ohio</option><option value="OK">Oklahoma</option><option value="OR">Oregon</option><option value="PA">Pennsylvania</option><option value="PR">Puerto Rico</option><option value="RI">Rhode Island</option><option value="SC">South Carolina</option><option value="SD">South Dakota</option><option value="TN">Tennessee</option><option value="TX">Texas</option><option value="UT">Utah</option><option value="VA">Virginia</option><option value="VT">Vermont</option><option value="WA">Washington</option><option value="WI">Wisconsin</option><option value="WV">West Virginia</option><option value="WY">Wyoming</option>
		
		</select>
	</div>
	--%>
	
	<%--
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingFirstName"><em>*</em> <liferay-ui:message key="first-name" /></label>
		<input name="<portlet:namespace/>billingFirstName" id="<portlet:namespace/>billingFirstName" value="" size="35" maxlength="50" type="text" class="textInput" />
	</div>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>billingLastName"><em>*</em> <liferay-ui:message key="last-name" /></label>
		<input name="<portlet:namespace/>billingLastName" id="<portlet:namespace/>billingLastName" value="" size="35" maxlength="50" type="text" class="textInput" />
	</div>
	--%>


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
		<label for="<portlet:namespace/>billingPhone" ><liferay-ui:message key="phone" /></label>
		<input name="<portlet:namespace/>billingPhone" id="<portlet:namespace/>billingPhone" value="<%=billingPhone%>" size="35" maxlength="50" type="text" class="textInput" />
    </div>
    
    
   	<div class="ctrl-holder">		
		<label for="<portlet:namespace/>billingFax" ><liferay-ui:message key="fax" /></label>
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

	<div class="buttonHolder1">
		<%--<input type="reset" class="resetButton" value="<liferay-ui:message key="reset" />"/>--%>
		<input type="button" class="resetButton" value="<liferay-ui:message key="back" />" onClick="<portlet:namespace />goPrevious();"/>
		<input type="button" class="primaryAction" value="<liferay-ui:message key="next" />" onClick="<portlet:namespace />goNext();"/>
	</div>


</fieldset>
</form>

<br /><br />

<script type="text/javascript">
	Liferay.Util.focusFormField(document.<portlet:namespace />fm.<portlet:namespace />billingFirstName);
</script>