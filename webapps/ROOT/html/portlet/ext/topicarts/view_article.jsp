<%@ include file="/html/portlet/ext/topicarts/init.jsp" %>

<%
long groupId = PortalUtil.getPortletGroupId(themeDisplay.getPlid());
boolean enableRatings = true; //GetterUtil.getBoolean(prefs.getValue("enable-ratings", StringPool.BLANK), true);
boolean enableComments = false; //GetterUtil.getBoolean(prefs.getValue("enable-comments", StringPool.BLANK), true);
boolean enablePrint = true;

DateFormat dateFormatDateTime = DateFormats.getDateTime(locale, timeZone);
%>

<%
JournalArticleDisplay articleDisplay = (JournalArticleDisplay)request.getAttribute(WebKeys.JOURNAL_ARTICLE_DISPLAY);
String redirect = ParamUtil.getString(request, "redirect");
%>

<c:choose>
	<c:when test="<%= articleDisplay != null && themeDisplay.isStateExclusive() %>">

		<%
		RuntimeLogic portletLogic = new PortletLogic(application, request, response, renderRequest, renderResponse);
		RuntimeLogic actionURLLogic = new ActionURLLogic(renderResponse);
		RuntimeLogic renderURLLogic = new RenderURLLogic(renderResponse);

		String content = articleDisplay.getContent();

		content = RuntimePortletUtil.processXML(request, content, portletLogic);
		content = RuntimePortletUtil.processXML(request, content, actionURLLogic);
		content = RuntimePortletUtil.processXML(request, content, renderURLLogic);
		%>

		<%= content %>
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="<%= articleDisplay != null %>">

				<%
				RuntimeLogic portletLogic = new PortletLogic(application, request, response, renderRequest, renderResponse);
				RuntimeLogic actionURLLogic = new ActionURLLogic(renderResponse);
				RuntimeLogic renderURLLogic = new RenderURLLogic(renderResponse);

				String content = articleDisplay.getContent();

				content = RuntimePortletUtil.processXML(request, content, portletLogic);
				content = RuntimePortletUtil.processXML(request, content, actionURLLogic);
				content = RuntimePortletUtil.processXML(request, content, renderURLLogic);
				%>

				<div class="journal-content-article" id="<%= articleDisplay.getGroupId() %>_<%= articleDisplay.getArticleId() %>_<%= articleDisplay.getVersion() %>">
				<%= content %>
				</div>

			</c:when>
		</c:choose>

		<%
		JournalArticle article = null;

		try {
			if (articleDisplay!=null)
				article = JournalArticleLocalServiceUtil.getLatestArticle(groupId, articleDisplay.getArticleId());
		}
		catch (NoSuchArticleException nsae) {
		}
		%>

		<c:if test="<%= themeDisplay.isSignedIn() %>">
			<div>
				<br />

				<c:if test="<%= article != null %>">
					<c:if test="<%= JournalArticlePermission.contains(permissionChecker, article, ActionKeys.UPDATE) %>">
						<liferay-portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="editURL" portletName="<%= PortletKeys.JOURNAL %>">
							<liferay-portlet:param name="struts_action" value="/journal/edit_article" />
							<liferay-portlet:param name="redirect" value="<%= currentURL %>" />
							<liferay-portlet:param name="groupId" value="<%= String.valueOf(article.getGroupId()) %>" />
							<liferay-portlet:param name="articleId" value="<%= article.getArticleId() %>" />
							<liferay-portlet:param name="version" value="<%= String.valueOf(article.getVersion()) %>" />
						</liferay-portlet:renderURL>

						<liferay-ui:icon image="edit" message="edit-article" url="<%= editURL %>" />
					</c:if>
				</c:if>

				<c:if test="<%=false && PortletPermissionUtil.contains(permissionChecker, plid.longValue(), PortletKeys.JOURNAL, ActionKeys.ADD_ARTICLE) %>">
					<liferay-portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>" var="addArticleURL" portletName="<%= PortletKeys.JOURNAL %>">
						<liferay-portlet:param name="struts_action" value="/journal/edit_article" />
						<liferay-portlet:param name="portletResource" value="<%= portletDisplay.getId() %>" />
						<liferay-portlet:param name="redirect" value="<%= currentURL %>" />
					</liferay-portlet:renderURL>

					<liferay-ui:icon image="add_article" message="add-article" url="<%= addArticleURL %>" />
				</c:if>
			</div>
		</c:if>


<hr />

		<c:if test="<%= articleDisplay != null && !renderRequest.getWindowState().equals(LiferayWindowState.POP_UP) %>">
			<div>
				<c:if test="<%= Validator.isNotNull(redirect) %>">
					<a href="<%=redirect%>"><img src="<%=themeDisplay.getPathThemeImages() %>/custom/back_from_article.gif" onmousemove="ToolTip.show(event, this, '<%=LanguageUtil.get(pageContext, "back") %>')" border="0"></a>
				</c:if>

				<c:if test="<%= enablePrint %>">
									
					<portlet:renderURL windowState="<%= LiferayWindowState.POP_UP.toString() %>" var="printArticleURL">
						<portlet:param name="struts_action" value="/ext/topicarts/viewArticle" />
						<portlet:param name="articleId" value="<%=articleDisplay.getId()+""%>" />
						<portlet:param name="topicid" value="<%=selTopicId%>" />
						<portlet:param name="st" value="<%=secTopicId%>" />
						<%--<portlet:param name="groupId" value="<%=topicedArticle.getArticle().getGroupId()+""%>" />--%>
					</portlet:renderURL>

					<a href="<%= printArticleURL %>" target="_blank"><img src="<%=themeDisplay.getPathThemeImages() %>/custom/print_article_icon.gif" onmousemove="ToolTip.show(event, this, '<%=UnicodeLanguageUtil.get(pageContext, "print") %>')" border="0"></a>

					<%--
					StringMaker sm = new StringMaker();

					sm.append(themeDisplay.getPathMain());
					sm.append("/journal_articles/view_article_content?groupId=");
					sm.append(article.getGroupId());
					sm.append("&articleId=");
					sm.append(article.getArticleId());
					sm.append("&version=");
					sm.append(article.getVersion());

					rowHREF = sm.toString();
					--%>
                    
				</c:if>




				<c:if test="<%= enableRatings %>">
				

					<liferay-ui:ratings
						className="<%= JournalArticle.class.getName() %>"
						classPK="<%= articleDisplay.getResourcePrimKey() %>"
						url='<%= themeDisplay.getPathMain() + "/journal_content/rate_article" %>'
					/>
				</c:if>


				<c:if test="<%= enableComments %>">
					<br />

					<portlet:actionURL var="discussionURL">
						<portlet:param name="struts_action" value="/journal_content/edit_article_discussion" />
					</portlet:actionURL>

					<liferay-ui:discussion
						formAction="<%= discussionURL %>"
						className="<%= JournalArticle.class.getName() %>"
						classPK="<%= articleDisplay.getResourcePrimKey() %>"
						userId="<%= articleDisplay.getUserId() %>"
						subject="<%= articleDisplay.getTitle() %>"
						redirect="<%= currentURL %>"
					/>
				</c:if>
			</div>
		</c:if>
	</c:otherwise>
</c:choose>