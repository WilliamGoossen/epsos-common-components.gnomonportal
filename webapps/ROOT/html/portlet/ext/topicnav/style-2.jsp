<%@ include file="/html/portlet/ext/topicnav/init.jsp" %>
<div id="perioxes">
<c:choose>
	<c:when test="<%=instanceTopicView!=null%>">

		<script type="text/javascript" src="/html/js/simpletreemenu2.js"></script><noscript></noscript>

		
       <!-- <a href="javascript:ddtreemenu.flatten('<portlet:namespace/>treemenu1', 'expand')">+</a> | <a href="javascript:ddtreemenu.flatten('<portlet:namespace/>treemenu1', 'contact')">-</a>
		<br />-->
		
		
			<%
				StringMaker sm = new StringMaker();
			
				_buildTopicNavigation(instanceTopicView, instanceTopicView, selTopicId, 0, 
						sm, srv, companyId, lang, renderResponse, 
						instanceIsSecondary, primaryTopicView, selAllParents, allowedTopicIds);
			
				out.print(sm.toString());
			%>
		
		
		<script type="text/javascript">
			//ddtreemenu.createTree(treeid, enablepersist, opt_persist_in_days (default is 1))
			ddtreemenu.createTree("<portlet:namespace/>treemenu1", false);
			//ddtreemenu.flatten('<portlet:namespace/>treemenu1', 'contact');
		</script>
		<noscript></noscript>
		
	</c:when>
	<c:otherwise>
		<%--no topics print user frindly message here, or nothing at all --%>
	</c:otherwise>
</c:choose>

<%!
private void _buildTopicNavigation(
		ViewResult globalRootTopicView, ViewResult rootTopicView, String selTopicId, int depth, 
		StringMaker sm, TopicsService srv, Long companyId, String lang, RenderResponse renderResponse, 
		boolean isSecondary, ViewResult primaryTopicView, String allParents, HashSet<Integer>allowedTopicIds) throws Exception {
	
	List topicViewChildren = srv.getTopics(
			companyId, globalRootTopicView.getMainid()+"", rootTopicView.getMainid()+"", lang, "table1.orderIndex, langs.name");
	
	
	if (topicViewChildren!=null && topicViewChildren.size()>0) {
		
		if (depth==0)
			sm.append("<ul ").append("id=\"" + renderResponse.getNamespace() + "treemenu1\" class=\"treeview\"").append(">");
		else {
			String rel = allParents.indexOf(rootTopicView.getMainid() + ",")>=0 ? 
					"rel=\"open\"": "rel=\"closed\"";
			sm.append("<ul ").append(rel).append(">");
		}
		
		for (int i=0; i<topicViewChildren.size(); i++) {
			
			ViewResult iTopicView = (ViewResult)topicViewChildren.get(i);
			
			if (allowedTopicIds != null && allowedTopicIds.size() > 0 && 
					!allowedTopicIds.contains(iTopicView.getMainid()))
				continue; // skip this topic
			
				
			String iTopicId = iTopicView.getMainid()+"";
			//it is a direct child of the current rootFolder
			String title = iTopicView.getField2().toString();
			PortletURL portletURL = renderResponse.createRenderURL();
			//portletURL.setWindowState(WindowState.NORMAL);
			portletURL.setParameter("struts_action", "/ext/topicnav/view");
			if (!isSecondary) {
				portletURL.setParameter("topicid", iTopicId);
			} else {
				if (primaryTopicView==null) {
					//this happens when user has not selected a primary topic yet
					//TODO: whould reconsider this
					portletURL.setParameter("topicid", "0");
					portletURL.setParameter("st", iTopicId);
				} else {
					portletURL.setParameter("topicid", primaryTopicView.getMainid()+"");
					portletURL.setParameter("st", iTopicId);					
				}
			}
			
			sm.append("<li");
			
			if (iTopicId.equals(selTopicId))
				sm.append(" class=\"selected\"");
			sm.append(">");
			sm.append("<a href=\"").append(portletURL).append("\"").append(">");
			sm.append(title);
			sm.append("</a>");
			
			_buildTopicNavigation(globalRootTopicView, iTopicView, selTopicId, depth+1, 
					sm, srv, companyId, lang, renderResponse, 
					isSecondary, primaryTopicView, allParents, allowedTopicIds);
			
			sm.append("</li>");
		}
		sm.append("</ul>");
	} else {
		sm.append("");
	}
}
%>