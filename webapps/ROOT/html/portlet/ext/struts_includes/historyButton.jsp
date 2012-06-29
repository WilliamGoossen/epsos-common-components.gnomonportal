<%@ include file="/html/common/init.jsp" %>

<tiles:useAttribute id="tilesName" name="buttonName" classname="java.lang.String" />
<tiles:useAttribute id="tilesForm" name="formName" classname="java.lang.String" />
<tiles:useAttribute id="tilesRelatedObjectId" name="relatedObjectId" classname="java.lang.String" />
<tiles:useAttribute id="tilesActionPermission" name="actionPermission" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesPartyRoleActionPermission" name="partyRoleActionPermission" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesPortletId" name="portletId" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesRelatedObject" name="relatedObject" classname="java.lang.String" />
<tiles:useAttribute id="tilesUserMatch" name="currentUserOnly" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesPopupWidth" name="popupWidth" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="tilesPopupHeight" name="popupHeight" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="cssClass" name="cssClass" classname="java.lang.String" ignore="true"/>

<%
	boolean permissionsCleared = true;
	if (tilesUserMatch == null) tilesUserMatch = "";
	if (tilesPopupWidth == null) tilesPopupWidth = "640";
	if (tilesPopupHeight == null) tilesPopupHeight = "480";

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
    if (tilesPartyRoleActionPermission != null)
    {
	   if (!PermissionUtil.userHasPartyRoleTypeAction(user, tilesPartyRoleActionPermission, tilesPortletId))
	   {
	   		permissionsCleared = false;
	   }
    }
    if (permissionsCleared)
    {
 %>
<script language="JavaScript"  type="text/javascript">
var <portlet:namespace/>popupClickWindow;

function <portlet:namespace/>clickHistoryButton<%=tilesName%>()
{
	var replaceWithFormValueKey = "REPLACEWITHFORMVALUEKEYHERE";
	var jsTilesRelatedObjectId = "<%= tilesRelatedObjectId %>";
	var replaceWithFormValue = false;
	if (isNaN(jsTilesRelatedObjectId) &&
	    document.<%= tilesForm %>.elements[jsTilesRelatedObjectId]) // if such an object exists in the form
	{
		replaceWithFormValue = true;
	}

	var actionString = '<liferay-portlet:renderURL portletName="PA_PARTIES_MANAGER"  windowState="<%= LiferayWindowState.POP_UP.toString() %>">
							<liferay-portlet:param name="struts_action" value="/ext/parties/manager/listEvents"/>
							<liferay-portlet:param name="relatedObjectId" value="REPLACEWITHFORMVALUEKEYHERE"/>
							<liferay-portlet:param name="relatedObject" value="<%= tilesRelatedObject %>"/>							
							<liferay-portlet:param name="userMatch" value="<%= tilesUserMatch %>"/>
							</liferay-portlet:renderURL>' ;


	if (replaceWithFormValue)
	{
		// need to find which one of the radio buttons is checked
		var buttonList = document.<%= tilesForm %>.elements[jsTilesRelatedObjectId];
		var buttonValue = "";
		if (!buttonList.length)  // just a single row, no list of radio buttons
		{
			buttonValue = buttonList.value;
		}
		else  // find which radio button was checked and use its value
		{
			for(var i=0; i<buttonList.length; i++)
			{
				if (buttonList[i].checked)
					break;
			}
			if (i == buttonList.length){ // this means end of list was reached, no button was selected
				return; // do nothing
			}
			buttonValue = buttonList[i].value;
		}
		actionString = actionString.replace(replaceWithFormValueKey, buttonValue);
	}
	else
		actionString = actionString.replace(replaceWithFormValueKey, jsTilesRelatedObjectId);

        if (<portlet:namespace/>popupClickWindow)
               <portlet:namespace/>popupClickWindow.close();

        <portlet:namespace/>popupClickWindow = window.open(actionString, "popup", "status=no,toolbar=no,resizable=yes,scrollbars=yes,width="+"<%= tilesPopupWidth %>"+",height="+"<%= tilesPopupHeight %>");
        <portlet:namespace/>popupClickWindow.focus();
}
</script><noscript></noscript>
<% cssClass = (cssClass == null) ? "portlet-form-button" : cssClass; %>


<input alt="<%= LanguageUtil.get(pageContext, "parties.events.button.list") %>" type="button" class="<%=cssClass%>" name="<%= tilesName %>" value="<%= LanguageUtil.get(pageContext, "parties.events.button.list") %>" onClick="<portlet:namespace/>clickHistoryButton<%=tilesName%>();"/>

<%
  } //end if (permissionsCleared)
%>

