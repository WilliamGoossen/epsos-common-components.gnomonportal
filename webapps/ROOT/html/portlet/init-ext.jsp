<%
/**
 * Copyright (c) 2000-2006 Liferay, LLC. All rights reserved.
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

<%@ page import="gnomon.hibernate.model.gn.GnPortletSetting" %>

<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Hashtable" %>

<%@ page import="gnomon.business.StringUtils" %>
<%@ page import="com.ext.portlet.permissions.service.PermissionsService" %>
<%@ page import="javax.portlet.PortletRequest"%>
<%@ page import="javax.portlet.RenderRequest"%>
<%@ page import="com.liferay.portlet.ActionRequestImpl"%>
<%@ page import="com.liferay.portlet.RenderRequestImpl"%>

<%
String defLang = com.liferay.portal.util.PropsUtil.get("locale.default");
//String redirect = (String)request.getParameter("redirect");
PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
String portletID = null;
if (portletRequest instanceof RenderRequest) {
	RenderRequestImpl req = (RenderRequestImpl)portletRequest;
	portletID = req.getPortletName();
} else {
	ActionRequestImpl req = (ActionRequestImpl)portletRequest;
	portletID = req.getPortletName();
}


boolean managetopic=true;

Boolean managetopics=(Boolean)request.getAttribute("managetopics");

if(managetopics!=null) {
	managetopic=managetopics.booleanValue();
}
else {
	String isTopicPermissions = GetterUtil.getString(PropsUtil.get("gn.topics.permissions"),"off");
int isTopics =0;
if(request.getAttribute("isTopics")!=null)
	isTopics= ((Integer) request.getAttribute("isTopics")).intValue();
String topicid = (String)request.getParameter("topicid");

	if(isTopicPermissions.equals("on") && isTopics!=GnPortletSetting.TOPICS_ENABLED_FALSE) {
	
	 if(topicid!=null && !topicid.equals("") && !com.ext.portlet.topics.service.permission.GnTopicPermission.contains(permissionChecker, new Integer(topicid), com.liferay.portal.kernel.security.permission.ActionExtKeys.MANAGECONTENT))
			managetopic=false;
			
	}
	}

%>

<%
	boolean hasAdmin = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADMINISTRATE) && managetopic;
	boolean hasPublish = PermissionsService.getInstance().isPortletPublishingEnabled(PortalUtil.getCompanyId(request),portletID) 
			&& PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.PUBLISH) && managetopic;
	boolean hasViewUnPublished = hasPublish; //PermissionsService.getInstance().isPortletPublishingEnabled(portletID) && PortletPermission.contains(permissionChecker, plid, portletID, ActionExtKeys.VIEW_UNPUBLISHED) && managetopic;
	boolean hasAdd = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.ADD) && managetopic;
	boolean hasEdit = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT) && managetopic;
	boolean hasDelete = PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.DELETE) && managetopic;
%>


