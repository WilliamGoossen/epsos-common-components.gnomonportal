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


  if (formFieldType.equals("image")) {
	String imgWidth = form_field.getImgWidth();
	String imgHeight = form_field.getImgHeight();
		
  	if (form_field.isDynamicField()) {
  		String imgPath = form_field.getUploadFilePath(); //com.liferay.portal.util.PropsUtil.get("path.upload.images");
		String imgFileName = form_field.getImageFileName();

		if (hidden)
	     	{ %>
    	 	<input alt=" " type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}  else {
	%>
		<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
			<img src="<%= imgPath + imgFileName%>" />
			<% if (required) { %><em>*</em><% } %>
			<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		   <% } %>
		  <html:errors property="<%=formFieldName%>"/>
		</div>
	<% }
  	
  	} else {
  		String imgPath = form_field.getUploadFilePath(); //com.liferay.portal.util.PropsUtil.get("path.upload.images");
		String imgFileName = form_field.getFileName();
		%>
		<div class="ctrl-holder">
		<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
			<img alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" <%=(Validator.isNotNull(imgWidth)) ? " width=\""+imgWidth+"\"" : "" %>  <%=(Validator.isNotNull(imgHeight)) ? " height=\""+imgHeight+"\"" : "" %> src="<%= imgPath + imgFileName%>" /><% if (required) { %><em>*</em><% } %>
	    <% if (helpMessage != null) { %>
			<liferay-ui:icon-help message="<%= helpMessage %>" />
	    <% } %>
	    <html:errors property="<%=formFieldName%>"/>
		</div>
	<% }
	}
	
} catch (Exception e) { e.printStackTrace(); } %>
