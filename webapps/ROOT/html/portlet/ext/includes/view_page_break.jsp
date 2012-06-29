<liferay:if test="<%= (items != null) && (items.size() > 0) %>">

	<%request.setAttribute("test", items);
	thisPage="/" + thisPage + "?actionURL=true";
	%>

	<display:table name="test" id="test" sort="list" class="<%=disp_class%>" pagesize="10" requestURI="<%=thisPage%>">
<%
 disprow=(Integer)(pageContext.getAttribute("test_rowNum"));
	item = (Hashtable) items.get(disprow.intValue()-1);
	
	%>
	
		<display:column>
		
		<%if (!columnImage.equals("")) { %>
				<!-- TO EIKONIDIO POY EXOUME EPILEKSEI -->
				<img src="<%=columnImage %>" border=0>

		<%} %>
		
		
		
	<%for (columnIndex = 0; columnIndex < ColumnNames.length; columnIndex++) {
		
	
		String url="";
				if (displayColumns[columnIndex] == true) {
					if (!hrefs[columnIndex].equals("")) {
					
						//PortletURL PURL1 = new PortletURLImpl(request, "", layout.getLayoutId(), true);
				
								int col_pos= hrefs[j].indexOf("column|");
								String urlcolumnname="";
								if(col_pos >=0)  {
									 urlcolumnname=hrefs[j].substring(col_pos + "column|".length());
										url = item.get(urlcolumnname).toString();
									}
									else {
											PortletURL PURL1 = new PortletURLImpl(request,ViewStrutsPortlet, layout.getLayoutId(), true);

											PURL1.setWindowState(WindowState.MAXIMIZED);
											PURL1.setPortletMode(PortletMode.VIEW);
											PURL1.setParameter("struts_action", hrefs[columnIndex]);
								
											for( j=0; j<ColumnNames.length; j++) {
													if(!ParamNames[j].equals("")  && item.get(ColumnNames[j])!=null) {
														String myvalP= item.get(ColumnNames[j]).toString();
														PURL1.setParameter(ParamNames[j], myvalP);
													}
											}
								
										for( j=0; j<ViewStrutsParamNames.length; j++) {
								
							PURL1.setParameter(ViewStrutsParamNames[j], ViewStrutsParamValues[j]);
										}
							
						 				url = PURL1.toString();	
								}
					}			
%>

		
	
				<%if(!url.equals("")) { 
					int ext_pos = hrefs[j].indexOf("external|");
				%>
				
			
					<%if (ext_pos >=0){ %>
						<a target="_blank" href="<%=url%>"> <%=item.get(ColumnNames[columnIndex]).toString()%></a>
					<%} else { %>
							<a href="<%=url%>"> <%=item.get(ColumnNames[columnIndex]).toString()%></a>
					<%}%>
			
				
		
			<%} else {%>
				<%=item.get(ColumnNames[columnIndex]).toString()%>
				<%}%>	
			
	<br>
		<%}%>
	
	
		<%}%>							
		
</display:column>
		
		
	<%if (showediticon == true)  {
		
//Integer disprow=(Integer)(pageContext.getAttribute("test_rowNum"));
//item = (Hashtable) items.get(disprow.intValue()-1);
%>




<display:column>


			<a class="gamma1"			href="<portlet:actionURL>
						<portlet:param name="struts_action"  value="<%=edit_page  %>" />
			
							<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")  && item.get(ColumnNames[columnIndex])!=null) {								
								String myvalP= item.get(ColumnNames[columnIndex]).toString();
								%>
								<liferay:param name="<%=ParamNames[columnIndex]%>" value="<%=myvalP%>" />
						
							
							<%}
						}%>
						
						<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<liferay:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}%>
						

								</portlet:actionURL>">
				<img src="/html/themes/portlet/gnomon_theme/img/pencil.gif" border=0></a>

	</display:column>
		<%}%>
	
		<%if (showdeleteicon == true)  {
		
//Integer disprow=(Integer)(pageContext.getAttribute("test_rowNum"));
//item = (Hashtable) items.get(disprow.intValue()-1);
%>




<display:column>


			<a class="gamma1"			href="<portlet:actionURL>
						<portlet:param name="struts_action"  value="<%=edit_page  %>" />
			
							<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")  && item.get(ColumnNames[columnIndex])!=null) {								
								String myvalP= item.get(ColumnNames[columnIndex]).toString();
								%>
								<liferay:param name="<%=ParamNames[columnIndex]%>" value="<%=myvalP%>" />
						
							
							<%}
						}%>
						
						<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<liferay:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}%>
						

								</portlet:actionURL>">
				[x]</a>

	</display:column>
		<%}%>
	
	
	

		






	
	
	</display:table>





</liferay:if>



