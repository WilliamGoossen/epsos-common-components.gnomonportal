<%@ include file="/html/portlet/ext/crm/helpdesk/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.sql.StrutsFormFieldsGroupDelimiter" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.crm.helpdesk.categories.auditors.CrCategoryAuditorForm" %>
<%@ page import="com.ext.portlet.crm.helpdesk.services.CrmService" %>
<%@ page import="gnomon.hibernate.model.crm.CrCategory" %>
<%@ page import="gnomon.hibernate.model.crm.CrRequestType" %>

<bean:define id="mainid" name="CrRequestForm" property="mainid"/>
<bean:define id="hasAudio" name="CrRequestForm" property="hasReqAudio"/>
<bean:define id="parent" name="CrRequestForm" property="parent"/>
<bean:define id="selectedCategory" name="CrRequestForm" property="reqCategory"/>
<bean:define id="selectedReqType" name="CrRequestForm" property="reqType"/>

<%
try {
String reqid =  request.getParameter("mainid");
String loadaction = (String)request.getAttribute("loadaction");

String formUrl = "/ext/crm/helpdesk/update?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.helpdesk.request.edit";


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

	listObj.selectedIndex = selectedIndex;
}
</script>



<%

boolean isParent = false;
if (parent != null && ((Boolean)parent).booleanValue())
	isParent = true;

boolean isEdit = false, isForward = false, isOpen = false, isResolve = false, isClose = false, isDelete = false;
if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_FORWARD))
{
	buttonText = "crm.button.forward";
	titleText = "crm.helpdesk.request.forward";
	isForward = true;
} else if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_OPEN))
{
	buttonText = "crm.button.open";
	titleText = "crm.helpdesk.request.open";
	isOpen = true;
} else if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_REOPEN))
{
	buttonText = "crm.button.re-open";
	titleText = "crm.helpdesk.request.open";
	isOpen = true;
}
else if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_RESOLVE_SUCCESS))
{
	buttonText = "crm.button.resolve-success";
	titleText = "crm.helpdesk.request.resolve-success";
	isResolve = true;
} else if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_RESOLVE_FAILURE))
{
	buttonText = "crm.button.resolve-failure";
	titleText = "crm.helpdesk.request.resolve-failure";
	isResolve = true;
} else if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_CLOSE_SUCCESS))
{
	buttonText = "crm.button.close-success";
	titleText = "crm.helpdesk.request.close-success";
	isClose = true;
} else if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_CLOSE_FAILURE))
{
	buttonText = "crm.button.close-failure";
	titleText = "crm.helpdesk.request.close-failure";
	isClose = true;
} else if (!Validator.isNull(loadaction) && loadaction.equals(CrRequestForm.LOADACTION_DELETE))
{
	formUrl = "/ext/crm/helpdesk/delete?actionURL=true" ;
	buttonText = "crm.button.delete";
	titleText = "crm.helpdesk.request.delete";
	isDelete = true;
}
else
	isEdit = true;



StrutsFormFields new_field=null;
java.util.Vector<StrutsFormFields> fields=new java.util.Vector<StrutsFormFields>();
String curFormName="CrRequestForm";

fields.addElement(new StrutsFormFields("mainid","mainid","text",true));
fields.addElement(new StrutsFormFields("parent","parent","text",true));
if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-protocol-number"),false)) {
	fields.addElement(new StrutsFormFieldsGroupDelimiter("basic", "crm.helpdesk.request.group.basic", "javascript", true));
	if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.use-external-protocol"),false)) 
	{
	fields.addElement(new StrutsFormFields("reqProtocolNumber","reqProtocolNumber","text",false,true));
	}
	else
	{
	new_field = new StrutsFormFields("reqProtocolNumber","crm.helpdesk.request.protocolNumber","text",false,!isOpen);
	if (isOpen)
		new_field.setRequired(true);
	fields.addElement(new_field);
	}
}
else
	fields.addElement(new StrutsFormFields("reqProtocolNumber","reqProtocolNumber","text",true));

