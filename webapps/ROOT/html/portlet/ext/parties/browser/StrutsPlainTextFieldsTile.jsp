<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<tiles:useAttribute id="fieldsAttrName" name="fieldsAttrName" classname="java.lang.String"/>
<tiles:useAttribute id="curFormName" name="curFormName" classname="java.lang.String"/>

<%
Vector fields= (Vector)request.getAttribute(fieldsAttrName);

%>

<table>
		<%for (int i = 0; i < fields.size(); i++){
			com.ext.sql.StrutsFormFields item = (com.ext.sql.StrutsFormFields)fields.get(i);
			String formFieldKey = item.getFormFieldKey();
			String formFieldName = item.getFormFieldName();
			boolean hidden = item.isHidden();
			String alignment = item.getAlignment();
			alignment = (alignment == null || alignment.equals("")) ? alignment = "left" : alignment;
		%>
			<%if (!hidden){%>
			<tr>
	     	<td align="right"><span class="gamma1-FormText" ><b><%= LanguageUtil.get(pageContext, formFieldKey) %></b></span></td>
	     	<td width="100" align="<%=alignment%>"><span class="alpha1"><bean:write name="<%=curFormName%>" property="<%=formFieldName%>"/></span></td>
    	 	<td ><html:errors property="<%=formFieldName%>"/></td> 
	     	</tr>
	     	<%} // hidden%>
	     <%} // for%>
</table>