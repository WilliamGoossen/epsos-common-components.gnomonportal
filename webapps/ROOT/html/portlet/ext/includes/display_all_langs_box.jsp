<liferay:box top="/html/common/box_top.jsp" bottom="/html/common/box_bottom.jsp"> 
<liferay:param name="box_title" value="<%=LanguageUtil.get(pageContext, \"translations\")%>" /> 
<table border="0" cellpadding="0" cellspacing="0" width="95%">
	<tr>
		<td>
			<%
			String languages= PropsUtil.get(PropsUtil.LOCALES);
			String locales[] = StringUtil.split(languages, ",");
			String url = (String)request.getAttribute(WebKeys.CURRENT_URL);
			
		if (url.indexOf("_" + thisPortletId + "_language=")==-1) {
				if (url.indexOf("?")==-1) 
					url = url + "?_" + thisPortletId + "_language=" + ParamUtil.getString(request, "language");
				else
					url = url + "&_" + thisPortletId + "_language=" + ParamUtil.getString(request, "language");
}
			if(locales!=null) {
				for (int k=0; k<locales.length; k++) { %>
					<span class="bg1" >
					[<a class="bg1" href="<%=url.replaceFirst("_" + thisPortletId + "_language="+ParamUtil.getString(request, "language"),"_" + thisPortletId + "_language="+(locales[k]).toString())%> "><%=(locales[k]).toString() %></a>]
					</span>
				<% }
			} %>
		</td>
	</tr>
</table>
</liferay:box>