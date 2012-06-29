<%@ include file="/html/portlet/ext/base/banners/init.jsp" %>

<%
String filePath = GetterUtil.getString(PropsUtil.get("base.banners.store"), CommonDefs.DEFAULT_STORE_PATH);
List bannersList = (List)request.getAttribute("banners");
%>
<%if (bannersList  != null){%>
<div id="bannersview">
<%for (int i = 0; i < bannersList.size(); i++){ 
ViewResult banner = (ViewResult)bannersList.get(i);

if (banner != null){
String urlOpenIn = (String)banner.getField5();
String aTitle = (String)banner.getField7();
String aUrl = (String)banner.getField8();
String imageFileName = (String)banner.getField9();
%>
<div class="bannersview-inner">
				<c:choose>
					<c:when test="<%= Validator.isNotNull(aUrl) %>">
						<a href="<liferay-portlet:actionURL portletName="bs_banners_display" windowState="<%=LiferayWindowState.POP_UP.toString()%>">
								<liferay-portlet:param name="struts_action" value="/ext/banners_display/goto" />
								<liferay-portlet:param name="loc" value="<%=aUrl%>" />
								<liferay-portlet:param name="mainid" value="<%=banner.getMainid()+""%>" />
								</liferay-portlet:actionURL>"
						target="<%=urlOpenIn%>">
						<% if (imageFileName.toString().endsWith("swf")) { %>
							<object>
								<param name="movie" value="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + imageFileName %>">
								<param name="wmode" value="opaque"/>
								<param name="loop" value="true"/>
								<param name="base" value="."/>
							<embed src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + imageFileName %>"
								   loop="true" base="." wmode="opaque"></embed>
							</object>
						<% } else { %>
						<img src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + imageFileName%>" title="<%=aTitle%>" alt="<%=aTitle%>"/>
						<% } %>
						</a>
					</c:when>
					<c:otherwise>
						<% if (imageFileName.toString().endsWith("swf")) { %>
							<object>
								<param name="movie" value="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + imageFileName %>">
								<param name="wmode" value="opaque"/>
								<param name="loop" value="true"/>
								<param name="base" value="."/>
							<embed src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + banner.getMainid() + "/" + imageFileName %>"
								   loop="true" base="." wmode="opaque"></embed>
							</object>
						<% } else { %>
						<img src="<%= "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" +filePath + banner.getMainid() + "/" + imageFileName%>" title="<%=aTitle%>" alt="<%=aTitle%>"/>
						<% } %>
					</c:otherwise>
				</c:choose>
</div>
<%}%>
<%}%>
</div>
<%}%>
