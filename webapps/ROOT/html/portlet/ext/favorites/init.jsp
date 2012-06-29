<%@ include file="/html/portlet/init.jsp" %>

<%@page import="com.ext.portlet.favorites.util.FavoritesUtil;"%>



<%--
PortletPreferences prefs = FavoritesUtil.getPortletPreferences(renderRequest);

/*
prefs.setValues("urls",null);
prefs.setValues("titles",null);
prefs.store();
*/
String[] urls = prefs.getValues("urls", new String[0]);
String[] titles = prefs.getValues("titles", new String[0]);

boolean hasFavorites = false;
boolean isFavorite = false;
if (urls!=null && urls.length>0) {
	hasFavorites = true;
	for (String url:urls) {
		if (url!=null && url.equals(currentURL)) {
			isFavorite = true;
			break;
		}
	}
}

--%>

	<%--
	for (int i=1000; urls!=null && i<urls.length; i++) {
		String furl = urls[i];
		String ftitle = titles[i];
	%>
	
	<a href="<%= furl %>"><%= ftitle %></a><a href="javascript:<portlet:namespace/>deleteFromFavorites('<%=furl%>', '<%=ftitle%>')"><img src="<%=themeDisplay.getPathThemeImages()%>/common/delete.png"/></a><br/>
	
	<%
	}
	--%>