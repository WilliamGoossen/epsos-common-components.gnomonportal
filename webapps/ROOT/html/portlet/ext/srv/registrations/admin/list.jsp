<%@ include file="/html/portlet/ext/srv/registrations/admin/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<h2  ><%= LanguageUtil.get(pageContext, "srv.adminregistrations.list") %></h2>
<!-- Events List -->


<%
String searchItem = ParamUtil.getString(request, "searchItem");
String fullName = ParamUtil.getString(request, "fullName");
String serviceName = ParamUtil.getString(request, "serviceName");
String registrationId = ParamUtil.getString(request, "registrationId");
%>
<form name="SRV_ServicesAdminRegistration_ButtonForm" action="<liferay-portlet:actionURL > <liferay-portlet:param name="struts_action" value="/ext/srv_adminregistrations/list"/></liferay-portlet:actionURL>" method="post" class="uni-form" >
<br>
<%
String[] statusTransArr = new String[]{
		LanguageUtil.get(pageContext,"srv.registrations.new"),
		LanguageUtil.get(pageContext,"srv.registrations.approved"),
		LanguageUtil.get(pageContext,"srv.registrations.rejected")
};
%>
<div class="inline-labels">

<div class="ctrl-holder">
<label >
<%= LanguageUtil.get(pageContext, "srv.resgSearchForm.status") %>
</label>
<select name="searchItem">
<option value=""> <%=LanguageUtil.get(pageContext,"all")%>
<option value="0" <%= (searchItem.equals("0")) ? " selected " : "" %>> <%=statusTransArr[0]%>
<option value="1" <%= (searchItem.equals("1")) ? " selected " : "" %>> <%=statusTransArr[1]%>
<option value="2" <%= (searchItem.equals("2")) ? " selected " : "" %>> <%=statusTransArr[2]%>
</select>
</div>

<div class="ctrl-holder">
<label >
<%=LanguageUtil.get(pageContext,"srv.resgSearchForm.userFullName")%> 
</label>
<input type="text" name="fullName" value="<%=fullName %>">
</div>

<div class="ctrl-holder">
<label >
<%=LanguageUtil.get(pageContext,"srv.resgSearchForm.serviceName")%> 
</label>
<input type="text" name="serviceName" value="<%=serviceName %>">
</div>

<div class="ctrl-holder">
<label >
<%=LanguageUtil.get(pageContext,"srv.resgSearchForm.registrationId")%> 
</label>
<input type="text" name="registrationId" value="<%=registrationId %>">
</div>


<div class="button-holder">
<input type="submit" value="<%=LanguageUtil.get(pageContext, "srv.resgSearchForm.search") %>">
</div>

<display:table id="service" name="serviceRegistrations" requestURI="//ext/srv_adminregistrations/list?actionURL=true" pagesize="20" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">


<% 
gnomon.hibernate.model.views.ViewResult gnItem = (gnomon.hibernate.model.views.ViewResult) pageContext.getAttribute("service"); 
Integer statusInt = null;
String statusTrans = "";
if (gnItem != null) {
	statusInt = (Integer)gnItem.getField4();
	statusTrans = statusTransArr[statusInt.intValue()];
	
}
%>

<display:column property="field5" titleKey="srv.registrations.date" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
<display:column titleKey="srv.registrations.status" sortable="true" sortProperty="field4">
<%=statusTrans %>
</display:column>
<display:column property="field1" titleKey="srv.registrations.name" sortable="true" />
<display:column property="field2" titleKey="srv.registrations.registeredIdentifier" sortable="true" />
<display:column  titleKey="srv.userFullName" sortable="true" >
<% try { %>
<%=UserLocalServiceUtil.getUserById((Long)gnItem.getField3()).getFullName()%>
<% } 
catch (Exception e) {}
%>

</display:column>
<% if (PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT)) { %>
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:<portlet:namespace/>actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>
<div id="browse:<portlet:namespace/>actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/srv_adminregistrations/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="edit"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
		</td>
		<td>
			<a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/srv_adminregistrations/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="delete"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
			</a>
		</td>
	</tr>

	</tbody>
	</table>
</div>
</display:column>
<% } %>

</display:table>


</form>
