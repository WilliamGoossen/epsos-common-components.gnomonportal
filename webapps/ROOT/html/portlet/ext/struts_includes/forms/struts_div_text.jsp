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
	if (Validator.isNull(value) && Validator.isNotNull(request.getParameter(formFieldName))) 
		value = request.getParameter(formFieldName);
	colour = form_field.getColour();
	bgcolour = colour;
	if (colour != null && colour.equals("inherit"))
		bgcolour = null;
	// force span colour to always be the default
	colour = "inherit";

  if (formFieldType.equals("text"))
 	{
 		 if (form_field.isDynamicField()) {
 		 	if (hidden)
	     	{ %>
    	 	<input type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
     		<%
	     	}
        else if (readonly)
     		{ %>
     			<div class="ctrl-holder">
				     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				     	<input alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" type="hidden" id="<%=formFieldName%>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>">
				     	<%= (value!= null? value : "") %>
				     	<% if (helpMessage != null) { %>
							<liferay-ui:icon-help message="<%= helpMessage %>" />
					    <% } %>
			    	 	<html:errors property="<%=formFieldName%>"/>
			     	</div>
			     	<%
				} else { %>
					<div class="ctrl-holder">
					     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
								<input alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> id="<%=formFieldName%>" type="text" size="<%= ""+field_size %>" name="<%=formFieldName%>" value="<%= (value!= null? value : "") %>"><% if (required) { %><em>*</em><% } %>
					     	<% if (helpMessage != null) { %>
								<liferay-ui:icon-help message="<%= helpMessage %>" />
						    <% } %>
				    	 	<html:errors property="<%=formFieldName%>"/>
				   </div>
				   <%  	
				}
		}
		
		
		else {
    	onChange = (form_field.getOnChange() != null) ? form_field.getOnChange() : "";
     	if (hidden)
	     	{ %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     		<%
	     	}
        else if (readonly && !secretField) 
        { %>
         		<div class="ctrl-holder">
				     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				     	<html:hidden property="<%=formFieldName%>"/>
				     	<bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
				     	<% if (helpMessage != null) { %>
							<liferay-ui:icon-help message="<%= helpMessage %>" />
					    <% } %>
			    	 	<html:errors property="<%=formFieldName%>"/>
			     	</div>
			     	<%
        }
        else
     		{
	     		if (!secretField) {
	     		%>
			     		<div class="ctrl-holder">
					     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
					     	<html:text alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" property="<%=formFieldName%>" size="<%= ""+field_size %>" onchange="<%= onChange %>" readonly="<%=readonly%>"/><% if (required) { %><em>*</em><% } %>
					     	<% if (helpMessage != null) { %>
								<liferay-ui:icon-help message="<%= helpMessage %>" />
						    <% } %>
				    	 	<html:errors property="<%=formFieldName%>"/>
				     	</div>
				<% } else { %>
						<div class="ctrl-holder">
				     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
				     	<html:password alt="<%= LanguageUtil.get(pageContext, formFieldKey) %>" property="<%=formFieldName%>" size="<%= ""+field_size %>" readonly="<%=readonly%>" /><% if (required) { %><em>*</em><% } %>
				     	<% if (helpMessage != null) { %>
							<liferay-ui:icon-help message="<%= helpMessage %>" />
					    <% } %>
			    	 	<html:errors property="<%=formFieldName%>"/>
				    </div>
				<% }
			}
		}
	}
	
} catch (Exception e) { e.printStackTrace(); } %>
