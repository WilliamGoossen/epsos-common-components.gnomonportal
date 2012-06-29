<tr>
		<td align="left">

		<table border="0" cellpadding="1" cellspacing="2" width="95%">

<% if (breakline==true) { %>
	<%@ include file="/html/portlet/ext/includes/view_page_break.jsp" %>
	
<% } else { %>
<liferay:if test="<%= (items != null) && (items.size() > 0) %>">

	<%request.setAttribute("test", items);
	thisPage="/" + thisPage + "?actionURL=true";
	%>



	<display:table name="test" id="test" sort="list" class="<%=disp_class%>" pagesize="10" requestURI="<%=thisPage%>">
	<display:setProperty name="paging.banner.placement" value="both"/>
		<display:setProperty name="paging.banner.full" value="<span class=\"pagelinks\">[<a href=\"{1}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/first.gif\" border=\"0\"/></a>/<a href=\"{2}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/prevhit.gif\" border=\"0\"/></a>]{0} [ <a href=\"{3}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/nexthit.gif\" border=\"0\"/></a>/ <a href=\"{4}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/last.gif\" border=\"0\"/></a>]</span>" />
	
		<display:setProperty name="paging.banner.first" value="<span class=\"pagelinks\"> {0} [ <a href=\"{3}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/nexthit.gif\" border=\"0\"/></a>/ <a href=\"{4}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/last.gif\" border=\"0\"/></a>]</span>" />
	
		<display:setProperty name="paging.banner.last" value="<span class=\"pagelinks\">[<a href=\"{1}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/first.gif\" border=\"0\"/></a>/<a href=\"{2}\"><img src=\"/html/themes/portlet/gnomon_theme/img/nav/prevhit.gif\" border=\"0\"/></a>]{0} </span>" />
	
	
	<display:setProperty name="paging.banner.one_item_found" value="<%=one_item%>" />
	
	<display:setProperty name="paging.banner.all_items_found" value="<%=all_items%>"  />
	
	<display:setProperty name="paging.banner.some_items_found" value="<%=some_items%>" />
	
<%
 disprow=(Integer)(pageContext.getAttribute("test_rowNum"));
	item = (Hashtable) items.get(disprow.intValue()-1);
	%>
	<%if (!columnImage.equals("")) { %>

				<!-- TO EIKONIDIO POY EXOUME EPILEKSEI -->
<display:column>
				<img src="<%=columnImage %>" border="0">
				
</display:column>		

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
					<display:column sortable="true" title="<%= LanguageUtil.get(pageContext, LabelNames[columnIndex]) %>">
			
					<%if (ext_pos >=0){ %>
						<a target="_blank" href="<%=url%>"> <%=item.get(ColumnNames[columnIndex]).toString()%></a>
					<%} else { %>
							<a href="<%=url%>"> <%=item.get(ColumnNames[columnIndex]).toString()%></a>
					<%}%>
			
					</display:column>
		
			<%} else {%>
				<display:column property="<%=ColumnNames[columnIndex]%>" sortable="true" title="<%= LanguageUtil.get(pageContext, LabelNames[columnIndex]) %>" />
				<%}%>	
			
		<%}%>
	
	
	
		<%}%>							
		
		
	<%if (showediticon == true)  {
		
//Integer disprow=(Integer)(pageContext.getAttribute("test_rowNum"));
//item = (Hashtable) items.get(disprow.intValue()-1);
%>




<display:column>


			<a class="gamma1"			href="<portlet:actionURL>
						<portlet:param name="struts_action"  value="<%=edit_page  %>" />
			<portlet:param name="cmd" value="edit" />
							<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")  && item.get(ColumnNames[columnIndex])!=null) {								
								String myvalP= item.get(ColumnNames[columnIndex]).toString();
								%>
								<portlet:param name="<%=ParamNames[columnIndex]%>" value="<%=myvalP%>" />
						
							
							<%}
						}%>
						
						<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<portlet:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
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
				<portlet:param name="cmd" value="delete" />
							<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")  && item.get(ColumnNames[columnIndex])!=null) {								
								String myvalP= item.get(ColumnNames[columnIndex]).toString();
								%>
								<portlet:param name="<%=ParamNames[columnIndex]%>" value="<%=myvalP%>" />
						
							
							<%}
						}%>
						
						<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<portlet:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}%>
					
						

								</portlet:actionURL>">
				[x]</a>

	</display:column>
		<%}%>
	
	
	

		






	
	
	</display:table>





</liferay:if>



<%}%>

</td></tr>