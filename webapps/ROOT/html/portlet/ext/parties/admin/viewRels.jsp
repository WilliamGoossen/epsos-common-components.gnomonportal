<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>


<%
List relTypesList=(List) request.getAttribute("relTypesList");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.list.rel") %></h2>
<!-- Relationship Types List -->
<form name="Parties_Admin_Rel_Button_Form" method="post" action="/some/url">

<display:table id="rels" name="relTypesList" requestURI="//ext/parties/admin/viewRelTypes" pagesize="10" sort="list"  style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult relItem = (ViewResult) rels; %>
	
<display:column class="gamma1" property="field1" titleKey="parties.admin.partyrelationshiptype.name"
    			sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.partyrelationshiptype.description"/>
<display:column class="gamma1" property="field3" titleKey="parties.admin.partyrelationshiptype.clientrolename"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.partyrelationshiptype.supplierrolename"/>

<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:<portlet:namespace/>_actionsMenu_1_<%=relItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="middle" border="0"></a>
<br>
<div id="browse:<portlet:namespace/>_actionsMenu_1_<%=relItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
		</td>
		<td>
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/loadRelType"/>
				<portlet:param name="mainid" value="<%= relItem.getMainid().toString() %>"/>
				<portlet:param name="loadaction" value="view"/></portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "parties.button.edit") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
		</td>
		<td>
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/loadRelType"/>
				<portlet:param name="mainid" value="<%= relItem.getMainid().toString() %>"/>
				<portlet:param name="delete" value="<%= relItem.getMainid().toString() %>"/>
				</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "parties.button.delete") %>
			</a>
		</td>
	</tr>
	
	</tbody>
	</table>
</div>
</display:column>

</display:table>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/parties/admin/loadRelType" />
  <tiles:put name="buttonName" value="addButtonRel" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Admin_Rel_Button_Form" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
  <tiles:put name="partyRoleActionPermission" value="admin"/>
  <tiles:put name="actionPermission" value="admin"/>
  <tiles:put name="portletId" value="PA_PARTIES_ADMIN"/>
</tiles:insert>


</form>
<br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/viewTypes"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.back-to-admin") %></html:link></TD>
</TR></TABLE>