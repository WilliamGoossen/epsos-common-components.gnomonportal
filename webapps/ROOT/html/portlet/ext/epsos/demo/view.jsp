<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%@ page import="com.ext.portlet.epsos.*" %>
<%@ page import="com.ext.portlet.epsos.demo.PatientSearchForm" %>

 <style type="text/css">

#left {
	float: left;
	width: 270px;
}

#right {
	float: right;
	width: 270px;
}

#middle { 
	float: left;
	width: 270px;
}
 </style>

<%
String currentURL2 = currentURL;
String extraParams = "";
java.util.Enumeration params = request.getParameterNames();
while(params.hasMoreElements())
{
	String paramName = (String)params.nextElement();
	if (paramName.equals("struts_action") || paramName.startsWith("p_p_")) 
		continue;
	String paramValue = request.getParameter(paramName);
	if (Validator.isNull(paramValue)) paramValue= "";
	extraParams += "&"+paramName+"="+paramValue;
}

currentURL2 = currentURL +extraParams;

currentURL = currentURL2;
%>

<script language="JavaScript">

function countrySelectionChanged()
{
	document.EpsosPatientSearchForm.elements['search'].value = false;
	document.EpsosPatientSearchForm.elements['submitButton'].disabled=true;
	document.EpsosPatientSearchForm.submit();
}
</script>



<html:form action="/ext/epsos/demo/view?actionURL=true" method="post" enctype="multipart/form-data" styleClass="uni-form">

<input type="hidden" name="choiceMade" value="true">

<%
String choiceMade = request.getParameter("choiceMade");
if (choiceMade == null || choiceMade.equals("false"))
{
	PatientSearchForm formBean = (PatientSearchForm) request.getAttribute("PatientSearchForm");
	%><fieldset><legend><%= LanguageUtil.get(pageContext, "epsos.demo.search.country") %></legend>
	<%
	for (int c=0 ; c< formBean.getCountryIds().length; c++ ) { 
		String countryid = formBean.getCountryIds()[c];
		String countryName = formBean.getCountryNames()[c];
		String divClass="";
		if (((c+1) % 3) ==0) divClass="left"; 
		if (((c+1) % 3) ==1) divClass="middle";
		if (((c+1) % 3) ==2) divClass="right";
		%>
		
		<div id="<%= divClass %>">
		<input  type="radio" name="country" value="<%= countryid %>" onClick="countrySelectionChanged()">
		&nbsp;<img style="padding-top:20px;" src="<%= themeDisplay.getPathThemeImage() %>/language/<%= countryid %>_flag.gif" width="47" height="26" title="<%= countryName %>" alt="<%= countryName %>">
		&nbsp;&nbsp;
		</div><%
	 }
	%>
	</fieldset>
	<input type="hidden" name="submitButton" value="">
	<input type="hidden" name="search" value="false">
	<%
}	
else {
%>

<bean:define id="labels1" name="EpsosPatientSearchForm" property="sexNames"/>
<%
// correct the list of keys for translations to be shown properly
String[] labelsList1 = (String[])labels1;
for (int i=0; i<labelsList1.length; i++)
{
 	labelsList1[i] = LanguageUtil.get(pageContext, labelsList1[i]);
}
%>

<input type="hidden" name="search" value="true">

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
	<tiles:put name="formName" value="EpsosPatientSearchForm"/>
	<tiles:put name="useTabs" value="false"/>
</tiles:insert>


<div class="block-labels" style="text-align:right;">
	<div class="buttonHolder">
<input type="submit" name="submitButton" value="<%= LanguageUtil.get(pageContext, "search") %>">
</div>
</div>

<% } %>

</html:form>

