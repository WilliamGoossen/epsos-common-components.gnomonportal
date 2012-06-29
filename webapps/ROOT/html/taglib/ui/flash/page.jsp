<%
/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/taglib/init.jsp" %>

<%
String randomNamespace = PwdGenerator.getPassword(PwdGenerator.KEY3, 4) + StringPool.UNDERLINE;

String align = (String)request.getAttribute("liferay-ui:flash:align");
String allowScriptAccess = (String)request.getAttribute("liferay-ui:flash:allowScriptAccess");
String base = (String)request.getAttribute("liferay-ui:flash:base");
String bgcolor = (String)request.getAttribute("liferay-ui:flash:bgcolor");
String devicefont = (String)request.getAttribute("liferay-ui:flash:devicefont");
String flashvars = (String)request.getAttribute("liferay-ui:flash:flashvars");
String height = (String)request.getAttribute("liferay-ui:flash:height");
String id = (String)request.getAttribute("liferay-ui:flash:id");
String loop = (String)request.getAttribute("liferay-ui:flash:loop");
String menu = (String)request.getAttribute("liferay-ui:flash:menu");
String movie = (String)request.getAttribute("liferay-ui:flash:movie");
String play = (String)request.getAttribute("liferay-ui:flash:play");
String quality = (String)request.getAttribute("liferay-ui:flash:quality");
String salign = (String)request.getAttribute("liferay-ui:flash:salign");
String scale = (String)request.getAttribute("liferay-ui:flash:scale");
String swliveconnect = (String)request.getAttribute("liferay-ui:flash:swliveconnect");
String version = (String)request.getAttribute("liferay-ui:flash:version");
String width = (String)request.getAttribute("liferay-ui:flash:width");
String wmode = (String)request.getAttribute("liferay-ui:flash:wmode");
%>

<div id="<%= randomNamespace %>flashcontent" style="height: <%= height %>; width: <%= width %>;" align="center"></div>

<%--
<script type="text/javascript">
	jQuery(
		function() {
			var <%= randomNamespace %>swfObj = new SWFObject("<%= movie %>", "<%= id %>", "<%= width %>", "<%= height %>", 
			"<%= version %>", "<%= bgcolor %>");

			<%= randomNamespace %>swfObj.addParam("allowScriptAccess", "<%= allowScriptAccess %>");
			<%= randomNamespace %>swfObj.addParam("base", "<%= base %>");
			<%= randomNamespace %>swfObj.addParam("devicefont", "<%= devicefont %>");
			<%= randomNamespace %>swfObj.addParam("flashvars", "<%= flashvars %>");
			<%= randomNamespace %>swfObj.addParam("loop", "<%= loop %>");
			<%= randomNamespace %>swfObj.addParam("menu", "<%= menu %>");
			<%= randomNamespace %>swfObj.addParam("play", "<%= play %>");
			<%= randomNamespace %>swfObj.addParam("quality", "<%= quality %>");
			<%= randomNamespace %>swfObj.addParam("salign", "<%= salign %>");
			<%= randomNamespace %>swfObj.addParam("scale", "<%= scale %>");
			<%= randomNamespace %>swfObj.addParam("swliveconnect", "<%= swliveconnect %>");
			<%= randomNamespace %>swfObj.addParam("wmode", "<%= wmode %>");

			<%= randomNamespace %>swfObj.write("<%= randomNamespace %>flashcontent");
		}
	);
</script>
--%>

<script src="/html/js/flash_scripts/swfobject_modified.js" type="text/javascript"></script>


<object id="FlashID_<%= randomNamespace %>" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="<%= width %>" height="<%= height %>">
  <param name="movie" value="<%= movie %>">
  <param name="quality" value="<%= quality %>">
  <param name="wmode" value="<%= wmode %>">
  <param name="swfversion" value="<%= version %>">
  <param name="allowScriptAccess" value="<%= allowScriptAccess %>">
  <param name="id" value="<%= id %>">
  <param name="bgcolor" value="<%= bgcolor %>">
  <param name="flashvars" value="<%= flashvars %>">
  <param name="loop" value="<%= loop %>">
  <param name="base" value="<%= base %>">
  <param name="menu" value="<%= menu %>">
  <param name="play" value="<%= play %>">
  <param name="salign" value="<%= salign %>">
  <param name="scale" value="<%= scale %>">
  <param name="swliveconnect" value="<%= swliveconnect %>">
  
  
  <!-- This param tag prompts users with Flash Player 6.0 r65 and higher to download the latest version of Flash Player. Delete it if you don't want users to see the prompt. -->
  <param name="expressinstall" value="/html/js/flash_scripts/expressInstall.swf">
  
  <!-- Next object tag is for non-IE browsers. So hide it from IE using IECC. -->
  <!--[if !IE]>-->
  <object type="application/x-shockwave-flash" data="<%= movie %>" width="<%= width %>" height="<%= height %>">
    <!--<![endif]-->
  <param name="movie" value="<%= movie %>">
  <param name="quality" value="<%= quality %>">
  <param name="wmode" value="<%= wmode %>">
  <param name="swfversion" value="<%= version %>">
  <param name="allowScriptAccess" value="<%= allowScriptAccess %>">
  <param name="id" value="<%= id %>">
  <param name="bgcolor" value="<%= bgcolor %>">
  <param name="flashvars" value="<%= flashvars %>">
  <param name="loop" value="<%= loop %>">
  <param name="base" value="<%= base %>">
  <param name="menu" value="<%= menu %>">
  <param name="play" value="<%= play %>">
  <param name="salign" value="<%= salign %>">
  <param name="scale" value="<%= scale %>">
  <param name="swliveconnect" value="<%= swliveconnect %>">
    <param name="expressinstall" value="/html/js/flash_scripts/expressInstall.swf">
    <!-- The browser displays the following alternative content for users with Flash Player 6.0 and older. -->
    <div>
      <h4>Content on this page requires a newer version of Adobe Flash Player.</h4>
      <p><a href="http://www.adobe.com/go/getflashplayer"><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="Get Adobe Flash player" width="112" height="33" /></a></p>
    </div>
    <!--[if !IE]>-->
  </object>
  <!--<![endif]-->
</object>


<script type="text/javascript">
<!--
swfobject.registerObject("FlashID_<%= randomNamespace %>");
//-->
</script>