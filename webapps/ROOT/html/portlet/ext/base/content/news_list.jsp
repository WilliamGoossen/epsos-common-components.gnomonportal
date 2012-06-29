<%@ include file="/html/portlet/ext/base/events/init.jsp" %>
<%

String includedPage = "/html/portlet/ext/base/content/news_list" + prefs.getValue("list-style", "1") + ".jsp";

 boolean exists = (new java.io.File(CommonUtil.getRootPath(request) + "/html/portlet/ext/base/content/"+ com.liferay.portal.util.PortalUtil.getCompanyId(request))).exists();
    if (exists) {
    	includedPage = "/html/portlet/ext/base/content/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/news_list" + prefs.getValue("list-style", "1") + ".jsp";
    } else {
    	includedPage = "/html/portlet/ext/base/content/news_list" + prefs.getValue("list-style", "1") + ".jsp";
    }
%>

<jsp:include page="<%=includedPage%>" flush="true"/>