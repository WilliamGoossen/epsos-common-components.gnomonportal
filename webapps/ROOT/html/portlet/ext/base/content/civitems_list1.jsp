<%@ include file="/html/portlet/ext/base/content/init.jsp" %>
<%@ page import="gnomon.hibernate.model.base.civitems.*" %>

<% String filePath = "FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + GetterUtil.getString(PropsUtil.get("base.civitems.store"), CommonDefs.DEFAULT_STORE_PATH); 
long rootPlid = GetterUtil.getLong(prefs.getValue("show_rootPlid", StringPool.BLANK), -1);
%>

<c:choose>
<c:when test="<%=CONTENT_EXISTS%>">
	<%
		List<ViewResult> viewList  = (java.util.List) request.getAttribute("itemsList");
	%>


<div id="latestcontent">


    <ul>
	<% for (ViewResult view: viewList) { %>

        <li>
        		<%
		  		String imageName = (view.getField4() != null? view.getField4().toString() : null);
		  		if (imageName != null && showImages) { %>
		  			<img src="/<%=filePath + view.getMainid() + "/" + gnomon.business.GeneralUtils.createThumbnailPath(imageName) %>" alt="<%= view.getField6() %>" align="left" />
		  		<% } %>
		  		<% if (rootPlid <= 0) { %>
			  	<a href="<liferay-portlet:renderURL portletName="bs_civitems" windowState="<%=WindowState.NORMAL.toString()%>">
					<portlet:param name="struts_action" value="/ext/civitems/load"/>
					<portlet:param name="mainid" value="<%= view.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="view"/>
					<portlet:param name="redirect" value="<%= currentURL %>"/>
					</liferay-portlet:renderURL>"><%=StringUtils.check_null(view.getField6(),"")%>
				</a>
				<% } else { 
					PortletURLImpl pURL=null;
					
	  		 		 if (portletRequest instanceof RenderRequest)
					{
						RenderRequestImpl req = (RenderRequestImpl)portletRequest;
						pURL = new PortletURLImpl(req, "bs_civitems", rootPlid, true);
					}
					else
					{
						ActionRequestImpl req = (ActionRequestImpl)portletRequest;
						pURL = new PortletURLImpl(req, "bs_civitems", rootPlid, true);
					}
			
					pURL.setPortletMode(PortletMode.VIEW);
					pURL.setWindowState(WindowState.NORMAL);
					pURL.setParameter("struts_action", "/ext/civitems/load");	
	    			pURL.setParameter("mainid" ,  view.getMainid().toString());
					pURL.setParameter("loadaction" , "view");
					pURL.setParameter("redirect" , currentURL);
				%>
				<a href="<%= pURL.toString() %>"><%=StringUtils.check_null(view.getField6(),"")%>
				</a>
				<% }  %>

            </li>

	<% } %>




</ul>

</div>


</c:when>
<c:otherwise>
<%= LanguageUtil.get(pageContext, "no.recent.content.civitems.found") %>
</c:otherwise>
</c:choose>
