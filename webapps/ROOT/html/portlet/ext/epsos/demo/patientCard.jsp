<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%@ page import="com.ext.portlet.epsos.*" %>

<% EhrPatientClientDto patient = (EhrPatientClientDto) request.getAttribute("patient"); 
%>

<div class="uni-form">
<fieldset class="inline-labels">
<legend>
<%= LanguageUtil.get(pageContext, "epsos.demo.search.patientCard") %>
</legend>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.familyName") %></label>
<span>
<%= patient.getFamilyName() != null ? patient.getFamilyName() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.givenName") %></label>
<span>
<%= patient.getGivenName() != null? patient.getGivenName(): "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.middleName") %></label>
<span>
<%= patient.getMiddleName() != null ? patient.getMiddleName() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.namePrefix") %></label>
<span>
<%= patient.getNamePrefix() != null ? patient.getNamePrefix() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.sex") %></label>
<span>
<%= patient.getSex() != null ? LanguageUtil.get(pageContext, "epsos.demo.search.sex."+patient.getSex()) : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.birthdate") %></label>
<span>
<%= patient.getBirthdate() != null? 
    EpsosHelperService.dateFormat.format(patient.getBirthdate().toGregorianCalendar().getTime()) : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.streetAddress") %></label>
<span>
<%= patient.getStreetAddress() != null? patient.getStreetAddress() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.city") %></label>
<span>
<%= patient.getCity() != null? patient.getCity() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.country") %></label>
<span>
<%= patient.getCountry() != null? patient.getCountry() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.zip") %></label>
<span>
<%= patient.getZip() != null? patient.getZip() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.state") %></label>
<span>
<%= patient.getState() != null? patient.getState() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.homePhone") %></label>
<span>
<%= patient.getHomePhone() != null? patient.getHomePhone() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.businessPhone") %></label>
<span>
<%= patient.getBusinessPhone() != null? patient.getBusinessPhone() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.emailHome") %></label>
<span>
<%= patient.getEmailHome() != null? patient.getEmailHome() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.emailBusiness") %></label>
<span>
<%= patient.getEmailBusiness() != null? patient.getEmailBusiness() : "" %>
</span>
</div>


<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.birthPlace") %></label>
<span>
<%= patient.getBirthPlace() != null? patient.getBirthPlace() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.citizenship") %></label>
<span>
<%= patient.getCitizenship() != null? patient.getCitizenship() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.nationality") %></label>
<span>
<%= patient.getNationality() != null? patient.getNationality() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.accountData") %></label>
<span>
<%= patient.getAccountNumber() != null? patient.getAccountNumber() : "" %>
</span>
</div>


<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.ssnNumber") %></label>
<span>
<%= patient.getSsnNumber() != null? patient.getSsnNumber() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.drivingLicense") %></label>
<span>
<%= patient.getDrivingLicense() != null? patient.getDrivingLicense() : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.dateOfDeath") %></label>
<span>
<%= patient.getDeathdate() != null? EpsosHelperService.dateFormat.format(patient.getDeathdate().toGregorianCalendar().getTime()) : "" %>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.search.lastUpdate") %></label>
<span>
<%= patient.getLastUpdtateTime() != null?  EpsosHelperService.dateFormat.format(patient.getLastUpdtateTime().toGregorianCalendar().getTime()): "" %>
</span>
</div>
</fieldset>


<br />



<%--
<!--<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "epsos.demo.search.patientIds") %></legend>
-->
<h3><%= LanguageUtil.get(pageContext, "epsos.demo.search.patiendIds") %></h3>


<% if (patient.getPid() != null && patient.getPid().size() > 0) { 
	request.setAttribute("patientIds", patient.getPid());
%>

<display:table id="pid" name="patientIds" requestURI="//ext/epsos/demo/viewPatientCard?actionURL=true" pagesize="25" sort="list" export="true" style="width: 100%;">

<% EhrPIDClientDto pidItem = (EhrPIDClientDto)pid; %>
<display:setProperty name="export.excel" value="true" />
<display:setProperty name="export.excel.filename" value="PatientIds.xls" />
<display:setProperty name="export.pdf" value="true" />
<display:setProperty name="export.pdf.filename" value="PatientIds.pdf" />
<display:setProperty name="export.csv" value="true" />
<display:setProperty name="export.csv.filename" value="PatientIds.csv" />
<display:setProperty name="export.xml" value="true" />
<display:setProperty name="export.xml.filename" value="PatientIds.xml" />

<display:column property="patientID" titleKey="epsos.demo.pid.id" sortable="true"/>
<display:column property="patientIDType" titleKey="epsos.demo.pid.type" sortable="true"/>
<display:column titleKey="epsos.demo.pid.domain" sortable="true">
<%=  pidItem.getDomain().getAuthUniversalID() %>
</display:column>
<display:column titleKey="epsos.demo.pid.domainType" sortable="true">
<%=  pidItem.getDomain().getAuthUniversalIDType() %>
</display:column>
<display:column  titleKey="epsos.demo.pid.namespace" sortable="true">
<%=  pidItem.getDomain().getAuthNamespaceID() %>
</display:column>
<display:column property="ehrPIDType" titleKey="epsos.demo.pid.ehrType" sortable="true"/>

</display:table>

<% }  %>
<!--</fieldset>-->

 --%>

<br>

<a href="<%= redirect %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="back"><%= LanguageUtil.get(pageContext, "back") %></a>
