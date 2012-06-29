<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="com.ext.util.CommonDefs" %>

<!-- Tile attributes for URLs that need to change according to the Portlet -->
<!-- in which the JSP is used											   -->
<!-- formActionUrl : A URL to be used in the action attribute of the struts html form tag tag -->
<!-- backActionUrl : A URL to be used in the back link -->

<tiles:useAttribute id="formActionUrl" name="formActionUrl" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="backActionUrl" name="backActionUrl" classname="java.lang.String" ignore="true"/>

<%
try{
	String partyIdStr = (String)request.getAttribute(Definitions.SELECTED_MAIN_ID);
	String partyIsPerson = (String)request.getAttribute(Definitions.PARTY_IS_PERSON);
	boolean isPersonFlag = partyIsPerson != null && partyIsPerson.equals(Definitions.C_TRUE);
	String loadAction = request.getParameter(Definitions.REQ_LOAD_ACTION);
	
	formActionUrl = (formActionUrl == null) ? "/ext/parties/browser/party_identifiers_execute?actionURL=true" :formActionUrl;
	backActionUrl = (backActionUrl == null) ? "/ext/parties/browser/partyIdentifiers_list" : backActionUrl;
%>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<h3  class="title1">
<% if (loadAction.equals(Definitions.LD_ACTION_EDIT)) {%>
<%= LanguageUtil.get(pageContext, "parties.manager.form.update-identifier") %>
<%}else if (loadAction.equals(Definitions.LD_ACTION_ADD)){%>
<%= LanguageUtil.get(pageContext, "parties.manager.form.add-identifier") %>
<%}%>
<BR>
<tiles:insert page="/html/portlet/ext/parties/browser/BusinessLogicMessagesTile.jsp" flush="true">
  <tiles:put name="propName"><%=Definitions.BUSINESS_LOGIC_MESSAGE_FOR_PARTY%></tiles:put>
</tiles:insert>

<%
Vector fields=null;
String curFormName="PrjPartyIdentifierForm";
%>

<html:form action="<%=formActionUrl%>" method="post">
	<html:hidden property="loadaction" value="<%=loadAction%>" />
	<% if (isPersonFlag) {%><html:hidden property="<%=Definitions.PARTY_IS_PERSON%>" value="<%=Definitions.C_TRUE%>" /><%}%>

	
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="PrjPartyIdentifierForm" />
		</tiles:insert>	

	<%if (loadAction.equals(Definitions.LD_ACTION_ADD)) {%>
		<html:submit styleClass="portlet-form-button"> <%= LanguageUtil.get(pageContext, "parties.button.add") %></html:submit>
	<%} else if (loadAction.equals(Definitions.LD_ACTION_EDIT)) {%>
		<html:submit styleClass="portlet-form-button"> <%= LanguageUtil.get(pageContext, "parties.button.update") %></html:submit>
	<%}%>

</html:form>


<%
	java.util.HashMap params = new java.util.HashMap();
	
	params.put(Definitions.SELECTED_MAIN_ID, partyIdStr);
	if (isPersonFlag) params.put(Definitions.PARTY_IS_PERSON, Definitions.C_TRUE);
		
	pageContext.setAttribute("paramsName", params);
%>

<BR>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD>
<html:link styleClass="beta1" action="<%=backActionUrl%>" name="paramsName">
	<img src="<%= _parties_imgPath %>/common/back.gif"  border="0" align="absmiddle">
	<%= LanguageUtil.get(pageContext, "parties.browser.link.identifiersView") %>
</html:link>
</TD>
</TR>
</TABLE>

<%
}catch (Exception ex){
	ex.printStackTrace();
}
%>
