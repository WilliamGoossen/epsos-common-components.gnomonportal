<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>


<% try { %>
<%
String partyroletypeid = titleData.getValue("partyroletypeid").toString();
List featureTypesList=(List) request.getAttribute("featureTypesList");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.list.feature.types") %></h2>
<!-- FeatureType List -->
<form name="Parties_Admin_FeatureType_Button_Form" method="post" action="/some/url">

<display:table id="featureTypes" name="featureTypesList" 
	requestURI="//ext/parties/admin/viewFeatureTypes" pagesize="10" sort="list"  style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult featureTypeItem = (ViewResult) featureTypes;//pageContext.getAttribute("roles"); %>
	
<display:column class="gamma1" property="field1" titleKey="parties.admin.featuretype.fieldcode" sortable="true" />
<display:column class="gamma1" property="field2" titleKey="parties.admin.featuretype.name" sortable="true" />
<display:column class="gamma1" property="field3" titleKey="parties.admin.featuretype.fieldtype" decorator="com.ext.portlet.parties.admin.util.FieldTypeColumnDecorator"/>
<display:column class="gamma1" property="field4" titleKey="parties.admin.featuretype.defaultvalue"/>

<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=featureTypeItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="middle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=featureTypeItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
		</td>
		<td>
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/loadFeatureType"/>
				<portlet:param name="mainid" value="<%= featureTypeItem.getMainid().toString() %>"/>
				<portlet:param name="partyroletypeid" value="<%=partyroletypeid%>"/>
				<portlet:param name="loadaction" value="view"/>
				</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "parties.button.edit") %>
			</a>
		</td>
	</tr>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
		</td>
		<td>
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/loadFeatureType"/>
				<portlet:param name="mainid" value="<%= featureTypeItem.getMainid().toString() %>"/>
				<portlet:param name="delete" value="<%= featureTypeItem.getMainid().toString() %>"/>
				<portlet:param name="partyroletypeid" value="<%=partyroletypeid%>"/>
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
  <tiles:put name="action"  value="/ext/parties/admin/loadFeatureType" />
  <tiles:put name="buttonName" value="addButtonFeatureType" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_Admin_FeatureType_Button_Form" />
  <tiles:put name="actionParam" value="loadaction"/>
  <tiles:put name="actionParamValue" value="add"/>
  <tiles:putList name="actionParamList">
  	<tiles:add value="partyroletypeid"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=partyroletypeid%></tiles:add>
  </tiles:putList>
</tiles:insert>


</form>

<br>
<%
java.util.HashMap params = new java.util.HashMap();
params.put("mainid", partyroletypeid);
pageContext.setAttribute("paramsName", params);
%>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/loadRoleType" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.link.partyroletype") %></html:link></TD>
</TR></TABLE>

<%} catch (Exception e) {e.printStackTrace(); } %>