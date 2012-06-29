

	<table border="0" cellpadding="0" cellspacing="0">

	<tr>

		<td>





		<%if (buttonSave==true) { %>

			<liferay:if test="<%= item == null %>">

				<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "save") %>" onClick="document.fm.cmd.value = '<%= Constants.ADD %>'; <%=onclickSave %>">

	</liferay:if>

			<%}%>



				<%if (buttonSaveTrans==true) { %>



					<%  if(availableLanguages!=null && availableLanguages.size() >0 ) {%>

				<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "save") %>" onClick="document.fm.cmd.value = 'ADDTRANS'; <%=onclickSaveTrans %>">

				<%} %>

			<%}%>





			<liferay:if test="<%= item != null %>">

			<%if (buttonUpdate==true) { %>



				<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "update") %>" onClick="document.fm.cmd.value = '<%= Constants.UPDATE %>'; <%=onclickUpdate %>">

		<%}%>



<%if (buttonAddTrans==true) { %>

	<%  if(availableLanguages!=null && availableLanguages.size() >0 ) {%>

		<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "add-translation") %>" onClick="<%=onclickAddTrans%>">

		<%} %>

<%}%>



<%if (buttonDelete==true) { %>

					<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "delete") %>" onClick="if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-this-item") %>')) { document.fm.cmd.value = '<%= Constants.DELETE %>';<%=onclickDelete%> }">

		<%}%>



<%  if(availableTranslations!=null && availableTranslations.size() >0 && !current_language.equals(default_lang)) { %>

<%if (buttonDeleteTrans==true) { %>

<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "delete-this-translation") %>" onClick="if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-delete-this-translation") %>')) { document.fm.cmd.value = 'DELETETRANS'; <%=onclickDeleteTrans%> }">

<%} %>

		<%}%>

			</liferay:if>



			<%if (buttonCancel==true) { %>

				<input class="portlet-form-button" type="button" value="<%= LanguageUtil.get(pageContext, "cancel") %>" onClick="<%=onclickCancel%>">

			<%}%>

		</td>











	</tr>

	</table>

