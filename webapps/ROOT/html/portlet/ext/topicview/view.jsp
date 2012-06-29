<%@ include file="/html/portlet/ext/topicview/init.jsp" %>

<%@ page import="com.liferay.portlet.journal.NoSuchArticleException" %>
<%@ page import="com.liferay.portlet.journal.action.EditArticleAction" %>
<%@ page import="com.liferay.portlet.journal.model.JournalArticle" %>
<%@ page import="com.liferay.portlet.journal.model.JournalArticleDisplay" %>
<%@ page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.journal.util.JournalUtil" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.RuntimePortletUtil" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.ActionURLLogic" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.PortletLogic" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.RenderURLLogic" %>
<%@ page import="com.liferay.portlet.layoutconfiguration.util.xml.RuntimeLogic" %>
<%@ page import="com.liferay.portlet.journalcontent.util.JournalContentUtil" %>
<%@ page import="com.liferay.util.portlet.PortletRequestUtil" %>




<div id="myshowhide">

<%
//topic driven portlet, so read topic context
PortalContext portalContext = PortalContextRequestUtil.getPortalContext(request); 

ViewResult topicView = (ViewResult) portalContext.getEntry(PortalContext.PRIMARY_TOPIC_VIEW);
//String topicId = (String) portalContext.getEntry(PortalContext.PRIMARY_TOPIC_ID);
%>

<c:choose>
	<c:when test="<%= !com.ext.portlet.topicview.action.ViewAction.isHide(portalContext) %>">
	  <div class="journal-content-article">
		<h3><%=ViewResultUtil.toString(topicView.getField2()) %></h3>
		
		<%
		String description = ViewResultUtil.toString(topicView.getField3());
		String strippedDescription = StringUtils.stripHTML(description).trim();
		int cutPoint = 300;
		Long articleId = (Long)topicView.getField5();
		if (articleId != null && articleId > 0) {
			JournalArticle article = JournalArticleLocalServiceUtil.getArticle(articleId);
			JournalArticleDisplay articleDisplay = null;
			String xmlRequest = PortletRequestUtil.toXML(renderRequest, renderResponse);
			String languageId = LanguageUtil.getLanguageId(request);
			if (article!=null) {
				articleDisplay = JournalContentUtil.getDisplay(
					article.getGroupId(), article.getArticleId(), article.getTemplateId(), languageId, themeDisplay,
					false, xmlRequest);
				
				
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
				<%
			}
		} else {
		%>

		<c:choose>
			<c:when test="<%=strippedDescription.length() > cutPoint%>">
			
				<div id="<portlet:namespace />shortTopicView" style="">
					<%=StringUtils.subStr(description, cutPoint) %>
					<p>&nbsp;</p>
				</div>
				
				
				<div style="text-align:right">
					<a href="javascript: void(0);" onclick="Liferay.Util.toggleByIdSpan(this, '<portlet:namespace />shortTopicView'); Liferay.Util.toggleByIdSpan(this, '<portlet:namespace />fullTopicView'); self.focus();">
						<span style="display: ;">
							<%=LanguageUtil.get(pageContext,"agrotour.tip.showfulloveriview")%>
						</span>
						<span style="display: none">
							<%=LanguageUtil.get(pageContext,"hide")%>
						</span>
					</a>
					<hr />
				</div>
				
				<div id="<portlet:namespace />fullTopicView" style="display: none;">
					<%=description%>
					<hr />
		            <br />
		            <a href="#top">TOP</a>
				</div>
				
			</c:when>
			<c:otherwise>
				<%=description%>
			</c:otherwise>
		</c:choose>
		<% } %>
		
		</div>
	</c:when>
</c:choose>
</div>
