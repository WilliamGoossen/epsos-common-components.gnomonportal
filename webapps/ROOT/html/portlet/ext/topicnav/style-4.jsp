<%@ include file="/html/portlet/ext/topicnav/init.jsp" %>
<c:choose>
	<c:when test="<%=instanceTopicView!=null%>">

	<script type="text/javascript">
	    function <portlet:namespace />OpenURL(sel) {
		    //alert(sel.value);
		    if (sel.value!=null && sel.value!='')
		    	  document.location = sel.value;
	    }
	</script>

		<%
			StringMaker sm = new StringMaker();
		
			_buildTopicNavigation(instanceTopicView, instanceTopicView, selTopicId, 0, 
					sm, srv, companyId, lang, renderResponse, 
					instanceIsSecondary, primaryTopicView, selAllParents, null, 
					false, pageContext, allowedTopicIds);
		
			out.print(sm.toString());
		%>
		
	</c:when>
	<c:otherwise>
		<%--no topics print user frindly message here, or nothing at all --%>
	</c:otherwise>
</c:choose>

<%!
private void _buildTopicNavigation(
		ViewResult globalRootTopicView, ViewResult rootTopicView, String selTopicId, int depth, 
		StringMaker sm, TopicsService srv, Long companyId, String lang, RenderResponse renderResponse, 
		boolean isSecondary, ViewResult primaryTopicView, String allParents, List topicViewChildren, 
		boolean childrenArePrepared, PageContext pageContext, HashSet<Integer>allowedTopicIds) throws Exception {
	
	//if children are not prepared, please find them for me
	if (!childrenArePrepared) {
		topicViewChildren = srv.getTopics(
			companyId, globalRootTopicView.getMainid()+"", rootTopicView.getMainid()+"", lang, "table1.orderIndex, langs.name");
	}
	
	if (topicViewChildren!=null && topicViewChildren.size()>0) {
		
		if (depth==0) {
			sm.append("<div class=\"topic-nav-combo\">");
			sm.append("\n");
			sm.append("<div class=\"topic-nav-combo-inner\">");
			sm.append("<select onChange=\"" + renderResponse.getNamespace() + "OpenURL(this);\">");
			sm.append("\n");
			String initText = rootTopicView==null? 
					(globalRootTopicView==null? 
							LanguageUtil.get(pageContext, "choose"): globalRootTopicView.getField2().toString()
					) : rootTopicView.getField2().toString();
			sm.append("<option value=\"\"" + (Validator.isNull(selTopicId)? "selected=\"selected\"": "") + ">" + initText + "...</option>");
		}
		
		for (int i=0; i<topicViewChildren.size(); i++) {
			
			ViewResult iTopicView = (ViewResult)topicViewChildren.get(i);
			
			if (allowedTopicIds != null && allowedTopicIds.size() > 0 && 
					!allowedTopicIds.contains(iTopicView.getMainid()))
				continue; // skip this topic
			
				
			String iTopicId = iTopicView.getMainid()+"";
			
			//prepare iTopicView's children
			List iTopicViewChildren = srv.getTopics(
					companyId, globalRootTopicView.getMainid()+"", iTopicView.getMainid()+"", lang, "table1.orderIndex, langs.name");
			
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
			
			sm.append("<option");
			sm.append(" value=\"").append(portletURL).append("\"");
			if (iTopicId.equals(selTopicId))
				sm.append(" selected=\"selected\"");
			sm.append(">");
			for (int j = 0; j < depth; j++) {
                sm.append("-&nbsp;");
            }
			sm.append(title);
			sm.append("</option>");
			
			_buildTopicNavigation(globalRootTopicView, iTopicView, selTopicId, depth+1, 
					sm, srv, companyId, lang, renderResponse, 
					isSecondary, primaryTopicView, allParents, iTopicViewChildren, 
					true, pageContext, allowedTopicIds);
		}
		
		if (depth==0) {
			  sm.append("</select>");
			  sm.append("</div>");
			  sm.append("</div>");
		}
	} else {
		sm.append("");
	}
}
%>