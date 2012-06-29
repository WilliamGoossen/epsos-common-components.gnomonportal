<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>

<a href= "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
		<portlet:param name="struts_action" value="/ext/base/yellowpages/browser/search"/>
		</portlet:actionURL>">Alphabetically</a>
		
<a href= "<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
		<portlet:param name="struts_action" value="/ext/base/yellowpages/browser/alphabetTile"/>
		</portlet:renderURL>">....</a>
		
<a href= "<portlet:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>">
		<portlet:param name="struts_action" value="/ext/base/yellowpages/browser/googlesearch"/>
		</portlet:actionURL>">Google Maps</a>