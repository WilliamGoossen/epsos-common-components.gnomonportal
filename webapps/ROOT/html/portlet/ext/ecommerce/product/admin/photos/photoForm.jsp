<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
String productid = request.getParameter("productid");
%>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_PRODUCTS %></tiles:put>
</tiles:insert>


<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/productHeader.jsp" flush="true">
	<tiles:put name="productTab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.PRODUCT_TAB_IMAGES %></tiles:put>
	<tiles:put name="productid"><%= productid %></tiles:put>
</tiles:insert>


<%
String loadaction = (String)request.getAttribute("loadaction");
String formUrl = "/ext/products/admin/updateProductPhoto?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "ec.admin.product.photo.edit";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/products/admin/deleteProductPhoto?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "ec.admin.product.photo.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/products/admin/addProductPhoto?actionURL=true" ;
	buttonText = "gn.button.add";
	titleText = "ec.admin.product.photo.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/products/admin/addProductPhoto?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "ec.admin.product.photo.add-translation";
}
%>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data" styleClass="uni-form">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>


<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="PrProductPhotoForm"/>

</tiles:insert>

<div class="button-holder">

<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<logic:notEqual name="PrProductPhotoForm" property="lang" value="<%= defLang %>">
<% if (!loadaction.equals("trans")) { %>
<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
  <tiles:put name="action"  value="/ext/products/admin/deleteProductPhoto" />
  <tiles:put name="buttonName" value="deleteButton" />
  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
  <tiles:put name="formName"   value="PrProductPhotoForm" />
  <tiles:put name="confirm" value="gn.messages.are-you-sure-you-want-to-delete-this-translation"/>
  <tiles:put name="actionParam" value="deleteDetail"/>
  <tiles:put name="actionParamValue" value="1"/>
</tiles:insert>
<% } %>
</logic:notEqual>

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


<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2">Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/products/admin/loadProductPhoto" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="view"/>
	    <tiles:putList name="editActionParamList">
	    	<tiles:add value="productid"/>
	    </tiles:putList>
	    <tiles:putList name="editActionParamValueList">
	    	<tiles:add><%= productid %></tiles:add>
	    </tiles:putList>
	    <tiles:put name="addAction"  value="/ext/products/admin/loadProductPhoto" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	    <tiles:putList name="addActionParamList">
	    	<tiles:add value="productid"/>
	    </tiles:putList>
	    <tiles:putList name="addActionParamValueList">
	    	<tiles:add><%= productid %></tiles:add>
	    </tiles:putList>
	</tiles:insert>
</c:if>
