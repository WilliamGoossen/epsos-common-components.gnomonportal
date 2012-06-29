<%@ include file="/html/portlet/ext/crm/messages/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<%
String crmPartyId = request.getParameter("crmPartyId");
%>

<liferay-ui:error key="crm.message.send.error" message="crm.message.send.error"/>

<html:form action="/ext/crm/messages/list" method="post" styleClass="uni-form">

	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
		<tiles:put name="formName" value="SearchCrMessageForm"/>
	</tiles:insert>

	<div class="button-holder">
	<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "crm.button.search") %>">
	</div>
</html:form>
<br>

<display:table id="item" name="crm_messages" requestURI="//ext/crm/messages/list?actionURL=true" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("item"); %>
<display:column property="field1" titleKey="crm.message.entryDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field2" titleKey="crm.message.messageDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper" />
<display:column property="field5" titleKey="crm.message.type" sortable="true"/>
<display:column property="field4" titleKey="crm.message.subject" sortable="true"/>
<display:column property="field6" titleKey="crm.message.creatorId" sortable="true"/>
<display:column  titleKey="crm.message.crmPartyId" sortable="true">
<a title="<%= gnItem.getField7().toString() %>" 
    href="#" onClick="openDialog('<liferay-portlet:actionURL portletName="PA_CONTACTS" windowState="pop_up"><liferay-portlet:param name="struts_action" value="/ext/parties/contacts/load"/><liferay-portlet:param name="mainid" value="<%= gnItem.getField12().toString() %>"/><liferay-portlet:param name="loadaction" value="view"/></liferay-portlet:actionURL>', 700, 850);">
<%= gnItem.getField7().toString() %>
</a>
</display:column>
<display:column titleKey="crm.message.attachmentFile" sortable="true">
<%
if (Validator.isNotNull(gnItem.getField8())) {
%>
<a target="_new" href="<%= "/FILESYSTEM/"+ com.liferay.portal.util.PortalUtil.getCompanyId(request)+ "/" + com.ext.portlet.crm.messages.CrMessageForm.UPLOAD_PATH + gnItem.getMainid() + "/"+ gnItem.getField8() %>">
<%= gnItem.getField8() %></a>
<% } %>
</display:column>

<c:if test="<%= hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
		<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
		<br>
		<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="display: none; padding-left: 0px;">
			<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="0">
			<tbody>
			<c:if test="<%= hasEdit %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/messages/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="edit"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
						</a>
					</td>
				</tr>
			</c:if>
			<c:if test="<%= hasDelete %>">
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/messages/load"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="loadaction" value="delete"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
						</a>
					</td>
				</tr>
			</c:if>
			<% if (hasEdit && 
					(gnItem.getField9() == null || !((Boolean)gnItem.getField9()).booleanValue()) &&
					(gnItem.getField10() == null || !((Boolean)gnItem.getField10()).booleanValue()) &&
					(gnItem.getField11().equals("email"))
					) {%>
				<tr>
					<td>
						<img src="<%= themeDisplay.getPathThemeImage() %>/mail/forward.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "send") %>">
					</td>
					<td>
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/crm/messages/send"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "send") %>
						</a>
					</td>
				</tr>
			<% } %>
			</tbody>
			</table>
		</div>
		</display:column>
</c:if>

</display:table>

<% if (hasAdd) { %>

<br/><br/>

<a href="<portlet:actionURL>
<portlet:param name="struts_action" value="/ext/crm/messages/load"/>
<portlet:param name="loadaction" value="add"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
<% if (Validator.isNotNull(crmPartyId)) { %>
<portlet:param name="crmPartyId" value="<%= crmPartyId %>"/>
<% } %>
</portlet:actionURL>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
<%= LanguageUtil.get(pageContext, "gn.button.add") %>
</a>

<% } %>



