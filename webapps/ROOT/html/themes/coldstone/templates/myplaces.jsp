<%@ include file="/html/taglib/ui/my_places/init.jsp" %>

<c:if test="<%= themeDisplay.isSignedIn() %>">

		<%
		PortletURL portletURL = new PortletURLImpl(request, PortletKeys.MY_PLACES, plid.longValue(), true);

		portletURL.setWindowState(WindowState.NORMAL);
		portletURL.setPortletMode(PortletMode.VIEW);

		portletURL.setParameter("struts_action", "/my_places/view");

		LinkedHashMap groupParams = new LinkedHashMap();

		groupParams.put("usersGroups", new Long(user.getUserId()));
		//groupParams.put("pageCount", StringPool.BLANK);

		List communities = GroupLocalServiceUtil.search(company.getCompanyId(), null, null, groupParams, QueryUtil.ALL_POS, QueryUtil.ALL_POS);

		Group locationGroup = user.getLocation().getGroup();

		if (locationGroup.getGroupId() > 0) {
			communities.add(0, locationGroup);
		}

		Group organizationGroup = user.getOrganization().getGroup();

		if (organizationGroup.getGroupId() > 0) {
			communities.add(0, organizationGroup);
		}

		if (user.isLayoutsRequired()) {
			Group userGroup = user.getGroup();

			communities.add(0, userGroup);
		}

		for (int i = 0; i < communities.size(); i++) {
			Group community = (Group)communities.get(i);

			boolean organizationCommunity = community.isOrganization();
			boolean regularCommunity = community.isCommunity();
			boolean userCommunity = community.isUser();
			int publicLayoutsPageCount = community.getPublicLayoutsPageCount();
			int privateLayoutsPageCount = community.getPrivateLayoutsPageCount();

			Organization organization = null;

			String publicAddPageHREF = null;
			String privateAddPageHREF = null;

			if (organizationCommunity) {
				organization = OrganizationLocalServiceUtil.getOrganization(community.getClassPK());

				if ((!organization.isLocation() && OrganizationPermissionUtil.contains(permissionChecker, organization.getOrganizationId(), ActionKeys.UPDATE)) ||
					(organization.isLocation() && LocationPermissionUtil.contains(permissionChecker, organization.getOrganizationId(), ActionKeys.UPDATE))) {

					PortletURL addPageURL = new PortletURLImpl(request, PortletKeys.MY_PLACES, plid.longValue(), true);

					addPageURL.setWindowState(WindowState.NORMAL);
					addPageURL.setPortletMode(PortletMode.VIEW);

					addPageURL.setParameter("struts_action", "/my_places/edit_pages");
					addPageURL.setParameter("groupId", String.valueOf(community.getGroupId()));
					addPageURL.setParameter("privateLayout", Boolean.FALSE.toString());

					publicAddPageHREF = addPageURL.toString();

					addPageURL.setParameter("privateLayout", Boolean.TRUE.toString());

					privateAddPageHREF = addPageURL.toString();
				}
			}
			else if (regularCommunity) {
				if (GroupPermissionUtil.contains(permissionChecker, community.getGroupId(), ActionKeys.MANAGE_LAYOUTS)) {
					PortletURL addPageURL = new PortletURLImpl(request, PortletKeys.MY_PLACES, plid.longValue(), true);

					addPageURL.setWindowState(WindowState.NORMAL);
					addPageURL.setPortletMode(PortletMode.VIEW);

					addPageURL.setParameter("struts_action", "/my_places/edit_pages");
					addPageURL.setParameter("groupId", String.valueOf(community.getGroupId()));
					addPageURL.setParameter("privateLayout", Boolean.FALSE.toString());

					publicAddPageHREF = addPageURL.toString();

					addPageURL.setParameter("privateLayout", Boolean.TRUE.toString());

					privateAddPageHREF = addPageURL.toString();
				}
			}
			else if (userCommunity) {
				long publicAddPagePlid = community.getDefaultPublicPlid();

				PortletURL publicAddPageURL = new PortletURLImpl(request, PortletKeys.LAYOUT_MANAGEMENT, publicAddPagePlid, false);

				publicAddPageURL.setWindowState(WindowState.MAXIMIZED);
				publicAddPageURL.setPortletMode(PortletMode.VIEW);

				publicAddPageURL.setParameter("struts_action", "/layout_management/edit_pages");
				publicAddPageURL.setParameter("tabs2", "public");
				publicAddPageURL.setParameter("groupId", String.valueOf(community.getGroupId()));

				publicAddPageHREF = publicAddPageURL.toString();

				long privateAddPagePlid = community.getDefaultPrivatePlid();

				PortletURL privateAddPageURL = new PortletURLImpl(request, PortletKeys.LAYOUT_MANAGEMENT, privateAddPagePlid, false);

				privateAddPageURL.setWindowState(WindowState.MAXIMIZED);
				privateAddPageURL.setPortletMode(PortletMode.VIEW);

				privateAddPageURL.setParameter("struts_action", "/layout_management/edit_pages");
				privateAddPageURL.setParameter("tabs2", "private");
				privateAddPageURL.setParameter("groupId", String.valueOf(community.getGroupId()));

				privateAddPageHREF = privateAddPageURL.toString();
			}
		%>

				<%
					String title = "";
					if (organizationCommunity) {
						title = organization.getName();
					} else if (userCommunity) {
						title = LanguageUtil.get(pageContext, "my-community");
					} else {
						title = community.getName();
					}
				%>

				<%
				portletURL.setParameter("groupId", String.valueOf(community.getGroupId()));
				portletURL.setParameter("privateLayout", Boolean.FALSE.toString());

				boolean selectedPlace = false;

				if (layout != null) {
					selectedPlace = !layout.isPrivateLayout() && (layout.getGroupId() == community.getGroupId());
				}
				%>

				<c:if test="<%=publicLayoutsPageCount>0 %>">
				<li class="public <%= selectedPlace ? "current" : "" %>">
					<a href='<%= publicLayoutsPageCount > 0 ? portletURL.toString() : "javascript: ;" %>'><%=title %></a>
				</li>
				</c:if>

				<%
				portletURL.setParameter("groupId", String.valueOf(community.getGroupId()));
				portletURL.setParameter("privateLayout", Boolean.TRUE.toString());

				selectedPlace = false;

				if (layout != null) {
					selectedPlace = layout.isPrivateLayout() && (layout.getGroupId() == community.getGroupId());
				}
				%>

				<c:if test="<%=privateLayoutsPageCount>0 %>">
				<li class="private <%= selectedPlace ? "current" : "" %>">
					<a href='<%= privateLayoutsPageCount > 0 ? portletURL.toString() : "javascript: ;" %>'><%=title %></a>
				</li>
				</c:if>

		<%
		}
		%>
</c:if>