new_field = new StrutsFormFields("reqNumber","crm.helpdesk.request.number","text",false,true);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqUserid","crm.helpdesk.request.userid","text",true,true);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqUserName","crm.helpdesk.request.userid","text",false,true);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDate","crm.helpdesk.request.date","date",false,true);
new_field.setDateFormat(CommonDefs.DATE_TIME_FORMAT_JSCRIPT);
fields.addElement(new_field);
/*if (CrmService.SHOW_REQUEST_TYPE) {
	new_field = new StrutsFormFields("reqType","crm.helpdesk.request.type","select",false,!isEdit && !isOpen);
	new_field.setCollectionLabel("reqTypeKeys");
	new_field.setCollectionProperty("reqTypes");
	fields.addElement(new_field);
	if (!isEdit && !isOpen) // add hidden field so that value is not lost
		fields.addElement(new StrutsFormFields("reqType","crm.helpdesk.request.type","text",true, true));
}
else
	fields.addElement(new StrutsFormFields("reqType","crm.helpdesk.request.type","text",true, true));
new_field = new StrutsFormFields("reqCategory","crm.helpdesk.request.category","select",false,!isOpen);
new_field.setCollectionLabel("reqCategoryNames");
new_field.setCollectionProperty("reqCategories");
fields.addElement(new_field);

*/
if (!isOpen) // add hidden field so that value is not lost
	fields.addElement(new StrutsFormFields("reqCategory","crm.helpdesk.request.category","text",true, true));

if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-contact-info"),false)) {
	fields.addElement(new StrutsFormFieldsGroupDelimiter("contact", "crm.helpdesk.request.group.contact", "javascript", false));
	new_field = new StrutsFormFields("reqReplyBy","crm.helpdesk.request.replyby","select",false,true);
	new_field.setCollectionLabel("reqReplyByKeys");
	new_field.setCollectionProperty("reqReplyBys");
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqReplyTo","crm.helpdesk.request.replyto","text",false,true);
	fields.addElement(new_field);
	//add hidden field so that value is not lost
	fields.addElement(new StrutsFormFields("reqReplyBy","crm.helpdesk.request.replyby","text",true, true));
	new_field = new StrutsFormFields("reqAlreadyContacted","crm.helpdesk.request.alreadycontacted","boolean",false,true);
	fields.addElement(new_field);
	new_field = new StrutsFormFields("reqAlreadyContactedWith","crm.helpdesk.request.alreadycontactedwith","text",false,true);
	fields.addElement(new_field);
}
new_field = new StrutsFormFields("reqNotifyProgress","crm.helpdesk.request.notifyprogress","boolean",false,true);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqNotifyFinish","crm.helpdesk.request.notifyfinish","boolean",false,true);
fields.addElement(new_field);


if (GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.smsnotify.enabled"),false)) {
new_field = new StrutsFormFields("cellPhone","crm.helpdesk.request.cellPhone","text",false,true);
	new_field.setHelpMessage("crm.helpdesk.request.cellPhone.help");

fields.addElement(new_field);
}



fields.addElement(new StrutsFormFieldsGroupDelimiter("info", "crm.helpdesk.request.group.info", "javascript", true));
new_field = new StrutsFormFields("reqSubject","crm.helpdesk.request.subject","text",false,!isOpen && !isEdit);
new_field.setRequired(true);
new_field.setField_size(70);
fields.addElement(new_field);
new_field = new StrutsFormFields("reqDescription","crm.helpdesk.request.description","textareahtml_FCK",false,!isOpen && !isEdit);
new_field.setField_size(400);
fields.addElement(new_field);
new_field = new StrutsFormFields("proPriority","crm.helpdesk.request.priority","select",false,!isEdit && !isOpen && !isForward);
new_field.setCollectionLabel("proPriorityKeys");
new_field.setCollectionProperty("proPriorities");
fields.addElement(new_field);
if (!isEdit && !isOpen && !isForward) //add hidden field so that value is not lost
	fields.addElement(new StrutsFormFields("proPriority","crm.helpdesk.request.proPriority","text",true, true));
new_field = new StrutsFormFields("proAssignedTo","crm.helpdesk.request.assignedto","select",false,!isEdit && !isOpen && !isForward);
new_field.setCollectionLabel("officerNames");
new_field.setCollectionProperty("officerIds");
fields.addElement(new_field);
if (!isEdit && !isOpen && !isForward) //add hidden field so that value is not lost
	fields.addElement(new StrutsFormFields("proAssignedTo","crm.helpdesk.request.proAssignedTo","text",true, true));
