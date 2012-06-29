<table border="0" cellpadding="0" cellspacing="0" width="95%">
	<tr>
		<td>
			<% 
			if(availableTranslations!=null) {
				for (int k=0; k<availableTranslations.size(); k++) { %>
					<span class="bg1" >
					[<a class="bg1" href="<%= mypage%>?<%=myqueryString.replaceFirst("_" + thisPortletId + "_language="+ParamUtil.getString(request, "language"),"_" + thisPortletId + "_language="+availableTranslations.get(k))%> "><%=availableTranslations.get(k) %></a>]
					</span>
				<% }
			} %>
		</td>
	</tr>
</table>

