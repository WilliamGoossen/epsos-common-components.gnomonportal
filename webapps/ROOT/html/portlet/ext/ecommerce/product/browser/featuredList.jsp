<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:useAttribute id="filePath" name="filePath" classname="java.lang.String" ignore="true"/>
	<tiles:useAttribute id="visibilityType" name="visibilityType" classname="java.lang.Integer" ignore="true"/>
<tiles:useAttribute id="myportletName" name="myportletName" classname="java.lang.String" ignore="true"/>

<%
	boolean manageInventory = EShopPropsUtil.isManageInventory(request);
	boolean showPrices = EShopPropsUtil.isShowPrices(request);
	
	
	PortletURLImpl pURL=null;
	if(rootPlid1<=0)
	rootPlid1=themeDisplay.getPlid();
%>





<display:table id="product" name="products" requestURI="//ext/products/browser/view?actionURL=true"  sort="list" export="false" style="width: 100%;">


	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("product"); 
	
	if (gnItem!=null ) {
	%>

	<display:setProperty name="basic.show.header" value="false"/>
		
    <display:column >
    
        
    	<%
		String thumb = "";
		if (gnItem.getField4()==null && gnItem.getField13()==null)
			thumb = themeDisplay.getPathThemeImages() + "/ecommerce/no-image-80.jpg";
		else {
			String imagepath = "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + gnItem.getMainid() + "/" +  StringUtils.check_null(gnItem.getField4(),StringUtils.check_null(gnItem.getField13(),""));
			thumb = gnomon.business.GeneralUtils.createThumbnailPath(imagepath);
			thumb=thumb.replace("thumbnail","thumbnail2");
		}
		%>
    	
    	<img src="<%=thumb%>" alt="news-image"  hspace="2" vspace="2" align="left" /> <br>
    	
    	
       <% 
    
    
    if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, "EC_PRODUCT_BROWSER", rootPlid1, true);
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					pURL = new PortletURLImpl(req, "EC_PRODUCT_BROWSER", rootPlid1, true);
				}
    
  
		
			pURL.setWindowState(WindowState.NORMAL);
			pURL.setPortletMode(PortletMode.VIEW);
			pURL.setParameter("struts_action", "/ext/products/browser/loadProduct");	
    	pURL.setParameter("mainid" ,  gnItem.getMainid().toString());
			pURL.setParameter("loadaction" , "view");
			pURL.setParameter("redirect" , currentURL);
			
			%>	
    	
    	
	<strong><a href="<%=pURL.toString()%>"> <%= gnItem.getField1().toString() %></a></strong>
			
            <br><br>
            
<span class="promotedProduct">
	<%=ProductBrowserService.getInstance().getProductVisibilityComment(gnItem.getMainid(),visibilityType)%>
</span>


<br>
	<!-- desciption -->
	<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField2(),"")).trim(),50)%>
	<br>
	<!-- price -->
	<% if(showPrices) {%>
	<c:if test="<%=ProductAdminService.getInstance().hasNonDefaultProductInstances(gnItem.getMainid()) %>">
        <%=LanguageUtil.get(pageContext, "from") %>
    </c:if>
	<span class="productprice">
	<%=ProductBrowserService.d2s(((java.math.BigDecimal)gnItem.getField3()).doubleValue())%>&euro;
	</span>
<%}%>
<!-- button options -->
<!-- 
 <button class="form-button" onclick=""><span><%=LanguageUtil.get(pageContext,"product.add.to.cart")%></span></button>
  <p>  <a href="" ><%=LanguageUtil.get(pageContext,"product.add.to.wishlist")%></a><br>
     <a href=""><%=LanguageUtil.get(pageContext,"product.add.to.compare")%></a><br>
       <a href=""><%=LanguageUtil.get(pageContext,"product.send.to.a.friend")%></a>
-->

	</display:column>
    

<%}%>


</display:table>




