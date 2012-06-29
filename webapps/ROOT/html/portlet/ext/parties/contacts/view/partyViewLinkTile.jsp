<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil" %>
<%@ page import="com.liferay.portal.util.PropsUtil" %>
<%@ page import="com.ext.portlet.parties.contacts.ContactsService" %>


<tiles:useAttribute id="mainId" name="mainid" classname="java.lang.Integer"/>
<tiles:useAttribute id="partyName" name="partyName" classname="java.lang.String"/>
<tiles:useAttribute id="partyLayoutId" name="partyLayoutid" classname="java.lang.Long" ignore="true"/>
<tiles:useAttribute id="imageFileName" name="imageFileName" classname="java.lang.String" ignore="true"/>

<% 
if (partyLayoutId == null) partyLayoutId = new Long(0);

boolean showInThickBox = GetterUtil.getBoolean(PropsUtil.get("gi9.fckeditor.lookup.parties.thickbox"), false) && partyLayoutId < 1;

%>

<a <% if (showInThickBox) { %> class="thickbox" <% } %> 
   href="<%= partyLayoutId > 0 ? 
	         ContactsService.generatePartyLink(mainId, partyLayoutId, LiferayWindowState.NORMAL, true, request).toString() :
			     showInThickBox ? 
			    		 ContactsService.generatePopupPartyLink(mainId, true, request).toString() :	
			             ContactsService.generateMaximizedPartyLink(mainId, true, request).toString() 
			%>">
			
	<% if (Validator.isNotNull(imageFileName)) {
		String filePath = GetterUtil.getString(PropsUtil.get("parties.upload.path.image"), CommonDefs.DEFAULT_STORE_PATH)+ mainId+"/"+imageFileName;
		String imageViewPath = "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath;
		%>
		<img src="<%= imageViewPath  %>" alt="photo">
	<% } %>		
		
	<%= partyName %>
</a>