<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<script language="JavaScript">
function <portlet:namespace/>chooseAdminTypeAction()
{
	var languageKey = "TYPESELECTIONKEYHERE";
	var selectedOption = document.Parties_Admin_Select_Form.typeList.options[document.Parties_Admin_Select_Form.typeList.selectedIndex].value;
	var actionString = '<portlet:renderURL><portlet:param name="struts_action" value ="/ext/parties/admin/viewTYPESELECTIONKEYHERE" /></portlet:renderURL>';
	actionString = actionString.replace(languageKey, selectedOption);
	document.Parties_Admin_Select_Form.action = actionString;
	return true;
}
</script>
<form name="Parties_Admin_Select_Form" method="post" action="/some/url" onSubmit="return <portlet:namespace/>chooseAdminTypeAction();">
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "parties.button.admin-go") %>"/>
<select name="typeList" class="gamma1-FormArea">
<option name="RoleTypes" value="RoleTypes" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.admin.options.partyroletypes") %></option>
<option name="RelTypes" value="RelTypes" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.admin.options.partyreltypes") %></option>
<option name="OrgTypes" value="OrgTypes" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.admin.options.organizationtypes") %></option>
<option name="Countries" value="Countries" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.admin.options.countries") %></option>
<option name="Portlets" value="Portlets" class="gamma1-FormText"><%= LanguageUtil.get(pageContext, "parties.admin.options.portlets") %></option>
</select>
</form>



