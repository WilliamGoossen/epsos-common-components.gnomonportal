<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%@ page import="com.ext.portlet.epsos.*" %>

<% 
DocumentClientDto doc = (DocumentClientDto) request.getAttribute("document"); 
String patID = request.getParameter("patID");
String docID = request.getParameter("docID");
%>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<div class="uni-form"
<fieldset class="inline-labels">
<legend>
<%= LanguageUtil.get(pageContext, "epsos.demo.document.details") %>
</legend>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.formatCode") %></label>
<span>
<%= doc.getFormatCode() != null ? doc.getFormatCode().getValue() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.language") %></label>
<span>
<%= doc.getLanguageCode() != null ? doc.getLanguageCode() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.creationTime") %></label>
<span>
<%= doc.getCreationTime() != null ? EpsosHelperService.formatCreationTimeString(doc.getCreationTime()) : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.name") %></label>
<span>
<%= doc.getName() != null ? doc.getName() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.description") %></label>
<span>
<%= doc.getDescription() != null ? doc.getDescription() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.documentClass") %></label>
<span>
<%= doc.getClassCode() != null ? doc.getClassCode().getValue() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.status") %></label>
<span>
<%= doc.getDocStatus() != null ? doc.getDocStatus().substring(doc.getDocStatus().lastIndexOf(':')+1) : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.documentType") %></label>
<span>
<%= doc.getTypeCode() != null ? doc.getTypeCode().getValue() : ""%>
</span>
</div>


<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.healthcareFacilityCode") %></label>
<span>
<%= doc.getHealthcareFacilityCode() != null ? doc.getHealthcareFacilityCode().getValue() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.practiceSetting") %></label>
<span>
<%= doc.getPracticeSettingCode() != null ? doc.getPracticeSettingCode().getValue() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.confidentiality") %></label>
<span>
<%= doc.getConfidentialityCode() != null ? doc.getConfidentialityCode().getValue() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.authorPerson") %></label>
<span>
<% if (doc.getAuthorPerson() != null  && doc.getAuthorPerson().size() > 0)
	for (String auth: doc.getAuthorPerson()) {
		out.print(auth+"&nbsp;");
	} 	
%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.size") %></label>
<span>
<%= doc.getSize() != null ? doc.getSize()+" kb" : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.mimeType") %></label>
<span>
<%= doc.getMimeType() != null ? doc.getMimeType() : ""%>
</span>
</div>

</fieldset>


<fieldset class="inline-labels">
<legend>
<%= LanguageUtil.get(pageContext, "epsos.demo.document.submission.details") %>
</legend>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.submission.title") %></label>
<span>
<%= doc.getSubmissionSet() != null && doc.getSubmissionSet().getName() != null ? doc.getSubmissionSet().getName() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.submission.description") %></label>
<span>
<%= doc.getSubmissionSet() != null && doc.getSubmissionSet().getDescription() != null ? doc.getSubmissionSet().getDescription() : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.submission.date") %></label>
<span>
<%= doc.getSubmissionSet() != null && doc.getSubmissionSet().getSubmissionTime() != null ? 
		EpsosHelperService.dateTimeFormat.format(doc.getSubmissionSet().getSubmissionTime().toGregorianCalendar().getTime()) : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.submission.authorInstitution") %></label>
<span>
<%= doc.getSubmissionSet() != null && doc.getSubmissionSet().getAuthorInstitution() != null && doc.getSubmissionSet().getAuthorInstitution().size() > 0?
		doc.getSubmissionSet().getAuthorInstitution().get(0) : ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.submission.authorDepartment") %></label>
<span>
<%= doc.getSubmissionSet() != null && doc.getSubmissionSet().getAuthorDepartment() != null && doc.getSubmissionSet().getAuthorDepartment().size() > 0 ? 
		doc.getSubmissionSet().getAuthorDepartment().get(0)		: ""%>
</span>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "epsos.demo.document.submission.contentType") %></label>
<span>
<%= doc.getSubmissionSet() != null && doc.getSubmissionSet().getContentTypeCode() != null ? doc.getSubmissionSet().getContentTypeCode().getValue() : ""%>
</span>
</div>
</fieldset>

<div class="button-holder">

<a title="<%= LanguageUtil.get(pageContext, "download") %>" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/getDocument"/>
<portlet:param name="patID" value="<%=  patID %>"/>
<portlet:param name="docID" value="<%=  docID %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/download.png" alt="download"></a>

<% if (doc.getMimeType().equals("text/xml") && !doc.getFormatCode().getValue().equals("urn:ihe:iti:xds-sd:pdf:2008")) { %>
&nbsp;
<a title="<%= LanguageUtil.get(pageContext, "epsos.xsl.view") %>" href="javascript:openDialog('<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/xslTransformDocument"/>
<portlet:param name="patID" value="<%=  patID %>"/>
<portlet:param name="docID" value="<%=  docID %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>', 900,800);"><img src="<%= themeDisplay.getPathThemeImage() %>/common/view_templates.png" alt="XSL"></a>
<% } %>
</div>

</div>



<br>

<a href="<%= redirect %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="back"><%= LanguageUtil.get(pageContext, "back") %></a>
