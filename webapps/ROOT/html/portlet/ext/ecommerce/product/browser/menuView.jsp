<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>


<%

 String filePath = GetterUtil.getString(PropsUtil.get("ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH); 
 String instanceProductListType=GetterUtil.getString(prefs.getValue("productListType", StringPool.BLANK));	

//	PortletConfigImpl portletConfig = (PortletConfigImpl)request.getAttribute(JavaConstants.JAVAX_PORTLET_CONFIG);
String myportletName =((PortletConfigImpl)portletConfig).getPortletId();
%>


<tiles:insert page="/html/portlet/ext/ecommerce/product/browser/menuProductList.jsp" flush="true">
	<tiles:put name="filePath" value="<%=filePath%>"/>
	<tiles:put name="myportletName" value="<%=myportletName%>"/>
</tiles:insert>
	
