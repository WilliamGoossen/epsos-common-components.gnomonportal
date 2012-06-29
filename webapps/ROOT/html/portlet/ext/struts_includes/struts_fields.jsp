<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="java.util.Vector" %>

<%@ page import="com.liferay.portlet.RenderRequestImpl" %>
<%@ page import="com.liferay.portlet.ActionRequestImpl" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.service.RoleLocalServiceUtil" %>
<%@ page import="com.liferay.portal.model.Role" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnContent" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.portlet.permissions.service.PermissionsService" %>
<%@ page import="com.ext.sql.StrutsFormFieldsGroupDelimiter" %>



<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="noTableAttribute" name="noTable" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="curFormNameAttribute" name="formName" classname="java.lang.String" />

<% try {
//Get all topics that we are allowed to get

String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");


	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();
	String no_table_flag = null;
	if (noTableAttribute != null)
		no_table_flag = noTableAttribute;
	else
		no_table_flag = (String) request.getAttribute(namespace+CommonDefs.ATTR_FORM_FIELDS_NO_TABLE_FLAG);

	String JS_PREFIX = (tileAttribute != null ? tileAttribute : "");

%>


<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<% if (no_table_flag == null || no_table_flag.equals("")) {
		// only draw the table tag if the no_table_flag was not present in the request
%>

<table border="0" cellpadding="0" cellpadding="0">

<% }
	String curFormName = curFormNameAttribute;

	Vector _struts_fields = null;
	if (tileAttribute != null)
		_struts_fields = (Vector)request.getAttribute(tileAttribute);
	else
	{
		_struts_fields = (Vector)request.getAttribute(namespace+com.ext.util.CommonDefs.ATTR_FORM_FIELDS);
		if (_struts_fields == null) {
			_struts_fields = (Vector)request.getAttribute(com.ext.util.CommonDefs.ATTR_FORM_FIELDS);
		}
		if (_struts_fields == null) _struts_fields = new Vector();
	}

	String onSubmitBody = "";
	String formFieldName;
	String formFieldKey;
	boolean required;
	String formFieldType;
	String value = null;
	String fieldDateFormat="";
	String helpMessage="";
	boolean hidden;
	boolean readonly;
	String collectionName;
	String collectionAttrName;
	String collectionProperty;
	String collectionLabel;
	int field_size;
	com.ext.sql.StrutsFormFields form_field;

	boolean textAreaHtmlFlag = false;
	String onChange = "";
	String lookupAction = "";
	boolean previous_fieldset = false;
	boolean secretField = false;
	String[] optionLabels=null;
	String[] optionValues=null;
	String[] selectedOptionValues=null;

%>
<script type="text/javascript">
var <%= JS_PREFIX %>_fck_fields = '';

function <%= JS_PREFIX %>_fck_updateHiddenText() {
    if (<%= JS_PREFIX %>_fck_fields)
    {
	eval( <%= JS_PREFIX %>_fck_fields );
    }
}
</script>
<noscript></noscript>
<%


for (int index=0; _struts_fields != null && index < _struts_fields.size(); index ++) {
	form_field = (com.ext.sql.StrutsFormFields) _struts_fields.get(index);
	if (form_field instanceof StrutsFormFieldsGroupDelimiter)
	{ %>
	<% if (index > 0 && previous_fieldset) { %>
		</table></div></td></tr>



<tr class="beta-gradient-title">
<td colspan="2" ><b><%=LanguageUtil.get(pageContext, ((com.ext.sql.StrutsFormFieldsGroupDelimiter)form_field).getGroupNameKey())%></b></td>

<td align="right"><span style="font-size: xx-small;">
<a href="javascript: void(0);" onclick="Liferay.Util.toggleByIdSpan(this, '<portlet:namespace /><%=((StrutsFormFieldsGroupDelimiter)form_field).getId()%>'); self.focus();"><span style="display: <%=((StrutsFormFieldsGroupDelimiter)form_field).isGroupShow()?"none":""%>"><img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_plus.gif" alt="<%=LanguageUtil.get(pageContext,"show")%>" /></span><span style="display: <%=((StrutsFormFieldsGroupDelimiter)form_field).isGroupShow()?"":"none"%>"><img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_minus.gif" alt="<%=LanguageUtil.get(pageContext,"hide")%>" /></span></a>
</span></td></tr>

		<tr><td colspan="3">
		<div id="<portlet:namespace /><%=((StrutsFormFieldsGroupDelimiter)form_field).getId()%>" class="beta-gradient" style="display: <%=((StrutsFormFieldsGroupDelimiter)form_field).isGroupShow()?"block":"none" %>;">
	<% } else { %>

<tr class="beta-gradient-title"><td colspan="2" ><b><%=LanguageUtil.get(pageContext, ((com.ext.sql.StrutsFormFieldsGroupDelimiter)form_field).getGroupNameKey())%></b></td>

<td align="right"><span style="font-size: xx-small;">
<a href="javascript: void(0);" onclick="Liferay.Util.toggleByIdSpan(this, '<portlet:namespace /><%=((StrutsFormFieldsGroupDelimiter)form_field).getId()%>'); self.focus();"><span style="display: <%=((StrutsFormFieldsGroupDelimiter)form_field).isGroupShow()?"none":""%>"><img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_plus.gif" alt="<%=LanguageUtil.get(pageContext,"show")%>" /></span><span style="display: <%=((StrutsFormFieldsGroupDelimiter)form_field).isGroupShow()?"":"none"%>"><img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_minus.gif" alt="<%=LanguageUtil.get(pageContext,"hide")%>" /></span></a>
</span></td></tr>

		<tr><td colspan="3">
		<div id="<portlet:namespace /><%=((StrutsFormFieldsGroupDelimiter)form_field).getId()%>" class="beta-gradient" style="display: <%=((StrutsFormFieldsGroupDelimiter)form_field).isGroupShow()?"block":"none" %>;">
	<% } %>
	<%--<legend><span class="title2"><%= LanguageUtil.get(pageContext, ((com.ext.sql.StrutsFormFieldsGroupDelimiter)form_field).getGroupNameKey()) %></span></legend>--%>
	<table width="100%">
	<% previous_fieldset = true;
	}
	else
	{
	formFieldName = form_field.getFormFieldName();
	formFieldKey = form_field.getFormFieldKey();
	formFieldType = form_field.getFormFieldType();
	fieldDateFormat = form_field.getDateFormat();
	if (fieldDateFormat == null || fieldDateFormat.equals(""))
		fieldDateFormat = CommonDefs.DATE_FORMAT_JSCRIPT;
	hidden = form_field.isHidden();
	readonly = form_field.isReadonly();
	required = form_field.isRequired();
	collectionName=form_field.getCollectionName();
	collectionAttrName = form_field.getCollectionAttrName();
	collectionProperty=form_field.getCollectionProperty();
	collectionLabel=form_field.getCollectionLabel();
	helpMessage = form_field.getHelpMessage();
	field_size = form_field.getField_size();
	secretField = form_field.isSecretTextField();
	optionLabels=form_field.getOptionLabels();
	optionValues=form_field.getOptionValues();
	selectedOptionValues=form_field.getSelectedOptionValues();

	 if (formFieldType.equals("select"))
	 {

	 	if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
         else
     		{
		onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";

	 	%>
	 <tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<% if (form_field.getMultipleSelection()>0) { %>
			<html:select property="<%=formFieldName%>" onchange="<%= onChange%>" disabled="<%=readonly%>"  size="<%= String.valueOf(form_field.getMultipleSelection())%>" multiple="true" styleClass="<%= (readonly ? "FormAreaDisable" : "FormArea") %>">
	     	<% if (collectionName != null) { %>
	     	    <html:optionsCollection styleClass="form-text" name="<%= curFormName %>" property="<%=collectionName%>" label="<%= collectionLabel %>"  value="<%=collectionProperty%>"/>
	     	<% } else if (collectionAttrName != null) { %>
	     	<html:options
		     		collection="<%=collectionAttrName%>"
		     		property="<%=collectionProperty%>"
		     		labelProperty="<%=collectionLabel%>" styleClass="form-text"/>
			<% } else if (collectionProperty != null) { %>
		     	<html:options
		     		property="<%=collectionProperty%>"
		     		labelProperty="<%=collectionLabel%>" styleClass="form-text"/>
			<% } %>
	     	</html:select>
	     	<% } else { %>
	     	<html:select property="<%=formFieldName%>" onchange="<%= onChange%>" disabled="<%=readonly%>" styleClass="<%= (readonly ? "FormAreaDisable" : "FormArea") %>">
	     	<% if (collectionName != null) { %>
	     	    <html:optionsCollection styleClass="form-text" name="<%= curFormName %>" property="<%=collectionName%>" label="<%= collectionLabel %>"  value="<%=collectionProperty%>"/>
	     	<% } else if (collectionAttrName != null) { %>
	     	<html:options
		     		collection="<%=collectionAttrName%>"
		     		property="<%=collectionProperty%>"
		     		labelProperty="<%=collectionLabel%>" styleClass="form-text"/>
			<% } else if (collectionProperty != null) { %>
		     	<html:options
		     		property="<%=collectionProperty%>"
		     		labelProperty="<%=collectionLabel%>" styleClass="form-text"/>
			<% } %>
	     	</html:select>
	     	<% } %>
	     	<% if (readonly) { %>
	     	<html:hidden property="<%=formFieldName%>"/>
	     	<% } %>
	     	<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
            <% if (helpMessage != null && !readonly ) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
     </tr>

	 <% } // end if hidden
	 } // end if "select"

     if (formFieldType.equals("text"))
     	{
     	onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";
     	if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
         else
     		{
     		if (!secretField) {
     		%>
	     	<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td><html:text property="<%=formFieldName%>" size="<%= ""+field_size %>" onchange="<%= onChange %>" readonly="<%=readonly%>" styleClass="<%= (readonly ? "FormAreaDisable" : "FormArea") %>"/><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
            <% if (helpMessage != null && !readonly) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
			<% } else { %>
			<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td><html:password property="<%=formFieldName%>" size="<%= ""+field_size %>" readonly="<%=readonly%>" styleClass="<%= (readonly ? "FormAreaDisable" : "FormArea") %>"/><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
			<% }
		}
	}

	// Date Type
	if (formFieldType.equals("date"))
	{
		boolean clearDate = form_field.isClearDate();
		if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
        else if (readonly)
		{ %>
		<tr>
     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
     	<td><html:text property="<%=formFieldName%>" readonly="<%=readonly%>" styleClass="FormAreaDisable"/></td>
     	</tr>
		<%
		}
		else
		{
	%>
	<tr>
	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	<td nowrap>
	<html:text property="<%=formFieldName %>" styleId="<%=formFieldName %>" readonly="true" styleClass="FormAreaDisable"/>
	<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_<%=formFieldName %>" style="cursor: pointer; border: 0px solid red;" title="Date selector"
    onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
    <%if (clearDate){%>
    <img src="<%=themeDisplay.getPathThemeImage()+"/common/close.png"%>" id="f_<%=formFieldName %>" style="cursor: pointer; border: 0px solid red;" title="<%=LanguageUtil.get(pageContext,"clear") %>"
    onclick="var dateEl = document.getElementById('<%=formFieldName%>');if (dateEl != null) {dateEl.value=''};" />
    <%}%>

    <% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
    <% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
 	<td><html:errors property="<%=formFieldName%>"/></td>
    </tr>


<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%=formFieldName %>",     // id of the input field
        button         :    "f_<%=formFieldName %>",  // trigger for the calendar (button ID)
        align          :    "Br",           // alignment (defaults to "Bl")
		ifFormat    : "<%=fieldDateFormat%>",
		daFormat : "<%=fieldDateFormat%>",
		showsTime :true,
        singleClick    :    true,
        firstDay : "1"
    });
</script>


	<%	} }

	// Alternative HTML TextEditor (TinyMCE)
	if (formFieldType.equals("textareahtml")) {
		if (readonly) {
	%>
	<tr>
	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	<td><html:hidden property="<%=formFieldName%>"/>
		<DIV class="FormAreaDisable">
			<bean:write filter="false" name="<%= curFormName%>" property="<%=formFieldName%>"/>
			&nbsp;
		</DIV>
	</td></tr>
	<%
		}else{
	%>
	 <tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>

	     	<textarea alt="textarea" title="<%=formFieldName%>" name="<%=formFieldName%>" readonly="<%=readonly%>" cols="60" rows="15"  mce_editable="true">
		     	<bean:write name="<%= curFormName%>" property="<%=formFieldName%>"/>
	     	</textarea>

	     	<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
            <% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	 </tr>
	<%
		}
	}

	// Alternative HTML TextEditor (FCK Editor)
	if (formFieldType.equals("textareahtml_FCK")) {
		if (readonly) {
	%>
	<tr>
	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	<td><html:hidden property="<%=formFieldName%>"/>
		<DIV class="FormAreaDisable">
			<bean:write filter="false" name="<%= curFormName%>" property="<%=formFieldName%>"/>
			&nbsp;
		</DIV>
	</td></tr>
	<%
		}else{
		//String content = BeanParamUtil.getString(entry, request, "content");
		String content = "";
	%>
	 <logic:present name="<%=curFormName%>" property="<%=formFieldName%>">
     	<bean:define id="contentTmp" name ="<%=curFormName%>" property="<%=formFieldName%>" />
     	<% content = contentTmp.toString(); %>
	 </logic:present>

	 <tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<script type="text/javascript">
		     	function initEditor<%=formFieldName%>() {
				if (<%= JS_PREFIX %>_fck_fields)
				   <%= JS_PREFIX %>_fck_fields += ' document.<%=curFormName%>.<%=formFieldName%>.value=parent.<portlet:namespace /><%=formFieldName%>_editor.getHTML();'
				else
				   <%= JS_PREFIX %>_fck_fields = 'document.<%=curFormName%>.<%=formFieldName%>.value=parent.<portlet:namespace /><%=formFieldName%>_editor.getHTML();'
			     	document.<%=curFormName%>.onsubmit = <%= JS_PREFIX %>_fck_updateHiddenText;
			return "<%=UnicodeFormatter.toString(content)%>";


				}
	     	</script>
            <noscript>noscript enable</noscript>
			<html:hidden property="<%=formFieldName%>"/>
		<% if (field_size==com.ext.sql.StrutsFormFields.DEFAULT_FIELD_SIZE)
			{
				field_size=370; 
			}
			%>
	     	<iframe frameborder="0" height="500"
	     	        id="<portlet:namespace /><%=formFieldName%>_editor"
	     	        name="<portlet:namespace /><%=formFieldName%>_editor"
	     	        scrolling="no"
	     	        src="<%= themeDisplay.getPathJavaScript() %>/editor/editor.jsp?p_l_id=<%= plid %>&p_main_path=<%=themeDisplay.getPathMain()%>&editorImpl=fckeditor&initMethod=initEditor<%=formFieldName%>&toolbarSet=<%= form_field.getTextAreaToolBar() %>"
	     	        width="<%= field_size %>">
	     	</iframe>
	     	<%--bean:write name="<%= curFormName%>" property="<%=formFieldName%>"/--%>

	     	<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
            <% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	 </tr>
	<%
		}
	}


    // Plain text area (no editor)
	if (formFieldType.equals("textarea")) {
		if (hidden){%>
		   	<html:hidden property="<%=formFieldName%>"/>
		<%}else if (readonly) {
	%>
	<tr>
	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	<td>
		<DIV class="FormAreaDisable">
			<bean:write filter="false" name="<%= curFormName%>" property="<%=formFieldName%>"/>
			&nbsp;
		</DIV>
        
	</td></tr>
	<%
		}else{
	%>
	 <tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<textarea alt="textarea" title="<%=formFieldName%>" name="<%=formFieldName%>"  cols="50" rows="20"><bean:write name="<%= curFormName%>" property="<%=formFieldName%>"/></textarea>
	     	<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
            <% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	 </tr>
	<%
		}
	}

	//---------------------------------------------------
	// File upload
	// formFieldName
	//---------------------------------------------------
	if (formFieldType.equals("fileupload")) {

		String filePath = form_field.getUploadFilePath();
		String fileName = form_field.getFileName();
		if (Validator.isNotNull(fileName)){
		%>
			<tr>
		     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
				<td>
					<%--html:text property="imageFileName" readonly="true"/--%>
					<% if (Validator.isNotNull(filePath)) { %>
						<a target="_new" href="<%= filePath + fileName %>">
					<% } %>
					<%=fileName%>
					<% if (Validator.isNotNull(filePath)) { %>
						</a>
					<% } %>
					<% if (!readonly && form_field.isClearDate()) { %>
					&nbsp;&nbsp;<input alt="<%= LanguageUtil.get(pageContext, "bs.events.action.delete-file") %>" title="<%= LanguageUtil.get(pageContext, "bs.events.action.delete-file") %>" type="checkbox" name="<%= formFieldName %>_DELETE_FILE" value="true">
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" title="<%= LanguageUtil.get(pageContext, "bs.events.action.delete-file") %>" alt="<%= LanguageUtil.get(pageContext, "bs.events.action.delete-file") %>">
					<% } %>
					<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
				<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
	    	 	<td><html:errors property="<%=formFieldName%>"/></td>
			</tr>
			<tr>
				<td></td>
		     	<td>
	    	 		<input alt="<%=formFieldName%>" title="<%=formFieldName%>" type="file" name="<%=formFieldName%>" value="" <%=(readonly) ? " disabled" : " " %> >
		     	</td>
			 	<td></td>
			</tr>
		<%} else {%>
			<tr>
		     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
				<td><input alt="<%=formFieldName%>" title="<%=formFieldName%>" type="file"  name="<%=formFieldName%>" value="" <%=(readonly) ? " disabled" : " " %>/><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
                <% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
	    	 	<td><html:errors property="<%=formFieldName%>"/></td>
			</tr>
		<%}
	}%>

	<%
	//---------------------------------------------------
	// Image
	//---------------------------------------------------

	if (formFieldType.equals("image")) {
		String imgPath = form_field.getUploadFilePath(); //com.liferay.portal.util.PropsUtil.get("path.upload.images");
		String imgFileName = form_field.getFileName();
		%>
		<tr>
		   	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
			<td><img height="32" width="32" src='<%= "/"+imgPath + imgFileName%>' /><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
            <% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
	    	<td><html:errors property="<%=formFieldName%>"/></td>
		</tr>
	<%
	}
	//---------------------------------------------------


	// boolean
	//---------------------------------------------------
	if (formFieldType.equals("boolean")) {
		onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";
		if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
         else
     		{ %>
		<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td><html:checkbox property="<%=formFieldName%>" onchange="<%= onChange %>" disabled="<%=readonly%>" styleClass="<%= (readonly ? "FormAreaDisable" : "FormArea") %>"/><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
	     	<% if (readonly) { %>
	     	<html:hidden property="<%=formFieldName%>"/>
	     	<% } %>
	     	</td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
	     	<tr>
	 <% }
	}

	//---------------------------------------------------
	// Lookup
	//---------------------------------------------------
	if (formFieldType.equals("lookup") && form_field instanceof com.ext.sql.ActionLookupField) {
		com.ext.sql.ActionLookupField lookUpfield = (com.ext.sql.ActionLookupField)form_field;
		String lookUpActionUrl = lookUpfield.getLookupActionUrl();
		String lookupIdFieldName = lookUpfield.getLookUpIdFieldName();
		String portletName = lookUpfield.getPortletName();
		String ppid = request.getParameter("p_p_id");
		String portletNameAttr = (portletName != null && !portletName.equals("")) ? portletName: ppid;

		java.util.Hashtable actionParameters = lookUpfield.getLookupActionParameters();
		if (actionParameters == null)
			actionParameters = new java.util.Hashtable();
		actionParameters.put("openerFormName", curFormName);
		actionParameters.put("lookupFieldIdHtmlId", lookupIdFieldName);
		actionParameters.put("lookupFieldDisplHtmlId", formFieldName);
		%>

		<html:hidden property="<%=lookupIdFieldName%>"/>

		<%if (hidden)  { %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     	<%}  else { %>
	     	<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<table>
	     	<tr>
	     	<td>
	     	<% if (!readonly) { %>
	     		<html:text property="<%=formFieldName%>" styleClass="FormAreaDisable" readonly="true" size="<%= ""+field_size %>" />
	     	<% } else { %>
	     		<bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
	     	<% } %>
	     	</td>

     		<%if (!readonly) { %>
     		<td>
				<script>
					function <%=formFieldName%>_openActionModalLookupWin(){
						var url = '<liferay-portlet:actionURL portletName="<%=portletNameAttr%>" windowState="<%= LiferayWindowState.POP_UP.toString() %>"><liferay-portlet:param name="struts_action" value="<%= lookUpActionUrl %>"/>
						<% java.util.Enumeration keys = actionParameters.keys();
						   while (keys.hasMoreElements())
						   {
						   		String param_key = (String)keys.nextElement();
						   		String param_value = (String) actionParameters.get(param_key);
						   		%>
						   		<liferay-portlet:param name="<%= param_key %>" value="<%= param_value %>"/>
						   		<%
						   }
						 %>
						</liferay-portlet:actionURL>';
						openDialog(url, 450, 400);
					}
				</script>
				<noscript></noscript>

				<span id="<%= formFieldName%>_LOOKUP_SPAN_ID" onclick="<%=formFieldName%>_openActionModalLookupWin()">
					<IMG src="<%=  themeDisplay.getPathThemeImage() %>/common/search.png" alt="search" border="0"/>
				</span>
			    <% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
			<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
     		<%}//readOnly %>

	     	</tr>
	     	</table>
	     	</td>
	     	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
     	<%} // hidden%>
	<%} // END Action Modal  Lookup
	//---------------------------------------------------


	//---------------------------------------------------
	// PlainText
	//---------------------------------------------------
	if (formFieldType.equals("plain_text")) {
	field_size = (field_size == 0) ? 40 : field_size;
		%>
     	<html:hidden property="<%=formFieldName%>"/>
     	<%if (!hidden) {%>
	     	<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td width="<%=field_size%>"><bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
            <% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
   		<% }
		}
	//---------------------------------------------------


	//---------------------------------------------------
	// LinkText
	//---------------------------------------------------
	if (formFieldType.equals("link_text")) {

		if (form_field instanceof com.ext.sql.LinkStrutsField) {
			com.ext.sql.LinkStrutsField linkStrutsField = (com.ext.sql.LinkStrutsField)form_field;
			String portletName = linkStrutsField.getPortletName();
			javax.portlet.WindowState windState = linkStrutsField.getWindowState();
			String windStateStr =  (windState == null) ? javax.portlet.WindowState.NORMAL.toString() : windState.toString();
			String onclick = form_field.getOnClick();
			String linkActionUrl = ((com.ext.sql.LinkStrutsField)form_field).getLinkActionUrl();
			java.util.HashMap params = ((com.ext.sql.LinkStrutsField)form_field).getLinkActionParameters();

			if (params != null) pageContext.setAttribute("paramsName", params);

			//boolean hiddenFlag = ((com.ext.sql.LinkStrutsField)form_field).isHiddenIfNull();
		%>
		<logic:notEmpty name="<%=curFormName%>" property="<%=formFieldName%>" >
     	<html:hidden property="<%=formFieldName%>"/>

     	<% if (!hidden) {%>
	     	<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<%if (linkActionUrl != null){%>
	     	<%if (portletName == null) {%>
		     	<html:link page="<%= linkActionUrl %>" name="paramsName"><bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/></html:link>
		     <%}else{
		     java.util.Set keysSet = params.keySet();
		     java.util.Iterator keysIter = keysSet.iterator();
		     %>
		     <a href="<liferay-portlet:actionURL portletName="<%=portletName %>" windowState="<%= windStateStr%>">
			     <liferay-portlet:param name="struts_action" value="<%=linkActionUrl %>" />
			     <%while (keysIter.hasNext()){
			     String parKey = (String)keysIter.next();
			     String parValue = (String)params.get(parKey);
			     //System.out.println(">> \t "+parKey+"= "+parValue);
			     %>
			     <liferay-portlet:param name="<%=parKey %>" value="<%=parValue %>" />
			     <%} %>
		     </liferay-portlet:actionURL>">
		     <bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
		     </a>
	         <%} // else %>
		     <%}else if (onclick != null && !onclick.equals("")) {%>
			     <a href="" onclick="<%=onclick%>">
			     <bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
			     </a>
		     <%}%>
	     	</td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
   		<% } %>
   		</logic:notEmpty>
   		<%}
	}
	//---------------------------------------------------

	//---------------------------------------------------
	// Browse Topics (multiple selection)
	//---------------------------------------------------
	if (formFieldType.equals("browse_topics_many")) {
		if (hidden) { %>
			<html:hidden property="<%=formFieldName%>"/>
		<% } else { %>
			<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<html:hidden property="<%=formFieldName%>"/>
	     	<%--
	     	<logic:empty name="<%=curFormName%>" property="<%=formFieldName%>" >
		     	<bean:define name="<%=curFormName%>" property="<%=formFieldName%>" id="bean_Value" ignore="true"/>
		     	 <%
		     	 //todo: FIX: soumelidis: added to support auto topic selection when adding content from inside topic
		     	 if (Validator.isNotNull(ParamUtil.getString(request,"topicid"))) {
		     	 	String tid = ParamUtil.getString(request,"topicid");
		     	 	if (Validator.isNull(value))
		     	 		value = tid;
		     	 	else if (!(value.endsWith(tid) || value.indexOf(tid+",")>=0)) {
		     	 		value = (value.endsWith(",")? "" : ",") + tid;
		     	 	}
		     	 }
		     	 if (value != null)
		     	 {
		     	 	// value will contain comma separated list of ids
		     	 	GnPersistenceService serv = GnPersistenceService.getInstance(null);
		     	 	String[] topicIds = value.split(",");
		     	 	String[] topicNameField = {"langs.name"};
		     	 	String lang = gnomon.business.GeneralUtils.getLocale(request);
		     	 	String newValue = "";
		     	 	for (int v=0; v<topicIds.length; v++)
		     	 	{
		     	 		Integer topicId = Integer.valueOf(topicIds[v]);
		     	 		ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, topicId, lang, topicNameField);
		     	 		newValue += (String)topicView.getField1();
		     	 		if (v<topicIds.length-1)
		     	 			newValue += ", ";
		     	 	}
		     	 	value = newValue;
		     	 }
		     	 %>
	     	</logic:empty>
	     	--%>
	     	<logic:notEmpty name="<%=curFormName%>" property="<%=formFieldName%>" >
		     	<bean:define name="<%=curFormName%>" property="<%=formFieldName%>" id="bean_Value"/>
		     	<%
		     	 value = (String) bean_Value;
		     	 //end auto topic selection
		     	 if (value != null)
		     	 {
		     	 	// value will contain comma separated list of ids
		     	 	GnPersistenceService serv = GnPersistenceService.getInstance(null);
		     	 	String[] topicIds = value.split(",");
		     	 	String[] topicNameField = {"langs.name"};
		     	 	String lang = gnomon.business.GeneralUtils.getLocale(request);
		     	 	String newValue = "";
		     	 	for (int v=0; v<topicIds.length; v++)
		     	 	{
		     	 		Integer topicId = Integer.valueOf(topicIds[v]);
		     	 		ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, topicId, lang, topicNameField);
		     	 		newValue += (String)topicView.getField1();
		     	 		if (v<topicIds.length-1)
		     	 			newValue += ", ";
		     	 	}
		     	 	value = newValue;
		     	 }
		     	%>
	     	</logic:notEmpty>
	     	<textarea alt="textarea" title="<%=formFieldName%>" class="FormAreaDisable" id="<%=formFieldName+"_Names"%>" readonly="true" name="<%=formFieldName+"_Names"%>"><%= (value!= null? value : "") %></textarea><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
	     	<%
	     		PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
				String portletId = null;
				PortletPreferences prefs = null;
				if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs= req.getPreferences();
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs = req.getPreferences();
				}
    	   	    String lang = gnomon.business.GeneralUtils.getLocale(request);
    	   	    String portletTopicIds = "";
    	   	    // check first if the current portlet instance has a topic-id set
    	   	    String portletResource = ParamUtil.getString(request, "portletResource");
				if (Validator.isNotNull(portletResource)) {
				    prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
				}
				String topicFoldersAreSelectable = GetterUtil.getString(prefs.getValue("topic-folders-are-selectable", "yes"));
				String portletInstanceTopicId = prefs.getValue("topic-id", StringPool.BLANK);
				if (Validator.isNotNull(portletInstanceTopicId) && !portletInstanceTopicId.equals("0"))
				{
					portletTopicIds = portletInstanceTopicId;
				}
				else // otherwise use the portlet topics set for this portlet
    	   	    {
	    	   		List<ViewResult> portletTopics = PermissionsService.getInstance().listPortletTopics(PortalUtil.getCompanyId(request),portletId, lang);
	    	   		for (int t=0; t<portletTopics.size(); t++)
	    	   		{
	    	   			portletTopicIds += ((ViewResult)portletTopics.get(t)).getField1();
	    	   			if (t<portletTopics.size()-1)
	    	   				portletTopicIds += ",";
	    	   		}
    	   		}
    	   	%>
    	   	<% if (!readonly) { %>
	     	<a href="#" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?managetopics=<%=managetopicids%>&multiSelection=true&openerFormName=<%=curFormName%>&openerFormFieldName=<%=formFieldName%>&rootTopicIds=<%=portletTopicIds%>&topicFoldersAreSelectable=<%=topicFoldersAreSelectable %>', 400,350);"><img src="/html/themes/classic/images/arrows/02_plus.gif" alt="<%= LanguageUtil.get(pageContext,"gn.topics.browser.add") %>"></a>
	     	&nbsp;<a href="#" onClick="if (document.<%=curFormName%>.elements['<%= formFieldName %>'].value != null && document.<%=curFormName%>.elements['<%= formFieldName %>'].value != '') { openDialog('/html/portlet/ext/struts_includes/topics/deleteTopics.jsp?openerFormName=<%=curFormName%>&openerFormFieldName=<%=formFieldName%>&topicIds='+document.<%=curFormName%>.elements['<%= formFieldName %>'].value, 400,350); } else { return true; } "><img src="/html/themes/classic/images/arrows/02_minus.gif" alt="<%= LanguageUtil.get(pageContext,"gn.topics.browser.delete") %>"></a>
	     	<% } %>
	     	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
            </td>
	     	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
   		<% }
   		}


   	//---------------------------------------------------
	// Browse Topics (single selection)
	//---------------------------------------------------
	if (formFieldType.equals("browse_topics_one")) {
		if (hidden) { %>
			<html:hidden property="<%=formFieldName%>"/>
		<% } else { %>
			<tr>
	     	<td width="30%"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<html:hidden property="<%=formFieldName%>"/>
	     	<logic:notEmpty name="<%=curFormName%>" property="<%=formFieldName%>" >
		     	<bean:define name="<%=curFormName%>" property="<%=formFieldName%>" id="bean_Value"/>
		     	<%
		     	 value = (String) bean_Value;
		     	 if (value != null)
		     	 {
		     	 	// value will be topicid
		     	 	GnPersistenceService serv = GnPersistenceService.getInstance(null);
		     	 	String[] topicNameField = {"langs.name"};
		     	 	String lang = gnomon.business.GeneralUtils.getLocale(request);
		     	 	String newValue = "";
		     	 	Integer topicId = Integer.valueOf(value);
		     	 	ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, topicId, lang, topicNameField);
		     	 	newValue = ((topicView==null || topicView.getField1()==null)? "" : (String)topicView.getField1());
		     	 	value = newValue;
		     	 }
		     	%>
	     	</logic:notEmpty>
	     	<input alt="<%=formFieldName%>" title="<%=formFieldName%>" type="text" class="FormAreaDisable" id="<%=formFieldName+"_Names"%>" readonly="true" name="<%=formFieldName+"_Names"%>" value="<%= (value!= null? value : "") %>"><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>&nbsp;
	     	<%
	     		PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
				String portletId = null;
				PortletPreferences prefs = null;
				if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs= req.getPreferences();
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					portletId = req.getPortletName();
					prefs = req.getPreferences();
				}
    	   	    String lang = gnomon.business.GeneralUtils.getLocale(request);
    	   	    String portletTopicIds = "";
    	   	    // check first if the current portlet instance has a topic-id set
    	   	    String portletResource = ParamUtil.getString(request, "portletResource");
				if (Validator.isNotNull(portletResource)) {
				    prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
				}
				String topicFoldersAreSelectable = GetterUtil.getString(prefs.getValue("topic-folders-are-selectable", "yes"));
				String portletInstanceTopicId = prefs.getValue("topic-id", StringPool.BLANK);
				if (portletInstanceTopicId != null && !portletInstanceTopicId.equals(""))
				{
					portletTopicIds = portletInstanceTopicId;
				}
				else // otherwise use the portlet topics set for this portlet
    	   	    {
	    	   		List<ViewResult> portletTopics = PermissionsService.getInstance().listPortletTopics(PortalUtil.getCompanyId(request), portletId, lang);
	    	   		for (int t=0; t<portletTopics.size(); t++)
	    	   		{
	    	   			portletTopicIds += ((ViewResult)portletTopics.get(t)).getField1();
	    	   			if (t<portletTopics.size()-1)
	    	   				portletTopicIds += ",";
	    	   		}
    	   		}
    	   	%>
    	   	<% if (!readonly) { %>
	     	<a href="#" class="beta1" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?managetopics=<%=managetopicids%>&multiSelection=false&openerFormName=<%=curFormName%>&openerFormFieldName=<%=formFieldName%>&rootTopicIds=<%=portletTopicIds%>&topicFoldersAreSelectable=<%=topicFoldersAreSelectable %>', 400,350);"><%= LanguageUtil.get(pageContext,"gn.button.choose") %></a>
	     	&nbsp;<a href="#" class="beta1" onClick="document.<%=curFormName%>.elements['<%= formFieldName %>'].value='';document.<%=curFormName%>.elements['<%= formFieldName +"_Names"%>'].value='';"><%= LanguageUtil.get(pageContext,"gn.button.clear") %></a>
	     	<% } %>
	     	</td>
	     	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
   		<% }
   		}
   		
   		   		
   		 if (formFieldType.equals("radio"))
	 {

	 	if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
         else
     		{
		onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";

	 	%>
	 <tr>
	     	<td colspan="2"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span>
	     		<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
     </tr>
	 <% if (optionLabels !=null && optionValues!=null) {
	 		for(int optionIndex=0; optionIndex<optionValues.length; optionIndex++) {%>
	     	<tr><td>&nbsp;&nbsp;<html:radio property="<%=formFieldName%>"  value="<%=optionValues[optionIndex]%>" onchange="<%= onChange %>" disabled="<%=readonly%>" styleClass="<%= (readonly ? "FormAreaDisable" : "FormArea") %>"/>
	     	<%=LanguageUtil.get(pageContext,optionLabels[optionIndex])%></td></tr>
	     
	    <%}
	  }%>
	  

	 <% } // end if hidden
	 } // end if "radio"
	 
	 
	 
	 
	 		 if (formFieldType.equals("checkbox"))
	 {

	 	if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
         else
     		{
		onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";

	 	%>
	 <tr>
	     	<td colspan="2"><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span>
	     		<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
     
	     	</tr>
	 <% if (optionLabels !=null && optionValues!=null) {
	 		for(int optionIndex=0; optionIndex<optionValues.length; optionIndex++) {
	 			String checkedbox="";
	 			if(selectedOptionValues!=null) {
	 				for (int j=0; j<selectedOptionValues.length; j++) {
	 					if(optionValues[optionIndex].equals(selectedOptionValues[j])) {
	 						checkedbox="checked";
	 						break;	
	 					}
	 				}
	 			}
	 			%>
	     		<tr><td colspan="2">&nbsp;&nbsp;
	     		<input alt="<%=formFieldName%>" type="checkbox" name="<%=formFieldName%>"  value="<%=optionValues[optionIndex]%>" onchange="<%= onChange %>"  <%if(readonly==true){%>disabled<%}%> class="<%= (readonly ? "FormAreaDisable" : "FormArea") %>"  <%=checkedbox%> /> 
	     	<%=LanguageUtil.get(pageContext,optionLabels[optionIndex])%></td></tr>
	     
	    <%}
	  } %>
	  
	     

	 <% } // end if hidden
	 } // end if "checkbox"

   	}
// end big for loop
}
if (previous_fieldset) {
%>
</table></div></td></tr>
<% } %>

<% if (no_table_flag == null || no_table_flag.equals("")) { %>

</table>

<% } %>


<% } catch (Exception e) { e.printStackTrace(); } %>
