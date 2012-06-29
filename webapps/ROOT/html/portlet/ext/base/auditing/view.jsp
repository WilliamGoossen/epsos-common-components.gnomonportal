<%@ include file="/html/portlet/ext/base/init.jsp" %>


<html:form action="/ext/bsAuditing/list?actionURL=true" method="post" styleClass="uni-form" enctype="multipart/form-data">

	<input type="hidden" name="loadaction" value="search">
	
	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
		<tiles:put name="formName" value="BsAuditingSearchForm"/>
		<tiles:put name="attributeName" value="<%= CommonDefs.ATTR_FORM_FIELDS+"_BsAuditingSearchForm"%>"/>
		<tiles:put name="useTabs" value="false"/>
	</tiles:insert>

<div class="button-holder">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "search" ) %></html:submit>
</div>
</html:form>
<BR>

<%
String loadaction = request.getParameter("loadaction");
if (Validator.isNull(loadaction)){%>
<div class="portlet-msg-info">
<%=LanguageUtil.get(pageContext, "bs.auditing.please-select-search-parameters") %>
</div>
<%}else{
%>
<display:table name="auditEventList" id="listItem" requestURI="//ext/bsAuditing/list" pagesize="50" sort="list" export="true" style="font-weight: normal; width: 100%; border-spacing: 0">
	<%
	ViewResult eventItem = (ViewResult)listItem;
	String eventType = "";
	boolean errorEvent = false;
	if (eventItem != null) {
		eventType = (String)eventItem.getField3();
		errorEvent = (eventItem.getField7() != null) && (Boolean)eventItem.getField7() ;
	}
	%>
	<display:setProperty name="export.pdf" value="false" />
	<display:setProperty name="export.xml" value="false" />
	<display:setProperty name="export.csv" value="false" />
	<display:setProperty name="export.excel" value="true" />
	<display:setProperty name="export.excel.filename" value="BsAuditingList.xls" />
	
	<display:column property="field4" titleKey="bs.auditing.eventDate" decorator="org.displaytag.sample.LongDateTimeWrapper" sortable="true" />		
	<display:column titleKey="bs.auditing.eventType"  sortable="true"  >
	<%=LanguageUtil.get(pageContext, "bs.auditing.eventType."+eventType) %>
	</display:column>
	<display:column property="field2" titleKey="bs.auditing.personName" sortable="true"  />
	<display:column property="field5" titleKey="bs.auditing.comment" />
	<display:column property="field6" titleKey="bs.auditing.message" />
	
	<display:column property="field7" titleKey="bs.auditing.errorEvent" sortable="true" media="excel" />
	<display:column titleKey="bs.auditing.errorEvent" sortable="true" media="html" >
		<input type="checkbox"  <%=(errorEvent) ? " checked ": "" %> disabled > 
	</display:column>
	
	<display:column property="field8" titleKey="bs.auditing.errorMessage" media="excel" />
	<display:column property="field8" titleKey="bs.auditing.errorMessage" maxLength="50" media="html" />
	
	<display:column property="field9" titleKey="bs.auditing.relatedObjects" media="excel" />
	<display:column property="field9" titleKey="bs.auditing.relatedObjects" maxLength="50" media="html"/>
	
</display:table>
<%}%>