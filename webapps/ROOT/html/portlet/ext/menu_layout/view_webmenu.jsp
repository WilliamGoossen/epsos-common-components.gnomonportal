<%@ include file="/html/portlet/ext/menu_layout/init.jsp" %>

<%
Vector  items =(Vector) request.getAttribute("menu_items");
Vector level0items=(Vector) request.getAttribute("menu_items");
String  showtop =(String) request.getAttribute("showtop");
String menutype=(String) request.getAttribute("menutype");
Vector other_menus=null;
if (request.getAttribute("other_menus")!=null)
other_menus=(Vector) (request.getAttribute("other_menus"));

/*MENU INIT */
WebMenu objWM = new WebMenu();

objWM.setUserData("GNOMON::1230366838");

// Set for browser auto detect

objWM.setUserAgent(request.getHeader("User-Agent"));

// Set the WebMenu properties
objWM.setBackgroundColor("");//sumenu bg color
objWM.setBackgroundImage("/html/themes/portlet/gnomon_theme/img/menu_button_bg.gif");
objWM.setGeneratedPrefix("gi9menu");
objWM.setBorderSize(1);
objWM.setClearPixelImage("/html/themes/portlet/gnomon_theme/img/menus/clearpixel.gif");
objWM.setDisabledTextColor("#696969");
objWM.setInnerHighlightColor("#C2DFF1");
objWM.setInnerShadowColor("#F9F8F7");
objWM.setOuterHighlightColor("#000000");
objWM.setOuterShadowColor("#000000");
objWM.setPopupIcon("/html/themes/portlet/gnomon_theme/img/menus/popup.gif");
objWM.setScrollDownActiveImage("/html/themes/portlet/gnomon_theme/img/menus/scrolldownactive.gif");
objWM.setScrollDownEnabledImage("/html/themes/portlet/gnomon_theme/img/menus/scrolldownenabled.gif");
objWM.setScrollUpActiveImage("/html/themes/portlet/gnomon_theme/img/menus/scrollupactive.gif");
objWM.setScrollUpEnabledImage("/html/themes/portlet/gnomon_theme/img/menus/scrollupenabled.gif");
objWM.setSelectedColor("#000000");
objWM.setSelectedPopupIcon("/html/themes/portlet/gnomon_theme/img/menus/selectedpopup.gif");
objWM.setSelectedTextColor("#ffff00");
objWM.setShadowEnabled(true);

objWM.setEffect(Coalesys.WebMenu.EffectConstants.Fade);
objWM.setHideTimer(250);


Coalesys.WebMenu.Group objGroup1=null;
Coalesys.WebMenu.Group objGroup2=null;
Coalesys.WebMenu.Item objItem = null;

