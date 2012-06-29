<%@ include file="/html/portlet/ext/base/banners_display/init.jsp" %>

<%
	List banners = (List) request.getAttribute("banners");
	//String realPath = com.ext.util.CommonUtil.getRootPath(ctx);
	String filePath = GetterUtil.getString(PropsUtil.get("base.banners.store"), CommonDefs.DEFAULT_STORE_PATH);
%>
<div id="bannersviewh">

<%
	for (int i=0; i<banners.size(); i++) {
		ViewResult banner = (ViewResult) banners.get(i); %>
			
            
            <div id="bannersview-innerh">
            
            
				<c:choose>
					<c:when test="<%= Validator.isNotNull(banner.getField3().toString()) %>">
						<a href="<portlet:actionURL>
								<portlet:param name="struts_action" value="/ext/banners_display/goto" />
								<portlet:param name="loc" value="<%=banner.getField3().toString()%>" />
								<portlet:param name="mainid" value="<%=banner.getMainid()+""%>" />
								</portlet:actionURL>"
						target="<%=banner.getField1().toString()%>">
						<% if (banner.getField4().toString().endsWith("swf")) { %>
							<object>
								<param name="movie" value="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + banner.getField4() %>">
								<param name="wmode" value="opaque"/>
								<param name="loop" value="true"/>
								<param name="base" value="."/>
							<embed src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + banner.getField4() %>"
								   loop="true" base="." wmode="opaque"></embed>
							</object>
						<% } else { %>
						<img src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + banner.getField4()%>" title="<%=banner.getField2().toString()%>" alt="<%=banner.getField2().toString()%>"/>
						<% } %>
						</a>
					</c:when>
					<c:otherwise>
					<% if (banner.getField4().toString().endsWith("swf")) { %>
							<object>
								<param name="movie" value="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + banner.getField4() %>">
								<param name="wmode" value="opaque"/>
								<param name="loop" value="true"/>
								<param name="base" value="."/>
							<embed src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + banner.getField4() %>"
								   loop="true" base="." wmode="opaque"></embed>
							</object>
						<% } else { %>
						<img src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" +  filePath + banner.getMainid() + "/" + banner.getField4()%>" title="<%=banner.getField2().toString()%>" alt="<%=banner.getField2().toString()%>"/>
						<% } %>
					</c:otherwise>
				</c:choose>
			
            
            </div>
	<% }
%>

</div>
<br/>
