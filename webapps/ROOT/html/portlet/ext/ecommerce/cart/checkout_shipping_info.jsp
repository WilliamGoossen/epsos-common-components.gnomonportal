<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>

<liferay-util:include page="/html/portlet/ext/ecommerce/cart/cartSummary.jsp">
	<liferay-util:param name="openPanelIndex" value="0"/>
</liferay-util:include>

<script type="text/javascript">
	function <portlet:namespace />goNext() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "shipping_info";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "update";
		submitForm(document.<portlet:namespace />fm);
	}
	function <portlet:namespace />goPrevious() {
		document.<portlet:namespace />fm.<portlet:namespace />page.value = "billing_info";
		document.<portlet:namespace />fm.<portlet:namespace />cmd.value = "";
		submitForm(document.<portlet:namespace />fm);
	}
</script>

<%
String shippingFirstName = "";
String shippingLastName = "";
String shippingCompany = "";
String shippingEmailAddress = "";
String shippingAddress = "";
String shippingCity = "";
String shippingZip = "";
String shippingCountry = "Greece";
String shippingRegion = "";
String shippingPhone = "";
String shippingFax = "";

String cmd = ParamUtil.getString(request, "cmd");
ShippingInfo shippingInfo = CheckoutUtil.getShippingInfo(request);

if (cmd.equals("update")) {
	shippingFirstName = ParamUtil.getString(request, "shippingFirstName");
	shippingLastName = ParamUtil.getString(request, "shippingLastName");
	shippingCompany = ParamUtil.getString(request, "shippingCompany");
	//shippingEmailAddress = ParamUtil.getString(request, "shippingEmailAddress");
	shippingAddress = ParamUtil.getString(request, "shippingAddress");
	shippingCity = ParamUtil.getString(request, "shippingCity");
	shippingZip = ParamUtil.getString(request, "shippingZip");
	shippingCountry = ParamUtil.getString(request, "shippingCountry");
	shippingRegion = ParamUtil.getString(request, "shippingRegion");
	shippingPhone = ParamUtil.getString(request, "shippingPhone");
	shippingFax = ParamUtil.getString(request, "shippingFax");
} else {
	if ((shippingInfo==null) && (themeDisplay.isSignedIn())) {
		shippingInfo = OrderService.getInstance().getDefaultShippingInfoForUser(user, lang);
	}
	
	if (shippingInfo!=null) {
		shippingFirstName = shippingInfo.getFirstName();
		shippingLastName = shippingInfo.getLastName();
		shippingCompany = shippingInfo.getCompany();
		//shippingEmailAddress = shippingInfo.getEmailAddress();
		shippingAddress = shippingInfo.getAddress();
		shippingCity = shippingInfo.getCity();
		shippingZip = shippingInfo.getZip();
		shippingCountry = shippingInfo.getCountry();
		shippingRegion = shippingInfo.getRegion();
		shippingPhone = shippingInfo.getPhone();
		shippingFax = shippingInfo.getFax();
	}
}
%>

<liferay-ui:error exception="<%= ShippingCityException.class %>" message="please-enter-a-valid-city" />
<liferay-ui:error exception="<%= ShippingCountryException.class %>" message="please-enter-a-valid-country" />
<liferay-ui:error exception="<%= ShippingEmailAddressException.class %>" message="please-enter-a-valid-email-address" />
<liferay-ui:error exception="<%= ShippingAddressException.class %>" message="please-enter-a-valid-address" />
<liferay-ui:error exception="<%= ShippingFirstNameException.class %>" message="please-enter-a-valid-first-name" />
<liferay-ui:error exception="<%= ShippingLastNameException.class %>" message="please-enter-a-valid-last-name" />
<liferay-ui:error exception="<%= ShippingPhoneException.class %>" message="please-enter-a-valid-phone" />
<liferay-ui:error exception="<%= ShippingStateException.class %>" message="please-enter-a-valid-state" />
<liferay-ui:error exception="<%= ShippingStreetException.class %>" message="please-enter-a-valid-street" />
<liferay-ui:error exception="<%= ShippingZipException.class %>" message="please-enter-a-valid-zip" />


<form class="uni-form" action="<%=submitURL%>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="" type="hidden" /> 
<input name="<portlet:namespace/>page" id="<portlet:namespace/>page" value="" type="hidden" />

<fieldset >

	<legend><%=LanguageUtil.get(pageContext,"shipping-information") %></legend>
	
	
		<%--
		<p class="label">
		  Onomateponymo
		</p>
		--%>

