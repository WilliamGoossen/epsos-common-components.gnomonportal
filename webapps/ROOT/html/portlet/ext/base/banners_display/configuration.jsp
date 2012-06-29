<%@ include file="/html/portlet/ext/base/banners_display/init.jsp" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<%
String schemaTab = ParamUtil.getString(request, "schemaTab", sourceSchema);
String previewWidth = ParamUtil.getString(request, "previewWidth");
// Configuration
//PortletURL configurationURL = renderResponse.createRenderURL();

//configurationURL.setParameter("struts_action", "/ext/base/banners_display/edit_configuration");
//configurationURL.setParameter("redirect", redirect);
//configurationURL.setParameter("portletResource", portletResource);
//configurationURL.setParameter("previewWidth", previewWidth);
//configurationURL.toString()
//
//	names="bs.banners_display.configuration.show-recent,bs.banners_display.configuration.show-selected"
//	values="show-recent,show-selected"

%>


<liferay-ui:tabs
	names="show-recent,show-selected"
	param="schemaTab"
	url="<%= currentURL %>"
	value="<%=schemaTab%>"
/>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<c:choose>
	<c:when test='<%= schemaTab.equals("show-recent") %>'>
		<input name="<portlet:namespace />schemaTab" type="hidden" value="show-recent">
		<input name="<portlet:namespace />sourceSchema" type="hidden" value="show-recent">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "view-orientation") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />viewOrientation">
					<option <%= (viewOrientation.equals("vertical")) ? "selected" : "" %> value="vertical"><%= LanguageUtil.get(pageContext, "vertical") %></option>
					<option <%= (viewOrientation.equals("horizontal")) ? "selected" : "" %> value="horizontal"><%= LanguageUtil.get(pageContext, "horizontal") %></option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "number-of-banners") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<input class="form-text" name="<portlet:namespace />numOfBanners" style="width: 50px;" type="text" value="<%= numberOfBanners %>">
			</td>
		</tr>
		</table>
		<br>
		<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</c:when>

	<c:when test='<%= schemaTab.equals("show-selected") %>'>
		<input name="<portlet:namespace />schemaTab" type="hidden" value="show-selected">
		<input name="<portlet:namespace />sourceSchema" type="hidden" value="show-selected">
		<table border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "view-orientation") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<select name="<portlet:namespace />viewOrientation">
					<option <%= (viewOrientation.equals("vertical")) ? "selected" : "" %> value="vertical"><%= LanguageUtil.get(pageContext, "vertical") %></option>
					<option <%= (viewOrientation.equals("horizontal")) ? "selected" : "" %> value="horizontal"><%= LanguageUtil.get(pageContext, "horizontal") %></option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<%= LanguageUtil.get(pageContext, "source-items") %>
			</td>
			<td style="padding-left: 10px;"></td>
			<td>
				<%--<input class="form-text" name="<portlet:namespace />sourceItemId" style="width: <%= ModelHintsDefaults.TEXT_DISPLAY_WIDTH %>px;" type="text" value="<%= sourceItemId %>">--%>
				<%
					List leftList = new ArrayList();
					List rightList = new ArrayList();
					List bannersPool = (List) request.getAttribute("bannersPool");
					List bannersSelected = (List) request.getAttribute("bannersSelected");
					//System.out.println(bannersSelected.toString());
					if (bannersPool!=null) {
						for (int i = 0; i < bannersPool.size(); i++) {
							ViewResult banner = (ViewResult) bannersPool.get(i);
							String bannerid = banner.getMainid() + "";
							String bannerTitle = banner.getField2().toString();
							if (!bannersSelected.contains(bannerid))
								rightList.add(new KeyValuePair(bannerid, bannerTitle));
						}
					}
					if (bannersSelected!=null) {
						for (int i = 0; i < bannersSelected.size(); i++) {
							String bannerid = (String) bannersSelected.get(i);
							for (int j = 0; j < bannersPool.size(); j++) {
								ViewResult banner = (ViewResult) bannersPool.get(j);
								if (bannerid.equals(banner.getMainid()+"")) {
									String bannerTitle = banner.getField2().toString();
									leftList.add(new KeyValuePair(bannerid, bannerTitle));
								}
							}
						}
					}
				%>
				<input name="<portlet:namespace />sourceItems" type="hidden" value="">
				<liferay-ui:input-move-boxes
					leftTitle='<%= LanguageUtil.get(pageContext, "current") %>'
					rightTitle='<%= LanguageUtil.get(pageContext, "available") %>'
					leftBoxName="current_banners"
					rightBoxName="available_banners"
					leftReorder="true"
					leftList="<%= leftList %>"
					rightList="<%= rightList %>"
				/>
			</td>
		</tr>
		</table>
		<br>
		<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="document.<portlet:namespace />fm.<portlet:namespace />sourceItems.value = Liferay.Util.listSelect(document.<portlet:namespace />fm.<portlet:namespace />current_banners); submitForm(document.<portlet:namespace />fm);">
	</c:when>
</c:choose>

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />viewOrientation.focus();
</script>