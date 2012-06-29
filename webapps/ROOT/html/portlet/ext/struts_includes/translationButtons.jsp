<%@ include file="/html/common/init.jsp" %>

<tiles:useAttribute id="editAction" name="editAction" classname="java.lang.String"/>
<tiles:useAttribute id="editParam" name="editActionParam" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="editParamValue" name="editActionParamValue" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="editParamList" name="editActionParamList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="editParamValueList" name="editActionParamValueList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="addAction" name="addAction" classname="java.lang.String"/>
<tiles:useAttribute id="addParam" name="addActionParam" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="addParamValue" name="addActionParamValue" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="addParamList" name="addActionParamList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="addParamValueList" name="addActionParamValueList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="tilesActionPermission" name="actionPermission" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesPortletId" name="portletId" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="cssClass" name="cssClass" classname="java.lang.String" ignore="true"/>

<%
cssClass = (cssClass == null) ? "portlet-form-button" : cssClass;
String redirect = request.getParameter("redirect");

List editLangsList=(List) request.getAttribute("editLangsList");
List addLangsList=(List) request.getAttribute("addLangsList");

	boolean permissionsCleared = true;
	if (tilesActionPermission != null)
    {
       /*
	   if (!PermissionUtil.userHasAction(user, tilesActionPermission, tilesPortletId))
	   {
	   		permissionsCleared = false;
	   }
	   */
	   if (!PortletPermissionUtil.contains(permissionChecker, plid, tilesPortletId, tilesActionPermission))
	   {
	   		permissionsCleared = false;
	   }
    }
    if (permissionsCleared)
    {
%>
<table>
<logic:notEmpty name="editLangsList">
<tr>
	<form name="<portlet:namespace/>editTranslationButtonsForm" action="/some/url" method="post">
	<td align=right>
		<select name="editLangSelect" class="gamma1-FormArea">
		<logic:iterate id="element" name="editLangsList" scope="request">
			<option class="gamma1-FormText" name="<%= element %>"><%= element %></option>
		</logic:iterate>
		</select>
	</td>
	<td align=left>
	<script>
	function <portlet:namespace/>clickEditButton()
	{
    var languageKey = "TRANSLATIONLANGUAGEKEYHERE";
    var selectedOption = document.<portlet:namespace/>editTranslationButtonsForm.editLangSelect.options[document.<portlet:namespace/>editTranslationButtonsForm.editLangSelect.selectedIndex].text;
	document.<portlet:namespace/>editTranslationButtonsForm.action =
	'<portlet:actionURL><portlet:param name="struts_action" value ="<%= editAction %>" />' +
	<% if (editParam != null && editParamValue != null) { %>
	'<portlet:param name="<%= editParam %>" value="<%= editParamValue %>" />'+
	<% } %>
	<% if(Validator.isNotNull(redirect)) { %>
	'<portlet:param name="redirect" value="<%= redirect %>" />' +
	<% } %>
	'<portlet:param name="lang" value="TRANSLATIONLANGUAGEKEYHERE" />';
	
	<% if (editParamList != null) {
		for (int i=0; i<editParamList.size(); i++)
		{ %>
		document.<portlet:namespace/>editTranslationButtonsForm.action = document.<portlet:namespace/>editTranslationButtonsForm.action +
				'<portlet:param name="<%= editParamList.get(i).toString() %>" value="<%= editParamValueList.get(i).toString() %>" />';
		<% } }
	%>
	<% if (request.getParameter("mainid") != null) { %>
	   document.<portlet:namespace/>editTranslationButtonsForm.action = document.<portlet:namespace/>editTranslationButtonsForm.action +
		'<portlet:param name="mainid" value="<%= request.getParameter("mainid") %>" />';
	<% } %>
	document.<portlet:namespace/>editTranslationButtonsForm.action = document.<portlet:namespace/>editTranslationButtonsForm.action + '</portlet:actionURL>';
	var actionString = document.<portlet:namespace/>editTranslationButtonsForm.action;
	actionString = actionString.replace(languageKey, selectedOption);
	document.<portlet:namespace/>editTranslationButtonsForm.action = actionString;
	submitForm(document.<portlet:namespace/>editTranslationButtonsForm);
	}
	</script>
	<input type="button" name="<portlet:namespace/>editLangsButton" value="Edit Translation" onClick="<portlet:namespace/>clickEditButton();" class="<%=cssClass%>">
	</td>
	</form>
</tr>
</logic:notEmpty>

<tr>
	<td></td>
</tr>

<logic:notEmpty name="addLangsList">
<tr>
	<form name="<portlet:namespace/>addTranslationButtonsForm" action="/some/url" method="post">
	<td align=right>
		<select name="addLangSelect" class="gamma1-FormArea">
		<logic:iterate id="element" name="addLangsList" scope="request">
			<option class="gamma1-FormText" name="<%= element %>"><%= element %></option>
		</logic:iterate>
		</select>
	</td>
	<td align=left>
	<script>
	function <portlet:namespace/>clickAddButton()
	{
    var languageKey = "TRANSLATIONLANGUAGEKEYHERE";
    var selectedOption = document.<portlet:namespace/>addTranslationButtonsForm.addLangSelect.options[document.<portlet:namespace/>addTranslationButtonsForm.addLangSelect.selectedIndex].text;
	document.<portlet:namespace/>addTranslationButtonsForm.action =
	'<portlet:actionURL><portlet:param name="struts_action" value ="<%= addAction %>" />' +
	<% if (addParam != null && addParamValue != null) { %>
	'<portlet:param name="<%= addParam %>" value="<%= addParamValue %>" />'+
	<% } %>
	<% if(Validator.isNotNull(redirect)) { %>
	'<portlet:param name="redirect" value="<%= redirect %>" />' +
	<% } %>
	'<portlet:param name="lang" value="TRANSLATIONLANGUAGEKEYHERE" />';

	<% if (addParamList != null) {
		for (int i=0; i<addParamList.size(); i++)
		{ %>
		document.<portlet:namespace/>addTranslationButtonsForm.action = document.<portlet:namespace/>addTranslationButtonsForm.action +
				'<portlet:param name="<%= addParamList.get(i).toString() %>" value="<%= addParamValueList.get(i).toString() %>" />';
		<% } }
	%>
	<% if (request.getParameter("mainid") != null) { %>
	   document.<portlet:namespace/>addTranslationButtonsForm.action = document.<portlet:namespace/>addTranslationButtonsForm.action +
		'<portlet:param name="mainid" value="<%= request.getParameter("mainid") %>" />';
	<% } %>
	document.<portlet:namespace/>addTranslationButtonsForm.action = document.<portlet:namespace/>addTranslationButtonsForm.action + '</portlet:actionURL>';
	var actionString = document.<portlet:namespace/>addTranslationButtonsForm.action;
	actionString = actionString.replace(languageKey, selectedOption);
	document.<portlet:namespace/>addTranslationButtonsForm.action = actionString;
	submitForm(document.<portlet:namespace/>addTranslationButtonsForm);
	}
	</script>
	<input type="button" name="<portlet:namespace/>addLangsButton" value="Add Translation" onClick="<portlet:namespace/>clickAddButton();" class="<%=cssClass%>">
	</td>
	</form>
</tr>
</logic:notEmpty>
</table>

<%
	} // end if (permissionsCleared)
%>