Hashtable item=null;
String parent="";
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

		if(type.equals("2")) {
			PortletURL PURL1 = new PortletURLImpl(request, portletid, layout.getLayoutId(), true);
			PURL1.setWindowState(WindowState.MAXIMIZED);
			PURL1.setPortletMode(PortletMode.VIEW);
			if (mytopicid!=null && !mytopicid.equals(""))
				PURL1.setParameter("vtopicid", mytopicid);
			PURL1.setParameter("start_topic", mytopicid);
			PURL1.setParameter("language", mylang1);
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
	 		}
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
				if (url.equals("#")) {
				url="#";
				}
				else
				{
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
				PURL1.setParameter("language", mylang1);
				if(request.getParameter("p_p_text")!=null) PURL1.setParameter("p_p_text", request.getParameter("p_p_text").toString());
				url = PURL1.toString();
				}
				}

 	else if(type.equals("4")) {

				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("chapter_id", pageid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapter");
				PURL1.setParameter("language", mylang1);
				if(request.getParameter("p_p_text")!=null) PURL1.setParameter("p_p_text", request.getParameter("p_p_text").toString());
				url = PURL1.toString();

				}





if(other_menus!=null && other_menus.size() >0) {
for (int j=0; j< other_menus.size(); j++) {
		if((other_menus.get(j).toString()).equals(itemid)) {
			new_menu=j+1;
					break;
			}

	}
	}


objGroup1=objWM.getGroups().Add();

objGroup1.setCaption(name);
//objGroup1.setDownLevelURL(url);
objGroup1.setBackgroundImage(image);
objGroup1.setID(itemid);
objGroup1.setOnMenuBarClick("location.href='" + url + "';");


}			//item

		}//for






		/* and now the children */
		if(other_menus!=null && other_menus.size() >0) {




		for(int k=0; k< other_menus.size(); k++) {
			items = (Vector)(Vector) request.getAttribute("menu_items" + other_menus.get(k));

		objGroup1 =objWM.FindGroup(other_menus.get(k).toString());

		if(objGroup1!=null) {
%>


<%


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




			 if(type.equals("2")) {

				PortletURL PURL1 = new PortletURLImpl(request, portletid, layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
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
			 		}
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
				if (url.equals("#")) {
				url="#";
				}
				else
				{

				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapters");
				PURL1.setParameter("language", mylang1);
				if(request.getParameter("p_p_text")!=null) PURL1.setParameter("p_p_text", request.getParameter("p_p_text").toString());
				url = PURL1.toString();
}
				}

else if(type.equals("4")) {
				PortletURL PURL1 = new PortletURLImpl(request, "GN_CHAPTERS", layout.getLayoutId(), true);
				PURL1.setWindowState(WindowState.MAXIMIZED);
				PURL1.setPortletMode(PortletMode.VIEW);
				PURL1.setParameter("course_id", courseid);
				PURL1.setParameter("chapter_id", pageid);
				PURL1.setParameter("struts_action", "/ext/chapters/view_chapter");
				PURL1.setParameter("language", mylang1);
				if(request.getParameter("p_p_text")!=null) PURL1.setParameter("p_p_text", request.getParameter("p_p_text").toString());
				 url = PURL1.toString();

				}





if(other_menus!=null && other_menus.size() >0) {
for (int j=0; j< other_menus.size(); j++) {
		if((other_menus.get(j).toString()).equals(itemid)) {
			new_menu=j+1;
					break;
			}

	}
	}



objItem = objGroup1.getItems().Add();
objItem.setCaption(name);
objItem.setIconHeight(16);
if (!image.equals(""))
{
objItem.setIconImage(image);
}
//objItem.setIconImage("null");
objItem.setIconPaddingRight(12);
objItem.setIconWidth(16);
//objItem.setBackgroundImage("/html/themes/portlet/gnomon_theme/img/left-button.gif");
objItem.setBackgroundImage("null");
objItem.setSelectedBackgroundImage("null");
//objItem.setOnClick("location.href='" + url + "';");
objItem.setURL(url);

if(new_menu!=0) {

	 objGroup2 = objItem.AddGroup();
objGroup2.setID(itemid);
}


}//objmneu null

}			//item

		}//for


		}
		}
		}










}


%>




<%



objWM.getMenuBar().setAbsoluteDockEnabled(false);
objWM.getMenuBar().setAbsoluteDragEnabled(false);
objWM.getMenuBar().setBackgroundColor("#FED28E");//bg color basikou menu
objWM.getMenuBar().setBorderSize(0);//border basikou menu
objWM.getMenuBar().setHoverColor("#E07C27");//bg hover color basikou menu
objWM.getMenuBar().setHoverHighlightColor("#000000");
objWM.getMenuBar().setHoverShadowColor("#000000");
objWM.getMenuBar().setOuterHighlightColor("#808080");//aristera kai pano grami basikou menu
objWM.getMenuBar().setOuterShadowColor("#808080");//kato kai dexia grami basikou menu
objWM.getMenuBar().setSelectedColor("#E07C27");//selected bg xroma grammis ??
objWM.getMenuBar().setSelectedHighlightColor("#000000");//basikou menou xorista gia kathe grammi apo pano
objWM.getMenuBar().setSelectedShadowColor("#000000");//basikou menou xorista gia kathe grammi apo kato
objWM.getMenuBar().setShowOnMouseOver(true);
if (showtop.equals("1")) objWM.getMenuBar().setDisplayMode(1);
if (showtop.equals("0")) objWM.getMenuBar().setDisplayMode(2);
if (showtop.equals("2")) objWM.getMenuBar().setDisplayMode(2);

objWM.getButtonFont().setColor("#000000");//font color basikou menu
objWM.getItemFont().setPaddingLeft(16);

objWM.getButtonFont().setSize("12px");
objWM.getButtonFont().setWeight("Bold");
objWM.getButtonFont().setFamily("Arial");
objWM.getButtonFont().setPaddingLeft(16);

%>


<style type="text/css">
		<%=objWM.GenerateStyleSheet()%>
</style>

<script language="JavaScript" type="text/javascript">
		<%=objWM.GenerateJavaScript(0)%>
		<%=objWM.GenerateOnLoadEvent()%>
 		document.body.onLoad="<%=objWM.GenerateOnLoadEvent()%>";
	    document.body.onResize="<%=objWM.GenerateOnResizeEvent()%>"
</script>
<%=objWM.GenerateWebMenu(0)%>







