<%@ include file="/html/portlet/ext/crm/helpdesk/categories/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/crm/helpdeskCategories/update?actionURL=true" ;
String buttonText = "crm.button.update";
String titleText = "crm.helpdesk.category.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/crm/helpdeskCategories/delete?actionURL=true" ;
 	buttonText = "crm.button.delete";
 	titleText = "crm.helpdesk.category.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/crm/helpdeskCategories/add?actionURL=true" ;
	buttonText = "crm.button.add";
	titleText = "crm.helpdesk.category.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/crm/helpdeskCategories/add?actionURL=true" ;
	buttonText = "crm.button.add-translation";
	titleText = "crm.helpdesk.category.add-translation";
}
%>

<h2  ><%= LanguageUtil.get(pageContext, titleText) %></h2>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">

<bean:define id="labels" name="CrCategoryForm" property="priorityKeys"/>
<% 
// correct the list of keys for translations to be shown properly
String[] labelsList = (String[])labels;
for (int i=0; i<labelsList.length; i++)
{
 	labelsList[i] = LanguageUtil.get(pageContext, labelsList[i]);
}
%>


<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="CrCategoryForm"/>

</tiles:insert>


<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="CrCategoryForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/crm/helpdeskCategories/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="crm.button.delete-translation" />
		  <tiles:put name="formName"   value="CrCategoryForm" />
		  <tiles:put name="confirm" value="crm.button.delete-translation-are-you-sure"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

</html:form>







<!--- EIDH AITHMATON -->



<br>
<% if (loadaction != null && loadaction.equals("edit")) { %>
<bean:define id="categoryid" name="CrCategoryForm" property="mainid"/>
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.current.list") %></legend>
<% List categoryRequestTypes = (List)request.getAttribute("categoryRequestTypes");
   if(categoryRequestTypes != null && categoryRequestTypes.size() > 0) {
   %>
<display:table id="reqType" name="categoryRequestTypes" requestURI="/<%=formUrl%>" pagesize="20" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">   
<% ViewResult reqView = (ViewResult)pageContext.getAttribute("reqType"); %>
<display:column titleKey="crm.helpdesk.requesttype.name" sortable="true">
<a title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.request.edit")%>" 
   href="<liferay-portlet:actionURL portletName="CRM_HELPDESK_REQUESTTYPES" windowState="maximized">
   <liferay-portlet:param name="struts_action" value="/ext/crm/helpdeskRequestTypes/load"/>
	<liferay-portlet:param name="mainid" value="<%= reqView.getMainid().toString() %>"/>
	<liferay-portlet:param name="loadaction" value="edit"/>
	<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
   </liferay-portlet:actionURL>">
<%= reqView.getField1()  %>
</a>
</display:column>
<display:column property="field2" titleKey="crm.helpdesk.requesttype.count" sortable="true"/>
<display:column>
<% if((Integer)reqView.getField2()<=0) {%>
<a name="<%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.delete")%>" 
   title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.delete")%>"
   href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskCategories/deleteRequestTypeFromCategory"/>
    <portlet:param name="categoryid" value="<%= categoryid + "" %>"/>
   <portlet:param name="mainid" value="<%= categoryid.toString() %>"/>
   <portlet:param name="reqTypeId" value="<%= reqView.getMainid().toString() %>"/>
   </portlet:actionURL>"
   onClick="return confirm('<%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.delete.are-you-sure")%>');"
   ><img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png">
</a>
<%}%>
</display:column>
</display:table>   
 <%  }  %>
 <br>
 <form name="CRM_CATEGORY_ADD_REQUEST_TYPE_FORM" action="<liferay-portlet:actionURL portletName="CRM_HELPDESK_REQUESTTYPES" windowState="maximized">
 	<liferay-portlet:param name="struts_action" value="/ext/crm/helpdeskRequestTypes/load"/>
	<liferay-portlet:param name="categoryid" value="<%= categoryid + "" %>"/>
	<liferay-portlet:param name="loadaction" value="add"/>
	<liferay-portlet:param name="redirect" value="<%=currentURL%>"/>
   </liferay-portlet:actionURL>" method="post">
 <input type="submit" value="<%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.add")%>">
 </form>
 </fieldset>
  
  
  <fieldset>
<legend><%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.add.list") %></legend>
  
  <% List requestTypes = (List)request.getAttribute("requestTypes");
   if(requestTypes != null && requestTypes .size() > 0) {
   %>
<display:table id="reqType" name="requestTypes" requestURI="/<%=formUrl%>" pagesize="20" sort="list" style="font-weight: normal; width: 100%; border-spacing: 0">   

<% ViewResult reqView = (ViewResult)pageContext.getAttribute("reqType"); %>
<display:column property="field1" titleKey="crm.helpdesk.requesttype.name" sortable="true"/>


<display:column>
<a name="<%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.add")%>" 
   title="<%= LanguageUtil.get(pageContext, "crm.helpdesk.requesttype.add")%>"
   href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/crm/helpdeskCategories/assignRequestTypeToCategory"/>
    <portlet:param name="categoryid" value="<%= categoryid + ""%>"/>
   <portlet:param name="mainid" value="<%= categoryid.toString() %>"/>
   <portlet:param name="reqTypeId" value="<%= reqView.getMainid().toString() %>"/>
   </portlet:actionURL>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/add_article.png">
</a>
</display:column>
</display:table>   
   <% }
  } %>
  
<br>

</fieldset>











<br>
<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" align="absmiddle">&nbsp;<html:link action="/ext/crm/helpdeskCategories/list"><%= LanguageUtil.get(pageContext, "crm.helpdesk.category.list") %></html:link>

<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3  >Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/crm/helpdeskCategories/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/crm/helpdeskCategories/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<%
} catch (Exception e) {e.printStackTrace(); } %>