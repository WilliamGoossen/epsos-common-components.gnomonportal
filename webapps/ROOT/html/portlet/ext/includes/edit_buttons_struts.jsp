
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>


		<%if (buttonSave==true) { %>
			<liferay:if test="<%= item == null %>">
 <input class="portlet-form-button" type="button"value="<%= LanguageUtil.get(pageContext, "save") %>" onClick="document.<portlet:namespace />fm.cmd.value = '<%= Constants.ADD %>';<%=onclickSave %>'<portlet:actionURL>
	<%for(int  pInd=0; pInd <SaveParamNames.length; pInd++) {%>
			<portlet:param name="<%=SaveParamNames[pInd] %>"  value="<%=SaveParamValues[pInd]%>" />
		<%}	%>
		</portlet:actionURL>';">

	</liferay:if>
			<%}%>

				<%if (buttonSaveTrans==true) { %>
					<%  if(availableLanguages!=null && availableLanguages.size() >0 ) {%>
<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "save") %>"
onClick="document.<portlet:namespace />fm.cmd.value = 'ADDTRANS';<%=onclickSaveTrans %>'<portlet:actionURL>
<%for(int  pInd=0; pInd <SaveTransParamNames.length; pInd++) {%>
			<portlet:param name="<%=SaveTransParamNames[pInd] %>"  value="<%=SaveTransParamValues[pInd]%>" />
		<%}	%>
		</portlet:actionURL>';">
				<%} %>
			<%}%>


			<liferay:if test="<%= item != null %>">
			<%if (buttonUpdate==true) { %>

				<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "update") %>" onClick="document.<portlet:namespace />fm.cmd.value = '<%= Constants.UPDATE %>'; <%=onclickUpdate %>'<portlet:actionURL>
<%for(int  pInd=0; pInd <UpdateParamNames.length; pInd++) {%>
			<portlet:param name="<%=UpdateParamNames[pInd] %>" value="<%=UpdateParamValues[pInd]%>" />
		<%}	%>
		</portlet:actionURL>';">
		<%}%>

<%if (buttonAddTrans==true) { %>
	<%  if(availableLanguages!=null && availableLanguages.size() >0 ) {%>
	 <input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "add-translation") %>"
	onClick="<%=onclickAddTrans%> '<portlet:actionURL>
	<%for(int  pInd=0; pInd <AddTransParamNames.length; pInd++) {%>
			<portlet:param name="<%=AddTransParamNames[pInd] %>"  value="<%=AddTransParamValues[pInd]%>" />
		<%}	%>
		</portlet:actionURL>';">


		<%} %>
<%}%>

<%if (buttonDelete==true) { %>
					<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "delete") %>" onClick="if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-this-item") %>')) { document.<portlet:namespace />fm.cmd.value = '<%= Constants.DELETE %>';<%=onclickDelete%>' <portlet:actionURL>
<%for(int  pInd=0; pInd <DeleteParamNames.length; pInd++) {%>
			<portlet:param name="<%=DeleteParamNames[pInd] %>"  value="<%=DeleteParamValues[pInd]%>" />
		<%}	%>
		</portlet:actionURL>';}">
		<%}%>

<%  if(availableTranslations!=null && availableTranslations.size() >0 && !current_language.equals(default_lang)) { %>
<%if (buttonDeleteTrans==true) { %>
<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "delete-this-translation") %>" onClick="if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-this-translation") %>')) { document.<portlet:namespace />fm.cmd.value = 'DELETETRANS'; <%=onclickDeleteTrans%>' <portlet:actionURL>
<%for(int  pInd=0; pInd <DeleteTransParamNames.length; pInd++) {%>
			<portlet:param name="<%=DeleteTransParamNames[pInd] %>"  value="<%=DeleteTransParamValues[pInd]%>" />
		<%}	%>
		</portlet:actionURL>'; }">
<%} %>
		<%}%>
			</liferay:if>

			<%if (buttonCancel==true) { %>
				<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "cancel") %>" onClick="<%=onclickCancel%>'<portlet:actionURL>
<%for(int  pInd=0; pInd <CancelParamNames.length; pInd++) {%>
			<portlet:param name="<%=CancelParamNames[pInd] %>"  value="<%=CancelParamValues[pInd]%>" />
		<%}	%>
		</portlet:actionURL>';">
			<%}%>
		</td>





	</tr>
	</table>
