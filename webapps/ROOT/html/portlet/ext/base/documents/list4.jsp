<%@ include file="/html/portlet/ext/base/documents/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
List gnitems = (List) request.getAttribute("documents");
Integer itemsInGrid = GetterUtil.getInteger(PrefsPropsUtil.getString(companyId, "bs.documents.video.thumbnail.itemsInGrid"), 4);
Integer prPageSize = GetterUtil.getInteger(PrefsPropsUtil.getString(companyId, "bs.documents.video.thumbnail.pagesize"), 10);

org.displaytag.util.ParamEncoder param_encoder = new org.displaytag.util.ParamEncoder("document");
String pencoded=param_encoder.encodeParameterName("p");
String pageNumStr = request.getParameter(pencoded);
int pageNum = ParamUtil.getInteger(request, pageNumStr, 1);

Integer gnrownum= (prPageSize*itemsInGrid)*(pageNum-1);
Integer uppage = gnrownum + prPageSize*itemsInGrid;
%>

<!-- Documents List -->
<display:table id="document" name="documents" requestURI="//ext/documents/list?actionURL=true" pagesize="<%=prPageSize*itemsInGrid%>" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">

<display:setProperty name="basic.show.header" value="true"/>
<display:setProperty name="css.tr.even" value="gridrow"/>
<display:setProperty name="css.tr.odd" value="gridrow"/>
<display:setProperty name="css.table" value="gridtable"/>

<% int disprownum = (Integer) pageContext.getAttribute("document_rowNum"); %>

<display:column titleKey="title" sortable="true" style="width:100%">

<div class="<%= disprownum % 2 == 0? "listing-type-grid-even": "listing-type-grid-odd" %>">
<c:if test="<%= gnrownum < gnitems.size() && gnrownum < uppage %>"> 
    <ul class="grid-row">    
    <% 
    for(int j=0; j<itemsInGrid;j++) {
        if (gnrownum < gnitems.size() && gnrownum < uppage) {
            ViewResult gnItem = (ViewResult) gnitems.get(gnrownum);
            gnrownum=gnrownum+1;
            
            if (gnItem!=null ) { %>
                <li class="griditem">
                    <%--here include thumbnail presentation--%>
                    <%
                    String filename = ViewResultUtil.getString(gnItem, "Field5");
                    String title = ViewResultUtil.getString(gnItem, "Field3");
                    String description = ViewResultUtil.getString(gnItem, "Field4");
                    Date publishDate = (gnItem!=null && gnItem.getField2()!=null)? (Date)gnItem.getField2(): null;
                    String dateStr = publishDate!=null? org.apache.commons.lang.time.FastDateFormat.getInstance("dd/MM/yyyy").format(publishDate): "";
                    Integer mainid = gnItem.getMainid();
                    %>
                    <c:choose>
                    <c:when test="<%=Validator.isNotNull(filename)%>">
                        <%
                        String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(filename, "page");
                        String fullpath = gnomon.business.FileUploadHelper.getFullWebPathWithIdAndName("/FILESYSTEM/"+companyId, filePath, mainid, filename);
                        boolean fileIsImage = FileUploadHelper.fileIsImage(companyId, extension);
                        boolean fileIsAudio = FileUploadHelper.fileIsAudio(companyId, extension);
                        boolean fileIsVideo = FileUploadHelper.fileIsVideo(companyId, extension);
                        String preferredPlayer = (extension.equals("flv") || Validator.isNull(mmsurl)) ?"FLV_PLAYER":"MEDIA_PLAYER";
                        %>
                        
                        <c:choose>
                        <c:when test="<%= embedMultimedia && fileIsImage %>">
                            <a href="<%= fullpath%>"  class="thickbox" rel="gallery" title="<%=title%>">
                            <img src="<%= GeneralUtils.createThumbnailPath(fullpath)%>"  alt="<%=title%>" >
                            </a>
                        </c:when>
                        <c:when test="<%= embedMultimedia && fileIsAudio %>">
                            <%
                            String audioURL = fullpath;
                            //if media server is configured, use its path
                            if (Validator.isNotNull(mmsurl))
                                audioURL = mmsurl + audioURL;
                            %>
                            <div id="myOnPageContent<%=mainid%>">
                                <%--<p><%= description %></p>--%>
                                <object id="mediaPlayer<%=mainid%>" width="100" height="90" 
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
                                <p><%= title %></p>
                            </div>
                        </c:when>
                        <c:when test="<%= embedMultimedia && fileIsVideo %>">                          
                            <%
                            String videoURL = fullpath;
                            String thumb = gnomon.business.GeneralUtils.createVideoThumbnailPath(fullpath);
                            if (Validator.isNotNull(mmsurl))
                                videoURL = mmsurl + videoURL;
                            %>
                            <%//=mmsurl + videopath %>
                            <c:if test="<%= useThumbnails %>">
                                <a class="thickbox" href="<%= fullpath%>#TB_inline?height=350&width=330&inlineId=myOnPageContent<%=mainid%>" rel="documents" title="<%=title%>">
                                <img src="<%= thumb%>" alt="<%=title%>" >
                                <p><%= title %></p>
                                   </a>
                                <p><%= dateStr %></p>
                            </c:if>
                            <div id="myOnPageContent<%=mainid%>" style="<%= useThumbnails? "display: none;": ""%>">
                                <%--<p><%= description %></p>--%>
                                <object id="mediaPlayer<%=mainid%>" width="320" height="304" 
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
                                <p><%= title %></p>
                            </div>
                            
                        </c:when>
                        <c:otherwise>
                            <img align="left" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
                            <a target="_blank" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
                                    <portlet:param name="struts_action" value="/ext/documents/get_file"/>
                                    <portlet:param name="mainid" value="<%= mainid.toString() %>"/>
                                    <portlet:param name="loadaction" value="view"/>
                                    </portlet:actionURL>"><%= title %></a>
                        </c:otherwise>
                        </c:choose>
                        
                    </c:when>
                    <c:otherwise>
                        <%= title %>
                    </c:otherwise>
                    </c:choose>
                    
                    <%-- administration goes here..--%>
                    <c:if test="<%= hasPublish || hasEdit || hasDelete %>">
                        <div>
                            <c:if test="<%= hasEdit %>">
                                <a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
                                    <portlet:param name="struts_action" value="/ext/documents/load"/>
                                    <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
                                    <portlet:param name="loadaction" value="edit"/>
                                    <portlet:param name="redirect" value="<%=currentURL%>"/>
                                    </portlet:actionURL>">
                                <img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
                                </a>
                            </c:if>
                            <c:if test="<%= hasDelete %>">
                                <a href="<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
                                        <portlet:param name="struts_action" value="/ext/documents/load"/>
                                        <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
                                        <portlet:param name="loadaction" value="delete"/>
                                        <portlet:param name="redirect" value="<%=currentURL%>"/>
                                        </portlet:actionURL>">
                                <img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>"></a>
                                </a>
                            </c:if>
                        </div>

                    </c:if>
                    
                </li> <%-- end of grid item  --%>
            <%} //end if gnItem!=null %>
        <% } //end if (gnrownum < gnitems.size() && gnrownum < uppage) %>
    <% } //end for all documents loop %>
    </ul>
</c:if>
</div>
</display:column>

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
