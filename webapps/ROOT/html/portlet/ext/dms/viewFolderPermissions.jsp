<%@ include file="/html/portlet/ext/dms/init.jsp" %>
<div id="<portlet:namespace />dms">
<%
ArrayList alfrescodata = (ArrayList)request.getAttribute("contentPermissions");
ArrayList alfrescoroles = com.ext.portlet.dms.util.AlfrescoContentUtil.getContentRoles();
List users = (List)request.getAttribute("users");
request.setAttribute("alfrescodata",alfrescodata);
String parentuuid = request.getParameter("parentuuid");
uuid = request.getParameter("uuid");
String filename=ParamUtil.getString(request,"filename");
String foldername=ParamUtil.getString(request,"foldername");
String contenttype="folder";//ParamUtil.getString(request,"contenttype");
org.alfresco.webservice.util.AuthenticationDetails details=(org.alfresco.webservice.util.AuthenticationDetails)request.getSession().getAttribute("authdetails");
%>
<script>
function breadcrumb(url)
{
AjaxUtil.update2(unescape(url), "<portlet:namespace />dms");
}
</script>
<liferay-portlet:actionURL portletConfiguration="false" varImpl="portletURL" />
<liferay-portlet:renderURL portletConfiguration="false" varImpl="portletURL1" />
<% String breadcrumbs = AlfrescoContentUtil.createBreadcrumb(details,request.getParameter("uuid"),(com.liferay.portlet.PortletURLImpl)portletURL1,instanceUuid); %>

<c:if test="<%=(alfrescodata!=null) && (alfrescodata.size()>0)%>">
	<%= LanguageUtil.get(pageContext, "dms.current-permissions.folder") %>: <%= breadcrumbs %><br/><br/>
	<display:table name="${alfrescodata}" id="ad" defaultsort="1" defaultorder="descending">
		<%
		com.ext.portlet.dms.util.AlfrescoPermission ar = (com.ext.portlet.dms.util.AlfrescoPermission)pageContext.getAttribute("ad");
		%>
			<portlet:actionURL var="url1">
				<portlet:param name="struts_action" value="/ext/dms/deletePermissions" />
				<portlet:param name="user" value="<%= ar.getAuthority()%>" />
				<portlet:param name="role" value="<%=ar.getPermission()%>" />
				<portlet:param name="parentuuid" value="<%=parentuuid%>" />
				<portlet:param name="filename" value="<%=filename%>" />
				<portlet:param name="foldername" value="<%=foldername%>" />
				<portlet:param name="contenttype" value="<%=contenttype%>" />
				<portlet:param name="uuid" value="<%=uuid%>" />
				<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
			</portlet:actionURL>

		<display:column title="Fullname"><%=ar.getFullname()%></display:column>
		<display:column title="Role"><%=ar.getPermission()%></display:column>
		<display:column><a href="<%=url1%>"><img align="left" border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/icons/delete_person.gif"></a></display:column>
	</display:table>
	<br/>
</c:if>


<portlet:actionURL var="inhPermissionsURL">
	<portlet:param name="struts_action" value="/ext/dms/inheritPermissions" />
	<portlet:param name="uuid" value="<%= request.getParameter("uuid") %>" />
	<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
	<portlet:param name="contenttype" value="<%=contenttype%>" />
	<portlet:param name="inheritPermissions" value="<%= request.getAttribute("inheritPermissions").toString() %>" />
</portlet:actionURL>

<%
String inheritPermissions = request.getAttribute("inheritPermissions").toString();
String inheritableJS = "javascript: document.forms['" + renderResponse.getNamespace() + "inheritpermissionsform'].submit(); void(0);";
%>


<%= LanguageUtil.get(pageContext, (inheritPermissions.equals("true")?"dms.permission-inheritance-is-enabled":"dms.permission-inheritance-is-disabled")) %>.<br/>
<%= LanguageUtil.get(pageContext, "dms.you-can") %>

