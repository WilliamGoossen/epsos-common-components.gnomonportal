<%@ include file="/html/common/init.jsp" %>

<tiles:useAttribute id="tilesAction" name="action" classname="java.lang.String"/>
<tiles:useAttribute id="tilesActionPortlet" name="actionPortlet" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesConfirm" name="confirm" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesName" name="buttonName" classname="java.lang.String" />
<tiles:useAttribute id="tilesValue" name="buttonValue" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesForm" name="formName" classname="java.lang.String" />
<tiles:useAttribute id="tilesParam" name="actionParam" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesParamValue" name="actionParamValue" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesActionPermission" name="actionPermission" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesPartyRoleActionPermission" name="partyRoleActionPermission" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesPortletId" name="portletId" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesParamList" name="actionParamList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="tilesParamValueList" name="actionParamValueList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="actionType" name="actionType" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="cssClass" name="cssClass" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="iconPath" name="iconPath" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="windowState" name="windowState" classname="java.lang.String" ignore="true"/>


<%/**
	Button accesibility is controlled by the actions defined in the Liferay Role or
	the party role. This is configured via the tile attributes 
		tilesActionPermission and tilesPartyRoleActionPermission
	If neither attribute is defined the button is accessible.
	If one of them is true, it is accessible regardless the status of the other attribute
	If only one is defined, then it controls the accessibility
*/

boolean managetopic=true;
String topicid="";
	String isTopicPermissions = GetterUtil.getString(PropsUtil.get("gn.topics.permissions"),"off");
int isTopics =0;
if(request.getAttribute("isTopics")!=null)
	isTopics= ((Integer) request.getAttribute("isTopics")).intValue();


//get topic id

if (tilesParamList != null) {
	   for (int i=0; i<tilesParamList.size(); i++)
	   { 
	   if(tilesParamList.get(i).toString().equals("topicid")) 
	   	topicid=tilesParamValueList.get(i).toString();
	    } }
	
	
	
	Boolean managetopics=(Boolean)request.getAttribute("managetopics");

