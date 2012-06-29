
<liferay:if test="<%= (items != null) && (items.size() > 0) %>">
	<%if (itemsPage>-1 &&  totalPages>1) {%>
	


	<% if (isViewStrutsPage== true) {
	qString ="";
	int my_i=0;
				Map myparams = request.getParameterMap();
				if(myparams!=null && myparams.size() >0) {
					Set mykeys = myparams.keySet();
								if(mykeys!=null && mykeys.size() >0) {
									Object mypNames[] =mykeys.toArray();
									String parNames[] = new String[mypNames.length];
									String parValues[] = new String[mypNames.length];
										for(int pIndex=0;pIndex <  mypNames.length; pIndex++) {
						parNames[pIndex]= mypNames[pIndex].toString();
						parValues[pIndex]= request.getParameter( mypNames[pIndex].toString()  ).toString();
										
										}%>
										
										
										
											
				
				
				<tr>
	<td align="center">
		<table border="0" cellpadding="0" cellspacing="0" width="95%">
			<tr  bgcolor="#D0DCFF" >
<td><input   type="image"  src="/html/themes/portlet/gnomon_theme/img/nav/first.gif"  border="0"   onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="1"/>
		</liferay:actionURL>'">

	<%if(curPage >1) { %>
&nbsp;<input   type="image"  src="/html/themes/portlet/gnomon_theme/img/nav/prevhit.gif"  border="0"  onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="<%=curPage-1 %>"/>
		</liferay:actionURL>'">

<%} %>
<%if(curPage <totalPages) { %>
&nbsp;<input   type="image"  src="/html/themes/portlet/gnomon_theme/img/nav/nexthit.gif"  border="0"   onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="<%=curPage+1 %>"/>
		</liferay:actionURL>'">
<%} %>

&nbsp;<input   type="image"  src="/html/themes/portlet/gnomon_theme/img/nav/last.gif"  border="0"   onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="<%=totalPages %>"/>
		</liferay:actionURL>'">
		
		&nbsp;&nbsp; <%=curPage %>  / <%=totalPages %>
		</td>
	</tr></table>
	</td></tr>


										
<%							}
				}%>
<%	} 
	
	else  {
	
	%>
	
	

	<%
//reconstruct URL;
				qString =myqueryString;
				i = qString.indexOf("page");
				if (i>=0) {
					j= qString.indexOf("&", i+1);
					if(j>=0) {
						qString = myqueryString.substring(0,i-1) + myqueryString.substring(j);
					
					}				
					else 
						qString = myqueryString.substring(0,i-1);
				}		
				%>
				
				
<tr>
	<td align="center">
		<table border="0" cellpadding="0" cellspacing="0" width="95%">
			<tr class="beta1">
<td><input  type="button" value="<<" onclick="document.location='<%=thisPage %>?<%=qString%>&page=1'"> 
	<%if(curPage >1) { %>
&nbsp;<input  type="button" value="<" onclick="document.location='<%=thisPage %>?<%=qString%>&page=<%=curPage-1%>'"> 
<%} %>
<%if(curPage <totalPages) { %>
&nbsp;<input  type="button" value=">" onclick="document.location='<%=thisPage %>?<%=qString%>&page=<%=curPage+1%>'"> 
<%} %>

&nbsp;<input  type="button" value=">>" onclick="document.location='<%=thisPage %>?<%=qString%>&page=<%=totalPages%>'"> 

	</tr></table>
	</td></tr>

	<%}%>
<%}   //StrutsPage%>
<tr>
	<td align="center">

		<table border="0" cellpadding="1" cellspacing="2" width="95%">
	
				<%
