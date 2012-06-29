<%@ include file="/html/portlet/ext/mediashow/init.jsp" %>
<c:choose>
<c:when test="<%=selFolderId>0 %>">
	<%
	Properties flashAttributesProps = PropertiesUtil.load(flashAttributes);
	
	String align = GetterUtil.getString(flashAttributesProps.getProperty("align"), "left");
	String allowScriptAccess = GetterUtil.getString(flashAttributesProps.getProperty("allowScriptAccess"), "sameDomain");
	String base = GetterUtil.getString(flashAttributesProps.getProperty("base"), ".");
	String bgcolor = GetterUtil.getString(flashAttributesProps.getProperty("bgcolor"), "#FFFFFF");
	String devicefont = GetterUtil.getString(flashAttributesProps.getProperty("devicefont"), "true");
	String height = GetterUtil.getString(flashAttributesProps.getProperty("height"), "300");
	String loop = GetterUtil.getString(flashAttributesProps.getProperty("loop"), "true");
	String menu = GetterUtil.getString(flashAttributesProps.getProperty("menu"), "false");
	String play = GetterUtil.getString(flashAttributesProps.getProperty("play"), "false");
	String quality = GetterUtil.getString(flashAttributesProps.getProperty("quality"), "best");
	String salign = GetterUtil.getString(flashAttributesProps.getProperty("salign"), "");
	String scale = GetterUtil.getString(flashAttributesProps.getProperty("scale"), "showall");
	String swliveconnect = GetterUtil.getString(flashAttributesProps.getProperty("swliveconnect"), "false");
	String width = GetterUtil.getString(flashAttributesProps.getProperty("width"), "100%");
	String wmode = GetterUtil.getString(flashAttributesProps.getProperty("wmode"), "opaque");
	String version = GetterUtil.getString(flashAttributesProps.getProperty("swfversion"), "7");
	
	String movie = "/html/portlet/ext/mediashow/slideshowpro.swf";
	String flashVariables = "paramXMLPath=/html/portlet/ext/mediashow/dynparam.jsp?qry=folderId$" + selFolderId + ",sspWidth$" + sspWidth + ",sspHeight$" + sspHeight;
	//flashVariables = StringUtil.replace(flashVariables, "\n", ";");
	%>

	<liferay-ui:flash
		align="<%= align %>"
		allowScriptAccess="<%= allowScriptAccess %>"
		base="<%= base %>"
		bgcolor="<%= bgcolor %>"
		devicefont="<%= devicefont %>"
		flashvars="<%= flashVariables %>"
		height="<%= height %>"
		loop="<%= loop %>"
		menu="<%= menu %>"
		movie="<%= movie %>"
		play="<%= play %>"
		quality="<%= quality %>"
		salign="<%= salign %>"
		scale="<%= scale %>"
		swliveconnect="<%= swliveconnect %>"
		width="<%= width %>"
		wmode="<%= wmode %>"
		version="<%= version %>"
	/>
	<noscript></noscript>
</c:when>
<c:otherwise>
    <%=LanguageUtil.get(pageContext,"the-folder-could-not-be-found")%>
</c:otherwise>
</c:choose>