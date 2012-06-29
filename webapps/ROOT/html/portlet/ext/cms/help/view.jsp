<%@ include file="/html/portlet/init.jsp" %>

<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnCmsHelp" %>
<%@ page import="gnomon.hibernate.model.gn.GnCmsHelpLanguage" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.List" %>

<liferay-ui:success key="request_processed" message="your-request-processed-successfully" />

<script language="JavaScript">
function HelpLanguageMessage(title, description, keywords) {
	this.title = title;
	this.description = description;
	this.keywords = keywords;
}

var languageMessagesArray = new Array();

function selectedLanguageBox(value)
{
	if (languageMessagesArray[value] != null) {
		document.GN_CMS_HELP_FORM.elements['title'].value = languageMessagesArray[value].title;
		document.GN_CMS_HELP_FORM.elements['description'].value = languageMessagesArray[value].description;
		document.GN_CMS_HELP_FORM.elements['keywords'].value = languageMessagesArray[value].keywords;
	}
	else
	{
		document.GN_CMS_HELP_FORM.elements['title'].value = '';
		document.GN_CMS_HELP_FORM.elements['description'].value = '';
		document.GN_CMS_HELP_FORM.elements['keywords'].value = '';
	}
}

var _fck_fields = '';

function _fck_updateHiddenText() {
    if (_fck_fields)
    {
	eval(_fck_fields );
    }
}
</script>


<% 
GnCmsHelp helpObject = (GnCmsHelp)request.getAttribute("helpMessageObject");
Hashtable<String, GnCmsHelpLanguage> helpTable = (Hashtable<String, GnCmsHelpLanguage>)request.getAttribute("helpMessageTable");
String lang = GeneralUtils.getLocale(request);
String deflang = PropsUtil.get("locale.default");
GnCmsHelpLanguage helpLangObject = null;
if (helpTable != null)
{
	helpLangObject = helpTable.get(lang);
	if (helpLangObject == null)
		helpLangObject = helpTable.get(deflang);
	
	%>
<script language="JavaScript">
<% for (String langKey: helpTable.keySet()) { %>
languageMessagesArray['<%= langKey %>'] = new HelpLanguageMessage('<%= helpTable.get(langKey).getTitle() %>', '<%= helpTable.get(langKey).getDescription() %>', '<%= helpTable.get(langKey).getKeywords() %>');
<% } %>	
</script>
	<%
}
String languages= PropsUtil.get(PropsUtil.LOCALES);
String locales[] = StringUtil.split(languages, StringPool.COMMA);

if (hasEdit) { %>

<form method="post" class="uni-form" name="GN_CMS_HELP_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/cms/help/save"/></portlet:actionURL>">

<input type="hidden" name="helpCallingPortletId" value="<%= GetterUtil.getString(request.getParameter("helpCallingPortletId"), "") %>">
<input type="hidden" name="helpCallingStrutsAction" value="<%= GetterUtil.getString(request.getParameter("helpCallingStrutsAction"), "") %>">
<input type="hidden" name="helpCallingCurrentURL" value="<%= GetterUtil.getString(request.getParameter("helpCallingCurrentURL"), "") %>">
	<%if (helpObject != null) { %>
		<input type="hidden" name="mainid" value="<%= helpObject.getMainid() %>">
	<% } %>


<fieldset class="block-labels">
	<legend>
	<%= LanguageUtil.get( pageContext, "javax.portlet.title."+ 
		(Validator.isNotNull(request.getParameter("helpCallingPortletId")) ?  request.getParameter("helpCallingPortletId") : "GN_CMS_HELP")) %>
	</legend>
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "language") %></label>
	<select name="lang" onchange="selectedLanguageBox(this.value);">
		<% for (String l : locales) { %>
		<option value="<%= l %>" <% if (l.equals(lang)) { out.print("selected"); } %>><%= l %></option>
		<% } %>
	</select>
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "title") %></label>
	<input type="text" size="50" name="title" value="<%= helpLangObject != null ? helpLangObject.getTitle() : "" %>">
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "description") %></label>
	
	
	<div>
	<script type="text/javascript">
     	function initEditordescription() {
		if (_fck_fields)
		   _fck_fields += ' document.GN_CMS_HELP_FORM.description.value=parent.<portlet:namespace />description_editor.getHTML();'
		else
		   _fck_fields = 'document.GN_CMS_HELP_FORM.description.value=parent.<portlet:namespace />description_editor.getHTML();'
	     	document.GN_CMS_HELP_FORM.onsubmit = _fck_updateHiddenText;
		return "<%=UnicodeFormatter.toString(helpLangObject != null ? helpLangObject.getDescription() : "")%>";
		}
    	</script>
	<input type="hidden" name="description" value="<%=UnicodeFormatter.toString(helpLangObject != null ? helpLangObject.getDescription() : "")%>"/>
    	<iframe frameborder="0" height="300"
    	        id="<portlet:namespace />description_editor"
    	        name="<portlet:namespace />description_editor"
    	        scrolling="no"
    	        src="<%= themeDisplay.getPathJavaScript() %>/editor/editor.jsp?p_l_id=<%= plid %>&editorImpl=fckeditor&initMethod=initEditordescription&toolbarSet=gnomon"
    	        width="600">
    	</iframe>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "keywords") %></label>
	<input type="text" size="50" name="keywords" value="<%= helpLangObject != null ? helpLangObject.getKeywords() : "" %>">
	</div>
</fieldset>	

<div class="button-holder">
<input type="submit" value="<%= LanguageUtil.get(pageContext, "save") %>">
</div>
</form>


<% } else { 
	
   if (helpObject == null || helpLangObject == null) { %>
   
   <h3><%= LanguageUtil.get( pageContext, "javax.portlet.title."+ 
		(Validator.isNotNull(request.getParameter("helpCallingPortletId")) ?  request.getParameter("helpCallingPortletId") : "GN_CMS_HELP")) %></h3>
   
	<div class="portlet-msg-info">
	<%= LanguageUtil.get(pageContext, "gn.cms.help.no-help-available") %>
	</div>
	
   <% } else { %>
   
	<div class="uni-form">
	<fieldset class="block-labels">
	<legend>
	<%= LanguageUtil.get( pageContext, "javax.portlet.title."+ 
		(Validator.isNotNull(request.getParameter("helpCallingPortletId")) ?  request.getParameter("helpCallingPortletId") : "GN_CMS_HELP")) %>
	</legend>
	
	<div class="ctrl-holder">
	<label><%= helpLangObject.getTitle() %></label>
	
	<div><%= helpLangObject.getDescription() %></div>
	</div>
	
	</fieldset>   
   <% } %>

<% } %>
