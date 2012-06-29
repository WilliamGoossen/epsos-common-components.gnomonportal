<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.browser.Definitions" %>

<%
try{
	String partyIdStr = (String)request.getAttribute(Definitions.SELECTED_MAIN_ID);
	String partyIdPerson = (String)request.getAttribute(Definitions.PARTY_IS_PERSON);
	boolean isPersonFlag = partyIdPerson != null && partyIdPerson.equals(Definitions.C_TRUE);
	String showTab = (String)request.getAttribute(Definitions.SHOW_TAB);

if (showTab == null){	
if (isPersonFlag) {%>

<jsp:include page="../persons/PersonSummaryFormView.jsp" />

<%}else{%>

<jsp:include page="../organizations/OrganizationSummaryFormView.jsp" />

<%}
}
%>

<tiles:insert page="/html/portlet/ext/struts_includes/tabsbar.jsp" flush="true"/>

<TABLE class="ProjectMgmtTabCssClass" width="100%" >

<TR><TD>

<!-- ================================================== -->
<display:table id="roles" name="partyRolesList" requestURI="//ext/parties/manager/listPartyRoles?actionURL=true" pagesize="10" sort="list" excludedParams="struts_action">
<display:column><input type="radio" name="group1" value="<%=((gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("roles")).getMainid().toString()%>"></display:column>
<display:column property="field2" titleKey="parties.admin.partyroletype.name" sortable="true" headerClass="sortable"/>
</display:table>
<!-- ================================================== -->

</TD></TR>
</TABLE>


<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>