<%@ include file="/html/portlet/ext/menu_layout/init.jsp" %>

<script type="text/javascript" src="/html/themes/portlet/gnomon_theme/includes/browser.js"></script>
	
<%
Vector  items =(Vector) request.getAttribute("menu_items");


Vector other_menus=null;

if(request.getAttribute("other_menus")!=null) 
other_menus=(Vector) (request.getAttribute("other_menus"));






Hashtable item=null;
String url="";
String type="";
String name="";
String portletid="";
String courseid="";
String image="";
String mytopicid="";
String itemid="";
int new_menu=0;

%>

<script type="text/javascript"> 

 
 function menuInit() {
 

			menus[0] = new  menu(214, "vertical", 0, 0, -5, -5, "#E29E71", "#ECECEC", "Tahoma", "11px", "bold", 
		"bold", "#ffffff", "#000", 1, "#9AC2E0", 1, "rollover:images/tri-right1.gif:images/tri-right2.gif", false, true, true, true, 12, true, 1, 1, "black");
	


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
				if(image!=null && !image.equals("")) 
					image ="/FILESYSTEM/menus/"+image;
				



			 if(type.equals("2")) {

				PortletURL PURL1 = new PortletURLImpl(request, portletid, layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				if (mytopicid!=null && !mytopicid.equals("")) 
					PURL1.setParameter("vtopicid", mytopicid);
	
				PURL1.setParameter("start_topic", mytopicid);
	
				 url = PURL1.toString();

			 }
			else if(type.equals("3")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
	
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
	menus[0].addItem("<%=url%>", "", 25, "left", "<%=name%>", <%=new_menu%>);
	

<%}			//item %>
		
		<%}//for%>		
		
		
		
		
		
		
		/* and now the children */
		<%if(other_menus!=null && other_menus.size() >0) {
		for(int k=0; k< other_menus.size(); k++) {
		items = (Vector)(Vector) request.getAttribute("menu_items" + other_menus.get(k));%>
		
		
		menus[<%=k+1%>] = new menu(214, "vertical", 0, 0, -5, -5, "#E29E71", "#ECECEC", "Tahoma", "11px", "bold", 
		"bold", "#ffffff", "#000", 1, "#9AC2E0", 2, 62, false, true, false, true, 6, true, 4, 4, "black");
		
		
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
				if(image!=null && !image.equals("")) 
					image ="/FILESYSTEM/menus/"+image;
				



			 if(type.equals("2")) {

				PortletURL PURL1 = new PortletURLImpl(request, portletid, layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				if (mytopicid!=null && !mytopicid.equals("")) 
					PURL1.setParameter("vtopicid", mytopicid);
	
				PURL1.setParameter("start_topic", mytopicid);
	
				 url = PURL1.toString();

			 }
			else if(type.equals("3")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
	
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
	menus[<%=k+1%>].addItem("<%=url%>", "", 32, "left", "<%=name%>", <%=new_menu%>);
	

<%}			//item %>
		
		<%}//for%>		
				
		
		<%}
		}
		}%>
		
		
		
		
		
		
		}
		
				</script>
				
<%}%>


<table border="0" cellpadding="0" cellspacing="0" width="100%">
<tr>
<td  id="mymenu">		<div id="menu" style="position:relative"></div>
</td></tr></table>

<script  type="text/javascript" >
menuInit();
</script>







