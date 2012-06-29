<%@ include file="/html/portlet/ext/parties/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="com.ext.util.TitleData" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<% TitleData titleData = (TitleData)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+TitleData.ATTRIBUTE); %>

<h1 class="title1"><%= LanguageUtil.get(pageContext, "parties.manager.form.update-party-role") %></h1>

<% Vector fields = null; 
   String curFormName="Parties_Manager_Party_Role_Features_Form"; 
   fields = (Vector)request.getAttribute(((RenderResponse)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_RESPONSE)).getNamespace()+com.ext.util.CommonDefs.ATTR_FORM_FIELDS);
   String form_action = (String)request.getAttribute(com.ext.util.CommonDefs.ATTR_TAB_STRUTS_ACTION);
   if (fields != null)  { 
   		if (fields.size() == 0) {
   %>
   <br>
   <h2 class="title2"><%= LanguageUtil.get(pageContext, "parties.manager.partyrole.features.none") %></h2>
   <% } else { %>
<form name="Parties_Manager_Party_Role_Features_Form" action="<portlet:actionURL><portlet:param name="struts_action" value="<%= form_action %>"/></portlet:actionURL>" method="post">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_dynamic_fields.jsp">
	<tiles:put name="formName" value="Parties_Manager_Party_Role_Features_Form"/>
</tiles:insert>
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "parties.button.update") %>">
</form>

<% } 
}

java.util.HashMap params = new java.util.HashMap();
params.put("partyid", titleData.getValue("partyid").toString());
pageContext.setAttribute("paramsName", params);
%>
<br>
<html:link styleClass="beta1" action="/ext/parties/manager/listPartyRoles" name="paramsName"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.manager.back-to-party-roles") %></html:link>
<br>



