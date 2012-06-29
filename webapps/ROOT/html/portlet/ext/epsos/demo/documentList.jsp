<%@ include file="/html/portlet/ext/epsos/demo/init.jsp" %>

<%@ page import="com.spirit.ehr.ws.client.generated.*" %>
<%@ page import="com.ext.portlet.epsos.*" %>


<script type="text/javascript" src="/html/js/jquery.DOMWindow.js"></script>

<script type="text/javascript" src="/html/js/lightbox2.05/js/prototype.js"></script>
<script type="text/javascript" src="/html/js/lightbox2.05js/scriptaculous.js?load=effects,builder"></script>
<script type="text/javascript" src="/html/js/lightbox2.05/js/lightbox.js"></script>

<h3><%= LanguageUtil.get(pageContext, "epsos.demo.document.list") %></h3>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%
String patID = request.getParameter("patID");
List<DocumentClientDto> patientDocuments = (List<DocumentClientDto>)request.getAttribute("patientDocuments");
session.setAttribute("patientDocuments",patientDocuments);
if (patientDocuments != null && patientDocuments.size() > 0) { %>

<display:table id="doc" name="patientDocuments" requestURI="//ext/epsos/demo/viewPatientDocuments?actionURL=true" style="width: 100%;">
<%  DocumentClientDto docItem = (DocumentClientDto) doc;  %>
<%--
<display:column>
<%= docItem.getUniqueId() + " --- " + docItem.getHomeCommunityId() %>
</display:column>
<display:column property="name" titleKey="epsos.demo.document.name" sortable="true" media="excel xml pdf csv"/>
--%>
<display:column titleKey="epsos.demo.document.name" sortable="true" sortProperty="name" media="html">
<% if (!docItem.getFormatCode().getNodeRepresentation().equals("urn:ihe:iti:xds-sd:pdf:2008")) { %>

<a class="thickbox" title="<%= LanguageUtil.get(pageContext, "epsos.xsl.view") %>" href="<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/xslTransformDocument"/>
<portlet:param name="patID" value="<%=  patID %>"/>
<portlet:param name="country" value="<%=  request.getParameter("country")  %>"/>
<portlet:param name="docID" value="<%=  patientDocuments.indexOf(docItem)+"" %>"/>
<portlet:param name="docType" value="ps"/>
<portlet:param name="redirect" value="<%= currentURL %>"/>
</portlet:actionURL>&height=600&width=1000">
<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/filetypes/xml.gif" alt="xml"> &nbsp;
<%= docItem.getName() %></a>
<% } else { %>
<a target="_new" class="aathickbox" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
<portlet:param name="struts_action" value="/ext/epsos/demo/getDocument"/>
<portlet:param name="patID" value="<%=  patID %>"/>
<portlet:param name="country" value="<%=  request.getParameter("country")  %>"/>
<portlet:param name="patIDType" value="<%=  request.getParameter("patIDType")  %>"/>
<portlet:param name="docType" value="ps"/>
<portlet:param name="docID" value="<%=  patientDocuments.indexOf(docItem)+"" %>"/>
<portlet:param name="extractPDF" value="true"/>
</portlet:actionURL>&KeepThis=true&TB_iframe=true&height=600&width=1000">
<img src="<%= themeDisplay.getPathThemeImage() %>/alfresco/filetypes/pdf.gif"> &nbsp;
<%= docItem.getName() %></a>

<% } %><br>

                       
<% if (docItem.getFormatCode().getNodeRepresentation().equals("urn:ihe:iti:xds-sd:pdf:2008")) { %>
<% if (docItem.getFormatCode().getNodeRepresentation().equals("urn:ihe:iti:xds-sd:pdf:2008")) { %>


<% }} %>
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
<
<display:column titleKey="epsos.demo.document.healthcareFacilityCode" sortable="true" media="print">
<%= docItem.getHealthcareFacilityCode() != null? docItem.getHealthcareFacilityCode().getValue() : ""%>
</display:column>


<display:column media="html" style="white-space:nowrap;">
<p>
<% if (docItem.getFormatCode().getNodeRepresentation().equals("urn:ihe:iti:xds-sd:pdf:2008")) { %>
<% if (docItem.getFormatCode().getNodeRepresentation().equals("urn:ihe:iti:xds-sd:pdf:2008")) { %>
<%--<a class="thickbox" href="#" onclick="javascript:displayPDF();javascript:Liferay.Util.toggle('ajaxloading')">show</a> --%>
<% }} %>

</display:column>
 

</display:table>

<%} else {%>
	   <span class="portlet-msg-alert">
	   <%= LanguageUtil.get(pageContext, "epsos.demo.ps.nodocs") %>
	   </span>
	   <% } %>
<br>
<a href="<%= redirect %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="back"><%= LanguageUtil.get(pageContext, "back") %></a>


<%-- <a class="media" href="<%="http://localhost:8090/web/guest/home?p_p_id=EPSOS_DEMO&p_p_action=1&p_p_state=exclusive&p_p_mode=view&p_p_col_id=column-2&p_p_col_count=1&_EPSOS_DEMO_struts_action=%2Fext%2Fepsos%2Fdemo%2FgetDocument&_EPSOS_DEMO_patID=0&_EPSOS_DEMO_country=AT&_EPSOS_DEMO_patIDType=null&_EPSOS_DEMO_docType=ps&_EPSOS_DEMO_docID=1&_EPSOS_DEMO_extractPDF=true&1.pdf" %>">PDF File</a> 
--%>
 
<div id="ajaxloading" align="center" style="display: inline;padding: 5px;display: none">
<img src="/html/themes/coldstone/images/ajax-loader.gif" />
</div>

<div id="loaddiv">
</div>

