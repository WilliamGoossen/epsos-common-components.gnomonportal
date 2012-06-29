<%@ include file="/html/portlet/ext/base/smslists/init.jsp" %>

<portlet:defineObjects />

<%
//String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>

<table cellpadding="0" cellspacing="0" width="100%">
<tbody>
<c:if test="<%= false && hasAdd %>">
	<tr>
		<%--td style="background-color: #92A8C0;" width="1"></td--%>
		<td style="padding-left: 4px;" align="right">
			<nobr>
				<table cellpadding="0" cellspacing="0">
				<tbody>
				<tr>
					<td>
						<form name="SmsListForm" action="/ext/smslists/load" method="post">
						<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
							<tiles:put name="action"  value="/ext/smslists/load" />
							<tiles:put name="buttonName" value="addButton" />
							<tiles:put name="buttonValue" value="gn.link.add-content" />
							<tiles:put name="formName"   value="SmsListForm" />
							<tiles:put name="actionParam" value="loadaction"/>
							<tiles:put name="actionParamValue" value="add"/>
							<tiles:put name="actionPermission" value="add"/>
							<tiles:put name="portletId" value="<%=portletID %>"/>
							<tiles:put name="actionType"  value="linkAction" />
							<tiles:put name="iconPath"><%= themeDisplay.getPathThemeImage() %>/base/add.gif</tiles:put>
						</tiles:insert>
						</form>
					</td>
				</tr>
				</tbody>
				</table>
			</nobr>
		</td>
	</tr>
</c:if>
</tbody>
</table>