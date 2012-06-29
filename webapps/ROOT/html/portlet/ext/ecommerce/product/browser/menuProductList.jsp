<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:useAttribute id="filePath" name="filePath" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="myportletName" name="myportletName" classname="java.lang.String" ignore="true"/>

<%
boolean manageInventory = EShopPropsUtil.isManageInventory(request);

boolean showPrices = EShopPropsUtil.isShowPrices(request);
boolean showCart = EShopPropsUtil.isShowCart(request);
boolean showTools = EShopPropsUtil.isShowTools(request);

Integer prPageSize = GetterUtil.getInteger(GnPropsUtil.get("prPageSize"), 10);
PortletURLImpl pURL=null;
if(rootPlid1<=0)
rootPlid1=themeDisplay.getPlid();

%>



<% 
List prod = (List) request.getAttribute("products"); 
if(prod!=null && prod.size()>0) { %>	

<% } %>


<div class="menu_product_list">

<% if(prod!=null && prod.size()>0) { %>
<display:table id="product" name="products" requestURI="//ext/products/browser/view?actionURL=true" sort="list" export="false" style="width:100%;">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("product"); 
	boolean isAvailable=true;
	if (gnItem!=null ) {
//	Double ammount = new Double(StringUtils.check_null(gnItem.getField5(),"").replace(",","."));
		Double ammount = ((	java.math.BigDecimal)gnItem.getField5()).doubleValue();
	if(Validator.isNull(gnItem.getField5()) || (gnItem.getField5()!=null && ammount<=0))
		isAvailable=false;
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
		
    	<span class="productimage">
    	<img src="<%=thumb%>" width="80" height="60" alt="<%=LanguageUtil.get(pageContext,"product-image")%>"  align="left" /> 
    	</span>
    
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
			pURL.setParameter("productViewType" , "2");
			pURL.setParameter("redirect" , currentURL);
			
		  if(gnItem.getField12()!=null) 
				pURL.setParameter("productinstanceid" ,gnItem.getField12().toString());
		
			%>	
				
		
    <!-- Product Title -->	
	<span class="producttitle">
		<a href="<%=pURL.toString()%>"> <%= gnItem.getField1().toString() %></a>
     </span>

	<!-- desciption -->
		<%  if(gnItem.getField12()!=null) { %>
	<span class="productdescription">
		<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField2(),"")).trim(),100)%>
    </span>
    <br />
	<%}%>


	
</display:column>

<%}%>
</display:table>
<% } else { %>
	<%=LanguageUtil.get(pageContext, "eshop.noproducts") %>
<% } %>

</div>