if(managetopics!=null) {
	managetopic=managetopics.booleanValue();
}
else {
	
	
	if(isTopicPermissions.equals("on") && isTopics!=gnomon.hibernate.model.gn.GnPortletSetting.TOPICS_ENABLED_FALSE) {
	
	 if(topicid!=null && !topicid.equals("") && !com.ext.portlet.topics.service.permission.GnTopicPermission.contains(permissionChecker, new Integer(topicid), com.liferay.portal.kernel.security.permission.ActionExtKeys.MANAGECONTENT))
			managetopic=false;
			
	}

}

	boolean permissionsCleared = true;
	
	boolean rolePermissions = false;
	boolean partyRolePermissions = false;
	
	if (Validator.isNull(windowState)) windowState = WindowState.MAXIMIZED.toString();
	if (tilesParam == null) tilesParam = "";
	if (tilesParamValue == null) tilesParamValue = "";
	if (tilesActionPermission != null)
    {
       /*
	   if (!PermissionUtil.userHasAction(user, tilesActionPermission, tilesPortletId, company.getCompanyId()))
	   {
	   		permissionsCleared = false;
	   }else{
	   		rolePermissions = true;
	   }
	   */
	   if (!PortletPermissionUtil.contains(permissionChecker, plid, tilesPortletId, tilesActionPermission))
	   {
	   		permissionsCleared = false;
	   }else{
	   		rolePermissions = true;
	   }
    }
    
    if (tilesPartyRoleActionPermission != null)
    {
	   if (!PermissionUtil.userHasPartyRoleTypeAction(user, tilesPartyRoleActionPermission, tilesPortletId))
	   {
	   		permissionsCleared = false;
	   }else{
	   	partyRolePermissions = true;
	   }
    }
    
    if (tilesPartyRoleActionPermission == null && tilesActionPermission == null) {
		rolePermissions = true;
	 	partyRolePermissions = true;
    }
    
    permissionsCleared = rolePermissions || partyRolePermissions;
    
    permissionsCleared=permissionsCleared && managetopic;
	//permissionsCleared = true;
	
	%>

	
	<%
	
	
    if (permissionsCleared)
    {
 %>
<script language="JavaScript"  type="text/javascript">
function <portlet:namespace/>clickButton<%=tilesName%>()
{
	var replaceWithFormValueKey = "REPLACEWITHFORMVALUEKEYHERE";
	var jsConfirm = "<%=tilesConfirm%>";
	var jsTilesParamValue = "<%= tilesParamValue %>";
	var replaceWithFormValue = false;

	if (jsConfirm != null && jsConfirm != "null")
	{
		if (!confirm('<%= UnicodeLanguageUtil.get(pageContext, tilesConfirm) %>'))
			return;
	}

	if (isNaN(jsTilesParamValue) &&
	    document.<%= tilesForm %>.elements[jsTilesParamValue]) // if such an object exists in the form
	{
		replaceWithFormValue = true;
	}

    <% if (tilesActionPortlet == null) { %>

	document.<%= tilesForm %>.action = '<portlet:actionURL windowState="<%=windowState%>"><portlet:param name="struts_action" value ="<%= tilesAction %>" /><portlet:param name="<%= tilesParam %>" value="REPLACEWITHFORMVALUEKEYHERE" />';

	<% if (tilesParamList != null) {
	   for (int i=0; i<tilesParamList.size(); i++)
	   { %>
	   document.<%= tilesForm %>.action = document.<%= tilesForm %>.action = + '<portlet:param name="<%= tilesParamList.get(i).toString() %>" value="<%= tilesParamValueList.get(i).toString() %>" />';
	   <% } }
	%>
	document.<%= tilesForm %>.action = document.<%= tilesForm %>.action = + '</portlet:actionURL>';

	<% } else { %>

	document.<%= tilesForm %>.action = '<liferay:actionURL windowState="<%=windowState%> portletName="<%= tilesActionPortlet %>"><liferay:param name="struts_action" value ="<%= tilesAction %>" /><liferay:param name="<%= tilesParam %>" value="REPLACEWITHFORMVALUEKEYHERE" />';

	<% if (tilesParamList != null) {
	   for (int i=0; i<tilesParamList.size(); i++)
	   { %>
	   document.<%= tilesForm %>.action = document.<%= tilesForm %>.action = + '<liferay:param name="<%= tilesParamList.get(i).toString() %>" value="<%= tilesParamValueList.get(i).toString() %>" />';
	   <% } }
	%>
	document.<%= tilesForm %>.action = document.<%= tilesForm %>.action = + '</liferay:actionURL>';

	<% } %>

	var actionString = document.<%= tilesForm %>.action;
	if (replaceWithFormValue)
	{
		// need to find which one of the radio buttons or checkboxes (more than one) is checked
		var buttonList = document.<%= tilesForm %>.elements[jsTilesParamValue];
		var buttonValue = "";
		if (!buttonList.length)  // just a single row, no list of buttons
		{
			buttonValue = buttonList.value;
		}
		else  // find which radio button or checkbox was checked and use its value
		{
			buttonValue = "";
			for(var i=0; i<buttonList.length; i++)
			{
				if (buttonList[i].checked)
				{
					if (buttonValue.length > 0)
					{
						buttonValue += ","
					}
					buttonValue += buttonList[i].value;
				}

			}
			if (buttonValue.length == 0){ // this means end of list was reached, no button was selected
				return; // do nothing
			}
		}
		actionString = actionString.replace(replaceWithFormValueKey, buttonValue);
	}
	else
		actionString = actionString.replace(replaceWithFormValueKey, jsTilesParamValue);
	document.<%= tilesForm %>.action = actionString;

	try {
	    formOnSubmit();
	} catch (e) { }
	submitForm(document.<%=tilesForm%>);
}
</script>

<%

	if (actionType != null && actionType.equals("linkAction")) {
		cssClass = (cssClass == null) ? "gamma" : cssClass;
		if (iconPath == null || iconPath.equals("")) {%>
		&nbsp;
				<a id="<%= tilesName %>_ID" class="<%= cssClass %>" name="<%= tilesName %>" href="#" onClick="<portlet:namespace/>clickButton<%=tilesName%>();">
					<SPAN class="<%= cssClass %>"><%= LanguageUtil.get(pageContext, tilesValue)%></SPAN>
				</a>
	<%		} else {%>
		&nbsp;
				<a id="<%= tilesName %>_ID" name="<%= tilesName %>" href="#" onClick="<portlet:namespace/>clickButton<%=tilesName%>();">
					<img src="<%=iconPath%>">
					<% if (tilesValue!=null && !tilesValue.equals("")) { %>
						<%= LanguageUtil.get(pageContext, tilesValue)%>
					<% } %>
				</a>
	<%}%>


<% }else {
	cssClass = (cssClass == null) ? "portlet-form-button" : cssClass;
	if (iconPath == null || iconPath.equals("")) {%>
			<input alt="button" type="button" name="<%= tilesName %>" value="<%= LanguageUtil.get(pageContext, tilesValue) %>" onClick="<portlet:namespace/>clickButton<%=tilesName%>();" class="<%=cssClass%>"/>
		<%} else {%>
			<input src="<%=iconPath%>" type="image" alt="<%= LanguageUtil.get(pageContext, tilesValue) %>" name="<%= tilesName %>" value="<%= LanguageUtil.get(pageContext, tilesValue) %>" onClick="<portlet:namespace/>clickButton<%=tilesName%>();" class="<%=cssClass%>"/>
		<%}%>
<%}%>
<%
  } //end if (permissionsCleared)
%>