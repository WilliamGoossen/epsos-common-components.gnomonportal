<%@ include file="/html/portlet/ext/base/content/init.jsp" %>
<%@ page import="gnomon.hibernate.model.base.bookmarks.*" %>
<%@ page import="gnomon.hibernate.model.base.documents.*" %>
<%@ page import="gnomon.hibernate.model.base.events.*" %>
<%@ page import="gnomon.hibernate.model.base.civitems.*" %>
<%@ page import="gnomon.hibernate.model.base.faq.*" %>
<%@ page import="gnomon.hibernate.model.base.news.*" %>


<c:choose>
<c:when test="<%=CONTENT_EXISTS%>">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<% for (GnContent item: contentList) { %>
	<c:choose>
		<c:when test="<%=BsBookmark.class.getName().equals(item.getClassName()) %>">
			<%
				String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.bookmarks.store"), CommonDefs.DEFAULT_STORE_PATH);
				String fields[] = new String[] {"table1.published",
									"table1.publishDateStart",
						   			"table1.publishDateEnd",
						   			"langs.title",
						   			"langs.description",
						   			"langs.url" };
				ViewResult view = GnPersistenceService.getInstance(null).getObjectWithLanguage(BsBookmark.class, item.getMainid(),
						lang, fields);
			%>
			<c:if test="<%=(view!=null) %>">
			<tr>
			  <td>
			  	<strong>
			  		<a href="<%=StringUtils.check_null(view.getField6(),"")%>" target="<%=view.getField4().toString()%>">
			  			<%=StringUtils.check_null(view.getField4(),"")%>
					</a>
			  	</strong>
			  	<c:if test="<%=view.getField2()!=null%>">
					<em>( <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField2())%> )</em>
				</c:if>
			  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</c:if>
		</c:when>

		<c:when test="<%=BsDocument.class.getName().equals(item.getClassName()) %>">
			<%
				String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.documents.store"), CommonDefs.DEFAULT_STORE_PATH);
				String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
							   			"table1.publishDateEnd",
							   			"langs.title",
							   			"langs.description",
							   			"langs.fileName" };
				ViewResult view = GnPersistenceService.getInstance(null).getObjectWithLanguage(BsDocument.class, item.getMainid(),
						lang, fields);
			%>
			<c:if test="<%=(view!=null) %>">
			<tr>
			  <td>
			  	<strong>
					<%String extension = gnomon.business.FileUploadHelper.getFileFilteredExtension(StringUtils.check_null(view.getField6(),""), "page");%>
					<img width="18px" height="18px" align="left" border="0" src="<%=themeDisplay.getPathThemeImage() + "/document_library/" + extension%>.gif">
					&nbsp;
					<a href="<%=themeDisplay.getPathMain() + "/ext/documents/get_file?mainid=" + view.getMainid().toString() %>">
						<%=StringUtils.check_null(view.getField4(),"")%>
					</a>
					</img>
			  	</strong>
			  	<c:if test="<%=view.getField2()!=null%>">
					<em>( <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField2())%> )</em>
				</c:if>
			  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</c:if>
		</c:when>

		<c:when test="<%=BsEvent.class.getName().equals(item.getClassName()) %>">
			<%
				String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.events.store"), CommonDefs.DEFAULT_STORE_PATH);
				String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
							   			"table1.eventDateStart",
							   			"langs.title",
							   			"langs.description",
							   			"table1.eventTime",
							   			"table1.eventType" };
				ViewResult view = GnPersistenceService.getInstance(null).getObjectWithLanguage(BsEvent.class, item.getMainid(),
						lang, fields);
			%>
			<c:if test="<%=(view!=null) %>">
			<tr>
			  <td>
			  	<strong>
				  	<a href="<liferay-portlet:renderURL portletName="bs_events" windowState="<%=WindowState.NORMAL.toString()%>">
						<portlet:param name="struts_action" value="/ext/events/load"/>
						<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="view"/>
						<portlet:param name="redirect" value="/web/guest/events"/>
						</liferay-portlet:renderURL>"><%=StringUtils.check_null(view.getField4(),"")%>
					</a>
			  	</strong>
			  	<c:if test="<%=view.getField3()!=null%>">
					<em>( <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField3())%> )</em>
				</c:if>
			  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</c:if>
		</c:when>
		
		<c:when test="<%=BsCivItem.class.getName().equals(item.getClassName()) %>">
			<%
				String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.civitems.store"), CommonDefs.DEFAULT_STORE_PATH);
				String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
										"table1.code",
										"table1.imageFile",
							   			"table1.attachmentFile",
										"langs.title",
							   			"langs.description"
							   			 };
				ViewResult view = GnPersistenceService.getInstance(null).getObjectWithLanguage(BsCivItem.class, item.getMainid(),
						lang, fields);
			%>
			<c:if test="<%=(view!=null) %>">
			<tr>
			  <td>
			  	<strong>
				  	<a href="<liferay-portlet:renderURL portletName="bs_civitems" windowState="<%=WindowState.NORMAL.toString()%>">
						<portlet:param name="struts_action" value="/ext/civitems/load"/>
						<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="view"/>
						<portlet:param name="redirect" value="/web/guest/civitems"/>
						</liferay-portlet:renderURL>"><%=StringUtils.check_null(view.getField6(),"")%>
					</a>
			  	</strong>
			  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</c:if>
		</c:when>
		
		
		<c:when test="<%=BsFaq.class.getName().equals(item.getClassName()) %>">
			<%
				String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.faq.store"), CommonDefs.DEFAULT_STORE_PATH);
				String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
							   			"table1.publishDateEnd",
							   			"langs.title",
							   			"langs.description" };
				ViewResult view = GnPersistenceService.getInstance(null).getObjectWithLanguage(BsFaq.class, item.getMainid(),
						lang, fields);
			%>
			<c:if test="<%=(view!=null) %>">
			<tr>
			  <td>
			  	<strong>
				  	<a href="<liferay-portlet:renderURL portletName="bs_faq" windowState="<%=WindowState.NORMAL.toString()%>">
						<portlet:param name="struts_action" value="/ext/faq/load"/>
						<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="view"/>
						<portlet:param name="redirect" value="/web/guest/faqs"/>
						</liferay-portlet:renderURL>"><%=StringUtils.check_null(view.getField4(),"")%>
					</a>
			  	</strong>
			  	<c:if test="<%=view.getField3()!=null%>">
					<em>( <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField3())%> )</em>
				</c:if>
			  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</c:if>
		</c:when>

		<c:when test="<%=BsNew.class.getName().equals(item.getClassName()) %>">
			<%
				String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.news.store"), CommonDefs.DEFAULT_STORE_PATH);
				String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
							   			"table1.newDate",
							   			"langs.title",
							   			"langs.description",
							   			"langs.image" };
				ViewResult view = GnPersistenceService.getInstance(null).getObjectWithLanguage(BsNew.class, item.getMainid(),
						lang, fields);
			%>
			<c:if test="<%=(view!=null) %>">
			<tr>
			  <td>
			  	<strong>
				  	<a href="<liferay-portlet:renderURL portletName="bs_news" windowState="<%=WindowState.NORMAL.toString()%>">
						<portlet:param name="struts_action" value="/ext/news/load"/>
						<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="view"/>
						<portlet:param name="redirect" value="/web/guest/news"/>
						</liferay-portlet:renderURL>"><%=StringUtils.check_null(view.getField4(),"")%>
					</a>
			  	</strong>
			  	<c:if test="<%=view.getField2()!=null%>">
					<em>( <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)view.getField2())%> )</em>
				</c:if>
			  </td>
			</tr>
			<tr>
			  <td>
			  	<p>
		  		<c:if test="<%=view.getField6()!=null%>">
		  			<img src="/<%=filePath + view.getMainid() + "/" + StringUtils.check_null(view.getField6(),"")%>" alt="news-img" width="87" height="69" hspace="5" vspace="5" align="left" />
		  		</c:if>
		  			<%//=StringUtils.check_null(view.getField5(),"")%>
			  	</p>
			  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
			</c:if>
		</c:when>

		<c:otherwise>
		<%--
			<tr>
			  <td>
			  	<strong>
				  	<a href="<liferay-portlet:renderURL portletName="bs_news" windowState="<%=WindowState.NORMAL.toString()%>">
						<portlet:param name="struts_action" value="/ext/news/load"/>
						<portlet:param name="mainid" value="<%= item.getMainid().toString() %>"/>
						<portlet:param name="loadaction" value="view"/>
						<portlet:param name="redirect" value="/web/guest/news"/>
						</liferay-portlet:renderURL>"><%=StringUtils.check_null(item.getClassName(),"")%>
					</a>
			  	</strong>
			  	<c:if test="<%=item.getPublishDateStart()!=null%>">
					<em>( <%=FastDateFormat.getInstance("dd/MM/yyyy").format((Date)item.getPublishDateStart())%> )</em>
				</c:if>
			  </td>
			</tr>
			<tr>
				<td>&nbsp;</td>
			</tr>
		--%>
		</c:otherwise>
		</c:choose>

	<% } %>
	</table>
</c:when>
<c:otherwise>
There is no recent content
</c:otherwise>
</c:choose>