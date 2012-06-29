 	<%if (inOneRow==true) { %>
	<tr>
	<%} %>
	

	
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
	fieldSize = form_field.getField_size();
	optionNames = form_field.getOption_labels();
	optionValues= form_field.getOption_values();
	optionSelected= form_field.getOption_selected();
	fieldDateFormat = form_field.getDateFormat();
//default case

 remainCols=index%pageColumns;
	

for(exceptionsIndex=0; exceptionsIndex<commonExceptionsFields.length; exceptionsIndex++) {
//	if(commonExceptionsFields[exceptionsIndex].equals(fieldName) ){ 
if(commonExceptionsFields[exceptionsIndex].indexOf(",--" + fieldName +"--") >=0  ){
%>



	<%if (inOneRow==false) { %>
		<tr>
	<%}%>
			<td>
				<span class="alpha1"><span class="bg-neg-alert">
				<%= commonExceptionsMessages[exceptionsIndex]%> <%=fieldName %>
				</span></span>
			</td>
		
			<%if (inOneRow==false) { %>
		</tr>
	<%}%>

	
<%	}
}

if(!exceptionName.equals("")) {%>

	<liferay:if test="<%= SessionErrors.contains(request, exceptionName) %>">
	

	<%if (inOneRow==false) { %>
		<tr>
	<%}%>

			<td>
				<span class="alpha1"><span class="bg-neg-alert"><%= LanguageUtil.get(pageContext, exceptionMessage) %>
				</span></span>
			</td>
			<%if (inOneRow==false) { %>
		</tr>
	<%}%>

	</liferay:if>
<%} %>



<%if (request.getParameter(formFieldName) != null)  {
	if(!formType.equals("file")) {
	formValue = request.getParameter(formFieldName).toString();
	
	//OK WE WILL HARDCODE FOR THE INTEREST MESSAGES
	
	if(formFieldName.equals("product_name") && formType.equals("hidden")) {
		formValue = JS.decodeURIComponent(request.getParameter(formFieldName));
	}
	}
	else {
//		UploadServletRequest uploadReq =(UploadServletRequest)request;
	//		formValue=(uploadReq).getFileName(formFieldName);
		
	
	}

}

if(formType.equals(""))
	formType="text";
