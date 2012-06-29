<%@ include file="/html/portlet/ext/parties/init.jsp" %>


<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<%
try{
	String loadAction = request.getParameter(Definitions.REQ_LOAD_ACTION);
	String partyIdStr = request.getParameter(Definitions.SELECTED_MAIN_ID);
%>
<h3 nowrap class="title1">
<%= LanguageUtil.get(pageContext, "parties.persons.editView")%>
</h3>
<BR>
<tiles:insert page="/html/portlet/ext/parties/browser/BusinessLogicMessagesTile.jsp" flush="true">
  <tiles:put name="propName"><%= Definitions.BUSINESS_LOGIC_MESSAGE_FOR_PERSON%></tiles:put>
</tiles:insert>

<html:form action="/ext/parties/browser/person_execute?actionURL=true" method="post">

	<TABLE width="100%">
	<TR>
	<TD align="left" valign="top" >
		<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"  value="PersonSummaryForm" />
		</tiles:insert>

	</TD>
	</TR>
	</TABLE>
	
	
	<logic:notEmpty name="partiesList">
		<tiles:insert page="/html/portlet/ext/parties/browser/SimilarPartiesTable_tile.jsp" flush="true">
			<tiles:put name="listAttrName" value="partiesList"/>
			<tiles:put name="actionUrl" value="//ext/parties/browser/person_execute"/>  
		</tiles:insert>
		
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
			<tiles:put name="action" value="/ext/parties/browser/person_execute"/>
	  		<tiles:put name="buttonName" value="PersonUpdateButton" />
			<tiles:put name="buttonValue" value="parties.button.update" />
	  		<tiles:put name="formName"   value="PersonSummaryForm" />
	  		<tiles:putList name="actionParamList">
		  		<tiles:add><%=Definitions.REQ_LOAD_ACTION%></tiles:add>
		  		<tiles:add><%=Definitions.SELECTED_MAIN_ID%></tiles:add>
		  		<tiles:add><%=Definitions.REQ_PARAM_IGNORE_SIMILAR_PARTIES%></tiles:add>
	  		</tiles:putList>
	  		<tiles:putList name="actionParamValueList">
				<tiles:add><%=Definitions.LD_ACTION_EDIT%></tiles:add>
				<tiles:add><%=partyIdStr%></tiles:add>
				<tiles:add><%=Definitions.C_TRUE%></tiles:add>
	  		</tiles:putList>
		</tiles:insert>
		
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
			<tiles:put name="action" value="/ext/parties/browser/person_load"/>
	  		<tiles:put name="buttonName" value="PersonCancelButton" />
			<tiles:put name="buttonValue" value="parties.button.cancel" />
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
	</logic:notEmpty>
	
	<logic:empty name="partiesList">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		<tiles:put name="action" value="/ext/parties/browser/person_execute"/>
  		<tiles:put name="buttonName" value="PersonUpdateButton" />
		<tiles:put name="buttonValue" value="parties.button.update" />
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
	</logic:empty>


</html:form>


<%
	java.util.HashMap params = new java.util.HashMap();
	
	params.put(Definitions.SELECTED_MAIN_ID, partyIdStr);
	params.put(Definitions.REQ_LOAD_ACTION, Definitions.LD_ACTION_VIEW);
	
	pageContext.setAttribute("paramsName", params);
%>

<BR>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD>
<html:link styleClass="beta1" action="/ext/parties/browser/person_load" name="paramsName">
	<img src="<%= _parties_imgPath %>/common/back.png"  border="0" align="absmiddle">
	<%= LanguageUtil.get(pageContext, "parties.browser.link.backToPersonInfo") %>
</html:link>
</TD>
</TR>
</TABLE>


<%} catch(Exception ex){
	ex.printStackTrace();
}%>

