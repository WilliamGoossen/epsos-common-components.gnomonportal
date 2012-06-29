<%@ include file="/html/portlet/ext/dms/init.jsp" %>

<%
AuthenticationDetails details = (AuthenticationDetails)request.getSession().getAttribute("authdetails");
Node instanceNode = AlfrescoContentUtil.getNode(details,instanceUuid);
NamedValue[] instanceNamedValues = instanceNode.getProperties();
String instanceFolderName = AlfrescoContentUtil.getNamedValue(instanceNamedValues, org.alfresco.webservice.util.Constants.PROP_NAME);
%>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">


	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "root-folder") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<input name="<portlet:namespace />instanceUuid" type="hidden" value="<%= instanceUuid %>" size="40">
			<%--<input name="<portlet:namespace />instanceFolderName" type="text" value="<%= instanceFolderName %>" size="40">--%>

			<a id="<portlet:namespace />instanceFolderName" href="#" onclick="openDialog('<liferay-portlet:renderURL portletName="<%= portletResource %>" windowState='<%=LiferayWindowState.POP_UP.toString()%>'>
				<portlet:param name='struts_action' value='/ext/dms/browseFolders' />
				<portlet:param name='multiSelection' value='false' />
				<portlet:param name='openerFormName' value='<%=renderResponse.getNamespace()+"fm"%>' />
				<portlet:param name='openerFormFieldName' value='<%=renderResponse.getNamespace()+"instanceUuid"%>' />
				<portlet:param name='openerLabelName' value='<%=renderResponse.getNamespace()+"instanceFolderName"%>' />
				<portlet:param name='instanceUuid' value='<%=instanceUuid%>' />
			</liferay-portlet:renderURL>', 400, 350);return false;">
			<%= instanceFolderName %></a>

		</td>
	</tr>


	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "display-style") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<select name="<portlet:namespace />listStyle">
				<option <%= (instancePortletListStyle.equals("list")) ? "selected" : "" %> value="list">
					<%=LanguageUtil.get(pageContext, "List") %>
				</option>
				<option <%= (instancePortletListStyle.equals("grid")) ? "selected" : "" %> value="grid">
					<%=LanguageUtil.get(pageContext, "Grid") %>
				</option>
			</select>
		</td>
	</tr>

	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>

<%!
private static Log _log = LogFactoryUtil.getLog("ROOT.docroot.html.portlet.alfresco_content.configuration.jsp");
%>