<div class="col block-labels">

			<div class="ctrl-holder">
			<label for="<portlet:namespace/>shippingFirstName" ><em>*</em><liferay-ui:message key="first-name" /></label>				
			<input name="<portlet:namespace/>shippingFirstName" id="<portlet:namespace/>shippingFirstName" value="<%=shippingFirstName%>" size="25" maxlength="50" type="text" class="textInput" />
			</div>	
			
        <div class="ctrl-holder">
			<label for="<portlet:namespace/>shippingLastName"><em>*</em><liferay-ui:message key="last-name" /></label>				
			<input name="<portlet:namespace/>shippingLastName" id="<portlet:namespace/>shippingLastName" value="<%=shippingLastName%>" size="30" maxlength="50" type="text" class="textInput" />
		</div>

	
        <div class="ctrl-holder">
            <label for="<portlet:namespace/>shippingCompany"> <liferay-ui:message key="company" /></label>
            <input name="<portlet:namespace/>shippingCompany" id="<portlet:namespace/>shippingCompany" value="<%=shippingCompany%>" size="35" maxlength="50" type="text" class="textInput" />
        </div>
	
        <%--
        <div class="ctrl-holder">
            <label for="<portlet:namespace/>shippingEmailAddress"><em>*</em> <liferay-ui:message key="email-address" /></label>
            <input name="<portlet:namespace/>shippingEmailAddress" id="<portlet:namespace/>shippingEmailAddress" value="<%=shippingEmailAddress%>" size="35" maxlength="50" type="text" />
        </div>
        --%>

        <div class="ctrl-holder">
            <label for="<portlet:namespace/>shippingAddress"><em>*</em> <liferay-ui:message key="address" /></label>
            <input name="<portlet:namespace/>shippingAddress" id="<portlet:namespace/>shippingAddress" value="<%=shippingAddress%>" size="35" maxlength="50" type="text" class="textInput" />
        </div>

        <div class="ctrl-holder">
            <label for="<portlet:namespace/>shippingCity"><em>*</em> <liferay-ui:message key="city" /></label>
            <input name="<portlet:namespace/>shippingCity" id="<portlet:namespace/>shippingCity" value="<%=shippingCity%>" size="35" maxlength="50" type="text" />
        </div>




</div>





<div class="col block-labels">



	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>shippingZip"><em>*</em> <liferay-ui:message key="zip" /></label>
		<input name="<portlet:namespace/>shippingZip" id="<portlet:namespace/>shippingZip" value="<%=shippingZip%>" size="35" maxlength="50" type="text" />
	</div>
	
	<%
	List<PaCountryLanguage> countries = (List<PaCountryLanguage>)GnPersistenceService.getInstance(null).listObjects(null, PaCountryLanguage.class, "table1.lang='"+lang +"'");
	%>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>shippingCountry" ><em>*</em><liferay-ui:message key="country" /></label>
		<%-- <input name="<portlet:namespace/>shippingCountry" id="<portlet:namespace/>shippingCountry" value="<%=shippingCountry%>" size="35" maxlength="50" type="text" />--%>
		<select name="<portlet:namespace/>shippingCountry" id="<portlet:namespace/>shippingCountry" class="selectInput">
			<%
			for (int i=0; countries!=null && i<countries.size(); i++) {
				PaCountryLanguage country = countries.get(i);
			%>
				<option <%= country.getName().equalsIgnoreCase(shippingCountry) ? "selected" : "" %> value="<%=country.getName()%>"><%=country.getName()%></option>				
			<%
			}
			%>
		</select>
    </div>
	

	
	<div class="ctrl-holder">
			<label for="<portlet:namespace/>shippingPhone"><em></em><liferay-ui:message key="phone" /></label>            	
			<input name="<portlet:namespace/>shippingPhone" id="<portlet:namespace/>shippingPhone" value="<%=shippingPhone%>" size="25" maxlength="50" type="text" class="textInput" />

	</div>

	<div class="ctrl-holder">
			<label for="<portlet:namespace/>shippingFax"><em></em><liferay-ui:message key="fax" /></label>				
			<input name="<portlet:namespace/>shippingFax" id="<portlet:namespace/>shippingFax" value="<%=shippingFax%>" size="25" maxlength="50" type="text" class="textInput" />

	</div>



</div>


</fieldset>

<div class="block-labels" style="text-align:right;">

	<div class="buttonHolder1">
		<%--<input type="reset" class="resetButton" value="<liferay-ui:message key="reset" />"/>--%>
		<input type="button" class="resetButton" value="<liferay-ui:message key="back" />" onClick="<portlet:namespace />goPrevious();"/>
		<input type="button" class="primaryAction" value="<liferay-ui:message key="next" />" onClick="<portlet:namespace />goNext();"/>
	</div>

</div>



</form>

<br /><br />

<script type="text/javascript">
	Liferay.Util.focusFormField(document.<portlet:namespace />fm.<portlet:namespace />shippingFirstName);
</script>