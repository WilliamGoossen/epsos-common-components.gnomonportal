<%@ include file="/html/portlet/ext/menu_layout/init.jsp" %>

<script type="text/javascript" src="/html/themes/portlet/gnomon_theme/includes/browser.js"></script>
	
<%
Vector  items =(Vector) request.getAttribute("menu_items");

Vector level0items=(Vector) request.getAttribute("menu_items");

String  showtop =(String) request.getAttribute("showtop");


Vector other_menus=null;

if(request.getAttribute("other_menus")!=null) 
other_menus=(Vector) (request.getAttribute("other_menus"));




if(request.getAttribute("other_menus")==null && !showtop.equals("1")) {%>

<jsp:include page ="/html/portlet/ext/menu_layout/plain_view.jsp" />

<%}


else { 




Hashtable item=null;
String url="";
String type="";
String name="";
String portletid="";
String courseid="";
String image="";
String mytopicid="";
String itemid="";
String pageid="";
int new_menu=0;
String mylang1="";

if (request.getParameter("language") != null)  
mylang1= request.getParameter("language").toString();

else 
mylang1=locale.getLanguage() + "_" + locale.getCountry();

%>

<script type="text/javascript"> 

 
 function menuInit() {
 <%if(showtop.equals("1") ) {%>
	isHorizontal = "1";
//	menus[0] = new  menu(35, "horizontal", 0, 0, -5, -5, "#069DEC", "#64B1E9", "Microsoft Sans Serif", "11px", "bold", 
//		"bold", "#ffffff", "#000", 1, "#fff", 1, "rollover:/html/themes/portlet/gnomon_theme/images/tri-right1.gif:/html/themes/portlet/gnomon_theme/images/tri-right2.gif", false, true, true, true, 12, true, 2, 2, "#BEBFC0");

	menus[0] = new  menu(30, "horizontal", 1, 1, -5, -5, "#FDEBB9", "#FAB891", "verdana", "10px", "bold", 
		"bold", "#000", "#000", 0, "#fff", 1, "", false, true, true, true, 6, false, 2, 2, "#BEBFC0");

// size, orientation, x, y, offsetX, offsetY, bgOut, bgOver, fontFace, fontSize, fontStyleOut,
//	fontStyleOver, textColorOut, textColorOver, borderSize, borderColor, margin, showChar, 
//	showOnClick, sepItems, isMainMenu, hasAnimations, animationType, hasShadow, sOffX, sOffY, shadowColor	
	
	<%} else {%>
		isHorizontal = "0";

	menus[0] = new  menu(150, "vertical", 0, 0, 1, 1, "#EAEEF1", "#FECA34", "Tahoma", "11px", "bold", 
		"bold", "#000", "#000", 1, "#000000", 1, ":", false, true, true, true, 6, true, 2, 2, "#BEBFC0");

<%}%>
	
<%
if(items!=null && items.size()>0) {%>




 




<%	for(int i=0; i<items.size(); i++) {
		item = (Hashtable)items.get(i);
	new_menu=0;
			if(item!=null) {
			itemid= (String)item.get("ITEMID");
				name = (String)item.get("NAME");
				type = (String)item.get("TYPE");
				url = (String)item.get("URL");
				portletid = (String)item.get("PORTLET_ID");												
				courseid = (String)item.get("COURSE_ID");															
				image=(String)item.get("M_IMAGE");	
				mytopicid=(String)item.get("TOPICID");	
				pageid=(String)item.get("PAGEID");	
				if(image!=null && !image.equals("")) 
					image ="/FILESYSTEM/menus/"+image;
				



			 if(type.equals("2")) {
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
			 			
						pActionParts = StringUtil.split(url,"||");
			 			pAction = pActionParts[0];
			 			pParamsString=pActionParts[1];
			 			pValuesString=pActionParts[2];
			 			
			 			pParams=pParamsString.split(",");
			 			pValues=pValuesString.split(",");
			 			
			 			
			 		}
//action			 		url||param1,param2||val2||val2
			 		
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

			}
				
			else if(type.equals("3")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
					PURL1.setParameter("language", mylang1);
				 url = PURL1.toString(); 

				}
 
 	else if(type.equals("4")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("chapter_id", pageid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapter");
					PURL1.setParameter("language", mylang1);
				 url = PURL1.toString(); 

				}

				
				%>
	
	
<%if(other_menus!=null && other_menus.size() >0) {
for (int j=0; j< other_menus.size(); j++) {
		if((other_menus.get(j).toString()).equals(itemid)) {
			new_menu=j+1;
					break;
			}

	}
	}

	%>
	 <%if(showtop.equals("1") ) {%>
	menus[0].addItem("<%=url%>", "", 105, "left", "<%=name%>", <%=new_menu%>);
	<%} else {%>
		menus[0].addItem("<%=url%>", "", 25, "left", "<%=name%>", <%=new_menu%>);
		<%}%>
	

<%}			//item %>
		
		<%}//for%>		
		
		
		
		
		
		
		/* and now the children */
		<%if(other_menus!=null && other_menus.size() >0) {
		for(int k=0; k< other_menus.size(); k++) {
		items = (Vector)(Vector) request.getAttribute("menu_items" + other_menus.get(k));%>
		
// size, orientation, x, y, offsetX, offsetY, bgOut, bgOver, fontFace, fontSize, fontStyleOut,
//	fontStyleOver, textColorOut, textColorOver, borderSize, borderColor, margin, showChar, 
//	showOnClick, sepItems, isMainMenu, hasAnimations, animationType, hasShadow, sOffX, sOffY, shadowColor	
	
			
		menus[<%=k+1%>] = new menu(150, "vertical", 0, 0, -2, -2, "#FECA34", "#ECECEC", "tahoma", "10px", "bold", "bold", "#000", "#000", 1, "#000", 2, 12, false, true, false, true, 6, true, 1, 1, "#BEBFC0");
		
		
<%if(items!=null && items.size()>0) {%>




 




<%	for(int i=0; i<items.size(); i++) {
		item = (Hashtable)items.get(i);
	new_menu=0;
			if(item!=null) {
			itemid= (String)item.get("ITEMID");
				name = (String)item.get("NAME");
				type = (String)item.get("TYPE");
				url = (String)item.get("URL");
				portletid = (String)item.get("PORTLET_ID");												
				courseid = (String)item.get("COURSE_ID");															
				image=(String)item.get("M_IMAGE");	
				mytopicid=(String)item.get("TOPICID");	
				pageid=(String)item.get("PAGEID");	
				
				if(image!=null && !image.equals("")) 
					image ="/FILESYSTEM/menus/"+image;
				



			  if(type.equals("2")) {
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

			}
				
			else if(type.equals("3")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
				PURL1.setParameter("language", mylang1);
				url = PURL1.toString(); 

				}
 
else if(type.equals("4")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("chapter_id", pageid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapter");
					PURL1.setParameter("language", mylang1);
				 url = PURL1.toString(); 

				}
				
				%>
				

	
<%if(other_menus!=null && other_menus.size() >0) {
for (int j=0; j< other_menus.size(); j++) {
		if((other_menus.get(j).toString()).equals(itemid)) {
			new_menu=j+1;
					break;
			}

	}
	}

	%>
	menus[<%=k+1%>].addItem("<%=url%>", "", 20, "left", "<%=name%>", <%=new_menu%>);
	

<%}			//item %>
		
		<%}//for%>		
				
		
		<%}
		}
		}%>
		
		
		
		
		
		
		}
		
				</script>
				
<%}%>


<table width="150" border="0" cellpadding="0" cellspacing="0">
<tr>
<td id="mymenu">


	<% items=level0items;
	if(items!=null && items.size()>0 && !showtop.equals("1")) {%>
		
		<div id="menuv" style="position:relative"></div>
		
	<table border="0" cellpadding="0" cellspacing="0" width="100">

	<%	for(int i=0; i<items.size(); i++) {
		item = (Hashtable)items.get(i);
			if(item!=null) {%> 

			<tr><td height=28>&nbsp;</td></tr>
			
			<%}
	}%>
	</table>
<%}%>



</td></tr></table>

<script  type="text/javascript" >
menuInit();
</script>







<%}%>