<%@ include file="/html/portlet/ext/cms/search/init.jsp" %>


<%
String defaultKeywords = LanguageUtil.get(pageContext, "search") + "...";
String unicodeDefaultKeywords = UnicodeFormatter.toString(defaultKeywords);

String keywords = ParamUtil.getString(request, "keywords", defaultKeywords);


String searchLayout= GetterUtil.getString(PropsUtil.get("gi9.search.layout"),"");


long  searchPlid=0;



if(Validator.isNotNull(searchLayout)) {

		long companyId = PortalUtil.getCompanyId(request);

		Group group = null;

		try {
			group = GroupLocalServiceUtil.getFriendlyURLGroup(
				companyId, "/guest");
				
				Object[] friendlyURLMapper = PortalUtil.getPortletFriendlyURLMapper(
				request, group.getGroupId(), false, searchLayout, null);

			Layout slayout = (Layout)friendlyURLMapper[0];
			 searchPlid = slayout.getPlid();
		}
	catch(Exception e) {
		e.printStackTrace();
	}

}
PortletURL portletURL=null;
if(searchPlid<=0 ) {
	
	portletURL = new PortletURLImpl(request, "GN_CMS_SEARCH",plid.longValue(), false);
portletURL.setWindowState(WindowState.MAXIMIZED);
	}
else {
 portletURL = new PortletURLImpl(request, "GN_CMS_SEARCH",searchPlid, false);
portletURL.setWindowState(WindowState.NORMAL);
}

portletURL.setPortletMode(PortletMode.VIEW);

portletURL.setParameter("struts_action", "/ext/cms/search/search");
;
%>

<form action="<%= portletURL %>" method="post" name="GN_CMS_SEARCH_FORM" onsubmit="submitForm(this); return false;">
<legend>&nbsp;</legend>
<input type="hidden" name="search" value="true">
<table >
  <tr>
    <td><input alt="<%= keywords %>" class="txt" title="<%= keywords %>" name="<%= namespace %>keywords" size="23" type="text" value="<%= keywords %>" onBlur="if (this.value == '') { this.value = '<%= unicodeDefaultKeywords %>'; }" onFocus="if (this.value == '<%= unicodeDefaultKeywords %>') { this.value = ''; }" />
    </td>
    <td style="padding-left:3px;">
    <input type="image" alt="<liferay-ui:message key="search" />" class="img" title="<liferay-ui:message key="search" />"  src="<%= themeDisplay.getPathThemeImages() %>/common/search.gif" title="<liferay-ui:message key="search" />" type="image" 
     onclick="if (document.GN_CMS_SEARCH_FORM.elements['<%= namespace %>keywords'].value == null || 
   		 document.GN_CMS_SEARCH_FORM.elements['<%= namespace %>keywords'].value == '') { alert('<%= LanguageUtil.get(pageContext, "cms.search.please-input-criterion") %>'); return false; }" onkeypress="if (document.GN_CMS_SEARCH_FORM.elements['<%= namespace %>keywords'].value == null || 
   		 document.GN_CMS_SEARCH_FORM.elements['<%= namespace %>keywords'].value == '') { alert('<%= LanguageUtil.get(pageContext, "cms.search.please-input-criterion") %>'); return false; }"/>
   </td>
  </tr>
</table>

</form>