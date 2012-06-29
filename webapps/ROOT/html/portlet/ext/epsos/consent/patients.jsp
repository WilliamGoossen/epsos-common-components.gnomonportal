<%@ include file="/html/portlet/ext/epsos/consent/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%@ page import="com.ext.portlet.epsos.*" %>

<script language="JavaScript">

function countrySelectionChanged()
{
	document.EpsosPatientSearchForm.submit();
}
</script>

<html:form action="/ext/epsos/consent/view?actionURL=true" method="post" enctype="multipart/form-data" styleClass="uni-form">

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
<input type="submit" value="<%= LanguageUtil.get(pageContext, "search") %>">
</div>
</div>

</html:form>

<%
List<EhrPatientClientDto> patientsList = (List<EhrPatientClientDto>)request.getAttribute("patientsList");
if (patientsList != null && patientsList.size() > 0) { %>

<h3><%= LanguageUtil.get(pageContext, "epsos.consent.patients") %></h3>

<display:table id="patient" name="patientsList" requestURI="//ext/epsos/consent/view?actionURL=true" pagesize="25" sort="list" export="true" style="width: 100%;">

<display:setProperty name="export.excel" value="true" />
<display:setProperty name="export.excel.filename" value="Patients.xls" />
<display:setProperty name="export.pdf" value="true" />
<display:setProperty name="export.pdf.filename" value="Patients.pdf" />
<display:setProperty name="export.csv" value="true" />
<display:setProperty name="export.csv.filename" value="Patients.csv" />
<display:setProperty name="export.xml" value="true" />
<display:setProperty name="export.xml.filename" value="Patients.xml" />


<%  EhrPatientClientDto pat = (EhrPatientClientDto) pageContext.getAttribute("patient"); 
	//if (!EpsosHelperService.getInstance().hasPatientConfirmation(request, pat))
		//EpsosHelperService.getInstance().createPatientConfirmation(request, pat);
%>
<display:column property="givenName" titleKey="epsos.demo.search.givenName" sortable="true"/>
<display:column property="familyName" titleKey="epsos.demo.search.surName" sortable="true"/>
<display:column titleKey="epsos.demo.search.birthdate" sortable="true" >
<% if (pat.getBirthdate() != null ) {
	java.util.Date bday = pat.getBirthdate().toGregorianCalendar().getTime();
	 out.print(EpsosHelperService.dateFormat.format(bday));
}
%>
</display:column>
<display:column property="streetAddress" titleKey="epsos.demo.search.street" sortable="true"/>
<display:column property="zip" titleKey="epsos.demo.search.zip" sortable="true"/>
<display:column property="city" titleKey="epsos.demo.search.city" sortable="true"/>
<display:column property="country" titleKey="epsos.demo.search.country" sortable="true"/>

<display:column media="html" style="white-space:nowrap;">
<a title="<%= LanguageUtil.get(pageContext, "epsos.consent.list") %>" href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/epsos/consent/checkPatientAccess"/>
<portlet:param name="accessAction" value="checkConfirmation"/>
<portlet:param name="forwardAction" value="/ext/epsos/consent/list"/>
<portlet:param name="patID" value="<%= pat.getPid().get(0).getPatientID() %>"/>
<portlet:param name="country" value="<%= request.getParameter("country") %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/all_pages.png" alt="view"></a>

</display:column>


</display:table>

<%} %>