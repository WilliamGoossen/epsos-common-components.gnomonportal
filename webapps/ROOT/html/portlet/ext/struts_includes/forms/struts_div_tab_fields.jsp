<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>

<%@ page import="java.util.Vector" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.sql.StrutsFormFieldsGroupDelimiter" %>
<%@ page import="com.ext.sql.StrutsFormFieldsTabDelimiter" %>



<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="curFormNameAttribute" name="formName" classname="java.lang.String" />
<tiles:useAttribute id="tabNames" name="tabNames" classname="java.lang.String" ignore="true" />
	

<% try {
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();
	String JS_PREFIX = (tileAttribute != null ? tileAttribute : "");
	request.setAttribute(namespace+"_STRUTS_DIV_JS_PREFIX", JS_PREFIX);

%>


<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script><noscript></noscript>

<%
	String curFormName = curFormNameAttribute;
	request.setAttribute(namespace+"_STRUTS_DIV_curFormName", curFormName);

	Vector _struts_fields = null;
	if (tileAttribute != null)
		_struts_fields = (Vector)request.getAttribute(tileAttribute);
	else
	{
		_struts_fields = (Vector)request.getAttribute(namespace+CommonDefs.ATTR_FORM_FIELDS);
		if (_struts_fields == null) {
			_struts_fields = (Vector)request.getAttribute(CommonDefs.ATTR_FORM_FIELDS);
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
	boolean secretField = false;
	
	boolean previous_fieldset = false;

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

<div class="inline-labels">
	
<liferay-ui:tabs names="<%= tabNames %>" param="tab" refresh="false">
 <%
		 String name = tabNames.substring(0, tabNames.indexOf(","));
 %>
	<div id="<%= namespace + "tab" + name %>TabsSection" style="display: none;">
<%
for (int index=0; _struts_fields != null && index < _struts_fields.size(); index ++) {
	form_field = (StrutsFormFields) _struts_fields.get(index);
	
	if (form_field instanceof StrutsFormFieldsTabDelimiter)
	{
		 if (index > 0) {
		 %>
			 </div>
		<% 
			 String _name = ((StrutsFormFieldsTabDelimiter)form_field).getTabNameKey();
			 previous_fieldset = false;
			 %>
				<div id="<%= namespace + "tab" + _name %>TabsSection" style="display: none;">
			<% 	}
	}
	else if (form_field instanceof StrutsFormFieldsGroupDelimiter)
	{
		if (index > 0 && previous_fieldset) { %>
		
				</fieldset>

				<fieldset class="<%= form_field.getColumn() != null? form_field.getColumn() : "inline-labels" %>">
					<legend>
					<%=LanguageUtil.get(pageContext, ((StrutsFormFieldsGroupDelimiter)form_field).getGroupNameKey())%>
				</legend>
		
			<% } else { %>
		
				<fieldset class="<%= form_field.getColumn() != null? form_field.getColumn() : "inline-labels" %>">
					<legend>
					<%=LanguageUtil.get(pageContext, ((StrutsFormFieldsGroupDelimiter)form_field).getGroupNameKey())%>
				</legend>
		
			<% } %>
			
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
	field_size = form_field.getField_size();
	textAreaCols = form_field.getTextAreaCols();
	textAreaRows = form_field.getTextAreaRows();
	popupWidth = form_field.getPopupWidth();
	popupHeight = form_field.getPopupHeight();
	secretField = form_field.isSecretTextField();
	helpMessage = form_field.getHelpMessage();



	 if (formFieldType.equals("select"))
	 {
			request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
     	%>
     	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_select.jsp" flush="true"/>
     	<% 
	 }

   else if (formFieldType.equals("text"))
   {
     	request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
     	%>
     	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_text.jsp" flush="true"/>
     	<% 
	 }


	else if (formFieldType.equals("date"))
	{
     	request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
     	%>
     	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_date.jsp" flush="true"/>
     	<% 
	}

	
	else if (formFieldType.equals("textareahtml_FCK") || formFieldType.equals("textareahtml")) {
			request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
     	%>
     	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_textareahtml.jsp" flush="true"/>
     	<% 
	}


    // Plain text area (no editor)
	else if (formFieldType.equals("textarea")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_textarea.jsp" flush="true"/>
   	<% 
	}

	
	else if (formFieldType.equals("fileupload")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_fileupload.jsp" flush="true"/>
   	<% 
	} 
		
	else if (formFieldType.equals("image")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_image.jsp" flush="true"/>
   	<% 
	}
	
	else if (formFieldType.equals("boolean")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_boolean.jsp" flush="true"/>
   	<% 
	}
	
	else if (formFieldType.equals("radio")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_radio.jsp" flush="true"/>
   	<% 
	}
	
	else if (formFieldType.equals("checkbox")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_checkbox.jsp" flush="true"/>
   	<% 
	}

	else if (formFieldType.equals("lookup") && form_field instanceof com.ext.sql.ActionLookupField) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_lookup.jsp" flush="true"/>
   	<% 
  } 
	
	
	else if (formFieldType.equals("plain_text")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_plain_text.jsp" flush="true"/>
   	<% 
	}
	
	
	else if (formFieldType.equals("link_text")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_link_text.jsp" flush="true"/>
   	<%
	}
	
	
	else if (formFieldType.equals("browse_topics_many") || formFieldType.equals("browse_topics_one")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
   	%>
   	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_topics.jsp" flush="true"/>
   	<%
	}
	
	else if (formFieldType.equals("tag_lookup")) {
    request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
    %>
    <jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_tag_lookup.jsp" flush="true"/>
    <% 
	}
   
 }
// end big for loop
}

if (previous_fieldset) {
%>
</fieldset>

<% } %>

</div>
</liferay-ui:tabs>

</div>

<% } catch (Exception e) { e.printStackTrace(); } %>