new_field = new StrutsFormFields("proExpectedResDate","crm.helpdesk.request.expectedresdate","date",false,!isEdit && !isOpen);
new_field.setDateFormat(CommonDefs.DATE_FORMAT_JSCRIPT);
fields.addElement(new_field);
//new_field = new StrutsFormFields("proPreviousComment","crm.helpdesk.request.previouscomment","textarea",false,true);
//fields.addElement(new_field);
new_field = new StrutsFormFields("proWatchRequest","crm.helpdesk.request.watchrequest","boolean",false,isDelete);
fields.addElement(new_field);
new_field = new StrutsFormFields("showComments","crm.helpdesk.request.showcomments","boolean",false,isDelete);
fields.addElement(new_field);
new_field = new StrutsFormFields("comments","crm.helpdesk.request.comments","textarea",false,isDelete);
fields.addElement(new_field);
//if (isResolve || isClose)
//{
//	new_field = new StrutsFormFields("resBy","crm.helpdesk.request.resby","select",false,false);
//	new_field.setCollectionLabel("reqReplyByKeys");
//	new_field.setCollectionProperty("reqReplyBys");
//	fields.addElement(new_field);
//	new_field = new StrutsFormFields("delayComments","crm.helpdesk.request.delaycomments","textarea", false,false);
//	fields.addElement(new_field);
	//new_field = new StrutsFormFields("resAttachmentContents","crm.helpdesk.request.attachment","fileupload", false,false);
	//new_field.setUploadFilePath("FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + CrRequestForm.UPLOAD_PATH + mainid + "/");
	//new_field.setFileName(resAttachment.toString());
	//fields.addElement(new_field);
//}
if (isParent && GetterUtil.getBoolean(PropsUtil.get("crm.helpdesk.request.show-check-type"),false) && (isOpen || isResolve || isClose || isForward)) {
	new_field = new StrutsFormFields("applyToRelatedTasks","crm.helpdesk.request.applyToChildrenTasks","boolean",false,false);
	fields.addElement(new_field);
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


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<input type="hidden" name="my_redirect" value="<%= redirect %>">
<bean:define id="labels1" name="CrRequestForm" property="reqTypeKeys"/>
<bean:define id="labels2" name="CrRequestForm" property="reqReplyByKeys"/>
<bean:define id="labels3" name="CrRequestForm" property="proPriorityKeys"/>
<bean:define id="status" name="CrRequestForm" property="status"/>


<table>

<tr>
<td><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.status") %></span></td>
<td><input type="text" name="status" readonly="true" Class="FormAreaDisable" value="<%= LanguageUtil.get(pageContext, com.ext.portlet.crm.helpdesk.CrRequestForm.translateStatus((String)status))%>"></td>
<td></td>
</tr>

<tr>
  	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.category") %></span></td>
  	<td>
  	<select name="reqCategory" onChange="setRequestTypes(this.options[this.selectedIndex].value);">
  		<option name="" value=""> </option>
  	<%  for (int i=0; i<reqCategories.length; i++) {

  				if(selectedCategory!=null && selectedCategory.toString().equals(reqCategories[i])) {
  		%>
  			<option name="<%= reqCategories[i] %>" value="<%= reqCategories[i] %>" selected> <%=reqCategoryNames[i] %></option>
  		<%} else {%>
  	    <option name="<%= reqCategories[i] %>" value="<%= reqCategories[i] %>"> <%=reqCategoryNames[i] %></option>
  	<%	 }
  	}%>
   	</select>


	</td>
	<td><html:errors property="reqCategory"/></td>
</tr>
<tr>
  	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, "crm.helpdesk.request.type") %></span></td>
  	<td>
  	<select name="reqType" >

   	</select>


   		<script>
   	setRequestTypes(<%=selectedCategory%>);
   	</script>
	</td>
	<td><html:errors property="reqType"/></td>
	</tr>

