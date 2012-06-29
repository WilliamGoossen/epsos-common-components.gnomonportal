<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<tiles:insert page="/html/portlet/ext/ecommerce/product/admin/header.jsp" flush="true">
    <tiles:put name="tab"><%= com.ext.portlet.ecommerce.product.admin.ViewAction.TAB_BULKIMPORT %></tiles:put>
</tiles:insert>


<%
Integer numOfProductsInserted = (Integer)request.getAttribute("numOfProductsInserted");
Integer numOfProductsUpdated = (Integer)request.getAttribute("numOfProductsUpdated");
Integer numOfProductsIgnored = (Integer)request.getAttribute("numOfProductsIgnored");
Integer numOfErrors = (Integer)request.getAttribute("numOfErrors");
%>

<div>
<ul>
    <li><%=LanguageUtil.get(pageContext, "inserted") %>: <%=numOfProductsInserted%></li>
    <li><%=LanguageUtil.get(pageContext, "updated") %>: <%=numOfProductsUpdated%></li>
    <li><%=LanguageUtil.get(pageContext, "ignored") %>: <%=numOfProductsIgnored%></li>
    <li><%=LanguageUtil.get(pageContext, "errors") %>: <%=numOfErrors%></li>
</ul>
</div>