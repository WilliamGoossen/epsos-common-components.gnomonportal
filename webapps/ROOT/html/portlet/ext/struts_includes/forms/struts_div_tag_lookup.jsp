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
	String colour = null;
	String bgcolour = null;

	form_field = (com.ext.sql.StrutsFormFields) request.getAttribute(namespace+"_STRUTS_DIV_FIELD");
	String curFormName = (String)request.getAttribute(namespace+"_STRUTS_DIV_curFormName");
	
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
	value = form_field.getValue();
	colour = form_field.getColour();
	bgcolour = colour;
	if (colour != null && colour.equals("inherit"))
		bgcolour = null;
	// force span colour to always be the default
	colour = "inherit";

  if (formFieldType.equals("tag_lookup"))
 	{
 		 	if (form_field.isDynamicField()) {
 		 		if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else
     		{ %>
	     	<div class="ctrl-holder">
				<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<% if (readonly) { %>
        <span style="color:<%= colour %>" ><%= (value!= null? value : "") %></span>
	     	<% } else { %>
	     			<input name="<%=formFieldName%>_tagEntries" id="<%=formFieldName%>_tagEntries" type="hidden">
            <input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %>
                   id="<%=formFieldName%>" type="text" size="<%= ""+field_size %>" 
                   name="<%=formFieldName%>" value="" autocomplete="off" >
            <% if (required) { %><em>*</em><% } %>
            <span id="<%=formFieldName%>_tagSummary"></span>
                    
            <script type="text/javascript">
                  var <%=formFieldName%>_ = null;
                  var GN_KMS_MetaTagsSelector_<%=formFieldName%>_tagGroup = "<%= form_field.getUploadFilePath() %>";
                  jQuery(
                  function() {
                  <%=formFieldName%>_ = new Liferay.GN_KMS_MetaTagsSelector(
                  {
                  instanceVar: "<%=formFieldName%>_",
                  hiddenInput: "<%=formFieldName%>_tagEntries",
                  textInput: "<%=formFieldName%>",
                  summarySpan: "<%=formFieldName%>_tagSummary",
                  curTags: "<%= (value!= null? value : "") %>",
                  focus: false
                  }
                  );
                  }
                  );
             </script>
	     	<% } %>
	     	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
    	 <html:errors property="<%=formFieldName%>"/>
	     	</div>
        <% }
 		 	
			}
			else 
			{
    		if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
         else
     		{ %>
	     	<div class="ctrl-holder">
				<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<% if (readonly) { %>
        <span style="color:<%= colour %>" ><bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/></span>
	     	<% } else { %>
	     			<input name="<%=formFieldName%>_tagEntries" id="<%=formFieldName%>_tagEntries" type="hidden">
            <input id="<%=formFieldName%>" type="text" size="<%= ""+field_size %>" 
                   name="<%=formFieldName%>" value="" autocomplete="off" >
            <% if (required) { %><em>*</em><% } %>
            <span id="<%=formFieldName%>_tagSummary"></span>
                    
            <script type="text/javascript">
                  var <%=formFieldName%>_ = null;
                  var GN_KMS_MetaTagsLookupSelector_<%=formFieldName%>_table = "<%= form_field.getUploadFilePath() %>";
                  jQuery(
                  function() {
                  <%=formFieldName%>_ = new Liferay.GN_KMS_MetaTagsLookupSelector(
                  {
                  instanceVar: "<%=formFieldName%>_",
                  hiddenInput: "<%=formFieldName%>_tagEntries",
                  textInput: "<%=formFieldName%>",
                  summarySpan: "<%=formFieldName%>_tagSummary",
                  curTags: "<logic:notEmpty name="<%=curFormName%>" property="<%=formFieldName%>"><bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/></logic:notEmpty><logic:empty name="<%=curFormName%>" property="<%=formFieldName%>"><%= (Validator.isNotNull(request.getParameter(formFieldName+"_tagEntries")) ? request.getParameter(formFieldName+"_tagEntries") : "" )%></logic:empty>",
                  focus: false
                  }
                  );
                  }
                  );
             </script>
	     	<% } %>
	     	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
    	 <html:errors property="<%=formFieldName%>"/>
	     	</div>
        <% }
    	}
	}
	
} catch (Exception e) { e.printStackTrace(); } %>
