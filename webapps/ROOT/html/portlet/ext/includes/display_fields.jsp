<table border="0" cellpadding="0" cellspacing="0" width="100%">

<!--  AND  NOW THE EDIT... IF WE HAVE PERMISSIONS -->


<% 


for (index=0; index < fields.size(); index ++) {

	form_field = (formFields) fields.get(index);

	fieldName = form_field.getFieldName();

	formFieldName = form_field.getFormFieldName();

	required = form_field.getRequired();

	formType = form_field.getFieldType();

	exceptionName = form_field.getExcpetionName();

	formValue= form_field.getValue();

	defaultValue=form_field.getDefaultValue();

	exceptionMessage= form_field.getExceptionMessage();

	fieldTitle=form_field.getTitle();

	show = form_field.isShowInViewPage();

	formPathUrl=form_field.getPathUrl();

	formStyle=form_field.getStyle();
	optionNames = form_field.getOption_labels();
	optionValues= form_field.getOption_values();
	optionSelected = form_field.getOption_selected();

//default case
%>


<%




if(!exceptionName.equals("")) {%>

	<liferay:if test="<%= SessionErrors.contains(request, exceptionName) %>">
		<tr >
			<td><span class="bg-neg-alert"><%= LanguageUtil.get(pageContext, exceptionMessage) %></span>
			</td>
		</tr>
	</liferay:if>



<%} 







	if(show==true) {

		if(formType.equals("HttpLink")) {%>
				<%if ((!formValue.equals("")   && !formValue.equals("http://")) || show_empty_fields==true) {%>
		<tr class="<%=disp_labelsLine%>">

		<%if(showLabels==true) { %>

				<td align="left"><span class="<%=disp_labelsStyle%>">
			<%= LanguageUtil.get(pageContext, fieldTitle) %>:</span>
				</td>

				<%}%>
				<%if (!formValue.equals("")   && !formValue.equals("http://")) {%>
				<td align="left" <%if (!formStyle.equals("")) { %> class="<%=formStyle%>"<%} else {%>  class="<%=disp_myspanstyle%>" <%} %>>	<a target="_blank" href="<%=formPathUrl%><%=formValue %>" ><%=formValue %> </a></td>
<%}%>
			</tr>		



<%		}
}



else if(formType.equals("HttpInternal")) {%>
		<tr class="<%=disp_labelsLine%>">

		<%if(showLabels==true) { %>

				<td align="left"> <span class="<%=disp_labelsStyle%>">
			<%= LanguageUtil.get(pageContext, fieldTitle) %>:</span>
				</td>

				<%}%>
				<%if (!formValue.equals("")   && !formValue.equals("http://")) {%>
				<%/* contstuct the url */
					for(int ci=0; ci<optionValues.length; ci++) {
						
						formPathUrl=formPathUrl + "&"  + optionNames[ci] + "=" + item.get(optionValues[ci]);
					
				}
						
			
					
					

				
				%>
				<td align="left" <%if (!formStyle.equals("")) { %> class="<%=formStyle%>"<%} else {%>  class="<%=disp_myspanstyle%>" <%} %>>	<a target="_blank" href="<%=formPathUrl%>" ><%=formValue %> </a></td>
				

<%}%>
			</tr>		



<%		}


		else {

			if(formType.equals("IMG")) {%>

							<tr class="<%=disp_labelsLine%>">

		<%if(showLabels==true) { %>

				<td align="left"> <span class="<%=disp_labelsStyle%>">
			<%= LanguageUtil.get(pageContext, fieldTitle) %>:</span>
				</td>

				<%} %>

				<td align="left" border=0 <%if (!formStyle.equals("")) { %> class="<%=formStyle%>"<%} %>">	<img src="<%=formValue %>"  border=0></td>

			</tr>		



			<% }

			else {

				if(formType.equals("textarea") || formType.equals("textareahtml")) { 	
					if((formValue!=null && !formValue.equals("")) || show_empty_fields==true) {%>
				<tr><td colspan=2></td></tr>
			<%if (area_labels==true){%> 
				<tr><td colspan=2><span class="<%=disp_labelsStyle%>">
				<%if(fieldTitle!=null && !fieldTitle.equals("")) {%>
			<%= LanguageUtil.get(pageContext, fieldTitle) %>:</span> </td></tr>
			 <%}
			 }%>

						<tr>

						<td colspan="2" <%if (!formStyle.equals("")) { %> class="<%=formStyle%>"<%} else {%>  class="<%=disp_myspanstyle%>" <%} %>><%=formValue %></td>

					</tr>		

				

			<%
			}
			}
			else {
			if(formType.equals("select") || formType.equals("radio") || formType.equals("checkbox")) 
			{
				if(formType.equals("select") && form_field.isMultiple())
				{
				
				if(formValue.equals(fieldName))
					formValue="";
					String tempList = "";
					for(int l=0;optionSelected != null && l < optionSelected.length;l++)
					{
						for (int k=0; k<optionValues.length; k++) { 
							if(optionValues[k].equals(optionSelected[l]))  {
								tempList += optionNames[k]+", ";
								break;
							}
						}	
						
					}
					if(!tempList.equals(""))
						formValue = tempList.substring(0,tempList.length()-2);//Strip the trailing comma
				}else
				{
					if (optionValues!=null && optionValues.length >0) {
						for (int k=0; k<optionValues.length; k++) { 
							if(optionValues[k].equals(formValue))  {
								formValue=optionNames[k];
								break;
								
							}
						}
					}
				}
		%>
		
			<%				if((formValue!=null && !formValue.equals("")) || show_empty_fields==true) {%>
		<tr class="<%=disp_labelsLine%>">

		<%if(showLabels==true) { %>

				<td align="left"> <span class="<%=disp_labelsStyle%>">
			<%= LanguageUtil.get(pageContext, fieldTitle) %>:</span>
				</td>

				<%} %>
						<td  <%if (!formStyle.equals("")) { %> class="<%=formStyle%>"<%} else {%>  class="<%=disp_myspanstyle%>" <%} %>>	<%=formValue %></td>
					</tr>		
			<%}
			}

			else { %>
			<%				if((formValue!=null && !formValue.equals("")) || show_empty_fields==true) {%>

			
						<tr class="<%=disp_labelsLine%>">

		<%if(showLabels==true) { %>

				<td align="left"> <span class="<%=disp_labelsStyle%>">
			<%= LanguageUtil.get(pageContext, fieldTitle) %>:</span>
				</td>



				<%} %>

				<td align="left" <%if (!formStyle.equals("")) { %> class="<%=formStyle%>"<%}  else {%>  class="<%=disp_myspanstyle%>" <%} %>>	<%=formValue %></td>

			</tr>		



<%			}

}

			}

		  }		
		}

	}

}

%>



</table>
