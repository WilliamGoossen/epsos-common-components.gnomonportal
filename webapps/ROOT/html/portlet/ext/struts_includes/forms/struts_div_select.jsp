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
	java.util.List optionValues;
	java.util.List optionNames;
	java.util.List optionHasChildren;
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
	optionNames =form_field.getOptionLabels();
	optionValues =form_field.getOptionValues();
	optionHasChildren =form_field.getOptionHasChildren();



  if (formFieldType.equals("select"))
	 {
	 	
	 	if (form_field.isDynamicField()) {
	 		
	 		%>
	 <script type="text/javascript">
	        <% if (value != null && !value.equals("")) { %>
	        <%=curFormName%>_selectLists[<%=curFormName%>_selectLists.length]=('<%= formFieldName %>');
	        <% } %>
	        
		     	function <%=formFieldName%>_selectLeafOnlyOptions(selectEl) {
		     		var showAlert = false;
			     	if (selectEl != null) {
			     		var isMultySelect = selectEl.multiple;
			     		var selInd = selectEl.selectedIndex;
			     		if (isMultySelect){
			     			for (var i = 0; i < selectEl.options.length; i++){
			     				var optEl = selectEl.options[i];

			     				if (optEl.selected && optEl.attributes.optHasChildren.value == 'true') {
				     				showAlert = true;
				     				optEl.selected = false;
				     				break;
			     				}
			     			}
			     		}else{
							if (selectEl.options[selInd].attributes.optHasChildren.value == 'true'){
								showAlert = true;
								selectEl.options[selInd].selected = false;
							}
						}
					}
					if (showAlert) {
						<%{String tmpAlertLabel = LanguageUtil.get(pageContext, "metadata.fields.select.alertMessage.select_only_leaf_options"); %>
						alert('<%=tmpAlertLabel%>');
						<%}%>
					}
				}
	     	</script><noscript></noscript>
	 <%
			String extraStyle = "";
			value = (value == null) ? "" : value;
			String[] valuesArr = value.split(",");
			boolean isMultySelect =  (form_field.getMultipleSelection()>0);
			boolean selectOnlyLeaves = form_field.isSelectOnlyLeaves();

			if (valuesArr != null) java.util.Arrays.sort(valuesArr);

			if (bgcolour != null) {
				extraStyle += "background-color: "+ bgcolour +";";
			}
			onChange = (onChange == null) ? "" : onChange;
			if (selectOnlyLeaves){
				onChange = formFieldName+"_selectLeafOnlyOptions(this);"+onChange;
			}
			
			onChange += "return _top_updateOptionsFor('"+ curFormName + "', this.name, this.options[this.selectedIndex].value);";
	 	if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else
     		{ %>
	 			<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<% if(isMultySelect){%>
	     	<%= form_field.getLabelForMultipleSelection()%><BR>
	     	<% }
	     	if (readonly) { %>
	     	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
	     	
	     	
     	<% if (optionNames != null && optionValues != null && !isMultySelect) {
     		String selectedValues = "";
	     	  for (int k=0; k<optionValues.size(); k++) {
	     	  	if (value != null && value.equals(optionValues.get(k))) {
		     	  		selectedValues =LanguageUtil.get(pageContext, optionNames.get(k)+"") ;
	    	 	  	}
	     	  }
	     	  %>
	     	  <%= selectedValues %>
	     	<% } %>
	     	<%} else {
	     		if (isMultySelect) { %>
	     		<select style="<%= extraStyle %>" name="<%=formFieldName%>" onChange="<%= onChange%>" size="<%= String.valueOf(form_field.getMultipleSelection())%>" multiple="true" >
	     	<% } else { %>
	     	<select style="<%= extraStyle %>" name="<%=formFieldName%>" onChange="<%= onChange%>" >
	     	<% }
	     	} %>
	     	
	     	
	     	
	     	<% if (!readonly) { %>
	     	<% if (optionNames != null && optionValues != null && (!readonly || !isMultySelect)) {
	     	  for (int k=0; k<optionValues.size(); k++) {
	     	  	boolean selected = false;
	     	  	String optHasChildren = (optionHasChildren != null && optionHasChildren.size() > k) ? optionHasChildren.get(k)+"" : "false";
	     	  	if (value != null){
	     	  		if (isMultySelect && valuesArr != null){
	     	  			selected = (java.util.Arrays.binarySearch(valuesArr, optionValues.get(k)) >= 0);
		     	  	}else {
			     	  	selected = value.equals(optionValues.get(k));
	    	 	  	}
	     	  	}
	     	  %>
	     			<option <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> value="<%=optionValues.get(k)%>"  <% if( selected  ){%> selected="selected" <%} %> optHasChildren="<%=optHasChildren%>"><%= LanguageUtil.get(pageContext, optionNames.get(k)+"") %></option>
				<% } %>
			<% } %>
	     	</select>
	     	<% } %>
	     	
	     	<% if (!readonly && required) { %><em>*</em><% } %>
	     	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
        <html:errors property="<%=formFieldName%>"/>
      </div>

	 <% }  // end if hidden
	 		
	 		
	 		
	 		
	 	} else {
	 		
	 		
	 	if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
         else
     		{
		onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";

	 	%>
	 	<div class="ctrl-holder">
	     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	   
	     	<% if (form_field.getMultipleSelection()>0) { %>
			<html:select alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" property="<%=formFieldName%>" onchange="<%= onChange%>" disabled="<%=readonly%>"  size="<%= String.valueOf(form_field.getMultipleSelection())%>" multiple="true">
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
	     	<% if (collectionName != null || collectionAttrName != null || !readonly) {  %>
	     	<html:select alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" property="<%=formFieldName%>" onchange="<%= onChange%>" disabled="<%=readonly%>" >
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
	     	
	     	<% } else  {  // readonly case for collectionProperty 
	     		try { %>
			     	<bean:define id="select_values" name="<%= curFormName %>" property="<%=collectionProperty%>"/>
			     	<bean:define id="select_labels" name="<%= curFormName %>" property="<%=collectionLabel%>"/>
			     	<bean:define id="select_id" name="<%= curFormName %>" property="<%=formFieldName%>" />
			     	<% 
			     	if (Validator.isNotNull(select_values) && Validator.isNotNull(select_labels) && Validator.isNotNull(select_id)) { 
				     	String[] selectValues = (String[])select_values;
				     	String[] selectLabels = (String[])select_labels;
		     	String selectId = select_id != null? select_id.toString() : "";
				     	if (selectValues != null && selectValues.length > 0 && Validator.isNotNull(selectId)) {
				     		List<String> selectList = Arrays.asList(selectValues);
				     		int valueIndex = selectList.indexOf(selectId);
				     		if (valueIndex >= 0 && valueIndex < selectLabels.length) {
				     			String selectedValue = selectLabels[valueIndex];
				     			%>
				     			<%= (selectedValue!= null? selectedValue : " - ") %>
				     			<%
				     		} else {
				     			out.print(" - ");
				     		}
				     	} else {
			     			out.print(" - ");
			     		}
			     	} else {
		     			out.print(" - ");
		     		}
	     		} catch (Exception e) { out.print(" - "); }
			%>
	     		<% } %>
	     	<% } %>
	     	
	     	<% if (readonly) { %>
	     		<html:hidden property="<%=formFieldName%>"/>
	     	<% } %>
	     	<% if (required) { %><em>*</em><% } %>
	     	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
    	 	<html:errors property="<%=formFieldName%>"/>
     </div>

	 <% } // end if hidden
	 } // end if "select"
	}
	
} catch (Exception e) { e.printStackTrace(); } %>
