<%@ include file="/html/portlet/ext/topicarts/init.jsp" %>

<%@ page import="org.dom4j.*" %>
<%@ page import="org.dom4j.io.SAXReader" %>
<%@ page import="com.liferay.portlet.journal.model.impl.JournalTemplateImpl" %>

<%
Long articlesTotal = (Long)request.getAttribute("articlesTotal");
if (articlesTotal==null) articlesTotal = new Long(0);
Integer articlesPage = (Integer)request.getAttribute("articlesPage");
if (articlesPage==null) articlesPage = 1;
Integer articlesPagesize = (Integer)request.getAttribute("articlesPagesize");
if (articlesPagesize==null) articlesPagesize = 1;
Long totalPages = articlesTotal/articlesPagesize;
if (articlesTotal % articlesPagesize > 0) totalPages++;

List<TopicArticlesWrapper> topicArticlesWrappers = (List<TopicArticlesWrapper>)request.getAttribute("topicArticlesWrappers");
%>

<c:choose>
<c:when test="<%=topicArticlesWrappers!=null && topicArticlesWrappers.size()>0%>">
	<div class="topic-articles">
	
		<%
		for (TopicArticlesWrapper topicArticlesWrapper:topicArticlesWrappers) {
			String includeInTopicid = topicArticlesWrapper.getTopicid();
			ViewResult includeInTopicView = topicArticlesWrapper.getTopicView();
			if (includeInTopicView==null)
				includeInTopicView = TopicsService.getInstance().getTopic(includeInTopicid, lang);
			List<TopicedArticle> topicedArticles = topicArticlesWrapper.getTopicedArticles();
		%>
		
		<c:if test="<%=topicedArticles!=null && topicedArticles.size()>0%>">
			<div class="topic-articles-section" style="padding-top:10px;">
				<div class="portlet-title2">
					<%=ViewResultUtil.toString(includeInTopicView.getField2())%>
					<c:if test="<%=selTopicView!=null && secTopicView==null%>">
						<portlet:renderURL var="viewAllURL">
							<portlet:param name="struts_action" value="/ext/topicarts/view" />
							<portlet:param name="topicid" value="<%=selTopicId%>" />
							<portlet:param name="st" value="<%=includeInTopicView.getMainid()+""%>" />
						</portlet:renderURL>
						
                        <span class="entries">
                        &nbsp;[ <%=LanguageUtil.get(pageContext,"latest-entries")%> ]  &nbsp;&nbsp;&nbsp;&nbsp;
                        
						<a href="<%=viewAllURL%>"><%=LanguageUtil.get(pageContext,"all-entries")%></a>
						</span>
                        
                        
                        
					</c:if>
				</div>
		        <div class="portlet-content2">
		        	
		        
		        	<%
					for (TopicedArticle topicedArticle:topicedArticles) {
					%>
					<div class="topic-article-title">
						<%
						JournalArticle article = topicedArticle.getArticle();
						
						PortletURL viewArticleURL = renderResponse.createRenderURL();
						viewArticleURL.setWindowState(WindowState.NORMAL);
						viewArticleURL.setParameter("struts_action", "/ext/topicarts/viewArticle");
						viewArticleURL.setParameter("articleId", topicedArticle.getArticle().getId()+"");
						if (Validator.isNotNull(selTopicId))
							viewArticleURL.setParameter("topicid", selTopicId);
						if (Validator.isNotNull(secTopicId))
							viewArticleURL.setParameter("st", secTopicId);
						viewArticleURL.setParameter("redirect", currentURL);
						%>
						
		                <%
		                long groupId = PortalUtil.getPortletGroupId(plid);
		                Map tokens = JournalUtil.getTokens(groupId, themeDisplay);

		    			String xml = article.getContentByLocale(
		    				themeDisplay.getLanguageId());

		    			String contentType = ContentTypes.TEXT_HTML_UTF8;

		    			Document doc = null;

		    			Element root = null;
		    			
		    			String title = article.getTitle();
		    			
		    			//default image: diorthose to
		    			String thumbPath = "";//themeDisplay.getPathThemeImage()  + "/spacer.gif";
		    			
		    			String shortDescription = StringUtils.subStr(article.getDescription());
		    			
		    			if (article.isTemplateDriven()) {
		    				SAXReader reader = new SAXReader();

		    				doc = reader.read(new StringReader(xml));

		    				root = doc.getRootElement();

		    				addProcessingInstructions(doc, themeDisplay, article);

		    				JournalUtil.addAllReservedEls(root, tokens, article);

		    				xml = JournalUtil.formatXML(doc);

		    				contentType = ContentTypes.TEXT_XML_UTF8;
							
		    				// Use XPath to find the element we want
							Node nodeArticleTitle = doc.selectSingleNode( 
									 "/root/dynamic-element[@name='title']/dynamic-content" 
							);

							Node nodeArticleThumb = doc.selectSingleNode( 
									 "/root/dynamic-element[@name='image']/dynamic-content" 
							);

							Node nodeArticleShortDescription = doc.selectSingleNode( 
									 "/root/dynamic-element[@name='short_description']/dynamic-content" 
							);

							Node nodeArticleDescription = doc.selectSingleNode( 
									 "/root/dynamic-element[@name='description']/dynamic-content" 
							);
							
							if (nodeArticleTitle!=null && nodeArticleTitle.getStringValue()!=null)
								title = nodeArticleTitle.getStringValue();
							if (nodeArticleThumb!=null && nodeArticleThumb.getStringValue()!=null)
								thumbPath = nodeArticleThumb.getStringValue();
							if (nodeArticleShortDescription!=null && nodeArticleShortDescription.getStringValue()!=null)
								shortDescription = nodeArticleShortDescription.getStringValue();
							else if (nodeArticleDescription!=null && nodeArticleDescription.getStringValue()!=null)
								shortDescription = StringUtils.subStr(nodeArticleDescription.getStringValue());
		    			}
		                %>
		                
		                <c:if test="<%=Validator.isNotNull(thumbPath)%>">
		                	<img align="left" src="<%=thumbPath %>" alt="article image" width="60" height="60" title="<%=title%>" />
		                </c:if>
		                <a href="<%=viewArticleURL %>"><%=title%></a>
		                <div style="font-size:0.9em;">
						<%=shortDescription%>
						</div>
		                <br />

					</div>
		
					<!--<div class="topic-article-content">
						<%=gnomon.business.StringUtils.subStr(topicedArticle.getArticle().getContent(), 150) %>
						<a href="<%=viewArticleURL %>"><%=LanguageUtil.get(pageContext, "more")%></a>
					</div>-->
					
					<%}%>
					
					<c:if test="<%=topicArticlesWrappers.size()==1%>">
						<portlet:renderURL var="pagingURL">
							<portlet:param name="struts_action" value="/ext/topicarts/view" />
							<portlet:param name="topicid" value="<%=selTopicId%>" />
							<portlet:param name="st" value="<%=secTopicId%>" />
						</portlet:renderURL>
						
						<liferay-ui:page-iterator
							curParam="<%=renderResponse.getNamespace() + "page"%>"
							curValue="<%= articlesPage %>"
							delta="<%= articlesPagesize %>"
							total="<%=totalPages.intValue()*articlesPagesize %>"
							url="<%= pagingURL %>"
						/>
					</c:if>
		        </div>
			</div>
		</c:if>
		
		<%
		} //end loop topics
		%>
	</div>
