<%@ include file="/html/common/init.jsp" %>



<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.liferay.portlet.RenderRequestImpl" %>
<%@ page import="com.liferay.portlet.ActionRequestImpl" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<%@ page import="gnomon.hibernate.model.gn.GnContent" %>

<%@ page import="gnomon.hibernate.model.gn.kms.ViewKmsPropertyValue" %>
<%@ page import="gnomon.hibernate.model.gn.kms.ViewKmsPropertyValueLanguage" %>
<%@ page import="gnomon.hibernate.model.gn.kms.ViewKmsContentMetadata" %>

<%@ page import="gnomon.business.GeneralUtils" %>

<%@ page import="com.ext.portlet.permissions.service.PermissionsService" %>

<tiles:useAttribute id="struts_action" name="struts_action" classname="java.lang.String"/>
<tiles:useAttribute id="contentClassName" name="contentClass" classname="java.lang.String"/>
<tiles:useAttribute id="hasPublish" name="hasPublish" classname="java.lang.Boolean" ignore="true"/>
<tiles:useAttribute id="hasEdit" name="hasEdit" classname="java.lang.Boolean" ignore="true"/>
<tiles:useAttribute id="hasDelete" name="hasDelete" classname="java.lang.Boolean" ignore="true"/>
<tiles:useAttribute id="hasPublish" name="hasPublish" classname="java.lang.Boolean" ignore="true"/>
<tiles:useAttribute id="requestURI" name="requestURI" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="requestAttr" name="requestAttr" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="currentURL" name="currentURL" classname="java.lang.String" ignore="true"/>



<display:table id="new" name="<%=requestAttr%>" requestURI="<%=requestURI%>" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	<% com.ext.portlet.base.search.GnSearchResultRow gnItem = (com.ext.portlet.base.search.GnSearchResultRow) pageContext.getAttribute("new"); %>
	<display:column titleKey="title" sortable="true" style="width:100%">
	<b><a href="<liferay-portlet:actionURL portletName="<%= gnItem.getPortlet().toString() %>">
			<liferay-portlet:param name="struts_action" value="<%= gnItem.getUrl().toString() %>"/>
			<liferay-portlet:param name="mainid" value="<%= gnItem.getId().toString() %>"/>
			<liferay-portlet:param name="loadaction" value="view"/>
			<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
			</liferay-portlet:actionURL>"><%= gnItem.getTitle().toString() %></a></b><br>

	</display:column>


	<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
		<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getId().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getId().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
			<tbody>
			
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="<%= gnItem.getPortlet().toString() %>" windowState="<%= WindowState.MAXIMIZED.toString() %>">
								<liferay-portlet:param name="struts_action" value="<%= gnItem.getUrl().toString() %>"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getId().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="edit"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
					</td>
					<td>
						<a href="<liferay-portlet:actionURL portletName="<%= gnItem.getPortlet().toString() %>" windowState="<%= WindowState.MAXIMIZED.toString() %>">
								<liferay-portlet:param name="struts_action" value="<%= gnItem.getUrl().toString() %>"/>
								<liferay-portlet:param name="mainid" value="<%= gnItem.getId().toString() %>"/>
								<liferay-portlet:param name="loadaction" value="delete"/>
								<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
								</liferay-portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
			</c:if>
			</tbody>
			</table>
		</div>
		</display:column>
	</c:if>
</display:table>
<br/><br/>