<%
String metaDataClassName = "gnomon.hibernate.model.crm.CrRequest";
String metaDataClassName_req = "";
if (selectedCategory!=null)  {
	CrCategory cat = (CrCategory)gnomon.hibernate.GnPersistenceService.getInstance(null).getObject(CrCategory.class, Integer.valueOf(selectedCategory.toString()));
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
	<tiles:put name="noTable" value="true"/>
	<tiles:put name="readOnly" value="true"/>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="CrRequestForm"/>
	<tiles:put name="className" value="<%= metaDataClassName_req %>"/>
	<% com.ext.portlet.crm.helpdesk.CrRequestForm formBean = (com.ext.portlet.crm.helpdesk.CrRequestForm ) request.getAttribute("CrRequestForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="noTable" value="true"/>
	<tiles:put name="readOnly" value="true"/>
</tiles:insert>

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
String[] labelsList3 = (String[])labels3;
for (int i=0; i<labelsList3.length; i++)
{
 	labelsList3[i] = LanguageUtil.get(pageContext, labelsList3[i]);
}
%>




<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
	<tiles:put name="formName" value="CrRequestForm"/>
	<tiles:put name="attributeName" value="_vector_fields"/>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>




</table>
<%
if(GetterUtil.getBoolean(PropsUtil.get("crm.usegooglemaps"),false))
	{
	%>
<jsp:include page="/html/portlet/ext/crm/helpdesk/googlemaps_view.jsp"></jsp:include>
  <body onload="load()" onunload="GUnload()">
    <div id="map" style="width: 600px; height: 600px"></div>
  </body>
<% }  %>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

</html:form>

<% if (hasAudio != null && ((Boolean)hasAudio).booleanValue()) { %>
<br>
<a class="beta" href="<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>"><portlet:param name="struts_action" value="/ext/crm/helpdesk/loadAudio"/><portlet:param name="mainid" value="<%= mainid.toString() %>"/></portlet:actionURL>"><img src="<%=  themeDisplay.getPathThemeImage() %>/common/download.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.load-audio-file") %></a>
<% } %>
<%
com.ext.portlet.crm.helpdesk.CrRequestForm formBean = (com.ext.portlet.crm.helpdesk.CrRequestForm ) request.getAttribute("CrRequestForm");
if (com.liferay.portal.kernel.util.Validator.isNotNull(formBean.getResAttachment())) { %>
<br>
<a class="beta" href="/IVR/<%=formBean.getResAttachment()%>"><img src="<%=  themeDisplay.getPathThemeImage() %>/common/download.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.load-audio-file") %></a>
<% } %>


<br><br>
<TABLE border="0" cellpadding="0" cellspacing="0">
<TR><TD>
<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>
<script language="JavaScript">
	function <portlet:namespace/>_openFlowsPopup(){
		var url = '<portlet:actionURL windowState="<%= LiferayWindowState.POP_UP.toString() %>"><portlet:param name="struts_action" value="/ext/crm/helpdesk/listFlows"/><portlet:param name="crrequestid" value="<%= mainid.toString() %>"/></portlet:actionURL>';
		openDialog(url, 650, 500);
	}
</script>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/history.png" alt="<%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>" border="0" align="absmiddle">
   &nbsp;<a title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %>"
   href="javascript:<portlet:namespace/>_openFlowsPopup();" class="beta">
   <%= LanguageUtil.get(pageContext, "crm.helpdesk.flow.list") %></a>
</TD></TR>

<% if (CrmService.getInstance().userHasAuditorRight(user.getUserId(), (Integer)mainid, CrCategoryAuditorForm.RIGHTS_VIEW)) { %>
<tr>
<td>
<a href="<portlet:actionURL >
		<portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestComments"/>
		<portlet:param name="requestid" value="<%= mainid.toString() %>"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>" >
<img src="<%= themeDisplay.getPathThemeImage() %>/common/quote.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>">
<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.comment.list") %>
<% if (request.getAttribute("request_comments_size") != null) { 
	out.print(" ("+request.getAttribute("request_comments_size")+")");
} %>
</a>
</td>
</tr>
<tr>
<td>
<a href="<portlet:actionURL >
		<portlet:param name="struts_action" value="/ext/crm/helpdesk/listRequestAttachments"/>
		<portlet:param name="requestid" value="<%= mainid.toString() %>"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>" >
<img src="<%= themeDisplay.getPathThemeImage() %>/common/clip.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.attachment.list") %>">
<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.attachment.list") %>
<% if (request.getAttribute("request_attachments_size") != null) { 
	out.print(" ("+request.getAttribute("request_attachments_size")+")");
} %>
</a>
</td>
</tr>
<% if (isParent) { %>
<tr>
<td>
<a href="<portlet:actionURL >
		<portlet:param name="struts_action" value="/ext/crm/helpdesk/listChildren"/>
		<portlet:param name="parentid" value="<%= mainid.toString() %>"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>" >
<img src="<%= themeDisplay.getPathThemeImage() %>/common/view_tasks.png" border="0" alt="<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %>">
<%=LanguageUtil.get(pageContext, "crm.helpdesk.request.children.list") %>
</a>
</td>
</tr>
<% } %>
<% } %>
</TABLE>


<br>
<% if (com.liferay.portal.kernel.util.Validator.isNotNull(redirect)) {%>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<a href="<%= redirect %>"><%= LanguageUtil.get(pageContext, "crm.button.back") %></a>
<%}
} catch (Exception e) {e.printStackTrace(); } %>