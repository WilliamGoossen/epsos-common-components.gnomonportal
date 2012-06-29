<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="org.displaytag.util.ParamEncoder"%>

<h3 nowrap class="title1">
<%= LanguageUtil.get(pageContext, "parties.browser.listTitle") %>
</h3>
<BR>
<tiles:insert page="/html/portlet/ext/parties/browser/BusinessLogicMessagesTile.jsp" flush="true">
  <tiles:put name="propName"><%= Definitions.BUSINESS_LOGIC_ERROR_MESSAGE %></tiles:put>
</tiles:insert>
<BR>

<% try { 
%>
<table width="100%"  >

<tr>
<td valign="top">
<TABLE width="100%" >
<TR><TD class="title2">
<%= LanguageUtil.get(pageContext, "parties.browser.searchFormTitle")%>
</TD></TR>
</TABLE>
<BR>
<%
Vector fields=null;
String curFormName= "PartiesSearchForm";
%>

<html:form action="/ext/parties/browser/parties_list?actionURL=true" method="post">
	<input type="hidden" name="<%= Definitions.REQ_LOAD_ACTION%>" value="<%=Definitions.LD_ACTION_SEARCH%>">
	
	<table width="100%"  border="0" cellspacing="1" cellpadding="1">
  	<tr>
    	<td width="60%">
    	<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
			<tiles:put name="formName"><%= curFormName %></tiles:put>
		</tiles:insert></td>
		
  		<td width="40%"><html:submit styleClass="portlet-form-button"> <%= LanguageUtil.get(pageContext, "parties.button.search") %></html:submit></td>
	</tr>
</table>
</html:form>

<BR>

</td>
<td valign="top">

<form name="PA_PARTIES_BROWSER_PartiesActions_Form" method="post" action="/some/url">
<table><tr>
<td>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <tiles:put name="action" value="/ext/parties/browser/party_newPerson_load"/>
  <tiles:put name="buttonName" value="PartiesNewPersonButton" />
  <tiles:put name="buttonValue" value="parties.browser.addPerson" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_PartiesActions_Form" />
  <tiles:put name="portletId" value="PA_PARTIES_BROWSER"/>
  <tiles:put name="actionPermission" value="edit"/>
</tiles:insert>
</td></tr>
<tr><td>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="actionType"  value="linkAction" />
  <tiles:put name="action" value="/ext/parties/browser/party_newOrganization_load"/>
  <tiles:put name="buttonName" value="PartiesNewOrgButton" />
  <tiles:put name="buttonValue" value="parties.browser.addOrganization" />
  <tiles:put name="formName"   value="PA_PARTIES_BROWSER_PartiesActions_Form" />
  <tiles:put name="portletId" value="PA_PARTIES_BROWSER"/>
  <tiles:put name="actionPermission" value="edit"/>
</tiles:insert>
</td></tr>

</table>


</form>

</td>
</tr>
</table>

<%

List partiesList=(List)request.getAttribute(Definitions.PARTIES_LIST);
String loadAction = request.getParameter(Definitions.REQ_LOAD_ACTION);
%>


<BR>


<% if (loadAction != null) {%>

<table  style="border:0px solid black" width="100%">
<tr><td class="title2">
<h3 nowrap>
<%= LanguageUtil.get(pageContext, "parties.browser.searchResults") %>
</h3>
</tr></td>
<tr><td>
<form name="PA_PARTIES_BROWSER_PartiesList_Form" method="post" action="/some/url">

<%
ParamEncoder param_encoder = new ParamEncoder("partiesList");
String pencoded=param_encoder.encodeParameterName("p");
String pageNumStr = request.getParameter(pencoded);

int pageSize = 20;
int pageNum = 1;
int rowNum = 0;
if (pageNumStr != null) pageNum = new Integer(pageNumStr).intValue();

boolean fastAndWrongFlag = false;

%>
<display:table id="parties" name="partiesList" sort="list" 
	requestURI="//ext/parties/browser/parties_list?actionURL=true" pagesize="20" excludedParams="struts_action">
	<%
		gnomon.hibernate.model.views.ViewResult listItem = (gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("parties");		
		boolean isPerson = true;
		String strutsActionUrl = "";
		try{
			if (listItem != null){
					isPerson = (listItem.getField2() != null) ? ((Boolean)listItem.getField2()).booleanValue() : false;
			}
		}catch(Exception ex){}
		
		if (isPerson) {
			strutsActionUrl = "/ext/parties/browser/person_load";
		}else{
			strutsActionUrl = "/ext/parties/browser/organization_load";
		}
	%>
 		
 	<display:column>
 	<% if (isPerson){%>
 	<img src=/html/themes/gn/images/orgchart/person.gif>
 	<%}else{%>
 	<img src=/html/themes/gn/images/orgchart/department.gif>
 	<%}%>
 	</display:column>
 	
	<display:column class="gamma1"  titleKey="parties.browser.name" sortable="true" headerClass="sortable">
		<a id="<%=listItem.getMainid().toString() %>_ID" href="
			<portlet:actionURL>
				<portlet:param name='struts_action'
					value='<%= strutsActionUrl%>' />
				<portlet:param name='<%= Definitions.REQ_LOAD_ACTION %>'
					value='<%= Definitions.LD_ACTION_VIEW%>' />
				<portlet:param name='<%= Definitions.SELECTED_MAIN_ID %>'
					value='<%= listItem.getMainid().toString()%>' />
			</portlet:actionURL>
			"><%=listItem.getField1()%></a>
	</display:column>
</display:table>


</form>
</td></tr>
</table>
<%} // loadAction%>

<%
}catch(Exception ex){
	ex.printStackTrace();
}
%>
