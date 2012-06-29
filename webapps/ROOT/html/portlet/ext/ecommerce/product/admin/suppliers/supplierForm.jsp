<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/products/admin/updateSupplier?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "ec.admin.supplier.edit";
if (loadaction.equals("delete"))
{
 	formUrl = "/ext/products/admin/deleteSupplier?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "ec.admin.supplier.delete";
}
else if (loadaction.equals("add"))
{
	formUrl = "/ext/products/admin/addSupplier?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "ec.admin.supplier.add";
}
%>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_SUPPLIERS %></tiles:put>
</tiles:insert>

<h3><%= LanguageUtil.get(pageContext, titleText) %></h3>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="PrSupplierForm"/>
</tiles:insert>

<div class="button-holder">
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, buttonText ) %>">

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>

</div>
</html:form>