<a href="<%=inheritableJS%>"><%= LanguageUtil.get(pageContext, (inheritPermissions.equals("true")?"dms.disable-inheritance":"dms.enable-inheritance")) %></a>
<div id="<portlet:namespace />inheritDiv" style="display: <%="none"%>; padding-top:10px;">
	<form name="<portlet:namespace />inheritpermissionsform" action="<%= inhPermissionsURL%>" method="post">
		<input type="hidden" value="<%= request.getParameter("filename")%>" name="filename">
		<input type="hidden" value="<%= parentuuid%>" name="parentuuid">
		<input type="hidden" value="<%= uuid%>" name="uuid">
		<input type="hidden" value="<%= foldername%>" name="foldername">
		<input type="hidden" value="<%= contenttype%>" name="contenttype">
		<input type="checkbox" name="inheritpermissionscb" <%=inheritPermissions.equals("true")?"":"checked"%>><%= LanguageUtil.get(pageContext, "dms.inheritpermissions") %>
		<input type="submit" value="<%= LanguageUtil.get(pageContext, "dms.setinheritpermissions") %>">
	</form>
</div>


<portlet:actionURL var="setPermissionsURL">
	<portlet:param name="struts_action" value="/ext/dms/setPermissions" />
	<portlet:param name="uuid" value="<%= uuid %>" />
	<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
	<portlet:param name="contenttype" value="<%=contenttype%>" />
</portlet:actionURL>

<%
String permissionsJS = "javascript: toggleById('" + renderResponse.getNamespace() + "permissionsDiv" + "',true); self.focus(); void(0);";
%>

<%= LanguageUtil.get(pageContext, "dms.or") %> <a href="<%=permissionsJS%>"><%= LanguageUtil.get(pageContext, "dms.definepermissions") %></a>
<div id="<portlet:namespace />permissionsDiv" style="display: <%="none"%>; padding-top:10px;">
	<form action="<%= setPermissionsURL%>" method="post" name="TmpForm">
	<input type="hidden" value="<%= request.getParameter("filename")%>" name="filename">
	<input type="hidden" value="<%= parentuuid%>" name="parentuuid">
	<input type="hidden" value="<%= uuid%>" name="uuid">
	<input type="hidden" value="<%= foldername%>" name="foldername">
	<input type="hidden" value="<%= contenttype%>" name="contenttype">
	<table>
	<tr>
		<td>
		<%= LanguageUtil.get(pageContext, "dms.selectusers") %>
		</td>
	</tr>
<%--
	<tr>
	<td>
		<%= FormFieldsRenderer.renderActionModalLookupField("TmpForm",
                "selectedPartyId", null, false, "/ext/eproject/commonLookup/employees_lookupPortletAction",
                new String[]{Definitions.LOOKUP_PERSON_ROLES}, new String[]{Definitions.C_FALSE},
                null, "", "", "PRJ_COMMON_LOOKUP_ACTIONS", request) %>
	</td>
	</tr>
--%>
	<tr>
		<td>
		<select name="users" MULTIPLE SIZE=6>
			<% for (int i=0; i<users.size(); i++)
					{
					String alfresco_useridtype=PropsUtil.get("alfresco.useridtype");
					String useroption="";
					com.liferay.portal.model.impl.UserImpl user1 = (com.liferay.portal.model.impl.UserImpl)users.get(i);
//					if (alfresco_useridtype.equals("userid"))
//					{
//					useroption=user1.getUserId()+"";
//					}
//					else
//					{
//					useroption=user1.getLogin();
//					}
					useroption = gnomon.business.SynchronizeAccountUtil.getInstance().getAlfrescoLogin(alfresco_useridtype,user1.getLogin(),user1.getCompanyId()+"");
					%>
					<option value="<%= useroption%>"><%= user1.getFullName() %></option>
				<% } %>
		</select>
		</td>
	</tr>

	<tr>
		<td>
		<%= LanguageUtil.get(pageContext, "dms.role") %>
		</td>
	<tr>
		<td>
		<select name="role">
			<% for (int i=0; i<alfrescoroles.size(); i++) {	%>
				<option value="<%=alfrescoroles.get(i).toString() %>"><%= LanguageUtil.get(pageContext, alfrescoroles.get(i).toString()) %></option>
			<% } %>
		</select>
		</td>
	</tr>
	<tr>
		<td>
		<input type="submit" value="<%= LanguageUtil.get(pageContext, "dms.setpermissions") %>">
		</td>
	</tr>
	</table>
	</form>
</div>
</div>