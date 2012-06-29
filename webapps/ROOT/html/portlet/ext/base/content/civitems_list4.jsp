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
			  	<a href="/web/guest/courses/bycategory/~/civitemsbrowser/<%= view.getMainid().toString() %>/0?p_p_action=1&_bs_civitems_browser_loadaction=view"><%=StringUtils.check_null(view.getField6(),"")%>
				</a>

            </li>

	<% } %>




</ul>

</div>


</c:when>
<c:otherwise>
<%= LanguageUtil.get(pageContext, "no.recent.content.civitems.found") %>
</c:otherwise>
</c:choose>
