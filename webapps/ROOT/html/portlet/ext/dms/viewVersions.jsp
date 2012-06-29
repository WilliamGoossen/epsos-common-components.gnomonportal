<%@ include file="/html/portlet/ext/dms/init.jsp" %>


<%
long userId=com.liferay.portal.util.PortalUtil.getUserId(request);
org.alfresco.webservice.util.AuthenticationDetails details=(org.alfresco.webservice.util.AuthenticationDetails)request.getSession().getAttribute("authdetails");
String contenttype="content";//ParamUtil.getString(request,"contenttype");
ArrayList contentVersions = (ArrayList)request.getAttribute("contentVersions");
String filename=request.getParameter("filename");
String parentuuid = request.getParameter("parentuuid");
String alfresco_useridtype=PropsUtil.get("alfresco.useridtype");
uuid = request.getParameter("uuid");
boolean hasReadHistory = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,uuid,"ReadProperties");
boolean hasToggleHistory = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,uuid,"WriteProperties");
boolean hasWriteFile = com.ext.portlet.dms.util.AlfrescoContentUtil.hasPermission(details,uuid,"WriteContent");
%>


<%= com.liferay.portal.kernel.util.ParamUtil.getString(request,"error") %>



<c:choose>
<c:when test="<%=(contentVersions!=null && contentVersions.size()>0)%>">
	<c:if test="<%=hasReadHistory%>">
		<display:table name="${contentVersions}" id="ad" defaultsort="3" defaultorder="descending">
<%
			com.ext.portlet.dms.util.AlfrescoRow ar = (com.ext.portlet.dms.util.AlfrescoRow)pageContext.getAttribute("ad");
%>
			<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>" var="url">
				<portlet:param name="struts_action" value="<%=ar.getStruts_action()%>" />
				<portlet:param name="uuid" value="<%= ar.getUuid()%>" />
				<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
				<portlet:param name="filename" value="<%=ar.getName()%>" />
				<portlet:param name="version" value="true" />
			</portlet:actionURL>
			<%
			String extensionimg="";
			try {
				extensionimg = gnomon.business.FileUtils.getFileExtension(ar.getName());
			} catch (Exception e) {
				extensionimg = "_default";
			}
			ar.setIcon(extensionimg);
			%>
			<display:column><a href="<%=url%>"><img align="left" border="0" src="<%=themeDisplay.getPathThemeImage()%>/alfresco/filetypes/<%=ar.getIcon()%>.png"></a></display:column>
			<display:column titleKey="dms.notes"><%=ar.getComment()%></display:column>
			<display:column titleKey="dms.version"><%=ar.getVersion()%></display:column>
			<display:column titleKey="dms.creator">
			<%= gnomon.business.SynchronizeAccountUtil.getInstance().getAlfrescoLoginName(alfresco_useridtype,ar.getCreator()) %>
				</display:column>
			<display:column titleKey="dms.versiondate"><%=ar.getCreated()%></display:column>
		</display:table>
	</c:if>

	<c:if test="<%=hasWriteFile%>">
		<%

		%>
			<portlet:actionURL var="url4">
				<portlet:param name="struts_action" value="/ext/dms/addVersion" />
				<portlet:param name="cmd" value="add" />
			</portlet:actionURL>

