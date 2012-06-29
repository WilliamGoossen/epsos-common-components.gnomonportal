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
	String curFormName = (String)request.getAttribute(namespace+"_STRUTS_DIV_curFormName");
	String JS_PREFIX = (String)request.getAttribute(namespace+"_STRUTS_DIV_JS_PREFIX");
	
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



  if (formFieldType.equals("textareahtml_FCK") || formFieldType.equals("textareahtml")) {
  	
  if (form_field.isDynamicField()) {
  		Object fieldValue = "";
	   	if (value != null) fieldValue = value;
		
			if (readonly) { %>
			<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				<DIV <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> >
					<%= fieldValue%>
					&nbsp;
				</DIV>
				<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
			</div>
		<%
			}else{
		%>
	 <div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<script type="text/javascript">
		     	function initEditor<%=formFieldName%>() {
				if (<%= JS_PREFIX %>_dynfck_fields)
				   <%= JS_PREFIX %>_dynfck_fields += ' document.<%=curFormName%>.<%=formFieldName%>.value=parent.<portlet:namespace /><%=formFieldName%>_editor.getHTML();'
				else
				   <%= JS_PREFIX %>_dynfck_fields = 'document.<%=curFormName%>.<%=formFieldName%>.value=parent.<portlet:namespace /><%=formFieldName%>_editor.getHTML();'
			     	document.<%=curFormName%>.onsubmit = <%= JS_PREFIX %>_dynfck_updateHiddenText;
				return "<%=UnicodeFormatter.toString(fieldValue.toString())%>";
				}
	     	</script>
			<input type="hidden" name="<%=formFieldName%>" value="<%= fieldValue %>"/>
	     	<iframe frameborder="0" height="<%= ""+(textAreaRows*40)%>"
	     	        id="<portlet:namespace /><%=formFieldName%>_editor"
	     	        name="<portlet:namespace /><%=formFieldName%>_editor"
	     	        scrolling="no"
	     	        src="<%= themeDisplay.getPathJavaScript() %>/editor/editor.jsp?p_l_id=<%= plid %>&editorImpl=fckeditor&initMethod=initEditor<%=formFieldName%>&toolbarSet=<%= form_field.getTextAreaToolBar() %>"
	     	        width="<%= ""+(textAreaCols*8)%>">
	     	</iframe>
	     	<% if (required) { %><em>*</em><% } %>
	     	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
	     <html:errors property="<%=formFieldName%>"/>
	     </div>
	<%
		}
  	
  	
  	
  } else { 
  	
  	
	if (readonly) {
	%>
	<div class="ctrl-holder">
	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>

		<DIV>
			<bean:write filter="false" name="<%= curFormName%>" property="<%=formFieldName%>"/>
			&nbsp;
		</DIV>
		<% if (helpMessage != null) { %>
		<liferay-ui:icon-help message="<%= helpMessage %>" />
    <% } %>
	</div>
	<%
		} else {
		//String content = BeanParamUtil.getString(entry, request, "content");
		String content = "";
	%>
	 <logic:present name="<%=curFormName%>" property="<%=formFieldName%>">
     	<bean:define id="contentTmp" name ="<%=curFormName%>" property="<%=formFieldName%>" />
     	<% content = contentTmp.toString(); %>
	 </logic:present>
	<div class="ctrl-holder">
	 <label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>

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
			<html:hidden property="<%=formFieldName%>"/>
	     	<iframe frameborder="0" height="<%= ""+(textAreaRows*40)%>"
	     	        id="<portlet:namespace /><%=formFieldName%>_editor"
	     	        name="<portlet:namespace /><%=formFieldName%>_editor"
	     	        scrolling="no"
	     	        src="<%= themeDisplay.getPathJavaScript() %>/editor/editor.jsp?p_l_id=<%= plid %>&p_main_path=<%=themeDisplay.getPathMain()%>&editorImpl=fckeditor&initMethod=initEditor<%=formFieldName%>&toolbarSet=<%= form_field.getTextAreaToolBar() %>"
	     	        width="<%= ""+(textAreaCols*8)%>">
	     	</iframe>
	     	<%--bean:write name="<%= curFormName%>" property="<%=formFieldName%>"/--%>

	     	<% if (required) { %><em>*</em><% } %>
	     	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
    	 	<html:errors property="<%=formFieldName%>"/>
	 </div>
	<%   }
		}
	}
	
} catch (Exception e) { e.printStackTrace(); } %>
