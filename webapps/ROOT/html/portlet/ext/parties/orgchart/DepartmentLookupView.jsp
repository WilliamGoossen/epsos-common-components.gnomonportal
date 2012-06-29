<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="com.ext.portlet.parties.orgchart.DepartmentLookupAction" %>

<%
try{
	// Lookup related parameters
	String lookupFieldIdHtmlId = request.getParameter("lookupFieldIdHtmlId");
	String lookupFieldDisplHtmlId = request.getParameter("lookupFieldDisplHtmlId");
	String openerFormName = request.getParameter("openerFormName");

	List lookUpList = (List)request.getAttribute(DepartmentLookupAction.ATTR_DEPARTMENTS_LIST);
	String selectedDepId = (String)request.getAttribute(DepartmentLookupAction.PAR_SELECTED_DEPARTMENT_ID);
	String rootDepId = (String)request.getAttribute(DepartmentLookupAction.PAR_ROOT_DEPARTMENT_ID);
	String parentDepId = (String)request.getAttribute(DepartmentLookupAction.PAR_PARENT_DEPARTMENT_ID);
	String parentDepName = (String)request.getAttribute(DepartmentLookupAction.PAR_PARENT_DEPARTMENT_NAME);
	//String grandFatherDepId = (String)request.getAttribute(DepartmentLookupAction.PAR_GRAND_FATHER_DEPARTMENT_ID);
	
	String orgNameTitleKey = "parties.orgchart.departmentLookup.orgName";
	
	if (rootDepId != null) {
		orgNameTitleKey = "parties.orgchart.departmentLookup.depName";
	}
%>


<%@ include file="/html/portlet/ext/struts_includes/Lookup_js.jsp" %>
<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>


<form name="LookupForm" action="/some/url"  method="post" enctype="multipart/form-data">

<display:table id="aListItem" name="<%=DepartmentLookupAction.ATTR_DEPARTMENTS_LIST%>">
	<%
	gnomon.hibernate.model.views.ViewResult listItem = (gnomon.hibernate.model.views.ViewResult)pageContext.getAttribute("aListItem");
	Integer mainid = null;
	String name = "";
	if (listItem != null) {
		mainid = listItem.getMainid();
		name = (String)listItem.getField1();
	}
	%>
	
	<display:column ><input type="radio" name="selectedObject"  value='<%=mainid.toString() + "&&" + name%>'>
	</display:column>
	
	<display:column titleKey="<%=orgNameTitleKey%>">
			<a href="<liferay-portlet:actionURL >
				<liferay-portlet:param name='struts_action' value='/ext/parties/browser/departmentLookupAction' />
				<%if (rootDepId != null) {%>
					<liferay-portlet:param name='<%= DepartmentLookupAction.PAR_ROOT_DEPARTMENT_ID %>' value='<%= rootDepId %>' />
				<%}else{%>
					<liferay-portlet:param name='<%= DepartmentLookupAction.PAR_ROOT_DEPARTMENT_ID %>' value='<%= listItem.getMainid().toString() %>' />
				<%}%>
				<liferay-portlet:param name='<%=DepartmentLookupAction.PAR_SELECTED_DEPARTMENT_ID%>' value='<%=listItem.getMainid().toString()%>' />
				<%if (lookupFieldIdHtmlId != null) {%><liferay-portlet:param name='lookupFieldIdHtmlId' value='<%=lookupFieldIdHtmlId%>' /><%}%>
				<%if (lookupFieldDisplHtmlId != null) {%><liferay-portlet:param name='lookupFieldDisplHtmlId' value='<%=lookupFieldDisplHtmlId%>' /><%}%>
				<%if (openerFormName != null) {%><liferay-portlet:param name='openerFormName' value='<%=openerFormName%>' /><%}%>
		</liferay-portlet:actionURL>"> 
				<%=listItem.getField1()%> </a>
	</display:column>
</display:table>
</form>
<BR>
<BR>
<% if (lookUpList != null && lookUpList.size() > 0) {%>	
	<input type="button" class="portlet-form-button" name="Select" value="<%= LanguageUtil.get(pageContext, "parties.orgchart.departmentLookup.select")%>" onclick="onSelectSeparator('LookupForm', 'selectedObject', '&&')">
	<% } // lookUpList%>
	<input type="button" class="portlet-form-button" name="Clear" value="<%= LanguageUtil.get(pageContext, "parties.orgchart.departmentLookup.clear")%>" onclick="onClear()">	
<BR>

<%
if (rootDepId != null) {

String titleOfBackLink = "parties.orgchart.departmentLookup.back";

Hashtable params = new Hashtable();

if (lookupFieldIdHtmlId != null && !lookupFieldIdHtmlId.equals("")) params.put("lookupFieldIdHtmlId", lookupFieldIdHtmlId);
if (lookupFieldDisplHtmlId != null && !lookupFieldDisplHtmlId.equals("")) params.put("lookupFieldDisplHtmlId", lookupFieldDisplHtmlId);
if (openerFormName != null && !openerFormName.equals("")) params.put("openerFormName", openerFormName);

if (selectedDepId != null && !selectedDepId.equals(rootDepId)) params.put(DepartmentLookupAction.PAR_ROOT_DEPARTMENT_ID, rootDepId);
if (parentDepId != null) {
	params.put(DepartmentLookupAction.PAR_SELECTED_DEPARTMENT_ID, parentDepId);
	titleOfBackLink = parentDepName;
}
				
request.setAttribute("backParams", params);
%>

<html:link styleClass="beta1" page="/ext/parties/browser/departmentLookupAction" name="backParams">
	<img src="<%=themeDisplay.getPathThemeImage()%>/common/back.gif" border="0" align="absmiddle">&nbsp;
	<%= titleOfBackLink %>
</html:link>


<%} // if (rootDepId != null) %>




<%}catch(Exception ex){
ex.printStackTrace();
}%>
