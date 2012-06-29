<%@ include file="/html/common/init.jsp" %>

<portlet:defineObjects />

<tiles:useAttribute id="tilesPortletContent" name="portlet_content" classname="java.lang.String" ignore="true" />

<%
String currentURL = PortletURLUtil.getCurrent(renderRequest, renderResponse).toString();
String cmstab = ParamUtil.getString(request, "cmstab", "item");
String loadaction = (String)request.getAttribute("loadaction");
%>


<c:choose>
	<c:when test="<%=loadaction.equals("view")%>">
		<liferay-ui:tabs
			names="item,publish,topics,audit,statistics,metadata"
			param="cmstab"
			url="<%=currentURL%>"
		/>

		<c:choose>
			<c:when test='<%= cmstab.equals("item") %>'>
				<c:if test="<%= Validator.isNotNull(tilesPortletContent) %>">
					<liferay-util:include page="<%= com.liferay.portal.struts.StrutsUtil.TEXT_HTML_DIR + tilesPortletContent %>" />
				</c:if>
				<c:if test="<%= Validator.isNull(tilesPortletContent) %>">
					<%
					pageContext.getOut().print(renderRequest.getAttribute(WebKeys.PORTLET_CONTENT));
					%>
				</c:if>
			</c:when>
			<c:when test='<%= cmstab.equals("publish") %>'>
				<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
					<input name="<portlet:namespace />tabs2" type="hidden" value="<%= cmstab %>">
					<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
					<table border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td>
							<%= LanguageUtil.get(pageContext, "topic") %>
						</td>
						<td style="padding-left: 10px;"></td>
						<td>
							<input type="text" name="<portlet:namespace />topicId" value="test">
						</td>
					</tr>
					</table>
					<br/>
					<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onclick="submitForm(document.<portlet:namespace />fm);">
				</form>
			</c:when>
		</c:choose>


	</c:when>
	<c:otherwise>
		<c:if test="<%= Validator.isNotNull(tilesPortletContent) %>">
			<liferay-util:include page="<%= com.liferay.portal.struts.StrutsUtil.TEXT_HTML_DIR + tilesPortletContent %>" />
		</c:if>
		<c:if test="<%= Validator.isNull(tilesPortletContent) %>">
			<%
			pageContext.getOut().print(renderRequest.getAttribute(WebKeys.PORTLET_CONTENT));
			%>
		</c:if>
	</c:otherwise>
</c:choose>