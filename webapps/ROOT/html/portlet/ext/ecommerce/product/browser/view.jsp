<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>



<%

 String filePath = GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH); 
 String instanceProductListType=GetterUtil.getString(prefs.getValue("productListType", StringPool.BLANK));	

//	PortletConfigImpl portletConfig = (PortletConfigImpl)request.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);

String myportletName =((PortletConfigImpl)portletConfig).getPortletId();
String showType = (String)request.getParameter("showType");

if(Validator.isNull(showType)){
	String prefListViewType = GetterUtil.getString(prefs.getValue("productListViewType", "1"));
	showType= (Validator.isNotNull(prefListViewType)) ? prefListViewType : "1";
}
%>

<c:choose>
	<c:when test="<%=instanceProductListType.equals("featuredlist") || instanceProductListType.equals("newlist") || instanceProductListType.equals("promotedlist")%>">
		<%
			Integer visibilityType = instanceProductListType.equals("featuredlist")? CommonDefs.PRODUCT_VISIBILTY_FEATURED:
				(instanceProductListType.equals("newlist")? CommonDefs.PRODUCT_VISIBILTY_NEW: CommonDefs.PRODUCT_VISIBILTY_PROMOTED);
		%>
		<c:choose>
			<c:when test="<%=showType.equals("3")%>">
				<tiles:insert page="/html/portlet/ext/ecommerce/product/browser/featuredCarousel.jsp" flush="true">
					<tiles:put name="filePath" value="<%=filePath%>"/>
					<tiles:put name="visibilityType" value="<%=visibilityType%>"/>
					<tiles:put name="myportletName" value="<%=myportletName%>"/>
				</tiles:insert>
			</c:when>
			<c:when test="<%=showType.equals("2")%>">
				<tiles:insert page="/html/portlet/ext/ecommerce/product/browser/featuredGrid.jsp" flush="true">
					<tiles:put name="filePath" value="<%=filePath%>"/>
					<tiles:put name="visibilityType" value="<%=visibilityType%>"/>
					<tiles:put name="myportletName" value="<%=myportletName%>"/>
				</tiles:insert>
			</c:when>
			<c:otherwise>
                <tiles:insert page="/html/portlet/ext/ecommerce/product/browser/featuredList.jsp" flush="true">
                    <tiles:put name="filePath" value="<%=filePath%>"/>
                    <tiles:put name="visibilityType" value="<%=visibilityType%>"/>
                    <tiles:put name="myportletName" value="<%=myportletName%>"/>
                </tiles:insert>
			</c:otherwise>
		</c:choose>
		
	</c:when>
	<c:otherwise>
		<%-- Show products catalog --%>
        <%
		List products = (List)request.getAttribute("products");
		%>
        <c:choose>
			<c:when test="<%=showType.equals("2")%>">
                <tiles:insert page="/html/portlet/ext/ecommerce/product/browser/productGrid.jsp" flush="true">
            		<tiles:put name="filePath" value="<%=filePath%>"/>
            		<tiles:put name="myportletName" value="<%=myportletName%>"/>
        		</tiles:insert>
            </c:when>
            <c:otherwise>
                <tiles:insert page="/html/portlet/ext/ecommerce/product/browser/productList.jsp" flush="true">
                	<tiles:put name="filePath" value="<%=filePath%>"/>
                	<tiles:put name="myportletName" value="<%=myportletName%>"/>
            	</tiles:insert>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>