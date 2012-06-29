<%
if ((availableTranslations!=null) && (availableTranslations.size()>0)) { %>
<%
	if (myqueryString.indexOf("language=")==-1) {
		myqueryString = myqueryString + "&_" + thisPortletId + "_language=";
	}
%>
<liferay:box top="/html/common/box_top.jsp" bottom="/html/common/box_bottom.jsp"> 
<liferay:param name="box_title" value="<%=LanguageUtil.get(pageContext, \"available-translations\")%>" /> 
<table border="0" cellpadding="0" cellspacing="0" width="95%">
  <tr>
  	<td>
		<table border="0" cellpadding="0" cellspacing="0" width="95%">
			<tr>
				<td>
					<% 
					for (int k=0; k<availableTranslations.size(); k++) { %>
						<span class="bg1" >
						[<a class="bg1" href="<%= mypage%>?<%=myqueryString.replaceFirst("_" + thisPortletId + "_language="+ParamUtil.getString(request, "language"),"_" + thisPortletId + "_language="+availableTranslations.get(k))%> "><%=availableTranslations.get(k) %></a>]
						</span>
					<% }%>
				</td>
			</tr>
		</table>
	</td>
  </tr>
</table>
</liferay:box>

<% } %>