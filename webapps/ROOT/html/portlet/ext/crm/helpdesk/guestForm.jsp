<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.sql.StrutsFormFieldsGroupDelimiter" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.helpdesk.categories.auditors.CrCategoryAuditorForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.CrRequestForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.hibernate.model.crm.CrCategory" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestType" %>

<bean:define id="status" name="CrRequestForm" property="status"/>
<bean:define id="crrequestid" name="CrRequestForm" property="mainid"/>
<bean:define id="parent" name="CrRequestForm" property="parent"/>



<%
try {

CrRequestForm crForm = (CrRequestForm) request.getAttribute("CrRequestForm");

String selectedCategory = crForm.getReqCategory();
String selectedReqType = crForm.getReqType();


String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/helpdesk/load?actionURL=true" ;
String buttonText = "crm.button.view";
String titleText = "crm.helpdesk.request.view";
String step = (String)request.getAttribute("step");
if (step == null) step = "step_two";
String reqCategoryNames[] = (String[])request.getAttribute("reqCategoryNames");
String reqCategories[] = (String[])request.getAttribute("reqCategories");

String genReqTypes[] = (String[])request.getAttribute("genReqTypes");
String genReqTypeNames[] = (String[])request.getAttribute("genReqTypeNames");

%>



<script language="JavaScript">

function reqType(id, name, catId)
{
	this.id = id;
	this.name = name;
	this.catId = catId;

}


var genRTypes = new Array(
  <%
  if(genReqTypes!=null) {
  	for(int r=0; r<genReqTypes.length; r++) {%>
  	 new reqType("<%= genReqTypes[r] %>", "<%= genReqTypeNames[r] %>", "0")

    <% if (r<genReqTypes.length-1) { %> , <% } %>
  <% }
  }
 %>
);

var rTypes = new Array(
  <%
  int count=0;
  for (int c=0; c<reqCategories.length; c++) {

  	String rtypes[] = (String[])request.getAttribute("_" + reqCategories[c]+"_reqTypes");
  	String rtypeNames[] = (String[])request.getAttribute("_" + reqCategories[c]+"_reqTypeNames");
  	if(rtypes!=null) {
  	for(int r=0; r<rtypes.length; r++) {
  		if(count>0) {%> , <% } %>
  	 new reqType("<%= rtypes[r] %>", "<%= rtypeNames[r] %>", "<%=reqCategories[c] %>")


  <%
  	count++;
  	 }
}
}%>
);


function setRequestTypes(categoryId) {
	var listObj = document.CrRequestForm.elements["reqType"];
	var oldOptions = listObj.options;
	while(oldOptions.length) { listObj.remove(0);}
	oldOptions.add(new Option("", ""));
	var i=0;
	var j=0;
	var selectedIndex = 0;
	var selectedReqType="<%= (selectedReqType!=null)?selectedReqType.toString():""%>";


if(genRTypes!=null) {
for (i=0; i<genRTypes.length; i++)
	{

			j++;
			var optionToAdd = new Option(genRTypes[i].name, genRTypes[i].id);
				if (genRTypes[i].id == selectedReqType)
			{
				selectedIndex = j;

			}
			oldOptions.add(optionToAdd);
	}
}

if(rTypes!=null) {
for (i=0; i<rTypes.length; i++)
	{
		if (rTypes[i].catId == categoryId)
		{
			//alert(rTypes[i].catId);
		//	alert(categoryId);
			j++;
			var optionToAdd = new Option(rTypes[i].name, rTypes[i].id);
			oldOptions.add(optionToAdd);
			if (rTypes[i].id == selectedReqType)
			{
				selectedIndex = j;

			}

		}
	}
}
	listObj.selectedIndex = selectedIndex;
}
</script>




<%
boolean isParent = false;
if (parent != null && ((Boolean)parent).booleanValue())
	isParent = true;

boolean isAdd = false;
boolean isPrint = false;
if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_ADD))
{
	isAdd = true;

	if(step.equals("step_one")) {
		formUrl = "/ext/crm/helpdesk/load?actionURL=true" ;
	buttonText = "crm.button.next";
	}
	else {
	formUrl = "/ext/crm/helpdesk/add?actionURL=true" ;
	buttonText = "crm.button.add";
}
	titleText = "crm.helpdesk.request.add";
}
if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_PRINT_VIEW))
{
	isPrint = true;
}

