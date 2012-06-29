<%@ include file="/html/portlet/ext/base/contentrel/init.jsp" %>

<%@ page import="com.ext.portlet.base.search.GnSearchResultRow" %>
<%@ page import="com.ext.portlet.base.contentrel.ContentRelUtil" %>
<%@ page import="com.ext.portlet.cms.generic.lucene.LuceneUtilities" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Set" %>

<tiles:useAttribute id="rel_className" name="className" classname="java.lang.String"/>
<tiles:useAttribute id="rel_primaryKey" name="primaryKey" classname="java.lang.String"/>
<tiles:useAttribute id="rel_style" name="style" classname="java.lang.String" ignore="true"/>

<%
String docFields[]={"langs.fileSize","langs.fileName"};
List<String> classNamesList1 = Arrays.asList(classNames);
ArrayList<String> classNamesList = new ArrayList<String>();
classNamesList.addAll(classNamesList1);
classNamesList.add(ContentRelUtil.JOURNAL_CLASSNAME);
classNames = classNamesList.toArray(new String[0]);

// make certain our className is one of the content rel allowed classnames, otherwise do nothing

if (classNamesList.contains(rel_className)) {

	// reorder classNames based on configuration orderIndices if present
	Vector<String> orderVector = new Vector<String>();
	orderVector.setSize(classNames.length);
	for (String pClassName: classNames) {
		String orderIndex = prefs.getValue("showRelContentOrderIndex_"+pClassName, StringPool.BLANK);
		int order = -1;
		try { order = Integer.parseInt(orderIndex); 
		} catch (Exception numE) {}
		if (order >=0 && order<orderVector.size()) 
		{
			if (orderVector.get(order) == null)
				orderVector.remove(order);
			orderVector.add(order, pClassName);
		}
		else
		{
			orderVector.add(pClassName);
		}
	}
	int arrayIndex = 0;
	for (int v=0; v<orderVector.size(); v++) 
	{
		String orderedName = orderVector.get(v);
		if (Validator.isNotNull(orderedName))
		{
			classNames[arrayIndex] = orderedName;
			arrayIndex++;
		}
	}
%>

<script language="JavaScript" src="/html/js/editor/modalwindow.js" type="text/javascript"></script><noscript></noscript>


<div style="<%= rel_style %>">

<!--  here list all related content items -->
<%if (hasDelete) {  %>
<form name="BS_RELATED_CONTENT_LISTS_FORM" action="<liferay-portlet:actionURL portletName="bs_content_rels" windowState="maximized"><liferay-portlet:param name="struts_action" value="/ext/contentrel/deleteRelatedItems"/></liferay-portlet:actionURL>" method="post">
<input type="hidden" name="rel_className" value="<%= rel_className %>">
<input type="hidden" name="rel_primaryKey" value="<%= rel_primaryKey %>">
<input type="hidden" name="redirect" value="<%= currentURL %>">
<%} %>
<%
String lang = GeneralUtils.getLocale(request);
boolean foundAtLeastOneItem = false;
boolean usedHeader = false;
long rootPlid=0;
int count_tables=0;
for (String className: classNames) {
count_tables++;
	if (Validator.isNull(instancePortletShowRelContent) || 
			instancePortletShowRelContent.indexOf(className) != -1) 
	{
		boolean isDocument = className.equals(gnomon.hibernate.model.base.documents.BsDocument.class.getName());
		boolean isJournal = className.equals(ContentRelUtil.JOURNAL_CLASSNAME);
		boolean isNew = className.equals(gnomon.hibernate.model.base.news.BsNew.class.getName());
		
		int sortcolumn=2;
		String sortorder="ascending";
		List<GnSearchResultRow> results = null;
		if (isJournal) {
			results = relUtil.searchRelatedArticles(PortalUtil.getCompanyId(request), "*", rel_className, rel_primaryKey, themeDisplay);
		}
		else {
			results = LuceneUtilities.searchForRelatedContent(request, lang, "*", new String[]{className}, rel_className, rel_primaryKey);
		}
		if (results != null && results.size() > 0) {
		
		if(isDocument) {
			foundAtLeastOneItem = true;
			String relatedPortletName = relUtil.getPortletNameForClassName(className);
				String langkey =  prefs.getValue("showRelContentLangKey_"+className, StringPool.BLANK);
			 rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+className, StringPool.BLANK));
			
			if (isJournal) {
				langkey =  prefs.getValue("showRelContentLangKey_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK);
				relatedPortletName = relUtil.JOURNAL_PORTLET;
				 rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK));
				}
			
			Hashtable<String, ArrayList<GnSearchResultRow>> topicsHash = relUtil.organizeSearchResultsByTopic(results);
			ArrayList<List<GnSearchResultRow>> topicsLists = new ArrayList<List<GnSearchResultRow>>();
			String[] topicNames = null;
			if (topicsHash.size() > 0)
			{
				Iterator<String> topicids = topicsHash.keySet().iterator();
				String topicIdsString = "(";
				while(topicids.hasNext())
				{
					topicIdsString += topicids.next();
					if (topicids.hasNext())
						topicIdsString += ",";
				}
				topicIdsString += ")";
				List<ViewResult> orderedTopicViews = GnPersistenceService.getInstance(null).listObjectsWithLanguage(PortalUtil.getCompanyId(request), GnTopic.class, 
						lang, new String[]{"langs.name"}, " table1.mainid in "+topicIdsString, " table1.systemCode, langs.name ");
				if (orderedTopicViews != null && orderedTopicViews.size()>0)
				{
					topicNames = new String[orderedTopicViews.size()];
					for (int t=0; t<orderedTopicViews.size(); t++) {
						ViewResult tView = orderedTopicViews.get(t);
						topicNames[t] = tView.getField1().toString();
						topicsLists.add(topicsHash.get(tView.getMainid().toString()));
					}
				}
				else
				{
					topicsLists.add(results);
					topicNames = new String[]{""};
				}
			}
			else
			{
				topicsLists.add(results);
				topicNames = new String[]{""};
			}
			for (int list=0; list<topicsLists.size(); list++) {
				List<GnSearchResultRow> topicResults = topicsLists.get(list);
				request.setAttribute("searchResults", topicResults);
				if (!usedHeader) {
					usedHeader = true;
					%>
			<%--		<h3><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_content_rels") %></h3> --%>
					
					<%
				}
				%>
				<fieldset>
				<legend>
						<% if (Validator.isNotNull(langkey)) {%>
				<%= LanguageUtil.get(pageContext, langkey) %> 
			<%} else {%>
				<%= LanguageUtil.get(pageContext, "javax.portlet.title."+relatedPortletName) %>
				<%}%>
				<% if (Validator.isNotNull(topicNames[list])) { 
					out.print(" - "+topicNames[list]);
				 } %>
				</legend>
				<%if( isNew) {
					 sortcolumn=1;
					 sortorder="descending";
					
				}
				%>
				
				<%
				String tablename="item"+count_tables;
				%>
				
				
				<display:table id="<%=tablename%>" name="searchResults" defaultsort="<%=sortcolumn %>" defaultorder="<%=sortorder%>" pagesize="-1" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
                 <display:setProperty name="basic.show.header" value="false"/>
                        
				<% GnSearchResultRow searchItem = (GnSearchResultRow) pageContext.getAttribute(tablename); %>
				<% if (hasDelete) { %>
				<display:column>
				<input type="checkbox" name="rel_relatedItem" value="<%= searchItem.getClassName()+"."+searchItem.getId() %>">
				</display:column>
				<% } %>
				<display:column style="width:100%" sortProperty="date" >
					
				<%	
				if (rootPlid<=0) {

				%>
				
				
					
				<strong>
				
				<% if (searchItem.getPortlet().equals(ContentRelUtil.JOURNAL_PORTLET)) { %>
				 <a title="<%= searchItem.getTitle() %>"  href="<%= searchItem.getUrl() %>"><%= searchItem.getTitle() %> </a>
				   <% } else if(!isDocument) { %>
				  <a title="<%= searchItem.getTitle() %>" href="<liferay-portlet:actionURL portletName="<%= searchItem.getPortlet() %>" windowState="<%=(isDocument)?"exclusive":"maximized"%>">
						<liferay-portlet:param name="struts_action" value="<%= searchItem.getUrl() %>"/>
						<liferay-portlet:param name="mainid" value="<%= searchItem.getId() %>"/>
						<liferay-portlet:param name="loadaction" value="view"/>
						<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
						</liferay-portlet:actionURL>"><%= searchItem.getTitle() %> </a>
						<% } else if(isDocument) { 
						String docTitle=searchItem.getTitle();
						String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
				
					
						ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+PortalUtil.getCompanyId(request), filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
						if( gnomon.business.FileUploadHelper.fileIsImage(extension) && instanceRelEmbedMedia.equals("yes")) {
									/* IMAGE WITH THUMBNAILS*/
						String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
						
						
						int pos = docTitle.lastIndexOf(StringPool.PERIOD);
						if (pos != -1) {
							docTitle = docTitle.substring(0, pos);
						}
				%>
				
				<a href="<%= fullpath%>"  class="thickbox" rel="gallery" title="<%=StringUtils.check_null(searchItem.getTitle(),"")%>">
				<img src="<%= thumb%>"  alt="<%=StringUtils.check_null(searchItem.getTitle(),"")%>" >
				</a> 
			
			
			
			
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsAudio(extension) && instanceRelEmbedMedia.equals("yes")) {%>


	<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="70">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="allowscriptaccess" value="always" />
		<param name="wmode" value="opaque">
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="70">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
	
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {%>
		<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="200">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="wmode" value="opaque">
		<param name="allowscriptaccess" value="always" />
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="200">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
		<%} else {%>
		
					  <a title="<%= searchItem.getTitle() %>" href="<liferay-portlet:actionURL portletName="<%= searchItem.getPortlet() %>" windowState="<%=(isDocument)?"exclusive":"maximized"%>">
						<liferay-portlet:param name="struts_action" value="<%= searchItem.getUrl() %>"/>
						<liferay-portlet:param name="mainid" value="<%= searchItem.getId() %>"/>
						<liferay-portlet:param name="loadaction" value="view"/>
						<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
						</liferay-portlet:actionURL>"> 
					<img alt="gif icon" style="float:left; border:0;" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
					
					 <%= docTitle %> ( <%=extension%>  <%=docsize.intValue()%> KB)</a>
					
					<% }
				}
					 %> 
			        
				</strong>
				
				
				
				
				
				
				
				
				
				
				
					<%} else {
				PortletURLImpl pURL=null;
				
  		  if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, searchItem.getPortlet(), rootPlid, true);
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, searchItem.getPortlet(), rootPlid, true);
				}
    
  
		
				 if(isDocument)
				 	pURL.setWindowState("exclusive");
				else
					pURL.setWindowState(WindowState.NORMAL);
			
				pURL.setPortletMode(PortletMode.VIEW);
				pURL.setParameter("struts_action",  searchItem.getUrl() );	
    		pURL.setParameter("mainid" ,  searchItem.getId());
				pURL.setParameter("loadaction" , "view");
				pURL.setParameter("redirect" , currentURL);
			
			
			%>
				
				<strong>
			<% if (!isDocument) { %>
					<a title="<%= searchItem.getTitle() %>"	href="<%=pURL.toString()%>"> <%= searchItem.getTitle() %>  </a>
				
				<% }  else if(isDocument) { 
						String docTitle=searchItem.getTitle();
						String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
				
					
						ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+PortalUtil.getCompanyId(request), filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
						if( gnomon.business.FileUploadHelper.fileIsImage(extension) && instanceRelEmbedMedia.equals("yes")) {
									/* IMAGE WITH THUMBNAILS*/
						String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
						
						
						int pos = docTitle.lastIndexOf(StringPool.PERIOD);
						if (pos != -1) {
							docTitle = docTitle.substring(0, pos);
						}
				%>
				
				<a href="<%= fullpath%>"  class="thickbox" rel="gallery" title="<%=StringUtils.check_null(searchItem.getTitle(),"")%>">
				<img src="<%= thumb%>"  alt="<%=StringUtils.check_null(searchItem.getTitle(),"")%>" >
				</a> 
			
			
			
			
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsAudio(extension) && instanceRelEmbedMedia.equals("yes")) {%>


	<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="70">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="allowscriptaccess" value="always" />
		<param name="wmode" value="opaque">
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="70">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
	
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {%>
		<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="200">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="wmode" value="opaque">
		<param name="allowscriptaccess" value="always" />
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="200">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
		<%} else {%>
		
					<a title="<%= searchItem.getTitle() %>" href="<%=pURL.toString()%>">
					<img alt="gif icon" style="float:left; border:0;" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
					
					 <%= docTitle %> ( <%=extension%>  <%=docsize.intValue()%> KB)</a>
					
					<% }
				}
					 %> 
			        
			</strong>
				
			
			<%} %>
				
				
				
				
				
				<% if (Validator.isNotNull(instancePortletShowRelContentDescription) &&
					instancePortletShowRelContentDescription.indexOf(className) != -1) { %> 
					<br/>
					<%= StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(searchItem.getDescription(),"")).trim(),500) %>
				<% } %>
				</display:column>
				</display:table>
				</fieldset>
			<% }
			}
			
		else {
			foundAtLeastOneItem = true;
			String relatedPortletName = relUtil.getPortletNameForClassName(className);
				String langkey =  prefs.getValue("showRelContentLangKey_"+className, StringPool.BLANK);
			 rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+className, StringPool.BLANK));
			
			if (isJournal) {
				relatedPortletName = relUtil.JOURNAL_PORTLET;
				langkey =  prefs.getValue("showRelContentLangKey_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK);
				relatedPortletName = relUtil.JOURNAL_PORTLET;
				 rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK));
				}
			request.setAttribute("searchResults", results);
			if (!usedHeader) {
				usedHeader = true;
				%>
	<%--			<h3><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_content_rels") %></h3> --%>
				
				<%
			}
			%>
			<fieldset>
			<legend>
					<% if (Validator.isNotNull(langkey)) {%>
				<%= LanguageUtil.get(pageContext, langkey) %> 
			<%} else {%>
			<%= LanguageUtil.get(pageContext, "javax.portlet.title."+relatedPortletName) %>
			<%}%>
			</legend>
	
	
		
			<%if( isNew) {
					 sortcolumn=1;
					 sortorder="descending";
					
				}
				%>
				<%
				String tablename="item"+count_tables;
				%>
				
		
		<display:table id="<%=tablename%>" name="searchResults"  defaultsort="<%=sortcolumn %>" defaultorder="<%=sortorder%>" pagesize="-1" sort="list" export="false" style="width: 100%; ">
        <display:setProperty name="basic.show.header" value="false"/>
		
			<% GnSearchResultRow searchItem = (GnSearchResultRow) pageContext.getAttribute(tablename); %>
			<% if (hasDelete) { %>
			<display:column>
			<input type="checkbox" name="rel_relatedItem" value="<%= searchItem.getClassName()+"."+searchItem.getId() %>">
			</display:column>
			<% } %>
				
				
			<display:column style="width:100%" sortProperty="date"  >
		<%	
				if (rootPlid<=0) {

				%>
				
				
					
				<strong>
				
				<% if (searchItem.getPortlet().equals(ContentRelUtil.JOURNAL_PORTLET)) { %>
				 <a title="<%= searchItem.getTitle() %>"  href="<%= searchItem.getUrl() %>"><%= searchItem.getTitle() %> </a>
				   <% } else if(!isDocument) { %>
				  <a title="<%= searchItem.getTitle() %>" href="<liferay-portlet:actionURL portletName="<%= searchItem.getPortlet() %>" windowState="<%=(isDocument)?"exclusive":"maximized"%>">
						<liferay-portlet:param name="struts_action" value="<%= searchItem.getUrl() %>"/>
						<liferay-portlet:param name="mainid" value="<%= searchItem.getId() %>"/>
						<liferay-portlet:param name="loadaction" value="view"/>
						<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
						</liferay-portlet:actionURL>"><%= searchItem.getTitle() %> </a>
						<% } else if(isDocument) { 
						String docTitle=searchItem.getTitle();
						String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
				
					
						ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+PortalUtil.getCompanyId(request), filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
						if( gnomon.business.FileUploadHelper.fileIsImage(extension) && instanceRelEmbedMedia.equals("yes")) {
									/* IMAGE WITH THUMBNAILS*/
						String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
						
						
						int pos = docTitle.lastIndexOf(StringPool.PERIOD);
						if (pos != -1) {
							docTitle = docTitle.substring(0, pos);
						}
				%>
				
				<a href="<%= fullpath%>"  class="thickbox" rel="gallery" title="<%=StringUtils.check_null(searchItem.getTitle(),"")%>">
				<img src="<%= thumb%>"  alt="<%=StringUtils.check_null(searchItem.getTitle(),"")%>" >
				</a> 
			
			
			
			
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsAudio(extension) && instanceRelEmbedMedia.equals("yes")) {%>


	<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="70">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="allowscriptaccess" value="always" />
		<param name="wmode" value="opaque">
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="70">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
	
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {%>
		<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="200">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="wmode" value="opaque">
		<param name="allowscriptaccess" value="always" />
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="200">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
		<%} else {%>
		
					  <a title="<%= searchItem.getTitle() %>" href="<liferay-portlet:actionURL portletName="<%= searchItem.getPortlet() %>" windowState="<%=(isDocument)?"exclusive":"maximized"%>">
						<liferay-portlet:param name="struts_action" value="<%= searchItem.getUrl() %>"/>
						<liferay-portlet:param name="mainid" value="<%= searchItem.getId() %>"/>
						<liferay-portlet:param name="loadaction" value="view"/>
						<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
						</liferay-portlet:actionURL>">
					<img style="float:left; border:0;" alt="<%= searchItem.getTitle() %>" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
					
					 <%= docTitle %> ( <%=extension%>  <%=docsize.intValue()%> KB)</a>
					
					<% }
				}
					 %> 
			        
				</strong>
				
				
				
				
				
			
			
				<%} else {
				PortletURLImpl pURL=null;
				
  		  if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, searchItem.getPortlet(), rootPlid, true);
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, searchItem.getPortlet(), rootPlid, true);
				}
    
  
		   if(isDocument)
		   		pURL.setWindowState("exclusive");
				else
					pURL.setWindowState(WindowState.NORMAL);
				pURL.setPortletMode(PortletMode.VIEW);
				pURL.setParameter("struts_action",  searchItem.getUrl() );	
    		pURL.setParameter("mainid" ,  searchItem.getId());
				pURL.setParameter("loadaction" , "view");
				pURL.setParameter("redirect" , currentURL);
			
			
			%>
				
					<strong>
			<% if (!isDocument) { %>
					<a title="<%= searchItem.getTitle() %>"	href="<%=pURL.toString()%>"> <%= searchItem.getTitle() %>  </a>
				
				<% }  else if(isDocument) { 
						String docTitle=searchItem.getTitle();
						String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
				
					
						ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+PortalUtil.getCompanyId(request), filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
						if( gnomon.business.FileUploadHelper.fileIsImage(extension) && instanceRelEmbedMedia.equals("yes")) {
									/* IMAGE WITH THUMBNAILS*/
						String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
						
						
						int pos = docTitle.lastIndexOf(StringPool.PERIOD);
						if (pos != -1) {
							docTitle = docTitle.substring(0, pos);
						}
				%>
				
				<a href="<%= fullpath%>"  class="thickbox" rel="gallery" title="<%=StringUtils.check_null(searchItem.getTitle(),"")%>">
				<img src="<%= thumb%>"  alt="<%=StringUtils.check_null(searchItem.getTitle(),"")%>" >
				</a> 
			
			
			
			
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsAudio(extension) && instanceRelEmbedMedia.equals("yes")) {%>


	<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="70">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="allowscriptaccess" value="always" />
		<param name="wmode" value="opaque">
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="70">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
	
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {%>
		<object id="player" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" name="player" width="200" height="200">
		<param name="movie" value="/html/js/mediaplayer/player.swf" />
		<param name="allowfullscreen" value="true" />
		<param name="wmode" value="opaque">
		<param name="allowscriptaccess" value="always" />
		<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
		<object type="application/x-shockwave-flash" data="/html/js/mediaplayer/player.swf" width="200" height="200">
			<param name="movie" value="/html/js/mediaplayer/player.swf" />
			<param name="allowfullscreen" value="true" />
			<param name="allowscriptaccess" value="always" />
			<param name="wmode" value="opaque">
			<param name="flashvars" value="file=<%=fullpath%>&image=preview.jpg" />
			<p><a href="http://get.adobe.com/flashplayer">Get Flash</a> to see this player.</p>
		</object>
	</object>
	<p><%= searchItem.getTitle().toString() %></p>
		<%} else {%>
		
					<a title="<%= searchItem.getTitle() %>" href="<%=pURL.toString()%>">
					<img alt="gif icon" style="float:left; border:0;" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
					
					 <%= docTitle %> ( <%=extension%>  <%=docsize.intValue()%> KB)</a>
					
					<% }
				}
					 %> 
			        
			</strong>
				
			
			<%} %>
			
			<% if (Validator.isNotNull(instancePortletShowRelContentDescription)  &&
				instancePortletShowRelContentDescription.indexOf(className) != -1) { %> 
			<br/>
			<% if (className.equals(gnomon.hibernate.model.base.news.BsNew.class.getName())) { %>
			<%= StringUtils.check_null(searchItem.getDescription(),"") %>
			<% } else { %>
			<%= StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(searchItem.getDescription(),"")).trim(),500) %>
			<% } %>
			<% } %>
			</display:column>
			</display:table>
			</fieldset>
			<%
			}
		}
	}
}

if (foundAtLeastOneItem && hasDelete) { %>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "bs.related.content.delete") %>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "bs.related.content.delete-are-you-sure") %>');">
<% } %>
<%if (hasDelete) {  %>
</form>
<%} %>

<br>	

<% if (hasAdd) { %>
<a href="javascript:openDialog('<liferay-portlet:actionURL portletName="bs_content_rels" windowState="pop_up">
		<liferay-portlet:param name="struts_action" value="/ext/contentrel/search"/>
		<liferay-portlet:param name="rel_className" value="<%= rel_className %>"/>
		<liferay-portlet:param name="rel_primaryKey" value="<%= rel_primaryKey %>"/>
		</liferay-portlet:actionURL>', 650, 450);">
<img alt="link icon" src="<%= themeDisplay.getPathThemeImage() %>/common/links.png">		
<%= LanguageUtil.get(pageContext, "bs.related.content.add") %> ...
</a>	
<% } %>	

</div>

<% } %>