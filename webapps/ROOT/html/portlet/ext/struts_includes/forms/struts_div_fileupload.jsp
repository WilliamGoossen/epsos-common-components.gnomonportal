<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>


<% try {
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();

	String formFieldName;
	String formFieldKey;
	boolean required;
	String formFieldType;
	String value = null;
	String fieldDateFormat="";
	boolean hidden;
	boolean readonly;
	String collectionName;
	String collectionAttrName;
	String collectionProperty;
	String collectionLabel;
	int field_size;
	int textAreaCols;
	int textAreaRows;
	int popupWidth;
	int popupHeight;
	String helpMessage = null;
	com.ext.sql.StrutsFormFields form_field;

	boolean textAreaHtmlFlag = false;
	String onChange = "";
	String lookupAction = "";
	boolean previous_fieldset = false;
	boolean secretField = false;

	form_field = (com.ext.sql.StrutsFormFields) request.getAttribute(namespace+"_STRUTS_DIV_FIELD");
	
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
	field_size = form_field.getField_size();
	textAreaCols = form_field.getTextAreaCols();
	textAreaRows = form_field.getTextAreaRows();
	popupWidth = form_field.getPopupWidth();
	popupHeight = form_field.getPopupHeight();
	secretField = form_field.isSecretTextField();
	helpMessage = form_field.getHelpMessage();
	String colour = null;
	String bgcolour = null;
	value = form_field.getValue();
	if (Validator.isNull(value) && Validator.isNotNull(request.getParameter(formFieldName))) 
		value = request.getParameter(formFieldName);
	colour = form_field.getColour();
	bgcolour = colour;
	if (colour != null && colour.equals("inherit"))
		bgcolour = null;
	// force span colour to always be the default
	colour = "inherit";



  if (formFieldType.equals("fileupload")) {

	if (form_field.isDynamicField()) {

		String filePath = form_field.getUploadFilePath();
		String fileValue = value;
		if (Validator.isNotNull(fileValue)){
			%>
			<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				<input <% if (bgcolour != null) { %> alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" style="background-color:<%= bgcolour %>" <% } %> type="text" name="<%=fileValue%>"  readonly="true" value="<%= (value!= null? value : "") %>">
			</div>
			<div class="ctrl-holder">	
				<label for="<%=formFieldName%>"></label>
			  <input <% if (bgcolour != null) { %> alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" style="background-color:<%= bgcolour %>" <% } %> type="file" name="<%=formFieldName%>" value="" />
				<% if (required) { %><em>*</em><% } %>
				<% if (helpMessage != null) { %>
						<liferay-ui:icon-help message="<%= helpMessage %>" />
			  <% } %>
			  <html:errors property="<%=formFieldName%>"/>
			</div>
		<% } else { %>
			<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				<input <% if (bgcolour != null) { %> alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" style="background-color:<%= bgcolour %>" <% } %> type="file" id="<%=formFieldName%>" name="<%=formFieldName%>" value="" />
				<% if (required) { %><em>*</em><% } %>
				<% if (helpMessage != null) { %>
						<liferay-ui:icon-help message="<%= helpMessage %>" />
			   <% } %>
			  <html:errors property="<%=formFieldName%>"/>
			</div>
	  <% }		

	} else {
				
		String filePath = form_field.getUploadFilePath();
		String fileName = form_field.getFileName();
		if (Validator.isNotNull(fileName)){
		%>
		<div class="ctrl-holder">
			<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
					<%--html:text property="imageFileName" readonly="true"/--%>
					
					<%=fileName%>
					<% if (!readonly && form_field.isClearDate()) { %>
					&nbsp;&nbsp;<input title="<%= LanguageUtil.get(pageContext, "bs.events.action.delete-file") %>" type="checkbox" name="<%= formFieldName %>_DELETE_FILE" value="true">
					<img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" title="<%= LanguageUtil.get(pageContext, "bs.events.action.delete-file") %>" alt="<%= LanguageUtil.get(pageContext, "bs.events.action.delete-file") %>">
					<% } %>
					<% if (required) { %><em>*</em><% } %>
					<% if (helpMessage != null) { %>
							<liferay-ui:icon-help message="<%= helpMessage %>" />
				   <% } %>
	    	<html:errors property="<%=formFieldName%>"/>
		</div>
		<% if (! readonly) { %>
		<div class="ctrl-holder">	
			<label for="<%=formFieldName%>"></label>
	    	<input title="<%=formFieldName%>" type="file" name="<%=formFieldName%>" value="" <%=(readonly) ? " disabled" : " " %> >
	    </div>
	    <% } %>
		<%} else {%>
		<div class="ctrl-holder">
			<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
			<% if (! readonly) { %>
				<input title="<%=formFieldName%>" type="file"  name="<%=formFieldName%>" value="" <%=(readonly) ? " disabled" : " " %>/><% if (required) { %><em>*</em><% } %>
				<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
	    	<html:errors property="<%=formFieldName%>"/>
	    	<% } %>
	    </div>
		<%}
		}
	}
	
} catch (Exception e) { e.printStackTrace(); } %>
