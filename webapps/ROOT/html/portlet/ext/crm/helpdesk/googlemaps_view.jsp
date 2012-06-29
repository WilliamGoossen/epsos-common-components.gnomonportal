<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>

<%
String reqid = request.getParameter("mainid");
String lat = GetterUtil.getString(PropsUtil.get("googlemaps.lat"),"");
String lon = GetterUtil.getString(PropsUtil.get("googlemaps.lon"),"");
String apikey = GetterUtil.getString(PropsUtil.get("googlemaps.key"),"");
%>
<script src="http://maps.google.com/maps?file=api&v=2&key=<%= apikey %>"
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
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map"));
        map.addControl(new GSmallMapControl());
        map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(<%=lat%>,<%=lon%>), 13);

        
               
        GDownloadUrl("/html/portlet/ext/crm/helpdesk/getIssueLocation.jsp?mainid=<%= reqid%>", function(data) {
          var xml = GXml.parse(data);
          var markers = xml.documentElement.getElementsByTagName("marker");
          for (var i = 0; i < markers.length; i++) {
            var name = markers[i].getAttribute("name");
            var address = markers[i].getAttribute("address");
            var type = markers[i].getAttribute("type");
            var point = new GLatLng(parseFloat(markers[i].getAttribute("lat")),
                                    parseFloat(markers[i].getAttribute("lng")));
            var marker = createMarker(point, name, address, type);
            map.addOverlay(marker);
          }
        });
      }
    }
    function createMarker(point, name, address, type) {
        var marker = new GMarker(point, customIcons[type]);
        var html = "<b>" + name + "</b> <br/>" + address;
        GEvent.addListener(marker, 'click', function() {
          marker.openInfoWindowHtml(html);
        });
        return marker;
      }
    

    //]]>
  </script>
