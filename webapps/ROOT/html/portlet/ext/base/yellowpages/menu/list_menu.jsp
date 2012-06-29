<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>

<portlet:defineObjects />

<%
//String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>

<table cellpadding="0" cellspacing="0" width="100%">
<tbody>
<tr>
	<!--<td style="background-color: #92A8C0;" width="1"></td>-->
	<td style="padding-left: 4px;" align="right">
		<nobr>
			<table cellpadding="0" cellspacing="0">
			<tbody>
				<td>
					<tiles:insert page="/html/portlet/ext/struts_includes/lucene_searchTile.jsp" flush="true">
						<tiles:put name="struts_action" value="/ext/yellowpages/list" />
						<tiles:put name="searchStyle" value="<%=instancePortletSearch%>" />
					</tiles:insert>
				</td>
			</tbody>
			</table>
		</nobr>
	</td>
</tr>
</tbody>
</table>
