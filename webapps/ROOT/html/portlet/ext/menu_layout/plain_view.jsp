<%@ include file="/html/portlet/ext/menu_layout/init.jsp" %>


<%
Vector  items =(Vector) request.getAttribute("menu_items");





Hashtable item=null;
String url="";
String type="";
String name="";
String portletid="";
String courseid="";
String image="";
String mytopicid="";
String mylang1="";

if (request.getParameter("language") != null)  
mylang1= request.getParameter("language").toString();

else 
mylang1=locale.getLanguage() + "_" + locale.getCountry();

if(items!=null && items.size()>0) {%>
<table border="0" cellpadding="0" cellspacing="0" width="100%">

<%	for(int i=0; i<items.size(); i++) {
		item = (Hashtable)items.get(i);
			if(item!=null) {
				name = (String)item.get("NAME");
				type = (String)item.get("TYPE");
				url = (String)item.get("URL");
				portletid = (String)item.get("PORTLET_ID");												
				courseid = (String)item.get("COURSE_ID");															
				image=(String)item.get("M_IMAGE");	
				mytopicid=(String)item.get("TOPICID");	
				if(image!=null && !image.equals("")) {
					image ="/FILESYSTEM/menus/"+image;
				}
				if(type.equals("1")) {%>
		<tr>
<td>		
	<div id="menu">
	
				<ul>
					<li>
					<a href="<%=url%>"><%if(image!=null && !image.equals("")) {%><img src="<%=image%>" border=0 align="absmiddle">
					<%}%><%=name%></a>
					</li>
				</ul>
	</div>
</td>
</tr>
<%				}
				
					else if(type.equals("2")) {
					
					
					 
			 	/* check if we have an action */
			 	String pAction="";
			 	String pParamsString="";
			 	String pValuesString="";
			 	String pActionParts[]={""};
			 	String pParams[]={""};
			 	String pValues[]={""};
			 	if(!url.equals("")) {
			 		pAction = url;
			 		if(pAction.indexOf("||")>=0) {
			 			
						pActionParts =  	StringUtil.split(url,"||");
			 		
			 			pAction = pActionParts[0];
			 			pParamsString=pActionParts[1];
			 			pValuesString=pActionParts[2];
			 			
			 			pParams=pParamsString.split(",");
			 			pValues=pValuesString.split(",");
			 			
			 			
			 		}
			 		
			 		
			 	}

				PortletURL PURL1 = new PortletURLImpl(request, portletid, layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				
				if(!pAction.equals("")) {
					PURL1.setParameter("struts_action", pAction);
					}
					if(pParams!=null && pParams.length >0) {
						for(int pIndex=0; pIndex <  pParams.length ; pIndex++) {
							PURL1.setParameter(pParams[pIndex], pValues[pIndex]);
						}
					}
					
				
				
				
				
				if (mytopicid!=null && !mytopicid.equals("")) 
					PURL1.setParameter("vtopicid", mytopicid);
	
				PURL1.setParameter("start_topic", mytopicid);
					PURL1.setParameter("language", mylang1);

				 url = PURL1.toString();

			
			 
					
					%>
				<tr>
<td>
			<div id="menu">		
				
				<ul>
					<li>
					<a href="<%=url%>">
					<%if(image!=null && !image.equals("")) {%><img src="<%=image%>" border=0 align="absmiddle">
					<%}%><%=name%></a>
					</li>
				</ul>
</div>
</td>
</tr>

						

<%				}
				
				
				else if(type.equals("3")) {%>
			<tr>
			<td>
			<div id="menu">		
				<ul>
					<li>
					<a href="<liferay:actionURL windowState="<%= WindowState.MAXIMIZED.toString() %>" portletName ="GN_CHAPTERS"><liferay:param name="struts_action" value="/ext/chapters/view_chapters" /><liferay:param name="course_id" value="<%=courseid%>" />	<liferay:param name="language" value="<%=mylang1%>"/>
					</liferay:actionURL>"><%if(image!=null && !image.equals("")) {%><img src="<%=image%>" border=0 align="absmiddle">
					<%}%><%= name %></a>
					</li>
				</ul>
</div>
</td>
</tr>
								
								
								

<%				} 
				
				
				
			}
	}%>
</table>
<%}





%>









