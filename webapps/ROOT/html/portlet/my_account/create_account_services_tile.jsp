<%@ include file="/html/portlet/my_account/init.jsp" %>


<tiles:useAttribute id="formName" name="formName" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="formName" name="formName" classname="java.lang.String" ignore="true"/>


<script language="JavaScript"  type="text/javascript">

function onSelectRegistrationType(regTypeSelectEl){
	var selRegType = regTypeSelectEl.options[regTypeSelectEl.selectedIndex].value;

	for (i = 0; i < regTypeSelectEl.options.length; i++){
		var optItem = regTypeSelectEl.options[i];
		var optVal= optItem.value;

		
		var divEl = document.getElementById("REG_TYPE_METADATA_DIV_"+optVal);
		if (divEl != null){
			if (optVal == selRegType) {
				// Show the corresponding div
				//onclick="Liferay.Util.toggleByIdSpan(this, '<portlet:namespace />_ADD_SUBPROJECT_FORM'); self.focus();"
				divEl.style.display='';
			}else{
				// Hide the corresponding div
				divEl.style.display='none';
			}
		}
	}
}

function onSelectCheckBox(regTypeCheckEl){
	var checkElVal = regTypeCheckEl.value;
	var checkElSel = regTypeCheckEl.checked;

	var divEl = document.getElementById("REG_TYPE_METADATA_DIV_"+checkElVal);
	if (divEl != null){
		if (checkElSel) {
			// Show the corresponding div
			//onclick="Liferay.Util.toggleByIdSpan(this, '<portlet:namespace />_ADD_SUBPROJECT_FORM'); self.focus();"
			divEl.style.display='';
		}else{
			// Hide the corresponding div
			divEl.style.display='none';
		}
	}
}
</script>

<%
String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();
formName = (Validator.isNull(formName)) ? namespace+"fm" : formName;

//List classesList = com.liferay.portlet.myaccount.action.AddUserAction.listServicesForUserRegistration(request);
	//gnomon.hibernate.GnPersistenceService.getInstance(null).listObjects(null, gnomon.hibernate.model.gn.kms.GnKmsClass.class, "table1.className like 'gnomon.hibernate.model.srv.%'");
%>

<%
String singleSelection = PropsUtil.get("gi9.userRegistration.registrationTypes.singleSelection");
String registrationTypesCommaSep = PropsUtil.get("gi9.userRegistration.registrationTypes");
String registrationTypesLabels = PropsUtil.get("gi9.userRegistration.registrationTypes.labels");
String allowSimpleUserRegistration = PropsUtil.get("gi9.userRegistration.allowSimpleUserRegistration");

if (Validator.isNotNull(registrationTypesCommaSep) && Validator.isNotNull(registrationTypesLabels)){
	String[] regTypesArr = registrationTypesCommaSep.split(",");
	String[] regTypesLabelsArr = registrationTypesLabels.split(",");
	
	boolean allowSimpleUserFlag = (allowSimpleUserRegistration != null) && allowSimpleUserRegistration.equals("true");
	
	boolean singleSelectionFlag = (singleSelection != null) && singleSelection.equals("true");
	//singleSelectionFlag = false;
%>
<div class="uni-form">
<%
String registrationType = request.getParameter("registrationType");
registrationType = (registrationType == null) ? "" : registrationType;

String[] regTypesMultySelect = request.getParameterValues("registrationType");
List regTypesMultySelectList = new ArrayList();
if (regTypesMultySelect != null) {
	regTypesMultySelectList = Arrays.asList(regTypesMultySelect);
	java.util.Collections.sort(regTypesMultySelectList);
}
%>

<%if (!allowSimpleUserFlag && regTypesArr.length == 1) { %>
<input type="hidden" name="registrationType" value="<%= regTypesArr[0]%>" />
<%} %>
<%
int regTypesArrLen = regTypesArr.length;
regTypesArrLen += (allowSimpleUserFlag) ? 1 : 0;

if (singleSelectionFlag && regTypesArrLen > 1){
%>
<div class="ctrl-holder">
<label>
<%=LanguageUtil.get(pageContext, "create_account_registrationTypes") %>
</label>

<select name="registrationType" onchange="onSelectRegistrationType(this)">
<%if (allowSimpleUserFlag){ %><option></option><%} %>
<%
	for (int i = 0; i < regTypesArr.length; i++){
		String regType = regTypesArr[i];
		String optionLabel = regType;
		if (regTypesLabelsArr != null && i < regTypesLabelsArr.length){
			optionLabel = regTypesLabelsArr[i];
		}
	%>
	<option value="<%=regTypesArr[i] %>" <%=(regTypesMultySelectList.contains(regType)) ? " selected " : "" %>> <%=LanguageUtil.get(pageContext, optionLabel) %></option>
<%
	}
%>
</select>
</div>

<%} %>

<%for (int i = 0; i < regTypesArr.length; i++){
	String regType = regTypesArr[i];
	String optionLabel = regType;
	if (regTypesLabelsArr != null && i < regTypesLabelsArr.length){
		optionLabel = regTypesLabelsArr[i];
	}
	
	String regTypeServices = PropsUtil.get("gi9.userRegistration.registrationTypes.services."+regType);

	if (Validator.isNotNull(regTypeServices)) {
		String[] servicesArr = regTypeServices.split(",");
%>

<%if (!singleSelectionFlag && regTypesArr.length > 1){
	boolean checkBoxIsSelected= (regTypesMultySelectList.contains(regType));
	String selectedStr = (regTypesMultySelectList.contains(regType)) ? " checked " : "";
%>

<div class="ctrl-holder">
<label>
<input type="checkbox" name="registrationType"
	onclick="onSelectCheckBox(this)"  
	value="<%=regType%>" 
	<%=selectedStr%> /> <%=LanguageUtil.get(pageContext, optionLabel)%>
</label>
</div>
<%} %>
<%
boolean markDivVisible = (regTypesMultySelectList.contains(regType)) || (regTypesArrLen == 1);
%>
<div id="REG_TYPE_METADATA_DIV_<%=regType %>" style="<%=(markDivVisible) ? "" : "display:none" %>" >
<fieldset class="inline-labels" >
<legend>
	<%=LanguageUtil.get(pageContext, optionLabel)  %> 
</legend>

<%for (int j = 0; j < servicesArr.length; j++){ 
	String serviceCode = servicesArr[j];
	
	List classesList = com.liferay.portlet.myaccount.action.AddUserAction.listServicesForUserRegistration(serviceCode, request);
	if (classesList != null && !classesList.isEmpty()) {
		ViewResult anSrvVr = (ViewResult)classesList.get(0);
		Integer srvId = anSrvVr.getMainid();
		String srvName = (String)anSrvVr.getField1();
		String className = (String)anSrvVr.getField2();
%>
<tiles:insert page="/html/portlet/ext/struts_includes/metaData_div.jsp" flush="true">
		<tiles:put name="formName" value="<%=formName%>" />
		<tiles:put name="className" value="<%= className %>" />
</tiles:insert>
<%	
	}
%>
<%} %>
</fieldset>
</div>
	<%} %>
<%} %>

</div>
<%}%>
<script language="JavaScript"  type="text/javascript">
//onSelectRegistrationType(document.<%=formName%>.elements["registrationType"])
</script>