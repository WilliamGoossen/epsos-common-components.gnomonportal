<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.browser.partyLookupStrutsField.PartyLookupForm" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.ext.util.CommonUtil" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%@ page import="com.ext.portlet.parties.browser.partyLookupStrutsField.PartyLookupPortletAction" %>


<tiles:useAttribute id="addOption" name="addOption" classname="java.lang.String" ignore="true"/>



<%
Vector columnProperties = (Vector)request.getAttribute(PartyLookupPortletAction.LOOKUP_COLUMN_PROPERTIES);
Vector columnTitles = (Vector)request.getAttribute(PartyLookupPortletAction.LOOKUP_COLUMN_TITLES);


String addPersonFlagStr = (String)request.getAttribute(PartyLookupPortletAction.ADD_PERSON_FLAG);
String addOrganizationFlagStr = (String)request.getAttribute(PartyLookupPortletAction.ADD_ORGANIZATION_FLAG);

boolean addPersonFlag = addPersonFlagStr != null && addPersonFlagStr.equals("true");
boolean addOrganizationFlag = addOrganizationFlagStr != null && addOrganizationFlagStr.equals("true");


boolean addOptionFlag = (addOption != null && addOption.equals("true"));
String lookupActionUrl = "/ext/parties/browser/partiesLookupPortletAction?actionURL=true";

String searchByAfm = request.getParameter("searchByAfm");
boolean searchByAfmFlag = (searchByAfm != null && searchByAfm.equals("true"));
%>

<link rel="stylesheet" type="text/css" href="/html/themes/portlet/gnomon_theme/style.css">


