<%@ include file="/html/portlet/ext/quickmap/init.jsp" %>

<c:if test="<%=showBreadcrumbs%>">
	<liferay-ui:breadcrumb/>
</c:if>


<%
//Layout rootLayout = LayoutLocalServiceUtil.getLayout(rootPlid > 0? rootPlid: layout.getPlid());
//List visibleLayouts = rootLayout.getChildren(permissionChecker);


List visibleLayouts = null;

if (rootPlid >= 0) {
	Layout rootLayout = LayoutLocalServiceUtil.getLayout(rootPlid > 0? rootPlid: layout.getPlid());

	visibleLayouts = rootLayout.getChildren();
}
else {
	visibleLayouts = LayoutLocalServiceUtil.getLayouts(layout.getGroupId(), layout.isPrivateLayout(), LayoutImpl.DEFAULT_PARENT_LAYOUT_ID);
}
%>



<%
int MAX_ITEMS = 8;
int numColumns = 0;
StringMaker sm = new StringMaker();
if (visibleLayouts!=null && visibleLayouts.size()>0) {
	sm.append("<div id=\"quickmap\">");
	int runHeight = 0;
	for (int i = 0; i < visibleLayouts.size(); i++) {
		Layout visibleLayout = (Layout)visibleLayouts.get(i);
		String visibleLayoutURL = PortalUtil.getLayoutURL(visibleLayout, themeDisplay);
		String visibleTarget = PortalUtil.getLayoutTarget(visibleLayout);
		String visibleCaption = visibleLayout.getHTMLTitle(themeDisplay.getLocale());
		visibleCaption = Validator.isNull(visibleCaption)?
						visibleLayout.getName(themeDisplay.getLocale()):
						visibleCaption;
						
		List visibleChildLayouts = visibleLayout.getChildren(permissionChecker);
		
		if (visibleChildLayouts!=null && visibleChildLayouts.size()>0) {
			int blockHeight = visibleChildLayouts.size();
			if (numColumns==0) {
				sm.append("<div id=\"dn-col" + numColumns + "\" class=\"column first\">");
				numColumns = 1;
			} else if (runHeight + blockHeight>MAX_ITEMS) {
				sm.append("</div>");
				sm.append("<div id=\"dn-col" + numColumns + "\" class=\"column\">");
				runHeight = 0;
				numColumns ++;
			}
			runHeight += blockHeight;
			sm.append("<h3>");
			sm.append("<a href=\"");
			sm.append(visibleLayoutURL);
			sm.append("\" ");
			sm.append(visibleTarget);
			sm.append("> ");
			sm.append(visibleCaption);
			sm.append("</a>");
			sm.append("</h3>");
			sm.append("<ul>");
			for (int j = 0; j < visibleChildLayouts.size(); j++) {
				Layout visibleChildLayout = (Layout)visibleChildLayouts.get(j);
				String layoutURL = PortalUtil.getLayoutURL(visibleChildLayout, themeDisplay);
				String target = PortalUtil.getLayoutTarget(visibleChildLayout);
				String caption = visibleChildLayout.getHTMLTitle(themeDisplay.getLocale());
				caption = Validator.isNull(caption)?
						visibleChildLayout.getName(themeDisplay.getLocale()):
						caption;
				sm.append("<li>");
				sm.append("<a href=\"");
				sm.append(layoutURL);
				sm.append("\" ");
				sm.append(target);
				sm.append("> ");
				sm.append(caption);
				sm.append("</a>");
				sm.append("</li>");
				
			}
			sm.append("</ul>");
			
		} else {
			sm.append("<h3>");
			sm.append("<a href=\"");
			sm.append(visibleLayoutURL);
			sm.append("\" ");
			sm.append(visibleTarget);
			sm.append("> ");
			sm.append(visibleCaption);
			sm.append("</a>");
			sm.append("</h3>");
			runHeight += 1;
		}
	}
	sm.append("</div>");
}

%>




<style type="text/css">
/*#quickmap .column {float: left; width:<%//=90/(numColumns>0?numColumns:1)%>%; padding: 9px 0 0 18px; }*/
</style>

<%= sm.toString() %>