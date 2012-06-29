

<liferay:if test="<%= (items != null) && (items.size() > 0) %>">


	<%if (itemsPage>-1 || totalPages>1) {%>

	<% if (isViewStrutsPage== true) {
	qString ="";
	int my_i=0;
	
	String ccPage="1";
String ttPage="1";
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
		<td align="right">
		<table border="0" cellpadding="1" cellspacing="1" width="140 ">
			<tr>
				<td width="52" align="left" valign="middle" nowrap><input
					type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/first.gif"
					border="0"
					onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="1"/>
		</liferay:actionURL>'">

				<%if(curPage >1) { %> &nbsp;<input type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/prevhit.gif"
					border="0"
					onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page") && !parNames[my_i].equals("vtopicname")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="<%=ccPage.valueOf(curPage-1) %>"/>
		</liferay:actionURL>'">

				<%} %></td>
				<td class="gamma1" bgcolor="#D6D7D9" nowrap align="center"
					width="36"><%=curPage %> / <%=totalPages %></td>

				<td width="52" align="right" valign="middle" nowrap><%if(curPage <totalPages) { %>
				&nbsp;<input type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/nexthit.gif"
					border="0"
					onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page") && !parNames[my_i].equals("vtopicname")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="<%=ccPage.valueOf(curPage+1) %>"/>
		</liferay:actionURL>'">
				<%} %> &nbsp;<input type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/last.gif" border="0"
					onclick="document.location='<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for( my_i=0; my_i <parNames.length; my_i++) {
		if(!parNames[my_i].equals("page") && !parNames[my_i].equals("vtopicname") ) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%} 
	}%>
		<liferay:param name="page" value="<%=ccPage.valueOf(totalPages) %>"/>
		</liferay:actionURL>'">


				</td>


			</tr>
		</table>
		</td>
	</tr>



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
		<table border="0" cellpadding="1" cellspacing="1" width="95%">
			<tr>
				<td width="92%" align="Right" valign="middle" class="gamma1"><input
					type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/first.gif"
					border="0"
					onclick="document.location='<%=thisPage %>?<%=qString%>&page=1'"> <%if(curPage >1) { %>
				&nbsp;<input type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/prevhit.gif"
					border="0"
					onclick="document.location='<%=thisPage %>?<%=qString%>&page=<%=curPage-1%>'">
				<%} %> <%if(curPage <totalPages) { %> &nbsp;<input type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/nexthit.gif"
					border="0"
					onclick="document.location='<%=thisPage %>?<%=qString%>&page=<%=curPage+1%>'">
				<%} %> &nbsp;<input type="image"
					src="/html/themes/portlet/gnomon_theme/img/nav/last.gif" border="0"
					onclick="document.location='<%=thisPage %>?<%=qString%>&page=<%=totalPages%>'">

				</td>
				<td align="center" width="8%" class="gamma1" bgcolor="#D6D7D9"><%=curPage %>
				/ <%=totalPages %></td>

			</tr>
		</table>
		</td>
		z
	</tr>

	<!-- END OF PAGING -->


	<%}%>
	<%}   //StrutsPage%>


	<!-- LABELS LINE WITH SORTING -->
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
				<td class="<%=labelsStyle %>" align="center">&nbsp;</td>
				<%} %>
				<%} %>
				<td class="<%=labelsStyle %>" align="center"><%if (SortNames[labelsIndex].equals("")) {%>
				<%= LanguageUtil.get(pageContext, LabelNames[labelsIndex]) %> <%} else { %>

				<%					if (isViewStrutsPage== true) { 


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
}

%> <a class="<%=labelsStyle %>"
					href="<liferay:actionURL  portletName="<%=ViewStrutsPortlet %>" >
<% for(  my_i=0; my_i <parNames.length; my_i++) {
		//if(!parNames[my_i].equals("page")) {
		if(!parNames[my_i].equals("sortBy")) {
%>

	<liferay:param name="<%=parNames[my_i]%>" value="<%=parValues[my_i]%>"/>
	<%}
	 
	}%>
		<liferay:param name="sortBy" value="<%=SortNames[labelsIndex]%>"/>
		</liferay:actionURL>">


				<%= LanguageUtil.get(pageContext, LabelNames[labelsIndex]) %></a> <%}
	} %> <%} else {%> <a class="<%=labelsStyle %>"
					href="<%=thisPage %>?<%=qString%>&sortBy=<%=SortNames[labelsIndex]%>"><%= LanguageUtil.get(pageContext, LabelNames[labelsIndex]) %></a>
				<%} %> <%}%></td>
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

			<!-- SHOW LIST OF ITEMS -->

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

			<%if (breakline==true) { %>
			<tr <%if (i%2==0 && lineColor==true) {%> class="even" <%} %>>


				<td width="100%" colspan=2>
				<table border="0" cellpadding="0" cellspacing="0" width="100%">
					<TD height=2><img
						src="/html/themes/portlet/gnomon_theme/img/none.gif" width="1"
						height="2"></TD>
				</table>
				</td>
			</tr>
			<%}%>

			<tr <%if (i%2==0 && lineColor==true) {%> class="even" <%} %>>



				<%if (!columnImage.equals("")) { %>

				<!-- TO EIKONIDIO POY EXOUME EPILEKSEI -->

				<td align="center" width="3%"><img src="<%=columnImage %>" border=0;>
				</td>

				<%}%>

				<%for ( j=0; j<ColumnNames.length; j++) { 
					/* STYLES */
						if(ColumnStyles.length == ColumnNames.length && !ColumnStyles[j].equals("")) {
					int stylePos = ColumnStyles[j].indexOf("|");
							if(stylePos >=0) {
							myspanstyle=ColumnStyles[j].substring(0,stylePos );
myrefstyle=ColumnStyles[j].substring(stylePos+1 );
							}
							else {
								myspanstyle=ColumnStyles[j];
								myrefstyle=ColumnStyles[j];
							}
						}
						else {
						myspanstyle=def_myspanstyle;
							myrefstyle=def_myspanstyle;
						}
						
					/***/	
						if(displayColumns[j]==true) {
							if(hrefs[j].equals("") ){
								%>

				<!-- PEDIO STH LISTA POY DEN EINAI LINK -->
				<%if (breakline==true && !columnImage.equals("") && j>0) {%>
				<td colspan=2 class="<%=myspanstyle%>" valign="top"
					<%if (ColumnNames[j].indexOf("date")>=0 || ColumnNames[j].indexOf("DATE")>=0) { %>
					nowrap <%} %>><%} else {%>
				<td class="<%=myspanstyle%>" valign="top"
					<%if (ColumnNames[j].indexOf("date")>=0 || ColumnNames[j].indexOf("DATE")>=0) { %>
					nowrap <%} %>><%}%> <!-- span class="<%=myspanstyle%>" --> <%= item.get(ColumnNames[j]) %>
				<!-- /span --></td>

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




				<!-- PEDIO STH LISTA POY  EINAI LINK -->


				<%if (breakline==true && !columnImage.equals("") && j>0) {%>
				<td colspan=2 valign="top" class="<%=myspanstyle%>"><%} else {%>
				<td valign="top" class="<%=myspanstyle%>"><%}%> <span
					class="<%=myspanstyle%>"> <%if (ext_pos >=0){ %> <a
					class="<%=myrefstyle%>" href="<%= new_page%> " target="_blank"><%= item.get(ColumnNames[j]) %></a>
				&nbsp; <%} else  if(isViewStrutsPage==true) { %> <!-- render --> <a
					<%if (inNewWindow==1) {%> target="_blank" <%}%>
					class="<%=myrefstyle%>"
					href="<liferay:actionURL   portletName="<%=ViewStrutsPortlet %>" >
									<liferay:param name="struts_action"  value="<%=new_page  %>" />
<%if (showLeft==false) {%>
<liferay:param name="showleft"  value="0" />
<%}%>
						
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
						
						<%}

						
						
						%>			
						<!--render -->
								</liferay:actionURL>">


				<%= item.get(ColumnNames[j]) %></a> &nbsp; <!-- EDO KLEINEI TO LINK -->
				<%} else { %> <a <%if (inNewWindow==1) {%> target="blank" <%}%>
					class="<%=myrefstyle%>" href="<%= new_page%> "><%= item.get(ColumnNames[j]) %></a>
				&nbsp; <%} %> </span></td>
				<%if (breakline==true) {%>
			</tr>
			<tr <%if (i%2==0 && lineColor==true) {%> class="even" <%} %>>
				<%}%>

				<%} 
						} //displayColumns
					} //for int j
					%>

				<!-- ELEGXEI GIA NA VALEI TO MOLYVAKI DEKSIA KAI TO X GIA TO DELETE -->
				<!-- EDIT ICON -->
				<%			if(showediticon==true) {%>
				<td width="5%" valign="top"><%if(isViewStrutsPage==false || EditPageNostruts==true) { %>
				<%if (edit_page.indexOf("?") >=0) { %> <a class="beta1"
					href="<%=edit_page%>&<%=qString%>&cmd=edit"><img
					src="/html/themes/portlet/gnomon_theme/img/pencil.gif" border=0></a>
				<%}else {%> <a class="beta1"
					href="<%=edit_page%>?<%=qString%>&cmd=edit"><img
					src="/html/themes/portlet/gnomon_theme/img/pencil.gif" border=0></a>
				<%} 
							}
							else  { %> <!-- render --> <a class="gamma1"
					href="<portlet:actionURL >
									<portlet:param name="struts_action"  value="<%=edit_page  %>" />

									
						<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")  && item.get(ColumnNames[columnIndex])!=null) {
															String myvalP= item.get(ColumnNames[columnIndex]).toString();
							
							%>
								<portlet:param name="<%=ParamNames[columnIndex]%>" value="<%=myvalP%>" />
<portlet:param name="cmd" value="edit" />
							<%}
						}
						%>			
						
												<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<portlet:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}%>
