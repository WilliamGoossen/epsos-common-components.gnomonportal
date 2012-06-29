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


 	if (formFieldType.equals("lookup") && form_field instanceof com.ext.sql.ActionLookupField) {
 		
 		if (form_field.isDynamicField()) {
 			
 		com.ext.sql.ActionLookupField lookUpfield = (com.ext.sql.ActionLookupField)form_field;
		String lookupIdValue = lookUpfield.getLookupIdValue();
		String lookUpActionUrl = lookUpfield.getLookupActionUrl();
		String lookupIdFieldName = lookUpfield.getLookUpIdFieldName();
		String portletName = lookUpfield.getPortletName();
		String ppid = request.getParameter("p_p_id");
		String portletNameAttr = (portletName != null && !portletName.equals("")) ? portletName: ppid;
		boolean multipleChoices = lookUpfield.isMultipleChoices();

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
	     	<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<input type="text" size="<%= ""+field_size %>"  id="<%=formFieldName%>" name="<%=formFieldName%>" readonly="true" value="<%= (value!= null? value : "") %>"/>
	     	<%if (!readonly) { %>
     		
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
						openDialog(url, <%= ""+popupWidth%>, <%= ""+popupHeight%>);
					}
				</script>
				<span id="<%= formFieldName%>_LOOKUP_SPAN_ID" onclick="<%=formFieldName%>_openActionModalLookupWin()">
					<IMG src="<%=  themeDisplay.getPathThemeImage() %>/common/search.gif" border="0"/>
				</span>
				<% if (required) { %><em>*</em><% } %>
     		<%}//readOnly %>
				<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
	     	<html:errors property="<%=formFieldName%>"/>
	     	</div>
     	<%} // hidden
 			
 			
 		} else {	
 		
		com.ext.sql.ActionLookupField lookUpfield = (com.ext.sql.ActionLookupField)form_field;
		String lookUpActionUrl = lookUpfield.getLookupActionUrl();
		String lookupIdFieldName = lookUpfield.getLookUpIdFieldName();
		String portletName = lookUpfield.getPortletName();
		String ppid = request.getParameter("p_p_id");
		String portletNameAttr = (portletName != null && !portletName.equals("")) ? portletName: ppid;
		boolean multipleChoices = lookUpfield.isMultipleChoices();

		java.util.Hashtable actionParameters = lookUpfield.getLookupActionParameters();
		if (actionParameters == null)
			actionParameters = new java.util.Hashtable();
		actionParameters.put("openerFormName", curFormName);
		actionParameters.put("lookupFieldIdHtmlId", lookupIdFieldName);
		actionParameters.put("lookupFieldDisplHtmlId", formFieldName);
		%>

		<html:hidden property="<%=lookupIdFieldName%>"/>

		<%if (hidden)  { %>
    	 	<html:hidden property="<%=formFieldName%>"/>
     	<%}  else { %>
     	<div class="ctrl-holder">
	     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<% if (!readonly) { %>
	     		<% if (!multipleChoices) {  %>
	     		<html:text property="<%=formFieldName%>" readonly="true" size="<%= ""+field_size %>" />
	     		<% } else { %>
	     		<html:text property="<%=formFieldName%>" readonly="true" size="70" />
	     		<% } %>
	     	<% } else { %>
	     		<bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
	     	<% } %>
	     	

     		<%if (!readonly) { %>
     		
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
						openDialog(url, <%= ""+popupWidth%>, <%= ""+popupHeight%>);
					}
				</script>
				<noscript></noscript>

				<span id="<%= formFieldName%>_LOOKUP_SPAN_ID" onclick="<%=formFieldName%>_openActionModalLookupWin()">
					<IMG src="<%=  themeDisplay.getPathThemeImage() %>/common/search.png" alt="search" border="0"/>
				</span>
			    <% if (required) { %><em>*</em><% } %>
		 		<%}//readOnly %>
     		<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
				<html:errors property="<%=formFieldName%>"/>
			</div>
     	<% }
    }
	} 
	
} catch (Exception e) { e.printStackTrace(); } %>