<%
String search = request.getParameter("search");
if (Validator.isNotNull(search) && search.equals("true")) {
List<EhrPatientClientDto> patientsList = (List<EhrPatientClientDto>)request.getAttribute("patientsList");
session.setAttribute("patients",patientsList);
if (patientsList != null && patientsList.size() > 0) { %>

<display:table id="patient" name="patientsList" requestURI="//ext/epsos/demo/view?actionURL=true" pagesize="25" sort="list" style="width: 100%;">

<display:setProperty name="export.excel" value="true" />
<display:setProperty name="export.excel.filename" value="Patients.xls" />
<display:setProperty name="export.pdf" value="true" />
<display:setProperty name="export.pdf.filename" value="Patients.pdf" />
<display:setProperty name="export.csv" value="true" />
<display:setProperty name="export.csv.filename" value="Patients.csv" />
<display:setProperty name="export.xml" value="true" />
<display:setProperty name="export.xml.filename" value="Patients.xml" />


<%  EhrPatientClientDto pat = (EhrPatientClientDto) pageContext.getAttribute("patient"); 
//session.setAttribute(request.getParameter("country") + "_" + "patient_" + pat.getPid().get(0).getPatientID() + "_" + pat.getPid().get(0).getPatientIDType(),pat);
%>
<display:column property="givenName" title="<%= EpsosHelperService.getPortalTranslation("patient.data.givenname",user.getLanguageId()) %>" />
<display:column property="familyName" title="<%= EpsosHelperService.getPortalTranslation("patient.data.surname",user.getLanguageId()) %>"  />
<display:column  title="<%= EpsosHelperService.getPortalTranslation("patient.data.birth.date",user.getLanguageId()) %>"  sortable="true" >
<% if (pat.getBirthdate() != null ) {
	java.util.Date bday = pat.getBirthdate().toGregorianCalendar().getTime();
	 out.print(EpsosHelperService.dateFormat.format(bday));
}
%>
</display:column>
<display:column property="streetAddress" title="<%= EpsosHelperService.getPortalTranslation("patient.data.street.address",user.getLanguageId()) %>" />
<display:column property="zip"  title="<%= EpsosHelperService.getPortalTranslation("patient.data.code",user.getLanguageId()) %>" />
<display:column property="city"  title="<%= EpsosHelperService.getPortalTranslation("patient.data.city",user.getLanguageId()) %>" />
<display:column property="country"  title="<%= EpsosHelperService.getPortalTranslation("patient.data.country",user.getLanguageId()) %>" />

<display:column media="html" style="white-space:nowrap;">

<a target="new" title="<%= EpsosHelperService.getPortalTranslation("navi.info.patient.agreement",user.getLanguageId()) %>" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/getConsentPDF"/>
<portlet:param name="patID" value="<%= patientsList.indexOf(pat)+""  %>"/>
<portlet:param name="country" value="<%= request.getParameter("country") %>"/>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/print.png" alt="consent">
</a>
&nbsp;
<% 	boolean allowCreateConsent = GetterUtil.getBoolean(gnomon.util.GnPropsUtil.get("portalb", "epsos.consent.allow.create"), false); %>
<% if  (allowCreateConsent) {%>
<a title="<%= EpsosHelperService.getPortalTranslation("navi.info.patient.agreement",user.getLanguageId()) %>" href="javascript:openDialog('<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/viewPatientConsent"/>
<portlet:param name="accessAction" value="checkConsent"/>
<portlet:param name="reason" value="consent"/>
<portlet:param name="patID" value="<%= patientsList.indexOf(pat)+"" %>"/>
<portlet:param name="docType" value="consent"/>
<portlet:param name="country" value="<%= request.getParameter("country") %>"/>
</portlet:actionURL>', 600,800);">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/assign_user_permissions.png" alt="consent">
</a>
&nbsp;
<% } %>
<a title="<%= LanguageUtil.get(pageContext, "epsos.patient.card.view") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/demo/checkPatientAccess"/>
<portlet:param name="accessAction" value="checkConfirmation"/>
<portlet:param name="forwardAction" value="/ext/epsos/demo/viewPatientCard"/>
<portlet:param name="patID" value="<%= patientsList.indexOf(pat)+"" %>"/>
<portlet:param name="docType" value="ps"/>
<portlet:param name="country" value="<%= request.getParameter("country") %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/view.png" alt="view"></a>
&nbsp;
<% if (true || EpsosHelperService.getInstance().hasCurrentUserPhysicianRole(request)) { %>
<a title="<%= EpsosHelperService.getPortalTranslation("navi.report.summary",user.getLanguageId()) %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/demo/viewPatientDocuments"/>
<portlet:param name="accessAction" value="checkConfirmation"/>
<portlet:param name="forwardAction" value="/ext/epsos/demo/viewPatientDocuments"/>
<portlet:param name="patID" value="<%= patientsList.indexOf(pat)+"" %>"/>
<portlet:param name="docType" value="ps"/>
<portlet:param name="country" value="<%= request.getParameter("country") %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/all_pages.png" alt="documents"></a>
<% } %>
<%// if (EpsosHelperService.getInstance().hasCurrentUserPharmacistRole(request)) { %>
<% if (true) { %>
&nbsp;
<a title="<%= EpsosHelperService.getPortalTranslation("navi.report.prescription",user.getLanguageId()) %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/demo/viewPatientPrescriptions"/>
<portlet:param name="accessAction" value="checkConfirmation"/>
<portlet:param name="forwardAction" value="/ext/epsos/demo/viewPatientPrescriptions"/>
<portlet:param name="country" value="<%= request.getParameter("country") %>"/>
<portlet:param name="patID" value="<%= patientsList.indexOf(pat)+"" %>"/>
<portlet:param name="docType" value="ep"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/manage_task.png" alt="epsos.demo.prescription.list"></a>
<% } %>

</display:column>


</display:table>

<%} else {%>
	   <span class="portlet-msg-alert">
<%= EpsosHelperService.getInstance().getPortalTranslation("patient.list.no.patient",themeDisplay.getLanguageId()) %>
</span>
<% }} %>

<%--
<a class="media" href="/html/portlet/ext/epsos/demo/Publication1.pdf">PDF File</a>
 --%>