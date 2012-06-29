<%@ include file="/html/portlet/ext/parties/init.jsp" %>


<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.portlet.parties.browser.persons.NewPersonWizardForm" %>


<%@ include file="/html/portlet/ext/parties/browser/Parties_js.jsp" %>


<%
try{
	String loadAction = request.getParameter(Definitions.REQ_LOAD_ACTION);
	String partyIdStr = request.getParameter(Definitions.SELECTED_MAIN_ID);

	String showBackButtonStr = (String)request.getAttribute(Definitions.SHOW_BACK_BUTTON);
	String showNextButtonStr = (String)request.getAttribute(Definitions.SHOW_NEXT_BUTTON);
	String showSaveButtonStr = (String)request.getAttribute(Definitions.SHOW_SAVE_BUTTON);
	String showCancelButtonStr = (String)request.getAttribute(Definitions.SHOW_CANCEL_BUTTON);
	String showSaveSystemUserButtonStr = (String)request.getAttribute(Definitions.SHOW_SAVE_SYSTEM_USER_BUTTON);
	
	boolean showBackButton = showBackButtonStr != null && showBackButtonStr.equals(Definitions.C_TRUE);
	boolean showNextButton = showNextButtonStr != null && showNextButtonStr.equals(Definitions.C_TRUE);
	boolean showSaveButton = showSaveButtonStr != null && showSaveButtonStr.equals(Definitions.C_TRUE);
	boolean showSaveSystemUserButton = showSaveSystemUserButtonStr != null && showSaveSystemUserButtonStr.equals(Definitions.C_TRUE);
	boolean showCancelButton = showCancelButtonStr != null && showCancelButtonStr.equals(Definitions.C_TRUE);
	
	String windowState = ((RenderRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST)).getWindowState().toString();
	boolean popUpWindowState = windowState != null && windowState.equals(LiferayWindowState.POP_UP.toString());
%>

<bean:define id="wizardPage" name="NewPersonWizardForm" property="wizardPageNumber" />
<bean:define id="systemUserStr" name="NewPersonWizardForm" property="systemUser" />


<h3 nowrap class="title1">
<% if (systemUserStr != null && systemUserStr.equals(Definitions.C_TRUE)){%>
<%= LanguageUtil.get(pageContext, "parties.persons.newSystemUserWizardTitle")%>
<%}else{%>
<%= LanguageUtil.get(pageContext, "parties.persons.newPersonWizardTitle")%>
<%}%>
</h3>
<tiles:insert page="/html/portlet/ext/parties/browser/persons/NewPersonWizardHelpMessages_tile.jsp" flush="true">
  <tiles:put name="propName"><%= Definitions.NEW_PERSON_WIZARD_HELP_MESSAGE%></tiles:put>
  <tiles:put name="posAlert" value="true" />
  <tiles:put name="currentPage"><%=wizardPage%></tiles:put>
</tiles:insert>

<BR>
<tiles:insert page="/html/portlet/ext/parties/browser/BusinessLogicMessagesTile.jsp" flush="true">
  <tiles:put name="propName"><%= Definitions.BUSINESS_LOGIC_MESSAGE_FOR_PERSON%></tiles:put>
</tiles:insert>

<%
Vector fields=null;
String curFormName="NewPersonWizardForm";
%>

<table class="StrutsFormFieldsCssClass" width="100%">
<tr><td >

<html:form action="/ext/parties/browser/party_newPerson_load?actionURL=true" method="post">
	
	<TABLE width="100%">
	<TR>
	<TD align="left" valign="top" >
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="NewPersonWizardForm" />
		</tiles:insert>

	</TD>
	</TR>
	</TABLE>
	
</td></tr>

<!-- ================================================================ -->
<logic:equal name="NewPersonWizardForm" property="wizardPageNumber" value="<%=""+NewPersonWizardForm.WIZ_PG_SIMILAR_PARTIES_LIST%>">

<%
List partiesList=(List)request.getAttribute(Definitions.PARTIES_LIST);

if (partiesList != null && partiesList.size() > 0){%>

<tr><td>

	<tiles:insert page="/html/portlet/ext/parties/browser/SimilarPartiesTable_tile.jsp" flush="true">
		<tiles:put name="listAttrName" value="partiesList"/>
		<tiles:put name="actionUrl" value="//ext/parties/browser/party_newPerson_load?actionURL=true"/>  		
	</tiles:insert>

</td></tr>
<%}%>
</logic:equal>

<!-- ================================================================ -->



<!-- ================================================================ -->

<!-- % @ include file="/html/portlet/ext/parties/browser/persons/NewPersonCompanyDepartmentSelection.jsp" % -->

<%@ include file="/html/portlet/ext/parties/browser/persons/NewPersonCompleteInfo.jsp" %>

<%@ include file="/html/portlet/ext/parties/browser/persons/NewSystemUserInfo.jsp" %>

<!-- ================================================================ -->
<tr><td>

<%-- if (showCancelButton){%>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newPerson_load"/>
  <tiles:put name="buttonName" value="NewPersonWizardCancelButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.cancel" />
  <tiles:put name="formName"   value="NewPersonWizardForm" />
</tiles:insert>
<%} --%>
<% if (showBackButton){%>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newPerson_load"/>
  <tiles:put name="buttonName" value="NewPersonWizardBackButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.back" />
  <tiles:put name="formName"   value="NewPersonWizardForm" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=Definitions.LOAD_ACTION_NEW_PARTY_WIZ_BACK%></tiles:add>
  </tiles:putList>
</tiles:insert>
<%}%>
<% if (showNextButton){%>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newPerson_load"/>
  <tiles:put name="buttonName" value="NewPersonWizardNextButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.next" />
  <tiles:put name="formName"   value="NewPersonWizardForm" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=Definitions.LOAD_ACTION_NEW_PARTY_WIZ_NEXT%></tiles:add>
  </tiles:putList>
</tiles:insert>
<%}%>
<% if (showSaveButton){%>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newPerson_execute"/>
  <tiles:put name="buttonName" value="NewPersonWizardSaveButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.save" />
  <tiles:put name="formName"   value="NewPersonWizardForm" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=Definitions.LOAD_ACTION_NEW_PARTY_WIZ_NEXT%></tiles:add>
  </tiles:putList>
</tiles:insert>
<%}%>

<% if (showSaveSystemUserButton){%>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action" value="/ext/parties/browser/party_newSystemUser_execute"/>
  <tiles:put name="buttonName" value="NewPersonWizardSaveButton" />
  <tiles:put name="buttonValue" value="parties.browser.organizationWizard.save" />
  <tiles:put name="formName"   value="NewPersonWizardForm" />
  <tiles:putList name="actionParamList">
	<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
	<tiles:add><%=Definitions.LOAD_ACTION_NEW_PARTY_WIZ_NEXT%></tiles:add>
  </tiles:putList>
</tiles:insert>
<%}%>



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