if(formType.equals("narrowtext") || formType.equals("text") || formType.equals("button") || formType.equals("reset") || formType.equals("submit") || formType.equals( "hidden") || formType.equals("file")){ %>
	<%if (inOneRow==false && remainCols==0 ) { %>

		<tr>
	<%}%>

		<td>
<%if(! formType.equals( "hidden") || form_field.isLanguage() == true) {%>
		<span class="gamma1-FormText">
		<%= LanguageUtil.get(pageContext, fieldTitle) %>
		
		</span>
		<%} %>
		</td>
		
		
		<td  class="gamma1">

<% if ((formValue==null ) || (formValue=="") || formValue.equals(""))
							formValue = defaultValue; %>
							
							
		<%if ( form_field.isLanguage() == true) {%>
		

				<input class="gamma1-FormArea" name="<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>" type="hidden" size="50" value="<%=formValue %>">
				<span class="alpha1"><%=formValue %></span>
			
			
			<%
			if(availableTranslations!=null) {
				for (int k=0; k<availableTranslations.size(); k++) { %>
					<span class="alpha1">
					<!-- RECONSTRUCT THE QUERY STRING -->

					<%
					if(isStrutsPage==false) {
						  String newQueryString = myqueryString.replaceFirst("language="+current_language, "language="+availableTranslations.get(k));
			 		%>		  			 
					[<a class="bg1" href="<%= mypage%>?<%=newQueryString%> ">
					<%=availableTranslations.get(k) %></a>]
					
					<%}
						else { %>
						[<a class="bg1" href="<portlet:actionURL>
						<portlet:param name="struts_action" value="<%= mypage%>"/>
						<%for (int myInd=0; myInd<StrutsParamNames.length; myInd++) { 
							if(StrutsParamNames[myInd].equals("language")) {
						%>	
						<portlet:param name="<%=StrutsParamNames[myInd] %>" value="<%= availableTranslations.get(k).toString()%>"/>
						<%} else  if(request.getParameter(StrutsParamNames[myInd])!=null) {%>
						<portlet:param name="<%=StrutsParamNames[myInd] %>" value="<%= request.getParameter(StrutsParamNames[myInd]).toString()%>"/>
<%						}
						}%>
						</portlet:actionURL>">
					<%=availableTranslations.get(k) %></a>]
						
						
						<%} %> 
					
					</span>
			<%	} 
			}
		} //islanguage
		else { 

			if (formType.equals("narrowtext")) {
				formType.equals("text");
				fieldSize = 15;
			}
		%>

<%if (isStrutsPage==true && formType.equals("file")){ %>

				<input class="gamma1-FormArea" type="<%=formType %>" name="<portlet:namespace /><%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>" value ="<%=formValue %>" size="<%=fieldSize%>"  <%if (fieldName.equals("TOPICNAME") && topicnamedisabled==true) { %> disabled <%} %>>

<%}

else { %>

				<input class="gamma1-FormArea" type="<%=formType %>" name="<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>" value ="<%=formValue %>" size="<%=fieldSize%>"  <%if (fieldName.equals("TOPICNAME") && topicnamedisabled==true) { %> disabled <%} %>>

<%} %>
				<%if  (fieldName.equals("TOPICNAME") && ! isTopics.equals("0")) {
						String namespace="_" + thisPortletId +"_";
				 %> 
				<%if(thisPortletId.equals("GN_CHAPTERS")) { %>
			
				<a target="_new" href="<liferay:actionURL windowState="maximized" portletName="GN_TOPICS"><liferay:param name="struts_action" value="/ext/topics/topics_tree"/><liferay:param name="portletid" value="<%=thisPortletId %>"/>
<% if(isStrutsPage==true) { %>
<liferay:param name="isStrutsPage" value="<%=namespace%>"/>
<%} %>
<liferay:param name="course_id" value="<%=request.getParameter("course_id")  %>"/>
				<liferay:param name="parent_id" value="<%=request.getParameter("parent_chapter")%>"/>
</liferay:actionURL>">add topic</a>
			
			
				
				<%} else { %>
				
				
				<a target="_new" href="<liferay:actionURL windowState="maximized" portletName="GN_TOPICS">
				<liferay:param name="struts_action" value="/ext/topics/topics_tree"/>
				<liferay:param name="portletid" value="<%=thisPortletId %>"/>
				<% if(isStrutsPage==true) { %>
				<liferay:param name="isStrutsPage" value="<%=namespace%>"/>
				<%} %></liferay:actionURL>">add topic</a>
				<%} %>
				
					<%if(!item_contentid.equals("")) { %>
					
										<a target="_new" href="<liferay:actionURL windowState="maximized" portletName="GN_TOPICS"><liferay:param name="struts_action" value="/ext/topics/itemstopics"/><liferay:param name="contentid" value="<%=item_contentid%>"/><liferay:param name="has_topics" value="<%=isTopics%>"/><liferay:param name="optional_topics" value="<%=optional_topics%>"/></liferay:actionURL>">view item topics</a>
					<%}%>
				<%} %>
<%if(formType.equals( "hidden")  && form_field.isDisplayHiddenValue() == true) { %>
	<%= formValue%>
	<%}%>
	
				</td>
	<%if ((inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}%>
			
				

	<%	}
}	

else {

if(formType.equals("date") ){ %>
<%if (inOneRow==false && remainCols==0 ) { %>

		<tr>
	<%}%>

		<td>

		<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, fieldTitle) %></span></td><td nowrap  class="gamma1">

<% if ((formValue==null ) || (formValue==""))
							formValue = defaultValue; 
		%>

				<input  type="text" id =<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%> name="<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>" value ="<%=formValue %>" size="<%=fieldSize%>"  <%if (fieldName.equals("TOPICNAME") && topicnamedisabled==true) { %> disabled <%} %>>
				<img src="/html/themes/portlet/gnomon_theme/img/calendar.gif" id="f_<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>" style="cursor: pointer; border: 1px solid red;" title="Date selector"
      onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />


<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>",     // id of the input field
        button         :    "f_<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
		ifFormat    : "<%=fieldDateFormat%>",  
		daFormat : "<%=fieldDateFormat%>",
		showsTime :true,
        singleClick    :    true
    });
</script>
				</td>
	<%if ((inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}	
	
}






