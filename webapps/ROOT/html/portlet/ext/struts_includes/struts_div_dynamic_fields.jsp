<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>
<%@ page import="java.util.Vector" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.sql.StrutsFormFieldsGroupDelimiter" %>

<tiles:useAttribute id="tileAttribute" name="attributeName" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="curFormNameAttribute" name="formName" classname="java.lang.String" />

<% try {
	String namespace = ((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace();
	String curFormName = curFormNameAttribute;
	request.setAttribute(namespace+"_STRUTS_DIV_curFormName", curFormName);

	String JS_PREFIX = (tileAttribute != null ? tileAttribute : "");

%>
<script language="JavaScript" src="/html/js/editor/modalwindow.js"  type="text/javascript"></script><noscript></noscript>

<script language="JavaScript"  type="text/javascript">
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

<% String javaScriptFilters = (String)request.getAttribute(namespace+com.ext.util.CommonDefs.ATTR_FORM_FIELDS_FILTER_DEFINITIONS);
if (javaScriptFilters != null) { %>
	<%= javaScriptFilters %>
<% } %>

var <%=curFormName%>_selectLists = new Array();
</script>
<noscript></noscript>


<div class="inline-labels">


<%

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

	StrutsFormFields form_field;
	
	String onSubmitBody = "";
	String formFieldName;
	String formFieldKey;
	boolean required;
	String formFieldType;
	String value;
	String fieldDateFormat="";
	boolean hidden;
	boolean readonly;
	List optionValues;
	List optionNames;
	List optionHasChildren;
	String colour = null;
	String bgcolour = null;
	int field_size;
	String onChange = "";
	String lookupAction = "";
	int tabIndex = 0;
	String helpMessage = null;
	boolean previous_fieldset = false;

for (int index=0; index < _struts_fields.size(); index ++) {

	form_field = (StrutsFormFields) _struts_fields.get(index);
	if (form_field instanceof StrutsFormFieldsGroupDelimiter)
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
	else if (form_field instanceof com.ext.sql.StrutsFormFieldsTabDelimiter)
	{ %>
	  <% if (tabIndex > 0) { %>
		</div>
		</fieldset>
	  <% } %>
	<fieldset class="inline-labels">
	<legend><a id="<%=curFormName%>_tab_link_tab<%=tabIndex%>" class="title2" href="#<%= tabIndex %>" onClick="<%=curFormName%>_showTab('tab<%=tabIndex%>')"><%= LanguageUtil.get(pageContext, ((com.ext.sql.StrutsFormFieldsTabDelimiter)form_field).getTabNameKey()) %></a>
	<% if (((com.ext.sql.StrutsFormFieldsTabDelimiter)form_field).containsErrors()) { %><em>*</em><% } %></legend>
	<div id="tab<%=tabIndex%>" style="display:none">
	<% tabIndex ++; 
	   previous_fieldset = false;
	%>
	<%
	} else
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
	optionNames =form_field.getOptionLabels();
	optionValues =form_field.getOptionValues();
	optionHasChildren =form_field.getOptionHasChildren();
	value = form_field.getValue();
	colour = form_field.getColour();
	bgcolour = colour;
	if (colour != null && colour.equals("inherit"))
		bgcolour = null;
	// force span colour to always be the default
	colour = "inherit";
	field_size = form_field.getField_size();
	helpMessage = form_field.getHelpMessage();

	 if (formFieldType.equals("select"))
	 {
	 		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
     	%>
     	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_select.jsp" flush="true"/>
     	<% 
	 } // end if "select"

   else if (formFieldType.equals("text"))
   {
     	request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
     	%>
     	<jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_text.jsp" flush="true"/>
     	<% 
   }

	else if (formFieldType.equals("statictext") || formFieldType.equals("plain_text"))
  {  
  	request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
    %>
    <jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_plain_text.jsp" flush="true"/>
    <%    	
  }
  
	else if (formFieldType.equals("textarea"))
  {
  	request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
    %>
    <jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_textarea.jsp" flush="true"/>
    <%    	
	}

	else if (formFieldType.equals("date"))
	{
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
    %>
    <jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_date.jsp" flush="true"/>
    <%  
	}

	else if (formFieldType.equals("textareahtml")) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
    %>
    <jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_textareahtml.jsp" flush="true"/>
    <%  
	}

	else if (formFieldType.equals("lookup") && form_field instanceof com.ext.sql.ActionLookupField) {
		request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
    %>
    <jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_lookup.jsp" flush="true"/>
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

	else if (formFieldType.equals("tag_lookup")) {
    request.setAttribute(namespace+"_STRUTS_DIV_FIELD",form_field);
    %>
    <jsp:include page="/html/portlet/ext/struts_includes/forms/struts_div_tag_lookup.jsp" flush="true"/>
    <% 
	}

  } // end if form_field is not instance of GroupDelimiter
} // end for loop on all fields%>
<% if (tabIndex > 0) { %>
		</div>
		</fieldset>
<% } 

if (previous_fieldset) {
%>
</fieldset>

<% } %>

</div>


<script language="JavaScript">
if (<%=curFormName%>_selectLists.length > 0) {
 	// ensure selection script is run when page is first loaded to filter other selection fields
 	for (var s=0; s< <%= curFormName %>_selectLists.length; s++) {
 		if (document.forms['<%= curFormName %>'].elements[<%=curFormName%>_selectLists[s]].options == null) {
 	    // this means that the list is not found, because it was a disabled one, so look again for the name plus '_'  or plus '__'
	     	if  (document.forms['<%= curFormName %>'].elements[<%=curFormName%>_selectLists[s] +'__']!= null) {
	         	_top_updateOptionsFor('<%= curFormName %>', <%=curFormName%>_selectLists[s], document.forms['<%= curFormName %>'].elements[<%=curFormName%>_selectLists[s] +'__'].value);
		     }
		     else
		     {
		    	 _top_updateOptionsFor('<%= curFormName %>', <%=curFormName%>_selectLists[s], document.forms['<%= curFormName %>'].elements[<%=curFormName%>_selectLists[s] +'_'].options[document.forms['<%= curFormName %>'].elements[<%=curFormName%>_selectLists[s] +'_'].selectedIndex].value);
           	 }
       	}
       	else
       	{
       		_top_updateOptionsFor('<%= curFormName %>', <%=curFormName%>_selectLists[s], document.forms['<%= curFormName %>'].elements[<%=curFormName%>_selectLists[s]].options[document.forms['<%= curFormName %>'].elements[<%=curFormName%>_selectLists[s]].selectedIndex].value);
       	}
 	}
}
</script>


<% } catch (Exception e) { e.printStackTrace(); } %>
