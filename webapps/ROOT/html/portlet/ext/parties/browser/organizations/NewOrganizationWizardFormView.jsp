<%@ include file="/html/portlet/ext/parties/init.jsp" %>


<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.portlet.parties.browser.organizations.NewOrganizationWizardForm" %>

<%
try{
	String loadAction = request.getParameter(Definitions.REQ_LOAD_ACTION);
	String partyIdStr = request.getParameter(Definitions.SELECTED_MAIN_ID);
	
	String windowState = ((RenderRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST)).getWindowState().toString();
	boolean popUpWindowState = windowState != null && windowState.equals(LiferayWindowState.POP_UP.toString());
%>
<bean:define id="wizardPage" name="NewOrganizationWizardForm" property="wizardPageNumber" />

<h3 nowrap class="title1">
<%= LanguageUtil.get(pageContext, "parties.organizations.newOrgWizardTitle")%>
</h3>
<tiles:insert page="/html/portlet/ext/parties/browser/parties/persons/NewPersonWizardHelpMessages_tile.jsp" flush="true">
  <tiles:put name="propName"><%= Definitions.NEW_ORG_WIZARD_HELP_MESSAGE %></tiles:put>
  <tiles:put name="posAlert" value="true" />
  <tiles:put name="currentPage"><%=wizardPage%></tiles:put>
</tiles:insert>

<BR>
<tiles:insert page="/html/portlet/ext/parties/browser/BusinessLogicMessagesTile.jsp" flush="true">
  <tiles:put name="propName"><%= Definitions.BUSINESS_LOGIC_MESSAGE_FOR_ORGANIZATION%></tiles:put>
</tiles:insert>

<%
Vector fields=null;
String curFormName="NewOrganizationWizardForm";
%>

<table class="StrutsFormFieldsCssClass" width="100%">
<tr><td >

<html:form action="/ext/parties/browser/party_newOrganization_load?actionURL=true" method="post">
	
	<TABLE width="100%">
	<TR>
	<TD align="left" valign="top" >
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewOrganizationWizardForm" />
		</tiles:insert>

	</TD>
	</TR>
	</TABLE>

</td></tr>

<!-- ================================================================ -->
<%
List partiesList=(List)request.getAttribute(Definitions.PARTIES_LIST);

if (partiesList != null && partiesList.size() > 0){%>

<tr><td>

		<tiles:insert page="/html/portlet/ext/parties/browser/SimilarPartiesTable_tile.jsp" flush="true">
			<tiles:put name="listAttrName" value="partiesList"/>
			<tiles:put name="actionUrl" value="//ext/parties/browser/party_newOrganization_load?actionURL=true"/>  		
		</tiles:insert>



</td></tr>

<%} //partiesList%>
<!-- ================================================================ -->



<!-- ================================================================ -->
<logic:equal name="NewOrganizationWizardForm" property="wizardPageNumber" value="<%=""+NewOrganizationWizardForm.WIZ_PG_COMPLETE_INFO%>">

<tr><td>

<BR>
<h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.organizations.optionalInfo")%>
</h3>
</td></tr>
<tr><td>

<TABLE width="100%">
<TR>
<TD colspan="2" align="left">
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewOrganizationWizardForm" />
			<tiles:put name="attributeName" value="ORG_AFM_FIELDS"/>
		</tiles:insert>
</TD>
</TR>

<TR>
<TD><h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.browser.tab.geographicAddress")%>
</h3></TD>
<TD><h3 class="title2">
<%= LanguageUtil.get(pageContext, "parties.browser.tab.telecomAddresses")%>
</h3></TD>
</TR>

<TR>
<TD align="left" valign="top" >
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewOrganizationWizardForm" />
			<tiles:put name="attributeName" value="ORG_GEOGRAPHIC_ADDRESS_FIELDS"/>
		</tiles:insert>
		
</TD>
<TD align="left" valign="top" >
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewOrganizationWizardForm" />
			<tiles:put name="attributeName" value="ORG_TELECOM_ADDRESS_FIELDS"/>
		</tiles:insert>
</TD>
</TR>
</TABLE>

<BR>

</td></tr>

</logic:equal>

<!-- ================================================================ -->

<tr><td>


<logic:notEqual name="NewOrganizationWizardForm" property="wizardPageNumber" value="<%=""+NewOrganizationWizardForm.WIZ_PG_COMPLETE_INFO%>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newOrganization_load"/>
  <tiles:put name="buttonName" value="NewOrganizationWizardNextButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.next" />
  <tiles:put name="formName"   value="NewOrganizationWizardForm" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=Definitions.LOAD_ACTION_NEW_PARTY_WIZ_NEXT%></tiles:add>
  </tiles:putList>
</tiles:insert>
</logic:notEqual>

<logic:equal name="NewOrganizationWizardForm" property="wizardPageNumber" value="<%=""+NewOrganizationWizardForm.WIZ_PG_COMPLETE_INFO%>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newOrganization_execute"/>
  <tiles:put name="buttonName" value="NewOrganizationWizardSaveButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.save" />
  <tiles:put name="formName"   value="NewOrganizationWizardForm" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=Definitions.LOAD_ACTION_NEW_PARTY_WIZ_NEXT%></tiles:add>
  </tiles:putList>
</tiles:insert>
</logic:equal>

<logic:notEqual name="NewOrganizationWizardForm" property="wizardPageNumber" value="<%=""+NewOrganizationWizardForm.WIZ_PG_BASIC_INFO%>">
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newOrganization_load"/>
  <tiles:put name="buttonName" value="NewOrganizationWizardBackButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.back" />
  <tiles:put name="formName"   value="NewOrganizationWizardForm" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=Definitions.LOAD_ACTION_NEW_PARTY_WIZ_BACK%></tiles:add>
  </tiles:putList>
</tiles:insert>
</logic:notEqual>

<%--logic:notEqual name="NewOrganizationWizardForm" property="wizardPageNumber" value="<%=""+NewOrganizationWizardForm.WIZ_PG_BASIC_INFO%>">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newOrganization_load"/>
  <tiles:put name="buttonName" value="NewOrganizationWizardCancelButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.cancel" />
  <tiles:put name="formName"   value="NewOrganizationWizardForm" />
</tiles:insert>
</logic:notEqual --%>

</html:form>

</td></tr>

<tr><td>
<BR>
</td></tr>

</table>
<br>
<%if (!popUpWindowState){ %>
<%@ include file="/html/portlet/ext/parties/browser/footer.jsp" %>
<%} %>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>