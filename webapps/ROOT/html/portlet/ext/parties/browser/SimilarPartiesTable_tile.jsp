<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.browser.Definitions" %>
<%@ page import="gnomon.hibernate.PartiesService" %>

<tiles:useAttribute id="actionUrl" name="actionUrl" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="listAttrName" name="listAttrName" classname="java.lang.String" />
<tiles:useAttribute id="excludedParams" name="excludedParams" classname="java.lang.String" ignore="true"/>

<%
try{
	actionUrl = (actionUrl == null) ? "//ext/parties/browser/party_newOrganization_load?actionURL=true": actionUrl;
	listAttrName = (listAttrName == null) ? "partiesList" : listAttrName;
	
	excludedParams = (excludedParams == null) ? "" : excludedParams;
%>
<display:table id="<%= listAttrName%>" name="<%= listAttrName%>" sort="list" 
	defaultsort="1"
	requestURI="<%= actionUrl%>" pagesize="10" excludedParams="<%=excludedParams%>" >
	<%
		gnomon.hibernate.model.views.ViewResult listItem = (gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute(listAttrName);
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
 	<img src="<%= _parties_imgPath %>/orgchart/person.gif">
 	<%}else{%>
 	<img src="<%= _parties_imgPath %>/orgchart/department.gif">
 	<%}%>
 	</display:column>
 	
	<display:column class="gamma1"  titleKey="parties.browser.name" sortable="true" headerClass="sortable">
			<a id="ID_SIM_PERS_<%=listItem.getMainid().toString()%>" 
				href="" onclick="openDialog('<portlet:renderURL  windowState='<%=LiferayWindowState.POP_UP.toString()%>'>
				<portlet:param name='struts_action'
					value='<%= strutsActionUrl %>' />
				<portlet:param name='<%= Definitions.REQ_LOAD_ACTION %>'
					value='<%= Definitions.LD_ACTION_VIEW%>' />
				<portlet:param name='<%= Definitions.SELECTED_MAIN_ID %>'
					value='<%= listItem.getMainid().toString()%>' />
			</portlet:renderURL>', 600, 400);return false;">
			<%=listItem.getField1()%>			
			</a>

	</display:column>
</display:table>

<%
} catch(Exception ex){
	ex.printStackTrace();
}
%>
<BR>

