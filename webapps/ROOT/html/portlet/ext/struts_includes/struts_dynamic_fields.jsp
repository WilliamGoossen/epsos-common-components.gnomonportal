<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.util.Vector" %>

<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="noTableAttribute" name="noTable" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="curFormNameAttribute" name="formName" classname="java.lang.String" />

<% try {
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();
	String no_table_flag = null;
	if (noTableAttribute != null)
		no_table_flag = noTableAttribute;
	else
		no_table_flag = (String) request.getAttribute(namespace+CommonDefs.ATTR_FORM_FIELDS_NO_TABLE_FLAG);

	String curFormName = curFormNameAttribute;

	String JS_PREFIX = (tileAttribute != null ? tileAttribute : "");

%>
<script language="JavaScript" src="/html/js/editor/modalwindow.js"  type="text/javascript"></script>

<script language="JavaScript" type="text/javascript">
var <%=curFormName%>_tabs = new Array();

function <%=curFormName%>_showTab(tabName)
{
  if (<%=curFormName%>_tabs[tabName] != null && <%=curFormName%>_tabs[tabName] == "on")
  {
      document.getElementById(tabName).style.display='none';
      document.getElementById('<%=curFormName%>_tab_link_'+tabName).className='title2';
      <%=curFormName%>_tabs[tabName] = "off";
  }
  else
  {
      document.getElementById(tabName).style.display='inline';
      document.getElementById('<%=curFormName%>_tab_link_'+tabName).className='beta1';
      <%=curFormName%>_tabs[tabName] = "on";
  }
}


var <%= JS_PREFIX %>_dynfck_fields = '';

function <%= JS_PREFIX %>_dynfck_updateHiddenText() {
    if (<%= JS_PREFIX %>_dynfck_fields)
    {
	eval(<%= JS_PREFIX %>_dynfck_fields );
    }
}

</script>

<% if (no_table_flag == null || no_table_flag.equals("")) {
		// only draw the table tag if the no_table_flag was not present in the request
%>

<table>

<% }

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
	String value;
	String fieldDateFormat="";
	boolean hidden;
	boolean readonly;
	String[] optionValues;
	String[] optionNames;
	String[] optionHasChildren;
	com.ext.sql.StrutsFormFields form_field;
	String colour = null;
	String bgcolour = null;
	int field_size;
	String onChange = "";
	String lookupAction = "";
	int tabIndex = 0;

for (int index=0; index < _struts_fields.size(); index ++) {
	Object item = _struts_fields.get(index);
	if (item instanceof com.ext.sql.StrutsFormFieldsGroupDelimiter)
	{ %>
	<% if (index > 0) { %>
		<tr><td><br></td></tr><tr>
	<% } else { %>
		<tr>
	<% } %>
	<% String groupNameTranslation = LanguageUtil.get(pageContext, ((com.ext.sql.StrutsFormFieldsGroupDelimiter)item).getGroupNameKey());
	   if (groupNameTranslation != null && groupNameTranslation.length()>0) { %>
	<td colspan=2><h2 class="title2"><%= LanguageUtil.get(pageContext, ((com.ext.sql.StrutsFormFieldsGroupDelimiter)item).getGroupNameKey()) %></h2>
	</td>
	<% } %>
	</tr>
	<%
	}
	else if (item instanceof com.ext.sql.StrutsFormFieldsTabDelimiter)
	{ %>
	  <% if (tabIndex > 0) { %>
	  	</table>
		</div>
		</fieldset>
		</td>
		</tr>
	  <% } %>
	<tr>
	<td colspan="3">
	<fieldset>
	<legend><a id="<%=curFormName%>_tab_link_tab<%=tabIndex%>" class="title2" href="#<%= tabIndex %>" onClick="<%=curFormName%>_showTab('tab<%=tabIndex%>')"><%= LanguageUtil.get(pageContext, ((com.ext.sql.StrutsFormFieldsTabDelimiter)item).getTabNameKey()) %></a>
	<% if (((com.ext.sql.StrutsFormFieldsTabDelimiter)item).containsErrors()) { %><span class="gamma-neg-alert"> *</span><% } %></legend>
	<div id="tab<%=tabIndex%>" style="display:none">
	<table>
	<% tabIndex ++; %>
	<%
	} else
	{
	form_field = (com.ext.sql.StrutsFormFields) item;
	formFieldName = form_field.getFormFieldName();
	formFieldKey = form_field.getFormFieldKey();
	formFieldType = form_field.getFormFieldType();
	fieldDateFormat = form_field.getDateFormat();
	if (fieldDateFormat == null || fieldDateFormat.equals(""))
		fieldDateFormat = CommonDefs.DATE_FORMAT_JSCRIPT;
	hidden = form_field.isHidden();
	readonly = form_field.isReadonly();
	required = form_field.isRequired();
	optionNames =form_field.getOptionLabels();
	optionValues =form_field.getOptionValues();
	optionHasChildren =form_field.getOptionHasChildren();
	value = form_field.getValue();
	if (Validator.isNull(value) && Validator.isNotNull(request.getParameter(formFieldName))) 
		value = request.getParameter(formFieldName);
	colour = form_field.getColour();
	bgcolour = colour;
	if (colour != null && colour.equals("inherit"))
		bgcolour = null;
	// force span colour to always be the default
	colour = "inherit";
	field_size = form_field.getField_size();

	 if (formFieldType.equals("select"))
	 {
	 %>
	 <script type="text/javascript">
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
	     	</script>
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
	 	if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else
     		{ %>
	 <tr>
	     	<td><span style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<%if(isMultySelect){%>
	     	<%= form_field.getLabelForMultipleSelection()%><BR>
	     	<%}
	     	if (readonly) { %>
	     	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
	     	<%if(!isMultySelect){%>
	     	<select style="<%= extraStyle %>" name="<%=formFieldName+"_"%>" onChange="<%= onChange%>" disabled="<%=readonly%>" class="FormAreaDisable" >
	     	<%}%>
	     	<%} else {
	     		if (isMultySelect) { %>
	     		<select style="<%= extraStyle %>" name="<%=formFieldName%>" onChange="<%= onChange%>" size="<%= String.valueOf(form_field.getMultipleSelection())%>" multiple="true" class="FormArea">
	     	<% } else { %>
	     	<select style="<%= extraStyle %>" name="<%=formFieldName%>" onChange="<%= onChange%>" class="FormArea" >
	     	<% }
	     	} %>
	     	<% if (optionNames != null && optionValues != null && (!readonly || !isMultySelect)) {
	     	  for (int k=0; k<optionValues.length; k++) {
	     	  	boolean selected = false;
	     	  	String optHasChildren = (optionHasChildren != null && optionHasChildren.length > k) ? optionHasChildren[k] : "false";
	     	  	if (value != null){
	     	  		if (isMultySelect && valuesArr != null){
	     	  			selected = (java.util.Arrays.binarySearch(valuesArr, optionValues[k]) >= 0);
		     	  	}else {
			     	  	selected = value.equals(optionValues[k]);
	    	 	  	}
	     	  	}
	     	  %>
	     			<option <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> value="<%=optionValues[k]%>"  <% if( selected  ){%> selected="selected" <%} %> optHasChildren="<%=optHasChildren%>"><%= LanguageUtil.get(pageContext, optionNames[k]) %></option>
				<% }
			} %>
	     	</select>
	     	<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
        </td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
     </tr>

	 <% }  // end if hidden
	 } // end if "select"

     else if (formFieldType.equals("text"))
     	{
     	if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else
     		{ %>
	     	<tr>
	     	<td><span  style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<% if (readonly) { %>
	     	<td><input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> id="<%=formFieldName%>" type="text" size="<%= ""+field_size %>" class="FormAreaDisable" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>" readonly="<%=readonly%>"><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
	     	<% } else { %>
	     	<td><input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> id="<%=formFieldName%>" type="text" size="<%= ""+field_size %>" class="FormArea" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>"><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
	     	<% } %>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
			<% }
		}


	else if (formFieldType.equals("statictext"))
     	{  %>
     	<tr>
     	<td><span style="color:<%= colour %>" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span>
     	</td>
     	<td colspan="2">
     	<span style="color:<%= colour %>" ><%= (value!= null? LanguageUtil.get(pageContext, value) : "") %></span>
     	</td>
     	</tr>
     	<%
        }
	else if (formFieldType.equals("textarea"))
     	{
     	if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else
     		{ %>
	     	<tr>
	     	<td><span style="color:<%= colour %>" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<% if (readonly) { %>
	     	<td><textarea cols="50" rows="3" <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> id="<%=formFieldName%>" class="FormAreaDisable" name="<%=formFieldName%>" readonly="<%=readonly%>"><%= (value!= null? value : "") %></textarea><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
	     	<% } else { %>
	     	<td><textarea cols="50" rows="3" <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> id="<%=formFieldName%>" class="FormArea" name="<%=formFieldName%>"><%= (value!= null? value : "") %></textarea><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
	     	<% } %>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
			<% }
		}


	// Date Type
	else if (formFieldType.equals("date"))
	{
		if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else if (readonly)
		{ %>
		<tr>
     	<td><span  style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
     	<td><input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="text" id="<%=formFieldName%>" class="FormAreaDisable"  name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>" readonly="<%=readonly%>"></td>
     	</tr>
		<%
		}
		else
		{
	%>
	<tr>
	<td><span  style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	<td>
	<input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="text" id="<%=formFieldName%>" class="FormArea" name="<%=formFieldName %>"  styleId="<%=formFieldName %>" readonly="true" value="<%= (value!= null? value : "") %>">
	<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_<%=formFieldName %>" style="cursor: pointer; border: 1px solid red;" title="Date selector"
    onmouseover="this.style.background='red';" onmouseout="this.style.background=''" /><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
    <%-- <a href="#" onClick="document.<%= curFormName %>.<%= formFieldName %>.value='';return true;"><%= LanguageUtil.get(pageContext, "delete") %></a> --%>
    </td>
 	<td><html:errors property="<%=formFieldName%>"/></td>
    </tr>


<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%=formFieldName %>",     // id of the input field
        button         :    "f_<%=formFieldName %>",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
		ifFormat    : "<%=fieldDateFormat%>",
		daFormat : "<%=fieldDateFormat%>",
		showsTime :true,
        singleClick    :    true,
        firstDay       : "1"
    });
</script>


	<%	} }

	// Alternative HTML TextEditor (FCK)
	else if (formFieldType.equals("textareahtml")) {
	%>
	<%
	     	Object fieldValue = "";
	     	if (value != null) fieldValue = value;
	 %>


	<%
		if (readonly) {
	%>
	<tr>
	<td><span style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	<td>
		<DIV <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> class="FormAreaDisable">
			<%= fieldValue%>
			&nbsp;
		</DIV>
	</td></tr>
	<%
		}else{
	%>
	 <tr>
	     	<td><span style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
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
	     	<iframe frameborder="0" height="300"
	     	        id="<portlet:namespace /><%=formFieldName%>_editor"
	     	        name="<portlet:namespace /><%=formFieldName%>_editor"
	     	        scrolling="no"
	     	        src="<%= themeDisplay.getPathJavaScript() %>/editor/editor.jsp?p_l_id=<%= plid %>&editorImpl=fckeditor&initMethod=initEditor<%=formFieldName%>"
	     	        width="370">
	     	</iframe>
	     	<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	 </tr>
	<%
		}
	}

	//---------------------------------------------------
	// Lookup
	//---------------------------------------------------
	if (formFieldType.equals("lookup") && form_field instanceof com.ext.sql.ActionLookupField) {
		com.ext.sql.ActionLookupField lookUpfield = (com.ext.sql.ActionLookupField)form_field;
		String lookupIdValue = lookUpfield.getLookupIdValue();
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

		<input type="hidden" id="<%=lookupIdFieldName%>" name="<%=lookupIdFieldName%>" value="<%= (lookupIdValue!= null? lookupIdValue : "") %>">

		<%if (hidden)  { %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     	<%}  else { %>
	     	<tr>
	     	<td><span class="form-text" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<table>
	     	<tr>
	     	<td>
	     		<input type="text" id="<%=formFieldName%>" name="<%=formFieldName%>" readonly="true" value="<%= (value!= null? value : "") %>"/>
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
						openDialog(url, 450, 350);
					}
				</script>
				<span id="<%= formFieldName%>_LOOKUP_SPAN_ID" onclick="<%=formFieldName%>_openActionModalLookupWin()">
					<IMG src="<%=  themeDisplay.getPathThemeImage() %>/common/search.gif" border="0"/>
				</span>
				<% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
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
	// File upload
	// formFieldName
	if (formFieldType.equals("fileupload")) {
		String filePath = form_field.getUploadFilePath();
		String fileValue = value;
		if (fileValue != null && !fileValue.equals("")){
%>
	<tr>
	     	<td><span style="color:<%= colour %>" ><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>

			<td><input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="text" class="FormArea" name="<%=fileValue%>"  readonly="true" value="<%= (value!= null? value : "") %>"><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	</tr>
	<tr><td></td>
     	<td>
     		<input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="file" name="<%=formFieldName%>" value="" />
     	</td>
	 	<td></td>
	</tr>
<%} else {%>
	<tr>
	     	<td><span  style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>

			<td><input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="file" id="<%=formFieldName%>" name="<%=formFieldName%>" value="" /><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	</tr>
<%}%>
<%
	}


	//---------------------------------------------------
	// Image
	//---------------------------------------------------

	else if (formFieldType.equals("image")) {
		String imgPath = form_field.getUploadFilePath(); //com.liferay.portal.util.PropsUtil.get("path.upload.images");
		String imgFileName = form_field.getImageFileName();

		if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}  else {
	%>
		<tr>
		     	<td><span  style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
				<td><img src='<%= "/"+imgPath + imgFileName%>' /><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %></td>
	    	 	<td><html:errors property="<%=formFieldName%>"/></td>
		</tr>
	<% }
	}


	//---------------------------------------------------



	// boolean
	//---------------------------------------------------
	else if (formFieldType.equals("boolean")) {

	if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else
     		{ %>
		<tr>
	     	<td><span  style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<td>
	     	<% if (readonly) { %>
	     	<input  type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
	     	<input type="checkbox" class="FormAreaDisable" id="<%=formFieldName+"_"%>" name="<%=formFieldName%>" disabled="<%=readonly%>" value="true" <% if (value!= null && value.equals("true")) { %> checked="true" <% } %> ><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
	     	<% } else { %>
	     	<% if (bgcolour != null && !bgcolour.equals("")) { %>
	     	<span class="FormArea" style="background-color:<%= bgcolour %>;">
	     	<% } %>
	     	<input type="checkbox" class="FormArea" id="<%=formFieldName%>" name="<%=formFieldName%>" value="true" <% if (value!= null && value.equals("true")) { %> checked="true" <% } %> ><% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
	     	<% if (bgcolour != null && !bgcolour.equals("")) { %>
	     	</span>
	     	<% } %>
	     	<% } %>
	     	</td>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
	     	<tr>
	 <% }
	}


	else if (formFieldType.equals("tag_lookup")) {
          if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
         else
     		{ %>
	     	<tr>
	     	<td><span  style="color:<%= colour %>"><%= LanguageUtil.get(pageContext, formFieldKey) %></span></td>
	     	<% if (readonly) { %>
	     	<td colspan="2">
         	<span style="color:<%= colour %>" ><%= (value!= null? value : "") %></span>
         	</td>
	     	<% } else { %>

	     	<td>
	     	<input name="<%=formFieldName%>_tagEntries" id="<%=formFieldName%>_tagEntries" type="hidden">
                <table class="liferay-table">
                    <tbody><tr>
                    <td>
                    <input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %>
                           id="<%=formFieldName%>" type="text" size="<%= ""+field_size %>" class="FormArea"
                           name="<%=formFieldName%>" value=""
                           autocomplete="off" >
                    <% if (required) { %><span class="gamma-neg-alert"> *</span><% } %>
                    </td>
                    <td>
                    <span id="<%=formFieldName%>_tagSummary"></span>
                    </td>
                    </tr>
                    </tbody>
                  </table>
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
                </td>
	     	<% } %>
    	 	<td><html:errors property="<%=formFieldName%>"/></td>
	     	</tr>
              <% }

	}

  } // end if item is not instance of GroupDelimiter
} // end for loop on all fields%>
<% if (tabIndex > 0) { %>
	  	</table>
		</div>
		</fieldset>
		</td>
		</tr>
<% } %>

<% if (no_table_flag == null || no_table_flag.equals("")) { %>

</table>

<% } %>

<% } catch (Exception e) { e.printStackTrace(); } %>