<%
try{
	String loadAction = request.getParameter(PartyLookupPortletAction.REQ_LOAD_ACTION);
	
	String lookupFieldIdHtmlId = request.getParameter("lookupFieldIdHtmlId");
	String lookupFieldDisplHtmlId = request.getParameter("lookupFieldDisplHtmlId");
	String openerFormName = request.getParameter("openerFormName");

	boolean lookupModeFlag = (lookupFieldIdHtmlId != null && !lookupFieldIdHtmlId.equals(""));
	
	String newOpenerUrlParam = request.getParameter("newOpenerUrlParam");
	
	
	PartyLookupForm aFormBean  = (PartyLookupForm)request.getAttribute("PaPartyLookupForm");
	String lookupTitle = (String)request.getAttribute(PartyLookupPortletAction.LOOKUP_TITLE);
	
	String lookupType = null;
	String partyType = null;
	Integer orgChartId = null;
	String allowAddParty = null;
  	
	if (aFormBean != null) {
		lookupType = aFormBean.getLookupType();
		orgChartId = aFormBean.getOrgChartId();
		partyType = aFormBean.getPartyType();
		allowAddParty = aFormBean.getAllowAddParty();
	}
%>


<%@ include file="/html/portlet/ext/struts_includes/Lookup_js.jsp" %>

<h3 nowrap class="title1">
<%= LanguageUtil.get(pageContext, lookupTitle)%>
</h3>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>


<%
	String curFormName="PaPartyLookupForm";


	
	String requestUri = "/"+lookupActionUrl;
	List lookUpList = (List)request.getAttribute(PartyLookupPortletAction.LOOKUP_LIST);
%>

<BR>

<TABLE >
<TR><TD>
<html:form action="<%=lookupActionUrl%>" method="post">
	<input type="hidden" name="loadaction" value="<%= PartyLookupPortletAction.LD_ACTION_LOOKUP%>">
	<% if (searchByAfmFlag){%><input type="hidden" name="searchByAfm" value="<%= searchByAfm%>"><%}%>
	<% if (newOpenerUrlParam != null) {%><input type="hidden" name="newOpenerUrlParam" value="<%= newOpenerUrlParam%>"><%}%>
	<%
	String nameSpace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();
	String strutsFieldAttrName = CommonDefs.ATTR_FORM_FIELDS;
	%>
	
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
		<tiles:put name="formName" value="<%=curFormName%>" />
		<tiles:put name="attributeName" value="<%=strutsFieldAttrName%>" />
	</tiles:insert>

	<div id="button_search"><html:submit styleClass="portlet-form-button"> <%= LanguageUtil.get(pageContext, "party.lookup.search") %></html:submit></div>
</html:form>
</TD></TR>
</TABLE>
<BR>


<% if (addOrganizationFlag || addPersonFlag){%>
<form name="PRJ_PARTIES_PartiesActions_Form" method="post" action="/some/url">
<table>
<tr>

<% if (addPersonFlag){%>
<td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <tiles:put name="action" value="/ext/parties/browser/party_newPerson_load"/>
  <tiles:put name="buttonName" value="PartiesNewPersonButton" />
  <tiles:put name="buttonValue" value="parties.browser.addPerson" />
  <tiles:put name="formName"   value="PRJ_PARTIES_PartiesActions_Form" />
  <tiles:put name="portletId" value="PA_PARTIES_BROWSER"/>
  <tiles:put name="actionPermission" value="add"/>
  
  	<tiles:putList name="actionParamList">
	  	<tiles:add value="redirectToSelectionListFlag" />
	  	
	  	<%if (openerFormName!=null){%><tiles:add value="openerFormName" /><%} %>
	  	<%if (lookupFieldIdHtmlId!=null){%><tiles:add value="lookupFieldIdHtmlId" /><%} %>
	  	<%if (lookupFieldDisplHtmlId!=null){%><tiles:add value="lookupFieldDisplHtmlId" /><%} %>
		
		<%if (partyType!=null){%><tiles:add value="partyType" /><%} %>
	  	<%if (lookupType!=null){%><tiles:add value="lookupType" /><%} %>
	  	<%if (orgChartId!=null){%><tiles:add value="orgChartId" /><%} %>
	  	<%if (allowAddParty!=null){%><tiles:add value="allowAddParty" /><%} %>
	</tiles:putList>
	<tiles:putList name="actionParamValueList">
	   	<tiles:add value="TRUE" />
	  	<%if (openerFormName!=null){%><tiles:add><%= openerFormName%></tiles:add><%} %>
	  	<%if (lookupFieldIdHtmlId!=null){%><tiles:add><%= lookupFieldIdHtmlId%></tiles:add><%} %>
	  	<%if (lookupFieldDisplHtmlId!=null){%><tiles:add><%= lookupFieldDisplHtmlId%></tiles:add><%} %>

		<%if (partyType!=null){%><tiles:add><%= partyType%></tiles:add><%} %>
	   	<%if (lookupType!=null){%><tiles:add><%= lookupType%></tiles:add><%} %>
	  	<%if (orgChartId!=null){%><tiles:add><%= orgChartId.toString()%></tiles:add><%} %>
	  	<%if (allowAddParty!=null){%><tiles:add><%= allowAddParty%></tiles:add><%} %>	
	</tiles:putList>
</tiles:insert>
</td>
<%} %>
<% if (addOrganizationFlag){%>
<td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <tiles:put name="action" value="/ext/parties/browser/party_newOrganization_load"/>
  <tiles:put name="buttonName" value="PartiesNewOrgButton" />
  <tiles:put name="buttonValue" value="parties.browser.addOrganization" />
  <tiles:put name="formName"   value="PRJ_PARTIES_PartiesActions_Form" />
  <tiles:put name="portletId" value="PA_PARTIES_BROWSER"/>
  <tiles:put name="actionPermission" value="add"/>
	<tiles:putList name="actionParamList">
	  	<tiles:add value="redirectToSelectionListFlag" />
	  	<%if (openerFormName!=null){%><tiles:add value="openerFormName" /><%} %>
	  	<%if (lookupFieldIdHtmlId!=null){%><tiles:add value="lookupFieldIdHtmlId" /><%} %>
	  	<%if (lookupFieldDisplHtmlId!=null){%><tiles:add value="lookupFieldDisplHtmlId" /><%} %>

		<%if (partyType!=null){%><tiles:add value="partyType" /><%} %>
	  	<%if (lookupType!=null){%><tiles:add value="lookupType" /><%} %>
	  	<%if (allowAddParty!=null){%><tiles:add value="allowAddParty" /><%} %>
	</tiles:putList>
	<tiles:putList name="actionParamValueList">
	   	<tiles:add value="TRUE" />
	  	<%if (openerFormName!=null){%><tiles:add><%= openerFormName%></tiles:add><%} %>
	  	<%if (lookupFieldIdHtmlId!=null){%><tiles:add><%= lookupFieldIdHtmlId%></tiles:add><%} %>
	  	<%if (lookupFieldDisplHtmlId!=null){%><tiles:add><%= lookupFieldDisplHtmlId%></tiles:add><%} %>

		<%if (partyType!=null){%><tiles:add><%= partyType%></tiles:add><%} %>
	   	<%if (lookupType!=null){%><tiles:add><%= lookupType%></tiles:add><%} %>
	  	<%if (allowAddParty!=null){%><tiles:add><%= allowAddParty%></tiles:add><%} %>	
	</tiles:putList>
</tiles:insert>
</td>
<%} %>
</tr>
</table>
</form>
<%}%>
<BR>


<TABLE >
<TR><TD>
<form name="LookupForm" method="post" action="/some/url">

	<% if (loadAction != null || lookUpList != null && lookUpList.size() > 0) {%>
<h3 nowrap class="title2">
<%= LanguageUtil.get(pageContext, "party.lookup.lookupResults")%>
</h3>
<BR>
	
	<display:table id="aListItem" name="lookUpList" sort="list" 
			requestURI="<%=requestUri%>" pagesize="20">
			<%
				gnomon.hibernate.model.views.ViewResult listItem = (gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("aListItem");
			%>

		 		<display:column class="gamma1" ><input type="radio" name="selectedPartyId" 
		 			value='<%=listItem.getMainid().toString()+"&"+listItem.getField1().toString()%>'></display:column>
	 		
			<% 	if (columnProperties != null && columnTitles != null && columnProperties.size() > 0 &&
					columnProperties.size() == columnTitles.size()) {
					for (int i = 0; i < columnProperties.size(); i++){
						String colPropName = (String)columnProperties.get(i);
						String colTitle = (String)columnTitles.get(i);
						
						Object prop = CommonUtil.getProperty(listItem, colPropName);
			%>
				<% if (prop != null && !(prop instanceof Boolean)){%>
				<display:column class="gamma1"  property="<%= colPropName%>" titleKey="<%=colTitle%>" sortable="true" headerClass="sortable"/>
				<%}else{%>
				<display:column titleKey="<%=colTitle%>" sortable="true" headerClass="sortable">
			 		<input type="checkbox" <%= (((Boolean)prop).booleanValue()) ? "checked" : ""%> disabled>
			 	</display:column>
				<%}%>
			<%  	}
				}
			%>
	</display:table>
	<%}%>
	<BR>
	<% if (lookUpList != null && lookUpList.size() > 0) {%>
	<input type="button" class="portlet-form-button" name="Select" value="<%= LanguageUtil.get(pageContext, "party.lookup.button.select")%>" onclick="onSelect('LookupForm', 'selectedPartyId')">
	<% } // lookUpList%>
	<input type="button" class="portlet-form-button" name="Clear" value="<%= LanguageUtil.get(pageContext, "party.lookup.button.clearLookup")%>" onclick="onClear()">
</form>	
</TD></TR>
</TABLE>
<BR>



<%
} catch(Exception ex){
	ex.printStackTrace();
}
%>

