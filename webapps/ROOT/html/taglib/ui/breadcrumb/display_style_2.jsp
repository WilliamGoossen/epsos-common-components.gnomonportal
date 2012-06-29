

<%@ include file="/html/taglib/ui/breadcrumb/init.jsp" %>

<div id="breadcrub">

<%
StringMaker sm = new StringMaker();

_buildBreadcrumb(selLayout, selLayoutParam, portletURL, themeDisplay, true, sm);
%>

<%= sm.toString() %>

<c:if test="<%=primaryTopicView!=null%>">
	 &raquo; <a href="<%=primaryTopicPathURL%>"><%=ViewResultUtil.toString(primaryTopicView.getField2()) %></a>
</c:if>

<c:if test="<%=secondaryTopicView!=null%>">
	 &raquo; <a href="<%=secondaryTopicPathURL%>"><%=ViewResultUtil.toString(secondaryTopicView.getField2()) %></a>
</c:if>

<c:if test="<%=journalArticle!=null%>">
	 &raquo; <a href="<%=journalArticlePathURL%>"><%=journalArticle.getTitle() %></a>
</c:if>

<%!
private void _buildBreadcrumb(Layout selLayout, String selLayoutParam, PortletURL portletURL, ThemeDisplay themeDisplay, boolean selectedLayout, StringMaker sm) throws Exception {
	String layoutURL = _getBreadcrumbLayoutURL(selLayout, selLayoutParam, portletURL, themeDisplay);
	String target = PortalUtil.getLayoutTarget(selLayout);
	long layoutParentId = selLayout.getParentLayoutId();

	StringMaker breadCrumbSM = new StringMaker();

	if (selectedLayout) {
		if (layoutParentId != LayoutImpl.DEFAULT_PARENT_LAYOUT_ID) {
			breadCrumbSM.append("<br />");
			breadCrumbSM.append("<br />");
		}

		breadCrumbSM.append("<div class=\"font-xx-large\" style=\"font-weight: bold;\">");
		breadCrumbSM.append(selLayout.getName(themeDisplay.getLocale()));
		breadCrumbSM.append("</div>");
		breadCrumbSM.append("<br />");
	}
	else {
		breadCrumbSM.append("<a href=\"");
		breadCrumbSM.append(layoutURL);
		breadCrumbSM.append("\" ");
		breadCrumbSM.append(target);
		breadCrumbSM.append(">");
		breadCrumbSM.append(selLayout.getName(themeDisplay.getLocale()));
		breadCrumbSM.append("</a>");
	}

	Layout layoutParent = null;

	if (layoutParentId != LayoutImpl.DEFAULT_PARENT_LAYOUT_ID) {
		layoutParent = LayoutLocalServiceUtil.getLayout(selLayout.getGroupId(), selLayout.isPrivateLayout(), layoutParentId);

		_buildBreadcrumb(layoutParent, selLayoutParam, portletURL, themeDisplay, false, sm);

		sm.append(" &raquo; ");
		sm.append(breadCrumbSM.toString());
	}
	else {
		sm.append(breadCrumbSM.toString());
	}
}

private String _getBreadcrumbLayoutURL(Layout selLayout, String selLayoutParam, PortletURL portletURL, ThemeDisplay themeDisplay) throws Exception {
	if (portletURL == null) {
		return PortalUtil.getLayoutURL(selLayout, themeDisplay);
	}
	else {
		portletURL.setParameter(selLayoutParam, String.valueOf(selLayout.getPlid()));

		return portletURL.toString();
	}
}
%>

</div>