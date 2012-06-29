<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<%
try{
	String partyIdStr = (String)request.getAttribute(Definitions.SELECTED_MAIN_ID);
	String partyIdPerson = (String)request.getAttribute(Definitions.PARTY_IS_PERSON);
	boolean isPersonFlag = partyIdPerson != null && partyIdPerson.equals(Definitions.C_TRUE);
	String showTab = (String)request.getAttribute(Definitions.SHOW_TAB);
	String windowState = ((RenderRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST)).getWindowState().toString();
	boolean popUpWindowState = windowState != null && windowState.equals(LiferayWindowState.POP_UP.toString());
	
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
<tiles:insert page="/html/portlet/ext/parties/browser/addresses/AddressesList_tile.jsp" flush="true">
  <tiles:put name="partyIdStr"><%=partyIdStr%></tiles:put>
</tiles:insert>
<!-- ================================================== -->

</TD></TR>
</TABLE>
<% if (!popUpWindowState) { %>
<br>

<%@ include file="/html/portlet/ext/parties/browser/footer.jsp" %>
<% } %>
<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>