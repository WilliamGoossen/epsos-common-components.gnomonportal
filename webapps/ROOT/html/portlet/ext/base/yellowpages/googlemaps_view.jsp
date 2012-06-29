<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portlet.PortletURLImpl" %>
<%@ page import="com.liferay.portal.kernel.portlet.LiferayWindowState" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%
String plid = (String)request.getAttribute("plid");

String req_points = ParamUtil.getString(request,"map_points");
if (Validator.isNull(req_points)){
req_points = (String)request.getAttribute("map_points");
}
String lat = GetterUtil.getString(PropsUtil.get("bs.yellowpage.googlemaps.lat"),"");
String lon = GetterUtil.getString(PropsUtil.get("bs.yellowpage.googlemaps.lon"),"");
String apikey = GetterUtil.getString(PropsUtil.get("googlemaps.key"),"");
%>
<script src="http://maps.google.com/maps?file=api&v=2.50a&key=<%=apikey%>"
            type="text/javascript"></script>
   
    <script type="text/javascript">

    //<![CDATA[

    var iconBlue = new GIcon(); 
    iconBlue.image = 'http://labs.google.com/ridefinder/images/mm_20_blue.png';
    iconBlue.shadow = 'http://labs.google.com/ridefinder/images/mm_20_shadow.png';
    iconBlue.iconSize = new GSize(12, 20);
    iconBlue.shadowSize = new GSize(22, 20);
    iconBlue.iconAnchor = new GPoint(6, 20);
    iconBlue.infoWindowAnchor = new GPoint(5, 1);

    var iconRed = new GIcon(); 
    iconRed.image = 'http://labs.google.com/ridefinder/images/mm_20_red.png';
    iconRed.shadow = 'http://labs.google.com/ridefinder/images/mm_20_shadow.png';
    iconRed.iconSize = new GSize(12, 20);
    iconRed.shadowSize = new GSize(22, 20);
    iconRed.iconAnchor = new GPoint(6, 20);
    iconRed.infoWindowAnchor = new GPoint(5, 1);

    var customIcons = [];
    customIcons["restaurant"] = iconBlue;
    customIcons["request"] = iconRed;

    function load() {
    	try{
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map"));

        map.addControl(new GSmallMapControl());
        map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(<%=lat%>,<%=lon%>), 13);

        <%java.util.Date now = new java.util.Date();%>
        GDownloadUrl("/html/portlet/ext/base/yellowpages/getYellowPageMultipleLocations.jsp?map_points=<%= req_points%>&plid=<%=plid%>&ts=<%=""+now.getTime()%>", function(data) {
          var xml = GXml.parse(data);
          var markers = xml.documentElement.getElementsByTagName("marker");

          var bounds = new GLatLngBounds;
          //bounds.extend(map.getCenter());
          var newZoom = map.getZoom();
          for (var i = 0; i < markers.length; i++) {
            var name = markers[i].getAttribute("name");
            var address = markers[i].getAttribute("address");
            var type = markers[i].getAttribute("type");
            var point = new GLatLng(parseFloat(markers[i].getAttribute("lat")),
                                    parseFloat(markers[i].getAttribute("lng")));   

            var marker = createMarker(point, name, address, type);
            map.addOverlay(marker);
            bounds.extend(point);
            
          }
          if (markers.length > 0){
        	  newZoom = map.getBoundsZoomLevel(bounds);
			  if (markers.length > 1){
				  // Set the Zoom so that we show all points
	          		map.setCenter(bounds.getCenter())
	          		map.setZoom(newZoom);
			  } else {
				  bounds.extend(map.getCenter());
				  newZoom = map.getBoundsZoomLevel(bounds);
				  map.setCenter(bounds.getCenter())
	        	  map.setZoom(newZoom);
			  }
          }
        });
      }

	    }catch(ex){alert(ex.message);
	    }
    }

    <%
    com.liferay.portal.theme.ThemeDisplay themeDisplay =
		(com.liferay.portal.theme.ThemeDisplay)request.getAttribute(com.liferay.portal.util.WebKeys.THEME_DISPLAY);
    PortletURLImpl urlImpl = new PortletURLImpl(request, "bs_yellowpages", themeDisplay.getPlid(), false);
	urlImpl.setWindowState(LiferayWindowState.POP_UP); 
	urlImpl.setParameter("struts_action", "/ext/yellowpages/load");
	urlImpl.setParameter("mainid", "MAINID_PLACE_HOLDER");
	urlImpl.setParameter("loadaction", "view");
	urlImpl.setParameter("showMap", "false");
    %>

    function createMarker(point, name, address, type) {
        var marker = new GMarker(point, customIcons[type]);
        marker.mainId = type;
        var html = "<b>" + name + "</b> <br/>" + address;
      	GEvent.addListener(marker, 'click', function() {
  			//for (a in marker) alert(a);
  			var aUrl = '<%=urlImpl.toString()%>';
  			aUrl = aUrl.replace('MAINID_PLACE_HOLDER', marker.mainId);
  			//prompt('', '<%=urlImpl.toString()%>');
        		openDialog(aUrl, 600,350);
          //marker.openInfoWindowHtml(html);
        });
        return marker;
    }
    //]]>
  </script>
