<%@ include file="/html/portlet/ext/base/contentrel/init.jsp" %>

<%@ page import="com.ext.portlet.base.search.GnSearchResultRow" %>
<%@ page import="com.ext.portlet.base.contentrel.ContentRelUtil" %>
<%@ page import="com.ext.portlet.cms.generic.lucene.LuceneUtilities" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="java.util.Vector" %>

<tiles:useAttribute id="rel_className" name="className" classname="java.lang.String"/>
<tiles:useAttribute id="rel_primaryKey" name="primaryKey" classname="java.lang.String"/>
<tiles:useAttribute id="rel_style" name="style" classname="java.lang.String" ignore="true"/>

<%

List<String> classNamesList1 = Arrays.asList(classNames);
ArrayList<String> classNamesList = new ArrayList<String>();
classNamesList.addAll(classNamesList1);
classNamesList.add(ContentRelUtil.JOURNAL_CLASSNAME);
classNames = classNamesList.toArray(new String[0]);
String docFields[]={"langs.fileSize","langs.fileName"};
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
long companyId = PortalUtil.getCompanyId(request);
String mmsurl = PropsUtil.get(companyId, "bs.documents.media.server.url");
if (mmsurl!=null && mmsurl.endsWith("/")) 
    mmsurl = mmsurl.substring(0, mmsurl.length()-1);
boolean useThumbnails = GetterUtil.getBoolean(PropsUtil.get(companyId, "bs.documents.video.create.thumbnail"), false);