//reconstruct URL;
				qString =myqueryString;
				i = qString.indexOf("sortBy");
				if (i>=0) {
					j= qString.indexOf("&", i+1);
					if(j>=0) {
						qString = myqueryString.substring(0,i-1) + myqueryString.substring(j);
					
					}				
					else 
						qString = myqueryString.substring(0,i-1);
				}				
				
				 labelFound=false;
				
				for ( labelsIndex=0; labelsIndex<LabelNames.length; labelsIndex++) {  
				if(displayColumns[labelsIndex]==true) {
					if(!LabelNames[labelsIndex].equals("")) {
					%>
				<%if(labelFound==false) {
										 labelFound=true; %>
							<tr class="<%=labelsLine %>">
						<%if (!columnImage.equals("")) { %>
									<td  class="<%=labelsStyle %>">  &nbsp;</td>
									<%} %>
<%} %>
					<td  class="<%=labelsStyle %>">  
					<%if (SortNames[labelsIndex].equals("")) {%>
						<%= LanguageUtil.get(pageContext, LabelNames[labelsIndex]) %>
					<%} else { %>
					<a href="<%=thisPage %>?<%=qString%>&sortBy=<%=SortNames[labelsIndex]%>"><%= LanguageUtil.get(pageContext, LabelNames[labelsIndex]) %></a>
			<%} %>
			
			</td>
					<%}
					else {%>
					<td>&nbsp;</td>
					
				<%}
				}
				
				} %>
				
				<%				 if(moreicons==true) {
			 for(iconsindex=0; iconsindex < MoreIconsSrc.length;iconsindex++) {%>
					<td class="<%=labelsStyle %>">&nbsp;</td>
					
			<%} 
			} %>		
			
					<%if(labelFound==true) { %>
			</tr>
<%} %>
			
			
			<%for( i=0; i<items.size(); i++) {

				item = (Hashtable) items.get(i);
				if(item!=null) {
					qString = "";
					qString2="";
					for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
					
					
					
						if(!ParamNames[columnIndex].equals("")) {
							if(!qString.equals(""))
								qString=qString + "&";
							qString = qString + ParamNames[columnIndex] + "=" +item.get(ColumnNames[columnIndex]) ;
						

						}
					}
					%>
					<tr>
					
					<%if (!columnImage.equals("")) { %>
					
					<td align="center" width="3%">
						<img src="<%=columnImage %>" border=0;>
					</td>

					<%}%>
					
					<%for ( j=0; j<ColumnNames.length; j++) { 
						if(displayColumns[j]==true) {
							if(hrefs[j].equals("") ){
								%>
								
<%								
								if(ColumnNames[j].equals("PROYPOLOGISMOS")) {
						NumberFormat nf = NumberFormat.getInstance(locale);
    			    double pp = Double.parseDouble( item.get(ColumnNames[j]).toString());
			     String   project_proypologismos= nf.format(pp);
%>
				<td align=right><%=project_proypologismos %> &euro;</td>
		<%			} else {%>
 								
								<td><%= item.get(ColumnNames[j]) %></td>
						<%} %>
								<%}
							else {   ////HREF 
							new_page=hrefs[j];
								int ext_pos = hrefs[j].indexOf("external|");
								int col_pos= hrefs[j].indexOf("column|");
								String urlcolumnname="";
								if(col_pos >=0)  {
									 urlcolumnname=hrefs[j].substring(col_pos + "column|".length());
										new_page = item.get(urlcolumnname).toString();
								}
								else  if(isViewStrutsPage==false)  
								if(hrefs[j].indexOf("?") >=0)
									new_page = hrefs[j] + "&" + qString;
								else
									new_page = hrefs[j] + "?" + qString;
								
					
						%>




									

								
				
								<td>
									<span class="gamma1">
									<%if (ext_pos >=0){ %>
									<a class="gamma1" href="<%= new_page%> " target="_blank"><%= item.get(ColumnNames[j]) %></a>   &nbsp;
									<%} else  if(isViewStrutsPage==true) { %>
									
									<a class="gamma1" href="<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
									<liferay:param name="struts_action"  value="<%=new_page  %>" />
						
						<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")) {%>
												
								<liferay:param name="<%=ParamNames[columnIndex]%>" value="<%=(String)item.get(ColumnNames[columnIndex])%>" />
						
							
							<%}
						}%>
						
						<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<liferay:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}

						
						
						%>			
								</liferay:actionURL>">

								
							<%= item.get(ColumnNames[j]) %></a>   &nbsp;
								

								<%} else { %>
								<a class="gamma1" href="<%= new_page%> "><%= item.get(ColumnNames[j]) %></a>   &nbsp;

								<%} %>
									</span>
								</td>
							<%} 
						} //displayColumns
					} //for int j
					%>
		<%			if(showediticon==true) {%>
						<td width="5%">
						<%if(isViewStrutsPage==false) { %>
						<%if (edit_page.indexOf("?") >=0) { %>
						<a class="beta1" href="<%=edit_page%>&<%=qString%>&cmd=edit"><img src="/html/themes/portlet/gnomon_theme/img/pencil.gif" border=0></a>
						<%}else {%>
							<a class="beta1" href="<%=edit_page%>?<%=qString%>&cmd=edit"><img src="/html/themes/portlet/gnomon_theme/img/pencil.gif" border=0></a>
							<%} 
							}
							else  { %>
									
									<a class="gamma1" href="<portlet:actionURL >
									<portlet:param name="struts_action"  value="<%=edit_page  %>" />

									
						<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")) {%>
								<portlet:param name="<%=ParamNames[columnIndex]%>" value="<%=(String)item.get(ColumnNames[columnIndex])%>" />
<portlet:param name="cmd" value="edit" />
							<%}
						}
						%>			
						
												<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<portlet:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}%>

								</portlet:actionURL>">
							<img src="/html/themes/portlet/gnomon_theme/img/pencil.gif" border=0></a>   &nbsp;
								

								<%} 							%>
						</td>
				<%} %>		
				
				<%			if(showdeleteicon==true) {%>
						<td width="5%">
						<% if (isViewStrutsPage==false) { %>
							<%if (edit_page.indexOf("?") >=0) { %>
										<a class="beta1" href="<%=edit_page%>&<%=qString%>&cmd=delete">[x]</a>
							<%}else {%>
								<a class="beta1" href="<%=edit_page%>?<%=qString%>&cmd=delete">[x]</a>
							<%} 
							
							}
							else  { %>
									
									<a class="gamma1" href="<portlet:actionURL >
									<portlet:param name="struts_action"  value="<%=edit_page  %>" />

									
						<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")) {%>
								<portlet:param name="<%=ParamNames[columnIndex]%>" value="<%=(String)item.get(ColumnNames[columnIndex])%>" />
<portlet:param name="cmd" value="delete" />
							<%}
						}
						%>			
							<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<portlet:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}%>
								</portlet:actionURL>">
							[x]</a>   &nbsp;
								

								<%} 						
							%>
						</td>
				<%} %>		
				
		
			<% if(moreicons==true) {%>
			<% for(iconsindex=0; iconsindex < MoreIconsSrc.length;iconsindex++) {%>
			
			<%
			iconsQString = "";
			if(useQstring==false) {
					for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
						if(!IconsParamNames[columnIndex].equals("")) {
							if(!iconsQString.equals(""))
								iconsQString=iconsQString + "&";
							iconsQString = iconsQString + IconsParamNames[columnIndex] + "=" +item.get(ColumnNames[columnIndex]) ;
						}
					}
					
					qString = iconsQString;
					}
			 %>
			
				<td width="5%">
			<a class="beta1"  name="<%=MoreIconsNames[iconsindex] %>" href="<%=MoreIconsHref[iconsindex]%>?<%=qString%>&cmd=edit"><img alt="<%=MoreIconsNames[iconsindex] %>" src="<%=MoreIconsSrc[ iconsindex]%>" border=0></a>
						</td>		
<%			  }	%>

		<%	} %>

					</tr>				
				<%}
			}%>
	</table>
			</td>
		</tr>
</liferay:if>



