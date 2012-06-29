<%@ include file="/html/portlet/ext/base/content/init.jsp" %>
<%@ page import="gnomon.hibernate.model.base.news.*" %>

<% String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.news.store"), CommonDefs.DEFAULT_STORE_PATH); 
   long rootPlid = GetterUtil.getLong(prefs.getValue("show_rootPlid", StringPool.BLANK), -1);
%>

<c:choose>
<c:when test="<%=CONTENT_EXISTS%>">
	<%
		String fields[] = new String[] {"table1.published",
										"table1.publishDateStart",
							   			"table1.newDate",
							   			"langs.title",
							   			"langs.shortDescription",
							   			"langs.image" };
		//List<ViewResult> viewList = GnPersistenceService.getInstance(null).listObjectsWithLanguage(com.liferay.portal.util.PortalUtil.getCompanyId(request),
		//	BsNew.class, lang, fields,contentCriterion);
		List<ViewResult> viewList  = (java.util.List) request.getAttribute("itemsList");
	%>
	
<div id="latestcontent">


    <ul>
	<% for (ViewResult view: viewList) { %>

          
		  	<li>
		  	    <% if (rootPlid <= 0) { %> 
			  	<a href="<liferay-portlet:renderURL portletName="bs_news" windowState="<%=WindowState.NORMAL.toString()%>">
					<portlet:param name="struts_action" value="/ext/news/load"/>
					<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="view"/>
					<portlet:param name="redirect" value="<%= currentURL %>"/>
					</liferay-portlet:renderURL>">
					
					<% 
			  		String imageName = (view.getField6() != null? view.getField6().toString() : null);
			  		if (imageName != null && showImages) { %>
			  			<img src="/<%=filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath(imageName) %>" alt="news-image" align="left"  />
			  		<% } %>
					
					<%= gnomon.business.DateUtils.convertDate(StringUtils.check_null(view.getField3(),""),"yyyy-MM-dd HH:mm:ss","dd-MM-yyyy")%>, <%=StringUtils.check_null(view.getField4(),"")%>
				 </a>
				 <% } else { 
				 
					 PortletURLImpl pURL=null;
						
		  		 		if (portletRequest instanceof RenderRequest)
						{
							RenderRequestImpl req = (RenderRequestImpl)portletRequest;
							pURL = new PortletURLImpl(req, "bs_news", rootPlid, true);
						}
						else
						{
							ActionRequestImpl req = (ActionRequestImpl)portletRequest;
							pURL = new PortletURLImpl(req, "bs_news", rootPlid, true);
						}
				
						pURL.setPortletMode(PortletMode.VIEW);
						pURL.setWindowState(WindowState.NORMAL);
						pURL.setParameter("struts_action", "/ext/news/load");	
		    			pURL.setParameter("mainid" ,  view.getMainid().toString());
						pURL.setParameter("loadaction" , "view");
						pURL.setParameter("redirect" , currentURL);
				 %>
				 <a href="<%= pURL.toString() %>">
					
					<% 
			  		String imageName = (view.getField6() != null? view.getField6().toString() : null);
			  		if (imageName != null && showImages) { %>
			  			<img src="/<%=filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath(imageName) %>" alt="news-image" align="left"  />
			  		<% } %>
					
					<%= gnomon.business.DateUtils.convertDate(StringUtils.check_null(view.getField3(),""),"yyyy-MM-dd HH:mm:ss","dd-MM-yyyy")%>, <%=StringUtils.check_null(view.getField4(),"")%>
					
				
				 </a>
				 <% } %>
				 <br>
					<%---StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(view.getField5(),"")).trim(),200)--%>
					<%= StringUtils.check_null(view.getField5(),"") %>
                   
            </li>
	<% } %>
     </ul>


    </div>
    
</c:when>
<c:otherwise>
<%= LanguageUtil.get(pageContext, "no.recent.content.found") %>
</c:otherwise>
</c:choose>
