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



  if (formFieldType.equals("link_text")) {

		if (form_field instanceof com.ext.sql.LinkStrutsField) {
			com.ext.sql.LinkStrutsField linkStrutsField = (com.ext.sql.LinkStrutsField)form_field;
			String portletName = linkStrutsField.getPortletName();
			javax.portlet.WindowState windState = linkStrutsField.getWindowState();
			String windStateStr =  (windState == null) ? javax.portlet.WindowState.NORMAL.toString() : windState.toString();
			String onclick = form_field.getOnClick();
			String linkActionUrl = ((com.ext.sql.LinkStrutsField)form_field).getLinkActionUrl();
			java.util.HashMap params = ((com.ext.sql.LinkStrutsField)form_field).getLinkActionParameters();

			if (params != null) pageContext.setAttribute("paramsName", params);

			//boolean hiddenFlag = ((com.ext.sql.LinkStrutsField)form_field).isHiddenIfNull();
		%>
		<logic:notEmpty name="<%=curFormName%>" property="<%=formFieldName%>" >
     	<html:hidden property="<%=formFieldName%>"/>

     	<% if (!hidden) {%>
     	<div class="ctrl-holder">
	     	<label for="<%=formFieldName%>"><%= LanguageUtil.get(pageContext, formFieldKey) %></label>
	     	<%if (linkActionUrl != null){%>
	     	<%if (portletName == null) {%>
		     	<html:link page="<%= linkActionUrl %>" name="paramsName"><bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/></html:link>
		     <%}else{
		     java.util.Set keysSet = params.keySet();
		     java.util.Iterator keysIter = keysSet.iterator();
		     %>
		     <a href="<liferay-portlet:actionURL portletName="<%=portletName %>" windowState="<%= windStateStr%>">
			     <liferay-portlet:param name="struts_action" value="<%=linkActionUrl %>" />
			     <%while (keysIter.hasNext()){
			     String parKey = (String)keysIter.next();
			     String parValue = (String)params.get(parKey);
			     %>
			     <liferay-portlet:param name="<%=parKey %>" value="<%=parValue %>" />
			     <%} %>
		     </liferay-portlet:actionURL>">
		     <bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
		     </a>
	         <%} // else %>
		     <%}else if (onclick != null && !onclick.equals("")) {%>
			     <a href="" onclick="<%=onclick%>">
			     <bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/>
			     </a>
		     <%}%>
		   	<% if (helpMessage != null) { %>
				<liferay-ui:icon-help message="<%= helpMessage %>" />
		    <% } %>
	     <html:errors property="<%=formFieldName%>"/>
	     	</div>
   		<% } %>
   		</logic:notEmpty>
   		<%}
	}
	
} catch (Exception e) { e.printStackTrace(); } %>