</c:when>
<c:otherwise>
<%--no topics print user frindly message here, or nothing at all --%>
<div class="portlet-msg-info">
<%=LanguageUtil.get(pageContext, "agrotour.tip.noarticlesfound")%>
</div>
</c:otherwise>
</c:choose>

<%!
protected void addProcessingInstructions(
		Document doc, ThemeDisplay themeDisplay, JournalArticle article) {

		// Add style sheets in the reverse order that they appear in the
		// document

		// Theme CSS

		String url =
			themeDisplay.getPathThemeCss() + "/main.css?companyId=" +
				themeDisplay.getCompanyId() + "&themeId=" +
					themeDisplay.getThemeId() + "&colorSchemeId=" +
						themeDisplay.getColorSchemeId();

		Map arguments = new LinkedHashMap();

		arguments.put("type", "text/css");
		arguments.put("href", url);
		arguments.put("title", "theme css");

		addStyleSheet(doc, url, arguments);

		// CSS cached

		url =
			themeDisplay.getPathMain() + "/portal/css_cached?themeId=" +
				themeDisplay.getThemeId() + "&colorSchemeId=" +
					themeDisplay.getColorSchemeId();

		arguments.clear();

		arguments.put("type", "text/css");
		arguments.put("href", url);
		arguments.put("title", "cached css");
		arguments.put("alternate", "yes");

		addStyleSheet(doc, url, arguments);

		// XSL template

		String templateId = article.getTemplateId();

		if (Validator.isNotNull(templateId)) {
			JournalTemplate template = null;

			try {
				template = JournalTemplateLocalServiceUtil.getTemplate(
					article.getGroupId(), templateId);

				if (Validator.equals(
						template.getLangType(),
						JournalTemplateImpl.LANG_TYPE_XSL)) {

					url =
						themeDisplay.getPathMain() +
							"/journal/get_template?groupId=" +
								article.getGroupId() + "&templateId=" +
									templateId;

					arguments.clear();

					arguments.put("type", "text/xsl");
					arguments.put("href", url);
					arguments.put("title", "xsl");

					addStyleSheet(doc, url, arguments);
				}
			}
			catch (Exception e) {
			}
		}
	}

	protected void addStyleSheet(Document doc, String url, Map arguments) {
		List content = doc.content();
	
		ProcessingInstruction pi =
			DocumentFactory.getInstance().createProcessingInstruction(
				"xml-stylesheet", arguments);
	
		content.add(0, pi);
	}
%>

<%@ include file="/html/portlet/ext/topicarts/select_content_to_add.jspf" %>