StrutsFormFields new_field=null;
java.util.Vector<StrutsFormFields> fields=new java.util.Vector<StrutsFormFields>();
String curFormName="CrRequestForm";








if(isAdd && step.equals("step_one")) {

/*new_field = new StrutsFormFields("reqCategory","crm.helpdesk.request.category","select",false,false);
new_field.setCollectionLabel("reqCategoryNames");
new_field.setCollectionProperty("reqCategories");
fields.addElement(new_field);



	new_field = new StrutsFormFields("reqType","crm.helpdesk.request.type","select",false,false);
	new_field.setCollectionLabel("reqTypeKeys");
	new_field.setCollectionProperty("reqTypes");
	fields.addElement(new_field);
	*/

}
	else {

fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("parent","parent","text",true));
fields.addElement(new StrutsFormFields("reqProtocolNumber","reqProtocolNumber","text",true));
if(GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-request-type"),false)) {
//	fields.addElement(new StrutsFormFieldsGroupDelimiter("basic", "crm.helpdesk.request.group.basic", "javascript", true));
}
if (!isAdd) {
	//if (CrmService.SHOW_PROTOCOL_NUMBER) {
	if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-protocol-number"),false)) {
		new_field = new StrutsFormFields("reqProtocolNumber","crm.helpdesk.request.protocolNumber","text",false,true);
		  fields.addElement(new_field);
	}
	new_field = new StrutsFormFields("reqNumber","crm.helpdesk.request.number","text",false,true);
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqUserid","crm.helpdesk.request.userid","text",true,true);
	fields.addElement(new_field);
	//new_field = new StrutsFormFields("reqUserName","crm.helpdesk.request.userid","text",false,true);
	//fields.addElement(new_field);
}

new_field = new StrutsFormFields("reqUserName","crm.helpdesk.request.userid","text",false,true);
new_field.setField_size(100);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDate","crm.helpdesk.request.date","date",false,true);
new_field.setDateFormat(CommonDefs.DATE_TIME_FORMAT_JSCRIPT);
fields.addElement(new_field);

/*if (CrmService.SHOW_REQUEST_TYPE) {
	new_field = new StrutsFormFields("reqType","crm.helpdesk.request.type","select",false,true);
	new_field.setCollectionLabel("reqTypeKeys");
	new_field.setCollectionProperty("reqTypes");
	fields.addElement(new_field);
}
else
	fields.addElement(new StrutsFormFields("reqType","crm.helpdesk.request.type","text",true, true));

new_field = new StrutsFormFields("reqCategory","crm.helpdesk.request.category","select",false,true);
new_field.setCollectionLabel("reqCategoryNames");
new_field.setCollectionProperty("reqCategories");
fields.addElement(new_field);


*/
//if (CrmService.SHOW_CONTACT_INFO) {
		if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-contact-info"),false)) {
	//if (isPrint)
		//fields.addElement(new StrutsFormFieldsGroupDelimiter("contact", "crm.helpdesk.request.group.contact", "javascript", true));
	//else
	
		//fields.addElement(new StrutsFormFieldsGroupDelimiter("contact", "crm.helpdesk.request.group.contact", "javascript", true));

	new_field = new StrutsFormFields("reqReplyBy","crm.helpdesk.request.replyby","select",false,!isAdd);
		new_field.setHelpMessage("crm.helpdesk.request.replyby.help");
	new_field.setCollectionLabel("reqReplyByKeys");
	new_field.setCollectionProperty("reqReplyBys");
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqReplyTo","crm.helpdesk.request.replyto","text",false,!isAdd);
		new_field.setHelpMessage("crm.helpdesk.request.replyto.help");
		if (isAdd)	
			new_field.setRequired(true);
		new_field.setField_size(70);
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqAlreadyContacted","crm.helpdesk.request.alreadycontacted","boolean",false,!isAdd);
		new_field.setHelpMessage("crm.helpdesk.request.alreadycontacted.help");
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqAlreadyContactedWith","crm.helpdesk.request.alreadycontactedwith","text",false,!isAdd);
		new_field.setHelpMessage("crm.helpdesk.request.alreadycontactedwith.help");
		new_field.setField_size(70);
	fields.addElement(new_field);
}

new_field = new StrutsFormFields("reqNotify","crm.helpdesk.request.notify","select",false,!isAdd);
	new_field.setHelpMessage("crm.helpdesk.request.notify.help");
