<%@ include file="/html/portlet/ext/menu_layout/init.jsp" %>
<script>
	function setGroupSelectedCookie(GroupCaptionOrIndex)
		{
			if(document.cookie)
			{
				document.cookie = "selected=" + escape(GroupCaptionOrIndex) + ";path=/";
			}
		}
	</script>


<%
String groupid="";
Vector items1=null;
Vector  items =(Vector) request.getAttribute("menu_items");
Vector level0items=(Vector) request.getAttribute("menu_items");
String  showtop =(String) request.getAttribute("showtop");
String menutype=(String) request.getAttribute("menutype");
Vector other_menus=null;
if (request.getAttribute("other_menus")!=null) 
other_menus=(Vector) (request.getAttribute("other_menus"));

/*MENU INIT */
PanelBar objWM = new PanelBar();

// Register the WebMenu object

objWM.setUserData("GNOMON::1230366838");

// Set for browser auto detect
objWM.setUserAgent(request.getHeader("User-Agent"));
objWM.setGeneratedPrefix("gi9menu");
objWM.setClearPixelImage("/html/themes/portlet/gnomon_theme/images/menus/clearpixel.gif");
objWM.setExpandMode(2);


Coalesys.PanelBar.Group objGroup1=null;
Coalesys.PanelBar.Group objGroup2=null;
Coalesys.PanelBar.Item objItem = null;

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
String pAction="";
String pParamsString="";
String pValuesString="";
String pActionParts[]={""};
String pParams[]={""};
String pValues[]={""};
String p_p_text="";

if (request.getParameter("language") != null)  
mylang1= request.getParameter("language").toString();

else 
mylang1=locale.getLanguage() + "_" + locale.getCountry();


if(items!=null && items.size()>0) {

for(int i=0; i<items.size(); i++) {
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
			 		}

			 if(type.equals("2")) {
				
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
				if(request.getParameter("p_p_text")!=null) PURL1.setParameter("p_p_text", request.getParameter("p_p_text").toString());					

				 url = PURL1.toString();

			 }
			else if(type.equals("3")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
					PURL1.setParameter("language", mylang1);
	if(pParams!=null && pParams.length >0) {
						for(int pIndex=0; pIndex <  pParams.length ; pIndex++) {
							PURL1.setParameter(pParams[pIndex], pValues[pIndex]);
						}
					}

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
	if(pParams!=null && pParams.length >0) {
						for(int pIndex=0; pIndex <  pParams.length ; pIndex++) {
							PURL1.setParameter(pParams[pIndex], pValues[pIndex]);
						}
					}

	            url = PURL1.toString(); 

				}



objGroup1=objWM.getGroups().Add();
objGroup1.setCaption(name);
objGroup1.setID(itemid);
groupid=itemid;
objGroup1.setOnClick("setGroupSelectedCookie(\'" + itemid + "\');");
///


		if(other_menus!=null && other_menus.size() >0) 
			{
			for(int k=0; k<other_menus.size(); k++) 
				{

				if (objGroup1.getID().equals(other_menus.get(k).toString()))
					{
						items1 = (Vector)(Vector) request.getAttribute("menu_items" + other_menus.get(k));
						if(items1!=null && items1.size()>0) 
							{
							for(int j=0;j<items1.size(); j++) 
								{
								item = (Hashtable)items1.get(j);
								new_menu=0;
								if(item!=null) 
									{
									itemid= (String)item.get("ITEMID");
									name = (String)item.get("NAME");
									type = (String)item.get("TYPE");
									url = (String)item.get("URL");
									portletid = (String)item.get("PORTLET_ID");												
									courseid = (String)item.get("COURSE_ID");															
									image=(String)item.get("M_IMAGE");	
									mytopicid=(String)item.get("TOPICID");	
									pageid=(String)item.get("PAGEID");				
									if(image!=null && !image.equals("")) image ="/FILESYSTEM/menus/"+image;
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
			 		}
									
									}
												 if(type.equals("2")) {

				PortletURL PURL1 = new PortletURLImpl(request, portletid, layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				if (mytopicid!=null && !mytopicid.equals("")) 
					PURL1.setParameter("vtopicid", mytopicid);
	
				PURL1.setParameter("start_topic", mytopicid);
				PURL1.setParameter("language", mylang1);
				if(!pAction.equals("")) {
					PURL1.setParameter("struts_action", pAction);
					}
					if(pParams!=null && pParams.length >0) {
						for(int pIndex=0; pIndex <  pParams.length ; pIndex++) {
							PURL1.setParameter(pParams[pIndex], pValues[pIndex]);
						}
					}
				if(request.getParameter("p_p_text")!=null) PURL1.setParameter("p_p_text", request.getParameter("p_p_text").toString());					

                url = PURL1.toString();

			 }
			else if(type.equals("3")) {
				
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
				PURL1.setParameter("language", mylang1);
					if(pParams!=null && pParams.length >0) {
						for(int pIndex=0; pIndex <  pParams.length ; pIndex++) {
							PURL1.setParameter(pParams[pIndex], pValues[pIndex]);
						}
					}


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
					if(pParams!=null && pParams.length >0) {
						for(int pIndex=0; pIndex <  pParams.length ; pIndex++) {
							PURL1.setParameter(pParams[pIndex], pValues[pIndex]);
						}
					}


                url = PURL1.toString(); 

				}



				objItem = objGroup1.getItems().Add();
				objItem.setCaption(name);
				objItem.setURL(url);
				
				// Retrieve the "selected" QueryString variable in order to set the currently selected Group
				
								}
							}


					}

				}
		}


///
	}
		}
	}


%>
<%


Cookie[] cookies = request.getCookies();

for (int i = 0; i < cookies.length; i++)
{
	if (cookies[i].getName().equals("selected"))
	{
		String value = cookies[i].getValue();
		objWM.setGroupSelected(value);
	}
}

%>
<style type="text/css">
		<%=objWM.GenerateStyleSheet()%>
	</style>
		
	<script language="JavaScript" type="text/javascript">
		<%=objWM.GenerateJavaScript(0)%>
	</script>


<body onLoad="<%=objWM.GenerateOnLoadEvent()%>" onResize="<%=objWM.GenerateOnResizeEvent()%>" bgcolor="#d4d0c8" leftmargin=0 topmargin=0 marginheight=0 marginwidth=0>
<table border=0>
<tr>
	<td valign="top">
<%=objWM.GeneratePanelBar(0)%>
		</td>
</tr>
</table>







