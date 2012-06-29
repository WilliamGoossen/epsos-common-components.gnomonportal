<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.product.*" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_FEATURES %></tiles:put>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<% 
List membersList = (List)request.getAttribute("membersList");
List availableList = (List)request.getAttribute("availableList");
%>
<h3><%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.list") %></h3>

<% String mainid = (String)request.getAttribute("mainid"); %>

<form name="EC_PRODUCT_ADMIN_FEATURESET_DELETION_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/deleteFeaturesetMembers"/><portlet:param name="mainid" value="<%= mainid %>"/></portlet:actionURL>" method="post">
<display:table id="feature1" name="membersList" requestURI="//ext/products/admin/listFeaturesetMembers?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("feature1"); %>
<display:column>
<input type="checkbox" name="memberid" value="<%= gnItem.getField5().toString() %>">
</display:column>
<display:column property="field2" titleKey="ec.admin.feature.name" sortable="true" />
<display:column property="field1" titleKey="ec.admin.feature.code" sortable="true" />
<display:column titleKey="ec.admin.featureset.members.mandatory" sortable="true">
<% if ( gnItem.getField3() != null && ((Boolean)gnItem.getField3()).booleanValue() ) {  %>
<img src="<%= themeDisplay.getPathThemeImage() %>/ecommerce/red_tick.gif" alt="true">
<% } %>
</display:column>
<display:column titleKey="ec.admin.featureset.members.type" sortable="true">
<% if (gnItem.getField4() != null) {
	int value = ((Integer)gnItem.getField4()).intValue(); 
	if ( value == CommonDefs.PRODUCT_FEAUTURE_TYPE_ATTRIBUTE) {
		out.print(LanguageUtil.get(pageContext, "ec.admin.featureset.members.type.attribute"));
	}
	else if (value == CommonDefs.PRODUCT_FEAUTURE_TYPE_SPEC) {
		out.print(LanguageUtil.get(pageContext, "ec.admin.featureset.members.type.spec"));
	}
} %>
</display:column>
</display:table>
<% if (hasEdit && membersList != null && membersList.size() > 0) { %>
<br>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.delete") %>">
<% } %>
</form>

<br><br><hr><br><br>

<h3><%= LanguageUtil.get(pageContext, "ec.admin.featureset.non-members.list") %></h3>

<form name="EC_PRODUCT_ADMIN_FEATURESET_ADDITION_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/products/admin/addFeaturesetMembers"/><portlet:param name="mainid" value="<%= mainid %>"/></portlet:actionURL>" method="post">
<display:table id="feature2" name="availableList" requestURI="//ext/products/admin/listFeaturesetMembers?actionURL=true" pagesize="25" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("feature2"); %>
<display:column>
<input type="checkbox" name="featureid" value="<%= gnItem.getMainid().toString() %>" onClick="Liferay.Util.toggle('form_div_for_feature_<%= gnItem.getMainid().toString() %>',true);">
</display:column>
<display:column property="field2" titleKey="ec.admin.feature.name" sortable="true" />
<display:column property="field1" titleKey="ec.admin.feature.code" sortable="true" />

<display:column>
<div id="form_div_for_feature_<%= gnItem.getMainid().toString() %>" name="form_div_for_feature_<%= gnItem.getMainid().toString() %>" style="display:none">
<fieldset>
<table>
<tr>
<td><%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.mandatory") %></td>
<td><input type="checkbox" name="mandatory_<%= gnItem.getMainid().toString() %>" value="true" checked="true"></td>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.type") %></td>
<td>
<table>
<tr><td>
<input type="radio" name="type_<%= gnItem.getMainid().toString() %>" value="<%= CommonDefs.PRODUCT_FEAUTURE_TYPE_ATTRIBUTE + "" %>" checked="true">
</td>
<td><%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.type.attribute") %></td>
</tr>
<tr>
<td>
<input type="radio" name="type_<%= gnItem.getMainid().toString() %>" value="<%= CommonDefs.PRODUCT_FEAUTURE_TYPE_SPEC + "" %>">
</td>
<td><%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.type.spec") %></td>
</tr>
</table>
</td>
</tr>
</table>
</fieldset>
</div>
</display:column>

</display:table>
<% if (hasEdit && availableList != null && availableList.size() > 0) { %>
<br>
<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.featureset.members.add") %>">
<% } %>
</form>
