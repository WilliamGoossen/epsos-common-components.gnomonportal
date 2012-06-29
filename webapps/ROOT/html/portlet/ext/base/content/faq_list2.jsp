<%@ include file="/html/portlet/ext/base/content/init.jsp" %>
<%@ page import="gnomon.hibernate.model.base.faq.*" %>

<% String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.faq.store"), CommonDefs.DEFAULT_STORE_PATH); 
long rootPlid = GetterUtil.getLong(prefs.getValue("show_rootPlid", StringPool.BLANK), -1);
%>

<c:choose>
<c:when test="<%=CONTENT_EXISTS%>">
	<%
		String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
							   			"table1.publishDateEnd",
							   			"langs.title",
							   			"langs.description" };
		//List<ViewResult> viewList = GnPersistenceService.getInstance(null).listObjectsWithLanguage(com.liferay.portal.util.PortalUtil.getCompanyId(request),
		//	BsFaq.class, lang, fields,contentCriterion);
		List<ViewResult> viewList  = (java.util.List) request.getAttribute("itemsList");
	%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<% for (ViewResult view: viewList) { %>
		<tr>
		  <td>
		  	<strong>
		  	<% if (rootPlid <= 0) { %>
			  	<a href="<liferay-portlet:renderURL portletName="bs_faq" windowState="<%=WindowState.NORMAL.toString()%>">
					<portlet:param name="struts_action" value="/ext/faq/load"/>
					<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="view"/>
					<portlet:param name="redirect" value="<%= currentURL %>"/>
					</liferay-portlet:renderURL>"><%=StringUtils.check_null(view.getField4(),"")%>
				</a>
			<% } else { 
				PortletURLImpl pURL=null;
				
 		 		 if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, "bs_faq", rootPlid, true);
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, "bs_faq", rootPlid, true);
				}
		
				pURL.setPortletMode(PortletMode.VIEW);
				pURL.setWindowState(WindowState.NORMAL);
				pURL.setParameter("struts_action", "/ext/faq/load");	
   			pURL.setParameter("mainid" ,  view.getMainid().toString());
				pURL.setParameter("loadaction" , "view");
				pURL.setParameter("redirect" , currentURL);
			%>
			<a href="<%= pURL.toString() %>"><%=StringUtils.check_null(view.getField4(),"")%>
				</a>
			<% }  %>		
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