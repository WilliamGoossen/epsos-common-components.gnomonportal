<%@ include file="/html/common/init.jsp" %>

<%
response.setContentType(ContentTypes.TEXT_XML);
//System.out.println(request.getQueryString());

String sspWidth = "";
String sspHeight = "";
String folderId = "";

String queryString = ParamUtil.getString(request, "qry");
String[] params = queryString.split(",");
for (int i=0; params!=null && i<params.length; i++) {
	String param = params[i];
	if (param.startsWith("folderId$"))
		folderId = param.substring(param.indexOf("$")+1);
	else if (param.startsWith("sspWidth$"))
		sspWidth = param.substring(param.indexOf("$")+1);
	else if (param.startsWith("sspHeight$"))
		sspHeight = param.substring(param.indexOf("$")+1);
}
String folderParamStr = Validator.isNull(folderId)? "": "?folderid=" + folderId;
/*
String sspWidth = ParamUtil.getString(request, "sspWidth");
String sspHeight = ParamUtil.getString(request, "sspHeight");
String folderId = ParamUtil.getString(request, "folderId", "65619");
*/
%>
<?xml version="1.0" encoding="UTF-8"?>
<params>
<customParams 
	sspWidth="<%=sspWidth%>"
	sspHeight="<%=sspHeight%>"
/>
<nativeParams
	albumBackgroundAlpha="1"
	albumBackgroundColor="0x303030"
	albumDescColor="0xCCCCCC"
	albumDescSize="9"
	albumPadding="8"
	albumPreviewScale="Proportional"
	albumPreviewSize="54,40"
	albumPreviewStrokeColor="0xFFFFFF"
	albumPreviewStrokeWeight="1"
	albumPreviewStyle="Inline Left"
	albumRolloverColor="0x262626"
	albumStrokeAppearance="Visible"
	albumStrokeColor="0x141414"
	albumTextAlignment="Left"
	albumTitleColor="0xFFFFFF"
	albumTitleSize="10"
	audioLoop="Off"
	audioPause="Off"
	audioVolume=".8"
	autoFinishMode="Switch"
	cacheContent="None"
	captionAppearance="Overlay Mouse Over (If Available)"
	captionBackgroundAlpha=".75"
	captionBackgroundColor="0x000000"
	captionHeaderAppearance="Image Count"
	captionPadding="5,5,5,5"
	captionPosition="Top"
	captionTextAlignment="Left"
	captionTextColor="0xEEEEEE"
	captionTextSize="9"
	contentAlign="Center"
	contentAreaBackgroundAlpha="1"
	contentAreaBackgroundColor="0x303030"
	contentAreaStrokeAppearance="Hidden"
	contentAreaStrokeColor="0xFFFFFF"
	contentFormat="Normal"
	contentFrameAlpha="1"
	contentFrameColor="0x262626"
	contentFramePadding="0"
	contentFrameStrokeAppearance="Hidden"
	contentFrameStrokeColor="0x333333" 
	contentOrder="Random"
	contentScale="Crop to Fit All"
	directorLargeImageSettings="80,1,1"
	directorThumbImageSettings="50,1"
	displayMode="Auto"
	feedbackBackgroundAlpha=".4"
	feedbackBackgroundColor="0x000000"
	feedbackHighlightAlpha=".8"
	feedbackHighlightColor="0xFFFFFF"
	feedbackPreloaderAlign="Center"
	feedbackPreloaderAppearance="Pie"
	feedbackPreloaderPosition="Inside Content Area"
	feedbackScale="1"
	feedbackTimerAlign="Top Right"
	feedbackTimerAppearance="Visible"
	feedbackTimerPosition="Inside Content Area"
	galleryAppearance="Closed at Startup"
	galleryBackgroundAlpha="1"
	galleryBackgroundColor="0x1c1c1c"
	galleryColumns="2"
	galleryOrder="Left to Right"
	galleryPadding="10"
	galleryRows="4"
	galleryNavActiveColor="0x303030"
	galleryNavAppearance="Visible"
	galleryNavInactiveColor="0x000000"
	galleryNavRolloverColor="0x262626"
	galleryNavStrokeAppearance="Visible"
	galleryNavStrokeColor="0x141414"
	galleryNavTextColor="0xCCCCCC"
	galleryNavTextSize="9"
	iconInactiveAlpha=".4"
	iconShadowAlpha=".6"
	keyboardControl="On"
	mediaPlayerAppearance="Visible"
	mediaPlayerBackgroundAlpha=".25"
	mediaPlayerBackgroundColor="0x000000"
	mediaPlayerBufferColor="0x000000"
	mediaPlayerControlColor="0xFFFFFF"
	mediaPlayerElapsedBackgroundColor="0xFFFFFF"
	mediaPlayerElapsedTextColor="0x000000"
	mediaPlayerIconColor="0xCCCCCC"
	mediaPlayerPosition="Bottom"
	mediaPlayerProgressColor="0xCCCCCC"
	mediaPlayerScale=".8"
	mediaPlayerTextColor="0xEEEEEE"
	mediaPlayerTextSize="9"
	mediaPlayerVolumeBackgroundColor="0x000000"
	mediaPlayerVolumeHighlightColor="0xCCCCCC"
	navAppearance="Hidden When Gallery Open"
	navBackgroundAlpha="0"
	navBackgroundColor="0x11729B"
	navButtonsAppearance="Hidden"
	navGradientAlpha=".3"
	navGradientAppearance="Glass Dark"
	navIconColor="0xEEEEEE"
	navLinkAppearance="Thumbnails"
	navLinkCurrentColor="0xEEEEEE"
	navLinkPreviewAppearance="Hidden"
	navLinkPreviewBackgroundAlpha="5"
	navLinkPreviewBackgroundColor="0xFFFFFF"
	navLinkPreviewScale="Crop to Fit"
	navLinkPreviewSize="50,25"
	navLinkPreviewStrokeWeight="1"
	navLinkRolloverColor="0xFFFFFF"
	navLinkSpacing="10"
	navLinksBackgroundAlpha=".1"
	navLinksBackgroundColor="0x121212"
	navNumberLinkColor="0x999999"
	navNumberLinkSize="9"
	navPosition="Bottom"
	navThumbLinkBackgroundColor="0x666666"
	navThumbLinkInactiveAlpha="2"
	navThumbLinkShadowAlpha=".6"
	navThumbLinkSize="40,30"
	navThumbLinkStrokeWeight="2"
	permalinks="Off"
	smoothing="Off"
	soundEffects="None,None,None"
	textStrings="Previous Screen,Next Screen,Screen,of,No caption,No title"
	transitionDirection="Left to Right"
	transitionLength="2"
	transitionPause="4"
	transitionStyle="Cross Fade"
	typeface="Verdana,_sans"
	typefaceHead="Verdana,Arial,_sans"
	typefaceEmbed="Off"
	videoAutoStart="On"
	videoBufferTime="0.1"
	xmlFilePath="/imagexml<%=folderParamStr%>"
	xmlFileType="Default" />
</params>

<%--
	xmlFilePath="images.xml<%=folderParamStr%>"
	xmlFilePath="<%="/imagexml?folderid=" + selFolderId%>images.xml"
--%>