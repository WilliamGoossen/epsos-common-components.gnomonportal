<%@ include file="/html/portlet/ext/base/documents/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<!-- Documents List -->
<display:table id="document" name="documents" requestURI="//ext/documents/list?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("document"); %>
<display:column titleKey="title" sortable="true" style="width:100%">
<b>
<c:choose>
	<c:when test="<%=gnItem.getField5()!=null%>">
		<%String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(gnItem.getField5().toString(), "page");
			String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+PortalUtil.getCompanyId(request), filePath, gnItem.getMainid(), gnItem.getField5().toString());
		
		
			if( gnomon.business.FileUploadHelper.fileIsImage(extension) && instanceEmbedMedia.equals("yes")) {
			/* IMAGE WITH THUMBNAILS*/
			String thumb = gnomon.business.GeneralUtils.createThumbnailPath(fullpath);
				
		
		%>
				<a href="<%= fullpath%>"  class="thickbox" rel="gallery" title="<%=StringUtils.check_null(gnItem.getField3(),"")%>">
				<img src="<%= thumb%>"  alt="<%=StringUtils.check_null(gnItem.getField3(),"")%>" >
				</a> 
			
			
			
			
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsAudio(extension) && instanceEmbedMedia.equals("yes")) {%>

                            <%
                            String audioURL = fullpath;
                            //if media server is configured, use its path
                            if (Validator.isNotNull(mmsurl))
                                audioURL = mmsurl + audioURL;
                            %>
                            <div id="myOnPageContent<%=gnItem.getMainid()%>">
                                <%--<p><%= description %></p>--%>
                                <object id="mediaPlayer<%=gnItem.getMainid()%>" width="100" height="90" 
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
                                <p><%= ViewResultUtil.getString(gnItem, "Field3") %></p>
                            </div>
		<%} else 	if( gnomon.business.FileUploadHelper.fileIsVideo(extension) && instanceEmbedMedia.equals("yes")) {%>
                            <%
                            String videoURL = fullpath;
                            String thumb = gnomon.business.GeneralUtils.createVideoThumbnailPath(fullpath);
                            if (Validator.isNotNull(mmsurl))
                                videoURL = mmsurl + videoURL;
                            %>
                            <%//=mmsurl + videopath %>
                            <c:if test="<%= useThumbnails %>">
                                <a class="thickbox" href="<%= fullpath%>#TB_inline?height=350&width=330&inlineId=myOnPageContent<%=gnItem.getMainid()%>" rel="documents" title="<%=ViewResultUtil.getString(gnItem, "Field3")%>">
                                <img src="<%= thumb%>" alt="<%=ViewResultUtil.getString(gnItem, "Field3")%>" >
                                <p><%= ViewResultUtil.getString(gnItem, "Field3") %></p>
                                </a>
                            </c:if>
                            <div id="myOnPageContent<%=gnItem.getMainid()%>" style="<%= useThumbnails? "display: none;": ""%>">
                                <%--<p><%= description %></p>--%>
                                <object id="mediaPlayer<%=gnItem.getMainid()%>" width="320" height="304" 
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
                                <p><%= ViewResultUtil.getString(gnItem, "Field3") %></p>
		<%} else {
		
		%>
		
		<img align="left" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
		<a target="_blank" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
						<portlet:param name="struts_action" value="/ext/documents/get_file"/>
						<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="view"/>
						</portlet:actionURL>"><%= gnItem.getField3().toString() %></a>
		</img>
		<%}%>
	</c:when>
	<c:otherwise>
		<%= gnItem.getField3().toString() %>
	</c:otherwise>
</c:choose>
</b>
<br/>
<%= gnItem.getField4()==null? "": gnItem.getField4().toString() %>
</display:column>


<c:if test="<%= hasPublish || hasEdit || hasDelete %>">
<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %><img src="<%= themeDisplay.getPathThemeImage() %>/base/menu.gif" align="absmiddle" border="0"></a>
<br>
<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasPublish %>">
		<c:choose>
		<c:when test="<%=gnItem.getField1().toString().equals("false")%>">
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/plum/iconDocumentApprove.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.approve") %>">
				</td>
				<td>
					<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
							<portlet:param name="struts_action" value="/ext/documents/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="edit"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "gn.link.approve") %>
					</a>
				</td>
			</tr>
		</c:when>
		<c:when test="<%=gnItem.getField1().toString().equals("true")%>">
			<tr>
				<td>
					<img src="<%= themeDisplay.getPathThemeImage() %>/plum/iconDocumentReject.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.reject") %>">
				</td>
				<td>
					<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
							<portlet:param name="struts_action" value="/ext/documents/load"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="edit"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "gn.link.reject") %>
					</a>
				</td>
			</tr>
		</c:when>
		</c:choose>
	</c:if>
	<c:if test="<%= hasEdit %>">
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
		</td>
		<td>
			<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
					<portlet:param name="struts_action" value="/ext/documents/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="edit"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
			</a>
		</td>
	</tr>
	</c:if>
	<c:if test="<%= hasDelete %>">
	<tr>
		<td>
			<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
		</td>
		<td>
			<a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
					<portlet:param name="struts_action" value="/ext/documents/load"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="delete"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
			</a>
		</td>
	</tr>
	</c:if>

	</tbody>
	</table>
</div>
</display:column>
</c:if>

</display:table>
<br/><br/>

<form name="BsDocumentForm" action="/ext/documents/load" method="post">
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/documents/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsDocumentForm" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add value="topicid"/>
	  	<% } %>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add><%= request.getParameter("topicid") %></tiles:add>
	  	<% } %>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:put name="actionPermission" value="add"/>
	  <tiles:put name="partyRoleActionPermission" value="add"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</form>
