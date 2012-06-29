<%
/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
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

<%@ include file="/html/taglib/init.jsp" %>

<%@ page import="com.liferay.portlet.journal.model.JournalArticle" %>
<%@ page import="com.ext.portal.context.PortalContext" %>
<%@ page import="com.ext.portal.context.PortalContextRequestUtil" %>
<%@ page import="gnomon.business.ViewResultUtil" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<%
Layout selLayout = (Layout)request.getAttribute("liferay-ui:breadcrumb:selLayout");

if (selLayout == null) {
	selLayout = layout;
}

String selLayoutParam = (String)request.getAttribute("liferay-ui:breadcrumb:selLayoutParam");
PortletURL portletURL = (PortletURL)request.getAttribute("liferay-ui:breadcrumb:portletURL");

int displayStyle = GetterUtil.getInteger((String)request.getAttribute("liferay-ui:breadcrumb:displayStyle"));

if (displayStyle == 0) {
	displayStyle = 1;
}


//try to read gi9 portal context is one exists (for now only topic context is supported)
PortalContext portalContext = PortalContextRequestUtil.getPortalContext(request); 

ViewResult primaryTopicView = null;
ViewResult secondaryTopicView = null;
JournalArticle journalArticle = null;
String primaryTopicPathURL = "";
String secondaryTopicPathURL = "";
String journalArticlePathURL = "";

if (PortalContextRequestUtil.contextExistsTopic(portalContext)) {
	
	primaryTopicView = (ViewResult) portalContext.getEntry(PortalContext.PRIMARY_TOPIC_VIEW);
	secondaryTopicView = (ViewResult) portalContext.getEntry(PortalContext.SECONDARY_TOPIC_VIEW);
	
	String friendlyURLPath = PortalUtil.getLayoutFriendlyURL(layout,themeDisplay);
	if (primaryTopicView!=null)
		primaryTopicPathURL = friendlyURLPath + "/~/topic/" + 
			primaryTopicView.getMainid();
	
	if (secondaryTopicView!=null)
		secondaryTopicPathURL = friendlyURLPath + "/~/topic/" + 
			(primaryTopicView!=null?primaryTopicView.getMainid():"0") + "/" +
			secondaryTopicView.getMainid();
}

if (PortalContextRequestUtil.contextExistsArticle(portalContext)) {
	journalArticle = (JournalArticle) portalContext.getEntry(PortalContext.JOURNAL_ARTICLE);
	
	String friendlyURLPath = PortalUtil.getLayoutFriendlyURL(layout,themeDisplay);
	if (journalArticle!=null)
		journalArticlePathURL = friendlyURLPath + "/~/topicarts/" + 
			journalArticle.getId();
}
%>