new_field.setCollectionLabel("notifyOnKeys");
new_field.setCollectionProperty("notifyOn");
fields.addElement(new_field);


//if(CrmService.SMS_NOTIFY) {

	if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.smsnotify.enabled"),false)) {
new_field = new StrutsFormFields("cellPhone","crm.helpdesk.request.cellPhone","text",false,!isAdd);
	new_field.setHelpMessage("crm.helpdesk.request.cellPhone.help");

fields.addElement(new_field);
}


/*new_field = new StrutsFormFields("reqNotifyProgress","crm.helpdesk.request.notifyprogress","boolean",false,!isAdd);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqNotifyFinish","crm.helpdesk.request.notifyfinish","boolean",false,!isAdd);
fields.addElement(new_field);*/

//fields.addElement(new StrutsFormFieldsGroupDelimiter("info", "crm.helpdesk.request.group.info", "javascript", true));
new_field = new StrutsFormFields("reqSubject","crm.helpdesk.request.subject","text",false,!isAdd);
	new_field.setHelpMessage("crm.helpdesk.request.subject.help");
new_field.setRequired(true);
new_field.setField_size(100);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDescription","crm.helpdesk.request.description","textareahtml_FCK",false,!isAdd);
if (isAdd)
	new_field.setRequired(true);
new_field.setTextAreaToolBar("gnomon_empty"); 
	new_field.setHelpMessage("crm.helpdesk.request.description.help");
fields.addElement(new_field);
new_field.setField_size(400);
if (!isAdd) {
	new_field = new StrutsFormFields("proAssignedTo","crm.helpdesk.request.assignedto","select",false,true);
	new_field.setCollectionLabel("officerNames");
	new_field.setCollectionProperty("officerIds");
	fields.addElement(new_field);
	new_field = new StrutsFormFields("proExpectedResDate","crm.helpdesk.request.expectedresdate","date",false,true);
	new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
	fields.addElement(new_field);

	if (PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.EDIT)) {
		new_field = new StrutsFormFields("proWatchRequest","crm.helpdesk.request.watchrequest","boolean",false,true);
		fields.addElement(new_field);
	}
	if (status != null &&
		(status.equals(CrRequestForm.STATUS_CLOSED_SUCCESS) || status.equals(CrRequestForm.STATUS_CLOSED_FAILURE)))
	{
		//new_field = new StrutsFormFields("resBy","crm.helpdesk.request.resby","select",false,true);
//		new_field.setCollectionLabel("reqReplyByKeys");
//		new_field.setCollectionProperty("reqReplyBys");
//		fields.addElement(new_field);
		new_field = new StrutsFormFields("resDate","crm.helpdesk.request.actualresdate","date",false,true);
		new_field.setDateFormat(CommonDefs.DATE_TIME_FORMAT_JSCRIPT);
		fields.addElement(new_field);
		//new_field = new StrutsFormFields("proPreviousComment","crm.helpdesk.request.comments","textarea",false,true);
		//fields.addElement(new_field);
	}
}
}
request.setAttribute("_vector_fields", fields);

if (!isParent) { %>
<h2  >
<bean:write name="CrRequestForm" property="checkType"/>
</h2>
<% } else { %>
<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>
<% } %>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data" >
<%if(isAdd) {
	if( step.equals("step_one")) {%>
	<input type="hidden" name="step" value="step_two">
	<!--- CATEGORIES AND REQUEST TYPES -->



<%} else {%>
	<input type="hidden" name="step" value="step_three">
<%}%>




<%}%>
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="my_redirect" value="<%= redirect %>">




<table width="100%" border="0">


<tr>
  	<td width="25%" ><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.category") %></span></td>
  	<td>
  	<select name="reqCategory" onChange="setRequestTypes(this.options[this.selectedIndex].value);"  <%if (!isAdd || !step.equals("step_one")) {%> disabled ="true" class="FormAreaDisable" <%}%>>
  		<option name="" value=""> </option>
<%  for (int i=0; i<reqCategories.length; i++) {
  	   			if(selectedCategory!=null && selectedCategory.toString().equals(reqCategories[i])) {
  		%>
  			<option name="<%= reqCategories[i] %>" value="<%= reqCategories[i] %>" selected> <%=reqCategoryNames[i] %></option>
  		<%} else {%>
  	    <option name="<%= reqCategories[i] %>" value="<%= reqCategories[i] %>"> <%=reqCategoryNames[i] %></option>
  	<%	 }
  	 } %>
   	</select>
    
    <% if (isAdd && step.equals("step_one") ) { %>
				<liferay-ui:icon-help message="crm.helpdesk.request.category.help" />
		    <% } %>
    
	</td>
	<td><html:errors property="reqCategory"/></td>
