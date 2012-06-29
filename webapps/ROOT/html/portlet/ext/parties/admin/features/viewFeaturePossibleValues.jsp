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

<% try {
String featuretypeid = titleData.getValue("featuretypeid").toString();
String partyroletypeid = titleData.getValue("partyroletypeid").toString();
List possibleValuesList=(List) request.getAttribute("possibleValuesList");
%>

<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.admin.list.feature.possiblevalues") %></h2>
<!-- Possible Values List -->

<form name="Parties_FeaturePossibleValues_Button_Form" method="post" action="/some/url">
<display:table id="values" name="possibleValuesList" requestURI="//ext/parties/admin/listFeaturePossibleValues?actionURL=true" pagesize="10" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult valueItem = (ViewResult) values; %>
	
<display:column class="gamma1" property="field1" titleKey="parties.admin.featurepossiblevalue.name"/>

<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=valueItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="middle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=valueItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
		</td>
		<td>
			<a  href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/loadFeaturePossibleValue"/>
				<portlet:param name="mainid" value="<%= valueItem.getMainid().toString() %>"/>
				<portlet:param name="featuretypeid" value="<%=featuretypeid%>"/>
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
			<a onclick="return confirm('<%=LanguageUtil.get(pageContext, "parties.admin.feature.possiblevalue.delete-are-you-sure")%>')" href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/parties/admin/deleteFeaturePossibleValue"/>
				<portlet:param name="mainid" value="<%= valueItem.getMainid().toString() %>"/>
				<portlet:param name="featuretypeid" value="<%=featuretypeid%>"/>
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
  <tiles:put name="action"  value="/ext/parties/admin/loadFeaturePossibleValue" />
  <tiles:put name="buttonName" value="addFeaturePossibleValueButton" />
  <tiles:put name="buttonValue" value="parties.button.add" />
  <tiles:put name="formName"   value="Parties_FeaturePossibleValues_Button_Form" />
  <tiles:putList name="actionParamList">
  	<tiles:add value="featuretypeid"/>
  	<tiles:add value="partyroletypeid"/>
  	<tiles:add value="loadaction"/>
  </tiles:putList>
  <tiles:putList name="actionParamValueList">
  	<tiles:add><%=featuretypeid%></tiles:add>
  	<tiles:add><%=partyroletypeid%></tiles:add>
  	<tiles:add value="add"/>
  </tiles:putList>
</tiles:insert>


</form>

<%
java.util.HashMap params = new java.util.HashMap();
params.put("mainid", featuretypeid);
params.put("partyroletypeid", partyroletypeid);
pageContext.setAttribute("paramsName", params);
%>
<br>

<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD><html:link styleClass="beta1" action="/ext/parties/admin/loadFeatureType" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.admin.link.feature.type") %></html:link></TD>
</TR></TABLE>

<% } catch (Exception e) {e.printStackTrace(); } %>