<!-- render -->
								</portlet:actionURL>">
				<img src="/html/themes/portlet/gnomon_theme/img/pencil.gif" border=0></a>
				&nbsp; <%} 							%></td>
				<%} %>
				<!-- DELETE ICON -->
				<%			if(showdeleteicon==true) {%>
				<td width="5%"><% if (isViewStrutsPage==false || EditPageNostruts==true) { %>
				<%if (edit_page.indexOf("?") >=0) { %> <a class="beta1"
					href="<%=edit_page%>&<%=qString%>&cmd=delete">[x]</a> <%}else {%> <a
					class="beta1" href="<%=edit_page%>?<%=qString%>&cmd=delete">[x]</a>
				<%} 
							
							}
							else  { %> <!-- render --> <a class="gamma1"
					href="<portlet:actionURL >
									<portlet:param name="struts_action"  value="<%=edit_page  %>" />

									
						<%	
						for( columnIndex=0; columnIndex<ColumnNames.length; columnIndex++) {
							if(!ParamNames[columnIndex].equals("")  && item.get(ColumnNames[columnIndex])!=null) {
															String myvalP= item.get(ColumnNames[columnIndex]).toString();
							%>
								<portlet:param name="<%=ParamNames[columnIndex]%>" value="<%=myvalP%>" />
<portlet:param name="cmd" value="delete" />
							<%}
						}
						%>			
							<%	
						for( columnIndex=0; columnIndex<ViewStrutsParamNames.length; columnIndex++) {%>
								<portlet:param name="<%=ViewStrutsParamNames[columnIndex]%>" value="<%=ViewStrutsParamValues[columnIndex]%>" />
						
						<%}%>
						<!-- render -->
								</portlet:actionURL>">
				[x]</a> &nbsp; <%} 						
							%></td>
				<%} %>

				<!-- EXTRA ICONS AN YPARXOYN (p.x STA FORUMS -->
				<% if(moreicons==true) {%>
				<% for(iconsindex=0; iconsindex < MoreIconsSrc.length;iconsindex++) {%>

				<%
			
			if(isViewStrutsPage==false) {
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

				<td width="5%"><a class="beta1"
					name="<%=MoreIconsNames[iconsindex] %>"
					href="<%=MoreIconsHref[iconsindex]%>?<%=qString%>&cmd=edit"><img
					alt="<%=MoreIconsNames[iconsindex] %>"
					src="<%=MoreIconsSrc[ iconsindex]%>" border=0></a></td>
				<%			} // is viewStrutsPage 
			else { %>
				<!-- render -->
				<td><a class="beta1" name="<%=MoreIconsNames[iconsindex] %>"
					href="<portlet:actionURL ><portlet:param name="struts_action" value="<%=MoreIconsHref[iconsindex]%>" /><portlet:param name="cmd" value="edit" />

							<%	
						for( columnIndex=0; columnIndex<IconsParamNames.length; columnIndex++) {
							if(!IconsParamNames[columnIndex].equals("") && item.get(ColumnNames[columnIndex])!=null) {
															String myvalP= item.get(ColumnNames[columnIndex]).toString();
							%>
								< portlet:param name="
					<%=IconsParamNames[columnIndex]%>" value="<%=myvalP%>" /> <%}
						}%> <!-- render --> </portlet:actionURL>"> <img
					alt="<%=MoreIconsNames[iconsindex] %>"
					src="<%=MoreIconsSrc[ iconsindex]%>" border=0></a></td>

				<%			}
  }	%>

				<%	} %>

			</tr>
			<%}
			}%>
		</table>
		</td>
	</tr>
</liferay:if>



