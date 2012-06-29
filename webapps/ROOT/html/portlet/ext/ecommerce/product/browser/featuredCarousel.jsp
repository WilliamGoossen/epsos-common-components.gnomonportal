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
	
	List products = (List)request.getAttribute("products");
%>

<c:if test="<%=products!=null && products.size()>0%>">
	<script type="text/javascript" src="/html/js/jcarousel/jquery.jcarousel.min.js"></script>
   
    <script type="text/javascript"> 
     
    jQuery(document).ready(function() {
        jQuery('#<portlet:namespace/>mycarousel').jcarousel();
    });
     
    </script>
    
    <ul id="<portlet:namespace/>mycarousel" class="jcarousel-skin-tango">
    	<% for (int i=0; i<products.size(); i++) {
			ViewResult gnItem = (ViewResult) products.get(i);
			
			//create image source url
			String thumb = "";
			if (gnItem.getField4()==null && gnItem.getField13()==null)
				thumb = themeDisplay.getPathThemeImages() + "/ecommerce/no-image-80.jpg";
			else {
				String imagepath = "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + gnItem.getMainid() + "/" +  StringUtils.check_null(gnItem.getField4(),StringUtils.check_null(gnItem.getField13(),""));
				thumb = gnomon.business.GeneralUtils.createThumbnailPath(imagepath);
				thumb=thumb.replace("thumbnail","thumbnail2");
			}
			
			//create link url
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
	        <li>
            	
                	<%--<img src="http://static.flickr.com/66/199481236_dc98b5abb3_s.jpg" width="75" height="75" alt="" />--%>
                	
                    <span class="productimage">
                    <img src="<%=thumb%>" alt="news-image" />
                    </span>

                    				
                    <a href="<%=pURL.toString()%>">
                    
                    <span class="producttitle">
					<%= gnItem.getField1().toString() %>
                    </span>
                    <br />

<!--                    <span class="promotedProduct">
						<%=ProductBrowserService.getInstance().getProductVisibilityComment(gnItem.getMainid(),visibilityType)%>
					</span>-->
                    
                    <!-- desciption -->
<!--                    <span class="productdescription">
                    <%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField2(),"")).trim(),50)%>
                    </span>
-->                    
                    <!-- price -->
                    <% if(showPrices) {%>
                        <c:if test="<%=ProductAdminService.getInstance().hasNonDefaultProductInstances(gnItem.getMainid()) %>">
                            <%=LanguageUtil.get(pageContext, "from") %>
                        </c:if>
                        <span class="productprice">
                        <%=ProductBrowserService.d2s(((java.math.BigDecimal)gnItem.getField3()).doubleValue())%>&euro;
                        </span>
                    <%}%>
                    
            	</a>
            </li> 
        <%}%>
	</ul> 
</c:if>