<%@ include file="/html/portlet/ext/parties/init.jsp" %>


<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<%
try{
	String loadAction = request.getParameter(Definitions.REQ_LOAD_ACTION);
	String partyIdStr = request.getParameter(Definitions.SELECTED_MAIN_ID);
	
	String windowState = ((RenderRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST)).getWindowState().toString();
	boolean popUpWindowState = windowState != null && windowState.equals(LiferayWindowState.POP_UP.toString());
	gnomon.hibernate.model.parties.PaPerson person = gnomon.hibernate.PartiesService.getInstance().getPaPerson(user.getUserId());
	if (person == null)
		popUpWindowState = true;
%>

<h3 nowrap class="title1">
<%= LanguageUtil.get(pageContext, "parties.persons.summaryView")%>
</h3>
<BR>
<tiles:insert page="/html/portlet/ext/parties/browser/BusinessLogicMessagesTile.jsp" flush="true">
  <tiles:put name="propName"><%= Definitions.BUSINESS_LOGIC_MESSAGE_FOR_PERSON%></tiles:put>
</tiles:insert>

<%
		
Vector fields=null;

String strutsFieldsAttrName = (String)request.getAttribute(Definitions.STRUTS_FIELDS_ATTR_NAME);

if (strutsFieldsAttrName == null) {
	//fields = (Vector)request.getAttribute(strutsFieldsAttrName);
	strutsFieldsAttrName = CommonDefs.ATTR_FORM_FIELDS;
}
String curFormName="PersonSummaryForm";

%>
<table class="StrutsFormFieldsCssClass" width="100%">
<tr><td >

<html:form action="/ext/parties/browser/person_load?actionURL=true" method="post">
	
	<TABLE width="100%">
	<TR>
	<TD align="left" valign="top" width="50%">
	<%fields = (Vector)request.getAttribute(CommonDefs.ATTR_FORM_FIELDS+"_COL1");
	%>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
		<tiles:put name="formName"><%= curFormName %></tiles:put>
		<tiles:put name="attributeName"><%= CommonDefs.ATTR_FORM_FIELDS+"_COL1" %></tiles:put>
	</tiles:insert>
	</TD>
	<TD align="left" valign="top" width="50%">
	<%fields = (Vector)request.getAttribute(CommonDefs.ATTR_FORM_FIELDS+"_COL2");
	%>
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
		<tiles:put name="formName"><%= curFormName %></tiles:put>
		<tiles:put name="attributeName"><%= CommonDefs.ATTR_FORM_FIELDS+"_COL2" %></tiles:put>
	</tiles:insert>
	</TD>
	</TR>
	</TABLE>
	
	<% if (!popUpWindowState){%>
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		<tiles:put name="action" value="/ext/parties/browser/person_load"/>
  		<tiles:put name="buttonName" value="EditPersonButton" />
		<tiles:put name="buttonValue" value="parties.button.edit" />
  		<tiles:put name="formName"   value="PersonSummaryForm" />
  		
  		<tiles:putList name="actionParamList">
	  		<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
	  		<tiles:add><%=Definitions.SELECTED_MAIN_ID%></tiles:add>
  		</tiles:putList>
  		<tiles:putList name="actionParamValueList">
			<tiles:add><%=Definitions.LD_ACTION_EDIT%></tiles:add>
			<tiles:add><%=partyIdStr%></tiles:add>
  		</tiles:putList>
	</tiles:insert>
	
	<%}%>
</html:form>

</td></tr>

</table>

<BR>

<%
	String showTab = (String)request.getAttribute(Definitions.SHOW_TAB);
	if (showTab != null) {
%>

<tiles:insert page="/html/portlet/ext/struts_includes/tabsbar.jsp" flush="true"/>
<TABLE class="ProjectMgmtTabCssClass" width="100%" >
<% if (showTab.equals(Definitions.PARTY_TABS_ADDRESSES)) {%>
<TR><TD>
<tiles:insert page="/html/portlet/ext/parties/browser/addresses/AddressesList_tile.jsp" flush="true">
  <tiles:put name="partyIdStr"><%=partyIdStr%></tiles:put>
</tiles:insert>

</TD></TR>
<%	} // showTab.equals%>

</TABLE>
<% if (!popUpWindowState) {%>
<br>

<%@ include file="/html/portlet/ext/parties/browser/footer.jsp" %>
<% } %>
<%} // showTab != null%>



<%
} catch(Exception ex){
	ex.printStackTrace();
}
%>