else {
		if(formType.equals("textarea") ) { %>
	<%if ( inOneRow==false && remainCols==0) { %>
		<tr>
	<%}%>


				<td>
				<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, fieldTitle) %></span></td><td  class="gamma1">
				<textarea class="gamma1-FormArea" rows="15" cols="<%=form_field.getTextareasize() %>"  name="<%=formFieldName %><%if (addIndexParam!=-1){%>_<%=addIndexParam%><%}%>"><%=formValue%></textarea>
				</td>

					<%if( (inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}%>

		<%	}
		else {
		if(formType.equals("textareahtml") ) { %>
	<%if ( inOneRow==false && remainCols==0) { %>
		<tr>
	<%}%>

		<%@ include file="/html/portlet/ext/includes/form_editor.jsp" %>
		<td  class="gamma1">
		<%formValue = formValue.replaceAll("\"","'"); %>
		
		
		<%if (isStrutsPage==true) { %>
		
		
			    <INPUT type="hidden" name="<portlet:namespace/><%=formFieldName%>" value="<%=formValue %>">	
		<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, fieldTitle) %></span></td><td>
		 <IFRAME  ondeactivate = "<%=formFieldName %>_saveArticle(); "  id=<portlet:namespace/><%=formFieldName%>_editor name=<portlet:namespace/><%=formFieldName%>_editor src="<%= contextPath %>/html/js/editor/editor.html" frameBorder=0  width="100%" height=400 ></IFRAME>

		
		<% } else { %>
	    <INPUT type="hidden" name="<%=formFieldName%>" value="<%=formValue %>">	
		<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, fieldTitle) %></span></td><td>
		 <IFRAME  ondeactivate = "<%=formFieldName %>_saveArticle(); "  id=<%=formFieldName%>_editor name=<%=formFieldName%>_editor src="<%= contextPath %>/html/js/editor/editor.html" frameBorder=0  width="100%" height=400 ></IFRAME>

<%} %>
	</td>
	
					<%if( (inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}%>

		<%	}
			else if(formType.equals("select")) {

				/************ special case for language ******/
				%>		
					<%if (inOneRow==false && remainCols==0) { %>
		<tr>
	<%}%>

		<td  >

		<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, fieldTitle) %></span></td><td class="gamma1">

				<% if (form_field.isMultiple()==true) { %>
					<select    class="gamma1-FormArea" name="<%=formFieldName %><%if (addIndexParam!=-1) { %>_<%=addIndexParam%><%}%>"  multiple >
					<%} else { %>
					<select  class="gamma1-FormArea" name="<%=formFieldName %><%if (addIndexParam!=-1) { %>_<%=addIndexParam%><%}%>"  >
					<%
					}
				if( form_field.isLanguage() == true) {						
						if(availableLanguages!=null) {
							for (int k=0; k<availableLanguages.size(); k++) { %>
								<option value=<%=availableLanguages.get(k)%>><%=availableLanguages.get(k) %></option>
						<%	} 
						} 
						
					} else {  // for other fields than language

						if (optionValues!=null && optionValues.length >0) {
								for (int k=0; k<optionValues.length; k++) { 
									boolean selected = false;
									if(!form_field.isMultiple())
										selected =  formValue.equals(optionValues[k]);
									else
									{
										if(optionSelected != null)
										{
												
											boolean found = false;
											for(int l=0;l<optionSelected.length;l++)
												if(optionSelected[l].equals(optionValues[k]))
													found =true;
											selected = found;
										}
									}
										
								
								%>

								
						<option value=<%=optionValues[k]%>  <% if( selected ){%> selected <%} %>><%=optionNames[k] %></option>


						<%	}
							}    
							}
							%>
</select>
				</td>
<%if ((inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}%>

				
		<%		
		
		
	}
	else if(formType.equals("radio")) {%>
	<%if (inOneRow==false && remainCols==0) { %>
		<tr>
	<%}%>

<td  >
	<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, fieldTitle) %></span></td><td class="gamma1">
					<%	if (optionValues!=null && optionValues.length >0) {
								for (int k=0; k<optionValues.length; k++) { 
								
								%>

						<input   type="radio" name="<%=formFieldName %><%if (addIndexParam!=-1) { %>_<%=addIndexParam%><%}%>"  value=<%=optionValues[k]%> <% if( formValue.equals(optionValues[k])  ){%> checked <%} %>><%=optionNames[k] %>

						<%	}
							}    %>
			</td>
	<%if ((inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}%>

		<%}
		
			else if(formType.equals("checkbox")) {%>
			<%if (inOneRow==false && remainCols==0) { %>
		<tr>
	<%}%>

			<td >
				<span class="gamma1-FormText"><%= LanguageUtil.get(pageContext, fieldTitle) %></span></td><td  class="gamma1">
<%
						if (optionValues!=null && optionValues.length >0) {
								for (int k=0; k<optionValues.length; k++) { 
								
								%>

						<input    type="checkbox" name="<%=formFieldName %><%if (addIndexParam!=-1) { %>_<%=addIndexParam%><%}%>"  value=<%=optionValues[k]%> <% if( formValue.equals(optionValues[k]) || formValue.indexOf("," + optionValues[k]) >=0){%> checked <%} %>><%=optionNames[k] %>
						<%	}

							}    %>
		</td>
			<%if ((inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}%>

<%		}
		}			
	 }	
	}
	
}
%>

<%if ((inOneRow==false && remainCols==pageColumns-1) || index ==fields.size()-1) { %>
		</tr>
	<%}%>
