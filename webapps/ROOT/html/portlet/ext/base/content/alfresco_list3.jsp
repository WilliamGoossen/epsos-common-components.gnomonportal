<%@ include file="/html/portlet/ext/base/content/init.jsp" %>
<%@ page import="com.ext.portlet.dms.util.*" %>

<% String filePath = GetterUtil.getString(PropsUtil.get("base.news.store"), CommonDefs.DEFAULT_STORE_PATH); %>

<c:choose>
<c:when test="<%=CONTENT_EXISTS%>">
	<%
		List<AlfrescoRow> viewList = (List<AlfrescoRow>) itemsList;
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<% for (AlfrescoRow view: viewList) { %>
		<tr>
		  <td>
		  	<strong>

			  	<a href="<liferay-portlet:actionURL portletName="gn_dms" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
					<portlet:param name="struts_action" value="/ext/dms/getfile"/>
					<portlet:param name="uuid" value="<%= view.getUuid() %>"/>
					<portlet:param name="filename" value="<%= view.getName() %>" />
<!--				<portlet:param name="redirect" value="<%= currentURL %>"/> -->
					</liferay-portlet:actionURL>"><%=StringUtils.check_null(view.getName(),"")%>
				</a>
		  	</strong>
			<%// String cdate = gnomon.business.DateUtils.convertDate(view.getCreated(),"yyyy-MM-dd'T'hh:mm:ss.SSS","dd-MM-yyyy HH:mm:ss"); %>
		  	<c:if test="<%=view.getCreated()!=null%>">
				<em>( <%= view.getCreated() %> )</em>
			</c:if>

		  </td>
		</tr>
		<tr>
		  <td>
		  	<p>
	  <%--
	  		<c:if test="<%=view.getField6()!=null%>">
	  			<img src="/<%=filePath + view.getMainid() + "/" + StringUtils.check_null(view.getField6(),"")%>" alt="news-img" width="87" height="69" hspace="5" vspace="5" align="left" />
	  		</c:if>
	  			<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(view.getField5(),"")).trim(),300)%>
	  			--%>
		  	</p>
		  </td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
	<% } %>
	</table>
</c:when>
<c:otherwise>
<%= LanguageUtil.get(pageContext, "dms.no_documents_found")  %>
</c:otherwise>
</c:choose>