<%
/**
 * Copyright (c) 2000-2006 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/taglib/ui/navigation/init.jsp" %>

<script type="text/javascript">
	function <portlet:namespace />updateTitle(title) {
		var titleBar = document.getElementById('portlet-title-bar_<%= portletDisplay.getId() %>');

		if (titleBar) {
			titleBar.innerHTML = title;
		}
	}
	
	function toggleDisplay(id) {
		var myElem = document.getElementById(id);

		if (myElem) {
			if (myElem.style.display=='block')
				myElem.style.display='none';
			else
				myElem.style.display='block';
		}
	}	
</script>



<%
Set layoutFamilySet = new LinkedHashSet();

Layout ancestorLayout = layout;

while (true) {
	layoutFamilySet.add(ancestorLayout);

	if (!ancestorLayout.getParentLayoutId().equals(LayoutImpl.DEFAULT_PARENT_LAYOUT_ID)) {
		ancestorLayout = LayoutLocalServiceUtil.getLayout(ancestorLayout.getParentLayoutId(), ancestorLayout.getOwnerId());
	}
	else {
		break;
	}
}

int depth = ParamUtil.getInteger(request, "depth", 2);
boolean showTitle = ParamUtil.getBoolean(request, "showTitle");

if (layoutFamilySet.size() >= depth) {
	Layout[] layoutFamilyArray = (Layout[])layoutFamilySet.toArray(new Layout[0]);

	Layout depthLevelLayout = layoutFamilyArray[layoutFamilyArray.length - depth];

	String groupId = depthLevelLayout.getGroupId();

	StringBuffer sb = new StringBuffer();

	_buildNavigation(depthLevelLayout, layout, layoutFamilySet, themeDisplay, 1, bulletStyle, showTitle, sb, true);
%>

	<%= sb.toString() %>

<%
}
%>

<%!
//private void _isAnchestorOf(String Anchestor


private void _buildNavigation(Layout layout, Layout selLayout, Set layoutFamilySet, ThemeDisplay themeDisplay, int layoutLevel, int bulletStyle, boolean showTitle, StringBuffer sb, boolean showItem) throws Exception {
	List layoutChildren = layout.getChildren();

	if (layoutChildren.size() > 0) {
		if (layoutLevel == 1) {
			String layoutURL = PortalUtil.getLayoutURL(layout, themeDisplay);
			String target = PortalUtil.getLayoutTarget(layout);

			if (showTitle) {
				PortletDisplay portletDisplay = themeDisplay.getPortletDisplay();

				sb.append("<script type='text/javascript'>");
				sb.append(portletDisplay.getNamespace() + "updateTitle('");
				sb.append("<a style=\"color: ");
				sb.append(themeDisplay.getColorScheme().getPortletTitleText());
				sb.append(";\" href=\"");
			}
			else {
				sb.append("<h3>");
				sb.append("<a href=\"");
			}

			sb.append(layoutURL);
			sb.append("\" ");
			sb.append(target);
			sb.append("> ");
			sb.append(layout.getName(themeDisplay.getLocale()));
			sb.append("</a>");

			if (!showTitle) {
				sb.append("</h3>");
			}
			else {
				sb.append("');");
				sb.append("</script>");
			}
		}

		if (bulletStyle == 1) {
			sb.append("<ul>");

			for (int i = 0; i < layoutChildren.size(); i++) {
				Layout layoutChild = (Layout)layoutChildren.get(i);

				if (!layoutChild.isHidden() && LayoutPermission.contains(themeDisplay.getPermissionChecker(), layoutChild, ActionKeys.VIEW)) {
					String layoutURL = PortalUtil.getLayoutURL(layoutChild, themeDisplay);
					String target = PortalUtil.getLayoutTarget(layoutChild);

					sb.append("<li>");
					sb.append("<a href=\"");
					sb.append(layoutURL);
					sb.append("\" ");
					sb.append(target);
					sb.append("> ");
					sb.append(layoutChild.getName(themeDisplay.getLocale()));
					sb.append("</a>");
					sb.append("</li>");

					if (layoutFamilySet.contains(layoutChild)) {
						_buildNavigation(layoutChild, selLayout, layoutFamilySet, themeDisplay, layoutLevel + 1, bulletStyle, showTitle, sb, true);
					}
				}
			}

			sb.append("</ul>");
		}
		else {
			if (layoutChildren.size()>0) {
				sb.append("<div id=\"wrapper_all_childern_of_"+ layout.getPlid() + "\"");
				if (layout.getType().equals("expand")) {
					com.liferay.portal.service.impl.LayoutLocalServiceImpl layService = 
						new com.liferay.portal.service.impl.LayoutLocalServiceImpl();
					if (!layService.isAnchestor(selLayout,layout.getPlid()))
						sb.append(" style=\"display: none;\"");
				}	
				sb.append(">");
			}
			if (layoutLevel == 1) {
				sb.append("<div style=\"margin-left: 2px;\">");
			}
			else {
				sb.append("<div style=\"margin-left: 10px;\">");
			}
			
			for (int i = 0; i < layoutChildren.size(); i++) {
				Layout layoutChild = (Layout)layoutChildren.get(i);

				if (!layoutChild.isHidden() && LayoutPermission.contains(themeDisplay.getPermissionChecker(), layoutChild, ActionKeys.VIEW)) {
					
					
					String layoutURL = PortalUtil.getLayoutURL(layoutChild, themeDisplay);
					String target = PortalUtil.getLayoutTarget(layoutChild);
					String javascript = "";
					if (layoutChild.getType().equals("expand")) {
						layoutURL = "#" + layoutChild.getPlid() + "#" + selLayout.getPlid() + "#" + selLayout.getAncestorLayoutId();
						javascript = " onClick=\"toggleDisplay('wrapper_all_childern_of_"+layoutChild.getPlid()+"')\";";
					}
					String layoutName = layoutChild.getName(themeDisplay.getLocale());


					
					
					if (layoutLevel == 1) {
						if (i != 0) {
							sb.append("<div class=\"blueblock-separator\"></div>");
						}

						sb.append("<div id=\"blueblock\"><ul class=\"list2\">");
					}
					else {
						sb.append("<div id=\"sm2block\"><ul class=\"list2\">");
					}
					
					

					 if (layoutLevel >= 3) {
						sb.append("<div class=\"font-small\"></div>");
					}
					
					

					

					sb.append("<li><a href=\"");
					sb.append(layoutURL);
					sb.append("\" ");



					if (layoutLevel != 1) {
						sb.append("style=\"color: #606060;\" ");
					}

					sb.append(target);
					sb.append(javascript);
					sb.append(">");
					sb.append(layoutName);
					sb.append("</a></li>");

					

					sb.append("</div>");


					if (layoutLevel == 1) {
						if (i == layoutChildren.size() - 1) {
							sb.append("");
						}
						else if (layoutFamilySet.contains(layoutChild) && layoutChild.getChildren().size() > 0) {
							sb.append("");
						}
					}

					if (layoutFamilySet.contains(layoutChild) || layoutChild.getType().equals("expand")) {
						_buildNavigation(layoutChild, selLayout, layoutFamilySet, themeDisplay, layoutLevel + 1, bulletStyle, showTitle, sb, !layoutChild.getType().equals("expand"));
					}
				}
			}

			sb.append("</ul></div>");
			if (layoutChildren.size()>0) {
				sb.append("</div>");
			}
		}
	}
}
%>