<%

		String versionJS = "javascript: toggleById('" + renderResponse.getNamespace() + "versionForm" + "',true); self.focus(); void(0);";
		%>
		<div style="padding-top:20px;">
			<a href="<%=versionJS%>"><%= LanguageUtil.get(pageContext, "dms.addnewversion") %></a>
			<div id="<portlet:namespace />versionForm" style="display: <%="none"%>; padding-top:10px;">
				<form action="<%=url4%>" method="post" name="<portlet:namespace />fm3" enctype="multipart/form-data">
				<input class="form-text" name="<portlet:namespace />uuid" size="30" type="hidden" value="<%= uuid%>">
				<input class="form-text" name="<portlet:namespace />parentuuid" size="30" type="hidden" value="<%= parentuuid%>">
				<input class="form-text" name="<portlet:namespace />contenttype" size="30" type="hidden" value="<%= contenttype%>">
				<input class="form-text" name="<portlet:namespace />cmd" size="30" type="hidden" value="add">
				<input class="form-text" name="oldfilename" size="30" type="hidden" value="<%= filename%>">
				<table>
				<tr>
					<td><%= LanguageUtil.get(pageContext, "dms.filename") %></td>
					<td>
						<input class="form-text" name="docFileContents" size="30" type="file" value="" onChange="javascript:if (this.value!='') {document.getElementById('replaceFileBtn').disabled=false} else {document.getElementById('replaceFileBtn').disabled=true}">
					</td>
				</tr>
				<tr>
					<td><%= LanguageUtil.get(pageContext, "dms.notes") %></td>
					<td>
						<input class="form-text" name="comments" size="30" type="text" value="">
					</td>
				</tr>
				<tr>
					<td colspan=2>
						<input id="replaceFileBtn" disabled class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "submit") %>">
						<input id="cancelBtn" class="portlet-form-button" type="button" onClick="<%=versionJS %>" value="<%= LanguageUtil.get(pageContext, "cancel") %>">
					</td>
				</tr>
				</table>
				</form>
			</div>
		</div>
	</c:if>



</c:when>
<c:otherwise>
	<c:if test="<%=hasReadHistory%>">
		<%= LanguageUtil.get(pageContext, "dms.this-content-is-not-versionable") %>.<br/>
	</c:if>

	<c:if test="<%=hasToggleHistory%>">

			<portlet:actionURL var="url2">
				<portlet:param name="struts_action" value="/ext/dms/makeversionable" />
				<portlet:param name="parentuuid" value="<%= request.getParameter("parentuuid")%>" />
				<portlet:param name="uuid" value="<%= request.getParameter("uuid")%>" />
				<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
				<portlet:param name="filename" value="<%=request.getParameter("filename")%>" />
			</portlet:actionURL>
		<%= LanguageUtil.get(pageContext, "dms.you-can") %>
		<%
		String versionableJS = "javascript: document.forms['" + renderResponse.getNamespace() + "verfm'].submit(); void(0);";
		%>

		<a href="<%=versionableJS%>"><%= LanguageUtil.get(pageContext, "dms.makeversionable") %></a>
		<div id="<portlet:namespace />versionableForm" style="display: <%="none"%>; padding-top:10px;">
			<form action="<%=url2 %>" method="post" name="<portlet:namespace />verfm">
				<input type="submit" value="make-versionable">
			</form>
		</div>
		<c:if test="<%=hasWriteFile%>">
			<%= LanguageUtil.get(pageContext, "dms.or") %>
		</c:if>
	</c:if>

	<c:if test="<%=hasWriteFile%>">

			<portlet:actionURL var="url4">
				<portlet:param name="struts_action" value="/ext/dms/updateContent" />
				<portlet:param name="cmd" value="add" />
			</portlet:actionURL>

		<%
		//String parentuuid = request.getParameter("parentuuid");
		String editJS = "javascript: toggleById('" + renderResponse.getNamespace() + "editForm" + "',true); self.focus(); void(0);";
		%>

		<a href="<%=editJS%>"><%= LanguageUtil.get(pageContext, "dms.change-file") %></a>
		<div id="<portlet:namespace />editForm" style="display: <%="none"%>; padding-top:10px;">
			<form action="<%=url4%>" method="post" name="<portlet:namespace />fm3" enctype="multipart/form-data">
				<input class="form-text" name="<portlet:namespace />uuid" size="30" type="hidden" value="<%= uuid%>">
				<input class="form-text" name="<portlet:namespace />parentuuid" size="30" type="hidden" value="<%= parentuuid%>">
				<input class="form-text" name="<portlet:namespace />cmd" size="30" type="hidden" value="add">
				<input class="form-text" name="docFileContents" size="30" type="file" value="" onChange="javascript:if (this.value!='') {document.getElementById('submitFileBtn').disabled=false} else {document.getElementById('submitFileBtn').disabled=true}">
				<input id="submitFileBtn" disabled class="portlet-form-button" type="submit" value="<%= LanguageUtil.get(pageContext, "dms.changefile") %>">
				<input id="cancelFileBtn" class="portlet-form-button" type="button" onClick="<%=editJS%>" value="<%= LanguageUtil.get(pageContext, "cancel") %>">
			</form>
		</div>
	</c:if>
</c:otherwise>
</c:choose>

<br>
