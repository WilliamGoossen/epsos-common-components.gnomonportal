<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>

<h3 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.summary-party") %></h3>


<%
try {

List identifiersList=(List) request.getAttribute("identifiersList");
List emailAddressesList=(List) request.getAttribute("emailAddressesList");
List webpageAddressesList=(List) request.getAttribute("webpageAddressesList");
List telecomAddressesList=(List) request.getAttribute("telecomAddressesList");
List geographicAddressesList=(List) request.getAttribute("geographicAddressesList");
List rolesList=(List) request.getAttribute("rolesList");
List relsListClient=(List) request.getAttribute("relsListClient");
List relsListSupplier=(List) request.getAttribute("relsListSupplier");

StrutsFormFields new_field=null;
Vector fields=new Vector();
String curFormName="OrganizationForm";
fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("nameid","nameid","text",true));
fields.addElement(new StrutsFormFields("langid","langid","text",true));
fields.addElement(new StrutsFormFields("lang","parties.manager.lang","text",false,true));
new_field = new StrutsFormFields("name","parties.manager.organization.name","text",false, true);
new_field.setRequired(true);
fields.addElement(new_field);
new_field = new StrutsFormFields("typeid","parties.manager.organization.typeid","select",false, true);
new_field.setCollectionProperty("typeIds");
new_field.setCollectionLabel("typeNames");
fields.addElement(new_field);
request.setAttribute("_vector_fields", fields);
%>

<html:form action="/ext/parties/manager/loadOrganizationSummary?actionURL=true" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName"><%= curFormName %></tiles:put>
	<tiles:put name="attributeName" value="_vector_fields"/>
</tiles:insert>
</html:form>

<br>

<% if (identifiersList == null || identifiersList.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-identifier") %></h3><% } %>
<display:table id="identifiers" name="identifiersList" requestURI="//ext/parties/manager/loadOrganizationSummary?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action" style="font-weight: normal; width: 100%; border-spacing: 0">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-identifier") %></b></display:caption>
<display:column class="gamma1" property="identifier" titleKey="parties.manager.identifier.identifier"/>
<display:column class="gamma1" property="registrationAuthority" titleKey="parties.manager.identifier.registrationauthority"/>
</display:table>

<br>

<% if (emailAddressesList == null || emailAddressesList.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-email-address") %></h3><% } %>
<display:table id="addresses1" name="emailAddressesList" requestURI="//ext/parties/manager/loadOrganizationSummary?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-email-address") %></b></display:caption>
<display:column class="gamma1" property="emailAddress" titleKey="parties.addresses.email"/>
</display:table>

<br>

<% if (webpageAddressesList == null || webpageAddressesList.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-webpage-address") %></h3><% } %>
<display:table id="addresses2" name="webpageAddressesList" requestURI="//ext/parties/manager/loadOrganizationSummary?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-webpage-address") %></b></display:caption>
<display:column class="gamma1" property="url" titleKey="parties.addresses.webpage.url"/>
<display:column class="gamma1" property="description" titleKey="parties.addresses.webpage.description"/>
</display:table>

<br>

<% if (telecomAddressesList == null || telecomAddressesList.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-telecom-address") %></h3><% } %>
<display:table id="addresses3" name="telecomAddressesList" requestURI="//ext/parties/manager/loadOrganizationSummary?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-telecom-address") %></b></display:caption>
<display:column class="gamma1" property="countryCode" titleKey="parties.addresses.telecom.countrycode"/>
<display:column class="gamma1" property="areaCode" titleKey="parties.addresses.telecom.areacode"/>
<display:column class="gamma1" property="number" titleKey="parties.addresses.telecom.number"/>
<display:column class="gamma1" property="extension" titleKey="parties.addresses.telecom.extension"/>
<display:column class="gamma1" property="physicalType" titleKey="parties.addresses.telecom.physicaltype"/>
</display:table>

<br>

<% if (geographicAddressesList == null || geographicAddressesList.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-geographic-address") %></h3><% } %>
<display:table id="addresses4" name="geographicAddressesList" requestURI="//ext/parties/manager/loadOrganizationSummary?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-geographic-address") %></b></display:caption>
<display:column class="gamma1" property="field1" titleKey="parties.addresses.geographic.addressline"/>
<display:column class="gamma1" property="field2" titleKey="parties.addresses.geographic.region"/>
<display:column class="gamma1" property="field3" titleKey="parties.addresses.geographic.ziporpostcode"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.country.name"/>
</display:table>

<br>

<% if (rolesList == null || rolesList.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-roles") %></h3><% } %>
<display:table id="roles" name="rolesList" requestURI="//ext/parties/manager/loadOrganizationSummary?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-roles") %></b></display:caption>
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyroletype.description"/>
</display:table>

<br>

<% if (relsListClient == null || relsListClient.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-rels-for-client") %></h3><% } %>
<display:table id="relsClient" name="relsListClient" requestURI="//ext/parties/manager/loadOrganizationSummary?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-rels-for-client") %></b></display:caption>
<display:column class="gamma1" property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyrelationshiptype.name" sortable="true" />
<display:column class="gamma1" property="field4" titleKey="parties.manager.relatedparty"/>
<display:column class="gamma1" property="field5" titleKey="parties.manager.relatedparty.role"/>
</display:table>

<br>

<% if (relsListSupplier == null || relsListSupplier.size() == 0) { %>
<h3  class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.list-rels-for-supplier") %></h3><% } %>
<display:table id="relsSupplier" name="relsListSupplier" requestURI="//ext/parties/manager/loadOrganizationSummary" pagesize="10" excludedParams="struts_action">
<display:caption><b><%= LanguageUtil.get(pageContext, "parties.manager.list-rels-for-supplier") %></b></display:caption>
<display:column class="gamma1" property="field1" titleKey="parties.admin.partyroletype.name" sortable="true" />
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyrelationshiptype.name" sortable="true" />
<display:column class="gamma1" property="field4" titleKey="parties.manager.relatedparty"/>
<display:column class="gamma1" property="field5" titleKey="parties.manager.relatedparty.role"/>
</display:table>

<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/manager/viewParties"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-parties") %></html:link></TD>
</TR></TABLE>

<% } catch (Exception e) { e.printStackTrace(); } %>