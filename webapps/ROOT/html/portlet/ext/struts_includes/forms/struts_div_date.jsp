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
	String lookupAction = "";
	boolean previous_fieldset = false;
	boolean secretField = false;

	form_field = (com.ext.sql.StrutsFormFields) request.getAttribute(namespace+"_STRUTS_DIV_FIELD");
	String curFormName = (String)request.getAttribute(namespace+"_STRUTS_DIV_curFormName");
	String onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";
	
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



  if (formFieldType.equals("date"))
	{
		boolean clearDate = form_field.isClearDate();
		
		if (form_field.isDynamicField()) {
			if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
        else if (readonly)
				{ %>
				<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				<input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="text" id="<%=formFieldName%>"  name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>" readonly="<%=readonly%>">
				</div>
				<%
				}
				else
				{
				%>
				<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				<input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="text" id="<%=formFieldName%>" name="<%=formFieldName %>"  styleId="<%=formFieldName %>" readonly="true" value="<%= (value!= null? value : "") %>" onchange="<%= onChange %>">
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_<%=formFieldName %>" style="cursor: pointer; border: 0px solid red;" title="Date selector" alt="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
    		<%if (clearDate){%>
			    <img src="<%=themeDisplay.getPathThemeImage()+"/common/close.png"%>" id="f_<%=formFieldName %>" style="cursor: pointer; border: 0px solid red;" title="<%= LanguageUtil.get(pageContext, "clear") %>" alt="<%= LanguageUtil.get(pageContext, "clear") %>" onclick="var dateEl = document.getElementById('<%=formFieldName%>');if (dateEl != null) {dateEl.value=''};" />
			  <%}%>
    		<% if (required) { %><em>*</em><% } %>
   		 	<% if (helpMessage != null) { %>
						<liferay-ui:icon-help message="<%= helpMessage %>" />
	    	<% } %>
    		<html:errors property="<%=formFieldName%>"/>
    		
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
                <noscript></noscript>
	<%	}	


		} else {	
			
		
		if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
        else if (readonly)
		{ %>
		<div class="ctrl-holder">
		<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
     	<html:hidden property="<%=formFieldName%>" />
     	<bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
     	<% if (helpMessage != null) { %>
			<liferay-ui:icon-help message="<%= helpMessage %>" />
	    <% } %>
    </div>
		<%
		}
		else
		{
	%>
	<div class="ctrl-holder">
	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>

	<html:text alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" property="<%=formFieldName %>" styleId="<%=formFieldName %>" readonly="true" onchange="<%= onChange %>"/>
	<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_<%=formFieldName %>" style="cursor: pointer; border: 0px solid red;" title="Date selector" alt="Date selector" onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
    <%if (clearDate){%>
    <img src="<%=themeDisplay.getPathThemeImage()+"/common/close.png"%>" id="f_<%=formFieldName %>" style="cursor: pointer; border: 0px solid red;" title="<%= LanguageUtil.get(pageContext, "clear") %>" alt="<%= LanguageUtil.get(pageContext, "clear") %>" onclick="var dateEl = document.getElementById('<%=formFieldName%>');if (dateEl != null) {dateEl.value=''};" />
    <%}%>

    <% if (required) { %><em>*</em><% } %>
    <% if (helpMessage != null) { %>
			<liferay-ui:icon-help message="<%= helpMessage %>" />
	    <% } %>
    <html:errors property="<%=formFieldName%>"/>
  </div>


<script type="text/javascript">
    Calendar.setup({
        inputField     :    "<%=formFieldName %>",     // id of the input field
        button         :    "f_<%=formFieldName %>",  // trigger for the calendar (button ID)
        align          :    "Tl",           // alignment (defaults to "Bl")
				ifFormat    : "<%=fieldDateFormat%>",
				daFormat : "<%=fieldDateFormat%>",
				showsTime :true,
        singleClick    :    true,
        firstDay : "1"
    });
</script>
<noscript></noscript>


	<%	} 
	}
	
}
	
} catch (Exception e) { e.printStackTrace(); } %>
