<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%@ page import="com.ext.portlet.epsos.*" %>

<script type="text/javascript" src="/html/js/jquery.DOMWindow.js"></script>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String patID = request.getParameter("patID");
List<DocumentClientDto> patientDocuments = (List<DocumentClientDto>)request.getAttribute("prescriptionDocuments");
session.setAttribute("patientDocuments",patientDocuments);
if (patientDocuments != null && patientDocuments.size() > 0) { %>

<h3><%= LanguageUtil.get(pageContext, "epsos.demo.prescription.list") %></h3>

<display:table id="doc" name="prescriptionDocuments" requestURI="//ext/epsos/demo/viewPatientDocuments?actionURL=true" style="width: 100%;">

<%  DocumentClientDto docItem = (DocumentClientDto) doc;  %>
<display:column property="name" titleKey="epsos.demo.document.name" sortable="true" media="xml excel csv pdf"/>
<display:column titleKey="epsos.demo.document.name" sortable="true" media="html">
<% if (docItem.getMimeType().equals("text/xml")) { %>
<a class="aa1" target="new" title="<%= LanguageUtil.get(pageContext, "epsos.xsl.view") %>" href="<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/xslTransformDocument"/>
<portlet:param name="patID" value="<%=  patID %>"/>
<portlet:param name="docType" value="ep"/>
<portlet:param name="country" value="<%=  request.getParameter("country")  %>"/>
<portlet:param name="docID" value="<%=  patientDocuments.indexOf(docItem)+"" %>"/>
</portlet:actionURL>&height=600&width=1000">
<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/filetypes/xml.gif" alt="xml"> &nbsp;
<%= docItem.getName() %></a>
<% } else { %>
<a target="new" class="aathickbox" title="<%= LanguageUtil.get(pageContext, "epsos.xsl.view") %>" href="
<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/getDocument"/>
<portlet:param name="patID" value="<%=  patID %>"/>
<portlet:param name="country" value="<%=  request.getParameter("country")  %>"/>
<portlet:param name="docType" value="ep"/>
<portlet:param name="docID" value="<%=  patientDocuments.indexOf(docItem)+"" %>"/>
<portlet:param name="extractPDF" value="true"/>
</portlet:actionURL>&KeepThis=true&TB_iframe=true&height=600&width=1000"><img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/filetypes/pdf.gif"> &nbsp;
<%= docItem.getName() %></a>
<% } %>

</display:column>
<display:column property="description" titleKey="epsos.demo.document.description" sortable="true"/>
<display:column titleKey="epsos.demo.document.authorPerson" sortable="true">
<% if (docItem.getAuthorPerson() != null && docItem.getAuthorPerson().size() > 0) {
	for (String auth: docItem.getAuthorPerson()) {
		out.print(auth+"&nbsp;");
	} 
}
%>
</display:column>
<display:column titleKey="epsos.demo.document.creationTime" sortable="true">
<% if (docItem.getCreationTime() != null) {
	out.print(EpsosHelperService.formatCreationTimeString(docItem.getCreationTime())); 
}%>

</display:column>
<display:column titleKey="epsos.demo.document.healthcareFacilityCode" sortable="true">
<%= docItem.getHealthcareFacilityCode() != null? docItem.getHealthcareFacilityCode().getValue() : ""%>
</display:column>

<display:column media="html" style="white-space:nowrap;">
<a title="<%= LanguageUtil.get(pageContext, "download") %>" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/getDocument"/>
<portlet:param name="patID" value="<%=  patID %>"/>
<portlet:param name="country" value="<%=  request.getParameter("country")  %>"/>
<portlet:param name="docType" value="ep"/>
<portlet:param name="docID" value="<%=  patientDocuments.indexOf(docItem)+"" %>"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
<% if (docItem.getMimeType().equals("application/pdf")) { %>
<portlet:param name="extractPDF" value="true"/>
<% } else { %>
<portlet:param name="extractPDF" value="false"/>
<% } %>
</portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/save16.gif" alt="download"></a>
</display:column>
 
</display:table>

<%} else {%>
	   <span class="portlet-msg-alert">
	   <%= LanguageUtil.get(pageContext, "epsos.demo.ep.nodocs") %>
	   </span>
	   <% } %>


<a href="<%= redirect %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="back"><%= LanguageUtil.get(pageContext, "back") %></a>