String lang = GeneralUtils.getLocale(request);
boolean foundAtLeastOneItem = false;
boolean usedHeader = false;
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
			results = relUtil.searchRelatedArticles(companyId, "*", rel_className, rel_primaryKey, themeDisplay);
		}
		else {
			results = LuceneUtilities.searchForRelatedContent(request, lang, "*", new String[]{className}, rel_className, rel_primaryKey);
		}
		if (results != null && results.size() > 0) {
			foundAtLeastOneItem = true;
			String relatedPortletName = relUtil.getPortletNameForClassName(className);
			String langkey =  prefs.getValue("showRelContentLangKey_"+className, StringPool.BLANK);
			long rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+className, StringPool.BLANK));
			
			
			if (isJournal) {
			langkey =  prefs.getValue("showRelContentLangKey_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK);
				relatedPortletName = relUtil.JOURNAL_PORTLET;
				 rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK));
				}
			request.setAttribute("searchResults", results);
			if (!usedHeader) {
				usedHeader = true;
				%>
		<%---		<h3><%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_content_rels") %></h3> --%>
				
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
				<display:table id="<%=tablename%>" name="searchResults" defaultsort="<%=sortcolumn %>" defaultorder="<%=sortorder%>" pagesize="-1" sort="list" export="false" style="width: 100%;">	<% GnSearchResultRow searchItem = (GnSearchResultRow) pageContext.getAttribute(tablename); %>
                <display:setProperty name="basic.show.header" value="false"/>
			<% if (hasDelete) { %>
			<display:column>
			<input type="checkbox" name="rel_relatedItem" value="<%= searchItem.getClassName()+"."+searchItem.getId() %>">
			</display:column>
			<% } %>
			<display:column style="width:100%" sortProperty="date" >
				
				<%
			
	
				if (rootPlid<=0) {
/* IF WE WANT THE CONTENT TO OPEN IN CURRENT LAYOUT */
				%>
				
				
				
				
			<strong>
		
			<% if (searchItem.getPortlet().equals(ContentRelUtil.JOURNAL_PORTLET)) { %>
				<a title="<%= searchItem.getTitle() %>"   href="<%= searchItem.getUrl() %>"><%= searchItem.getTitle() %>
			         </a>
			   <% } else if(!isDocument){ %>
			 	<a title="<%= searchItem.getTitle() %>"  href="<liferay-portlet:actionURL portletName="<%= searchItem.getPortlet() %>" windowState="<%=(isDocument)?"exclusive":"maximized"%>">
					<liferay-portlet:param name="struts_action" value="<%= searchItem.getUrl() %>"/>
					<liferay-portlet:param name="mainid" value="<%= searchItem.getId() %>"/>
					<liferay-portlet:param name="loadaction" value="view"/>
					<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
					</liferay-portlet:actionURL>"><%= searchItem.getTitle() %></a>
			     			        
				 <% } else if (isDocument) { 
					String docTitle=searchItem.getTitle();
					String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
					
						int pos = docTitle.lastIndexOf(StringPool.PERIOD);
						if (pos != -1) {
							docTitle = docTitle.substring(0, pos);
						}
							ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+companyId, filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
					if( gnomon.business.FileUploadHelper.fileIsImage(companyId, extension) && instanceRelEmbedMedia.equals("yes")) {
									/* IMAGE WITH THUMBNAILS*/
								String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
						%>
				
							<a href="<%= fullpath%>"  class="thickbox" rel="gallery" title="<%=StringUtils.check_null(searchItem.getTitle(),"")%>">
							<img src="<%= thumb%>"  alt="<%=StringUtils.check_null(searchItem.getTitle(),"")%>" >
							</a> 
			
			
			
			
		<%} else if( gnomon.business.FileUploadHelper.fileIsAudio(companyId, extension) && instanceRelEmbedMedia.equals("yes")) {
                            String audioURL = fullpath;
                            //if media server is configured, use its path
                            if (Validator.isNotNull(mmsurl))
                                audioURL = mmsurl + audioURL;
                            %>
                            <div id="myOnPageContent<%=searchItem.getId()%>">
                                <%--<p><%= description %></p>--%>
                                <object id="mediaPlayer<%=searchItem.getId()%>" width="100" height="90" 
                                        classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6"
                                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'
                                        standby='Loading Microsoft Windows Media Player components...' type="application/x-oleobject">  
                                    <param name="URL" value="<%= audioURL %>" />
                                    <param name="SendPlayStateChangeEvents" value="True" />
                                    <param name="AutoStart" value="false" />
                                    <param name="defaultFrame" value="1" />
                                    <param name="PlayCount" value="9999" />
                                    <!-- <param name="SAMIFileName" value="captions/sample.smi" /> -->
                                    <embed type="application/x-mplayer2"
                                        pluginspage = "http://www.microsoft.com/Windows/MediaPlayer/en/download/"
                                        src="<%= audioURL %>"
                                        id="mediaPlayer"
                                        width="100"
                                        height="90"
                                        autostart="0">
                                    </embed>
                                </object>
                                <p><%= docTitle %></p>
                            </div>
	
		<%} else if (gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {
                            String videoURL = fullpath;
                            String thumb = gnomon.business.GeneralUtils.createVideoThumbnailPath(fullpath);
                            if (Validator.isNotNull(mmsurl))
                                videoURL = mmsurl + videoURL;
                            %>
                            <%//=mmsurl + videopath %>
                            <c:if test="<%= useThumbnails %>">
                                <a class="thickbox" href="<%= fullpath%>#TB_inline?height=350&width=330&inlineId=myOnPageContent<%=searchItem.getId()%>" rel="documents" title="<%=docTitle%>">
                                <img src="<%= thumb%>" alt="<%=docTitle%>" >
                                <p><%= docTitle %></p>
                                </a>
                            </c:if>
                            <div id="myOnPageContent<%=searchItem.getId()%>" style="<%= useThumbnails? "display: none;": ""%>">
                                <%--<p><%= description %></p>--%>
                                <object id="mediaPlayer<%=searchItem.getId()%>" width="320" height="304" 
                                        classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6"
                                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'
                                        standby='Loading Microsoft Windows Media Player components...' type="application/x-oleobject">  
                                    <param name="URL" value="<%= videoURL %>" />
                                    <param name="SendPlayStateChangeEvents" value="True" />
                                    <param name="AutoStart" value="false" />
                                    <param name="defaultFrame" value="1" />
                                    <param name="PlayCount" value="9999" />
                                    <!-- <param name="SAMIFileName" value="captions/sample.smi" /> -->
                                    <embed type="application/x-mplayer2"
                                        pluginspage = "http://www.microsoft.com/Windows/MediaPlayer/en/download/"
                                        src="<%= videoURL %>"
                                        id="mediaPlayer"
                                        width="320"
                                        height="304"
                                        autostart="0">
                                    </embed>
                                </object>
                                <p><%= docTitle %></p>
                            </div>
		
		<%} else {%>
		
					<a title="<%= searchItem.getTitle() %>"	  href="<liferay-portlet:actionURL portletName="<%= searchItem.getPortlet() %>" windowState="exclusive">
					<liferay-portlet:param name="struts_action" value="<%= searchItem.getUrl() %>"/>
					<liferay-portlet:param name="mainid" value="<%= searchItem.getId() %>"/>
					<liferay-portlet:param name="loadaction" value="view"/>
					<liferay-portlet:param name="redirect" value="<%= currentURL %>"/>
					</liferay-portlet:actionURL>">
					
					
					
					
					
					
					
					
					
					
					
					
					<img style="float:left; border:0;" alt="<%= docTitle %>" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif" />
					
					 <%= docTitle %> ( <%=extension%>  <%=docsize!=null?docsize.intValue() + "KB": ""%> )</a>
					
					<% }
					}%> 
			        
			</strong>
			
			<%}  else { 			
				/* IF WE WANT THE CONTENT TO OPEN IN ANOTHER LAYOUT */
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
				
				<% } else if(isDocument) { 
						String docTitle=searchItem.getTitle();
						String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(docTitle, "page");
				
					
						ViewResult bsdoc= (ViewResult)GnPersistenceService.getInstance(null).getObjectWithLanguage(gnomon.hibernate.model.base.documents.BsDocument.class, new Integer(searchItem.getId()), lang, docFields);
						Double docsize =(Double)bsdoc.getField1();
						String filePath = GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
						String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+companyId, filePath, bsdoc.getMainid(), (String)bsdoc.getField2());
					
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
			
			
			
			
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsAudio(extension) && instanceRelEmbedMedia.equals("yes")) {
                            String audioURL = fullpath;
                            //if media server is configured, use its path
                            if (Validator.isNotNull(mmsurl))
                                audioURL = mmsurl + audioURL;
                            %>
                            <div id="myOnPageContent<%=searchItem.getId()%>">
                                <%--<p><%= description %></p>--%>
                                <object id="mediaPlayer<%=searchItem.getId()%>" width="100" height="90" 
                                        classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6"
                                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'
                                        standby='Loading Microsoft Windows Media Player components...' type="application/x-oleobject">  
                                    <param name="URL" value="<%= audioURL %>" />
                                    <param name="SendPlayStateChangeEvents" value="True" />
                                    <param name="AutoStart" value="false" />
                                    <param name="defaultFrame" value="1" />
                                    <param name="PlayCount" value="9999" />
                                    <!-- <param name="SAMIFileName" value="captions/sample.smi" /> -->
                                    <embed type="application/x-mplayer2"
                                        pluginspage = "http://www.microsoft.com/Windows/MediaPlayer/en/download/"
                                        src="<%= audioURL %>"
                                        id="mediaPlayer"
                                        width="100"
                                        height="90"
                                        autostart="0">
                                    </embed>
                                </object>
                                <p><%= docTitle %></p>
                            </div>
	
		<%} else if( gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceRelEmbedMedia.equals("yes")) {
            String videoURL = fullpath;
            String thumb = gnomon.business.GeneralUtils.createVideoThumbnailPath(fullpath);
            if (Validator.isNotNull(mmsurl))
                videoURL = mmsurl + videoURL;
            %>
            <%//=mmsurl + videopath %>
            <c:if test="<%= useThumbnails %>">
                <a class="thickbox" href="<%= fullpath%>#TB_inline?height=350&width=330&inlineId=myOnPageContent<%=searchItem.getId()%>" rel="documents" title="<%=docTitle%>">
                <img src="<%= thumb%>" alt="<%=docTitle%>" >
                <p><%= docTitle %></p>
                </a>
            </c:if>
            <div id="myOnPageContent<%=searchItem.getId()%>" style="<%= useThumbnails? "display: none;": ""%>">
                <%--<p><%= description %></p>--%>
                <object id="mediaPlayer<%=searchItem.getId()%>" width="320" height="304" 
                        classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6"
                        codebase='http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701'
                        standby='Loading Microsoft Windows Media Player components...' type="application/x-oleobject">  
                    <param name="URL" value="<%= videoURL %>" />
                    <param name="SendPlayStateChangeEvents" value="True" />
                    <param name="AutoStart" value="false" />
                    <param name="defaultFrame" value="1" />
                    <param name="PlayCount" value="9999" />
                    <!-- <param name="SAMIFileName" value="captions/sample.smi" /> -->
                    <embed type="application/x-mplayer2"
                        pluginspage = "http://www.microsoft.com/Windows/MediaPlayer/en/download/"
                        src="<%= videoURL %>"
                        id="mediaPlayer"
                        width="320"
                        height="304"
                        autostart="0">
                    </embed>
                </object>
                <p><%= docTitle %></p>
            </div>
		<%} else {%>
		
					<a title="<%= searchItem.getTitle() %>" href="<%=pURL.toString()%>">
					<img style="float:left; border:0;" alt="<%= searchItem.getTitle() %>" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif" />
					
					 <%= docTitle %> ( <%=extension%>  <%=docsize!=null?docsize.intValue() + "KB": ""%> )</a>
					
					<% }
				}
					 %> 
			        
			</strong>
				
			
			<%} // end of else or rootplid%>
			
			
			
			
			
			
			<% if (Validator.isNotNull(instancePortletShowRelContentDescription) && 
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

if (foundAtLeastOneItem && hasDelete) { %>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "bs.related.content.delete") %>" onClick="return confirm('<%= LanguageUtil.get(pageContext, "bs.related.content.delete-are-you-sure") %>');">
<% } %>

<%if (hasDelete) {  %>
</form>
<%} %>


<% if (hasAdd) { %>
<a href="javascript:openDialog('<liferay-portlet:actionURL portletName="bs_content_rels" windowState="pop_up">
		<liferay-portlet:param name="struts_action" value="/ext/contentrel/search"/>
		<liferay-portlet:param name="rel_className" value="<%= rel_className %>"/>
		<liferay-portlet:param name="rel_primaryKey" value="<%= rel_primaryKey %>"/>
		</liferay-portlet:actionURL>', 650, 450);">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/links.png" alt="link icon">		
<%= LanguageUtil.get(pageContext, "bs.related.content.add") %> ...
</a>	
<% } %>	

</div>

<% } %>