</tr>
<tr>
  	<td width="25%"><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.type") %></span></td>
  	<td>
  	<select name="reqType" <%if (!isAdd || !step.equals("step_one")) {%> disabled ="true" class="FormAreaDisable" <%}%> >

   	</select>
	<% if (isAdd && step.equals("step_one") ) { %>
				<liferay-ui:icon-help message="crm.helpdesk.request.type.help" />
		    <% } %>

   	<script>
   	setRequestTypes(<%= selectedCategory %>);
   	</script>
	</td>
	<td><html:errors property="reqType"/></td>
	</tr>

	<%if (!isAdd || !step.equals("step_one")) {%>
		<input type="hidden" name ="reqCategory" value="<%=selectedCategory%>">
		<input type="hidden" name ="reqType" value="<%=selectedReqType%>">

	<%}%>

<% if (step == null || step.equals("step_two")) { %>

<%
String metaDataClassName = "gnomon.hibernate.model.crm.CrRequest";
String metaDataClassName_req = "";
if (selectedCategory!=null)  {
	CrCategory cat = (CrCategory)gnomon.hibernate.GnPersistenceService.getInstance(null).getObject(CrCategory.class, Integer.valueOf(selectedCategory));
	com.ext.portlet.crm.helpdesk.CrRequestForm formBean1 = (com.ext.portlet.crm.helpdesk.CrRequestForm ) request.getAttribute("CrRequestForm");
	CrRequestType req  = (CrRequestType)gnomon.hibernate.GnPersistenceService.getInstance(null).getObject(CrRequestType.class, Integer.valueOf(formBean1.getReqType()));
	metaDataClassName_req=req.getMetadataCode();
	if (cat != null && Validator.isNotNull(cat.getSystemCode()))
	{
		metaDataClassName = cat.getSystemCode();
	}
} %>

<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="CrRequestForm"/>
	<tiles:put name="className" value="<%= metaDataClassName %>"/>
	<% com.ext.portlet.crm.helpdesk.CrRequestForm formBean = (com.ext.portlet.crm.helpdesk.CrRequestForm ) request.getAttribute("CrRequestForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<% if (!isAdd) { %>
	<tiles:put name="readOnly" value="true"/>
	<% } %>
	<tiles:put name="noTable" value="false"/>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="CrRequestForm"/>
	<tiles:put name="className" value="<%= metaDataClassName_req %>"/>
	<% com.ext.portlet.crm.helpdesk.CrRequestForm formBean = (com.ext.portlet.crm.helpdesk.CrRequestForm ) request.getAttribute("CrRequestForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="noTable" value="true"/>
	<% if (!isAdd) { %>
	<tiles:put name="readOnly" value="true"/>
	<% } %>
	<tiles:put name="noTable" value="false"/>
</tiles:insert>


<% } %>


<br />




<bean:define id="labels1" name="CrRequestForm" property="reqTypeKeys"/>
<bean:define id="labels2" name="CrRequestForm" property="reqReplyByKeys"/>
<%
// correct the list of keys for translations to be shown properly
String[] labelsList1 = (String[])labels1;
for (int i=0; i<labelsList1.length; i++)
{
 	labelsList1[i] = LanguageUtil.get(pageContext, labelsList1[i]);
}
String[] labelsList2 = (String[])labels2;
for (int i=0; i<labelsList2.length; i++)
{
 	labelsList2[i] = LanguageUtil.get(pageContext, labelsList2[i]);
}
%>


<% if (!isAdd) { %>
<bean:define id="priority" name="CrRequestForm" property="proPriority"/>
<tr>
<td width="25%"><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.status") %></span></td>
<td width="77%"><input type="text" name="status" readonly="true" Class="FormAreaDisable" value="<%= LanguageUtil.get(pageContext, CrRequestForm.translateStatus((String)status))%>"></td>
<td width="6%"></td>
</tr>
<tr>
<td width="25%"><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.priority") %></span></td>
<td><input type="text" name="priority" readonly="true" Class="FormAreaDisable" value="<%= LanguageUtil.get(pageContext, com.ext.portlet.crm.helpdesk.categories.CrCategoryForm.translatePriorityType((String)priority))%>"></td>
<td></td>
</tr>
<% } %>
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName" value="CrRequestForm"/>
	<tiles:put name="attributeName" value="_vector_fields"/>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>

<% if (step.equals("step_two")) {
	if(GetterUtil.getBoolean(PropsUtil.get("crm.usegooglemaps"),false))
	{
%>
<TR><TD><INPUT SIZE=13 TYPE="hidden" ID="latbox" NAME="lat" value="" ></TD></TR>
<TR><TD><INPUT SIZE=13 TYPE="hidden" ID="lonbox" NAME="lon" value="" ></TD></TR>
<% } }%>
</table><br />
<% if (step.equals("step_two")) {
if(GetterUtil.getBoolean(PropsUtil.get("crm.usegooglemaps"),false))
	{%>
<jsp:include page="/html/portlet/ext/crm/helpdesk/googlemaps.jsp"></jsp:include>
  <body onload="load()" onunload="GUnload()">
    <div id="map" style="width: 600px; height: 600px"></div>
  </body>
<% } }%>

<div align="right">
<% if (isAdd) { %>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>
<% } %>
</html:form>
</div>
<% if (!isAdd && !isPrint) { %>
<br>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>
<script language="JavaScript">
	function <portlet:namespace/>_openFlowsPopup(){
		var url = '<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/ext/crm/helpdesk/listFlows"/><portlet:param name="crrequestid" value="<%= crrequestid.toString() %>"/></portlet:actionURL>';
		openDialog(url, 650, 500);
	}
</script>


<TABLE border="0" style="padding:4px;">
<TR>

<TD>

    <div class="action_link" >
    <img src="<%=  themeDisplay.getPathThemeImage() %>/common/history.png" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>" border="0" align="absmiddle"><a title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>"
       href="javascript:<portlet:namespace/>_openFlowsPopup();" >
       <%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>
     </a>
     </div>

</TD>


<% if (CrmService.getInstance().userHasAuditorRight(user.getUserId(), (Integer)crrequestid, CrCategoryAuditorForm.RIGHTS_VIEW)) { %>

<td>
    <div class="action_link" >
    <img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>" align="absmiddle">
    <a href="<portlet:actionURL >
            <portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestComments"/>
            <portlet:param name="requestid" value="<%= crrequestid.toString() %>"/>
            <portlet:param name="redirect" value="<%=currentURL%>"/>
            </portlet:actionURL>" >
    <%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>
    <% if (request.getAttribute("request_comments_size") != null) { 
		out.print(" ("+request.getAttribute("request_comments_size")+")");
	} %>
    </a>
    </div>
</td>


<td>

        <div class="action_link" >
        <img src="<%= themeDisplay.getPathThemeImage() %>/common/clip.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.attachment.list") %>" align="absmiddle">
        <a href="<portlet:actionURL >
                <portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestAttachments"/>
                <portlet:param name="requestid" value="<%= crrequestid.toString() %>"/>
                <portlet:param name="redirect" value="<%=currentURL%>"/>
                </portlet:actionURL>" >
        <%=LanguageUtil.get(pageContext, "crm.helpdesk.request.attachment.list") %>
        <% if (request.getAttribute("request_attachments_size") != null) { 
			out.print(" ("+request.getAttribute("request_attachments_size")+")");
		} %>
        </a>
        </div>
</td>


		<% if (isParent) { %>

        <td>
        <div class="action_link" >
        <img src="<%= themeDisplay.getPathThemeImage() %>/common/view_tasks.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %>" align="absmiddle">
        <a href="<portlet:actionURL >
                <portlet:param name="struts_action" value="/ext/crm/helpdesk/listChildren"/>
                <portlet:param name="parentid" value="<%= crrequestid.toString() %>"/>
                <portlet:param name="redirect" value="<%=currentURL%>"/>
                </portlet:actionURL>" >
        <%=LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %>
        </a>
        </div>
        </td>


        <% } %>
<% } %>
 </tr>
</TABLE>

<% } %>
<% if (!isPrint) { %>
<br>
<% if (com.liferay.portal.kernel.util.Validator.isNotNull(redirect)) {%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "crm.button.back") %></a>
<% }}
} catch (Exception e) {e.printStackTrace(); } %>