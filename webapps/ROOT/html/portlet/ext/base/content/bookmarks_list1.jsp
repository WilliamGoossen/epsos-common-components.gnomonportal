<%@ include file="/html/portlet/ext/base/content/init.jsp" %>
<%@ page import="gnomon.hibernate.model.base.bookmarks.*" %>

<% String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.bookmarks.store"), CommonDefs.DEFAULT_STORE_PATH); %>

<c:choose>
<c:when test="<%=CONTENT_EXISTS%>">
	<%
		String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
							   			"table1.publishDateEnd",
							   			"langs.title",
							   			"langs.description",
							   			"langs.url" };
		//List<ViewResult> viewList = GnPersistenceService.getInstance(null).listObjectsWithLanguage(com.liferay.portal.util.PortalUtil.getCompanyId(request),
		//	BsBookmark.class, lang, fields,contentCriterion);
		List<ViewResult> viewList  = (java.util.List) request.getAttribute("itemsList");
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<% for (ViewResult view: viewList) { %>
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
	<% } %>
	</table>
</c:when>
<c:otherwise>
There is no recent content of the selected type
</c:otherwise>
</c:choose>