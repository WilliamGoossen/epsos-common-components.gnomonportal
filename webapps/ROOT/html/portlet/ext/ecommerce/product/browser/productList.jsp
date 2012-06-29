<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:useAttribute id="filePath" name="filePath" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="myportletName" name="myportletName" classname="java.lang.String" ignore="true"/>

<%
long companyId = PortalUtil.getCompanyId(request);
boolean manageInventory = EShopPropsUtil.isManageInventory(companyId);

boolean showPrices = EShopPropsUtil.isShowPrices(companyId);
boolean showCart = EShopPropsUtil.isShowCart(companyId);
boolean showTools = EShopPropsUtil.isShowTools(companyId);

Integer prPageSize = GetterUtil.getInteger(GnPropsUtil.get(companyId,"prPageSize"), 10);
PortletURLImpl pURL=null;
if(rootPlid1<=0)
rootPlid1=themeDisplay.getPlid();

double orangeLevel = GetterUtil.getDouble(GnPropsUtil.get(companyId, "orangeInventoryLevel"), 0);
%>



<script type="text/javascript")>
	function <portlet:namespace />addToCart(id, qty) {
		var callurl = '<%= themeDisplay.getPathMain() %>/ext/ecommerce/cart/add';

		jQuery.ajax(
				{
					url: callurl,
					data: {
						productInstanceId: id,
						quantity: qty
					},
					type: 'POST',
					dataType: 'json',
					success: function(data, textStatus) {
						_EC_SHOPPING_CART_populateCart("#_EC_SHOPPING_CART_cart", data);
					},
					error: function(XMLHttpRequest, textStatus, errorThrown) {
						<portlet:namespace />handleJSONError('update', XMLHttpRequest, textStatus, errorThrown)
					}
				}
			);
		return false; //to prevent browser from scrolling page to the top
	}
</script><noscript></noscript>
	


<!-- Styles gia koumpia Grid kai List , Epilogi Emfanisis lista proionton -->
<div class="toggle_button_list-grid">
<% 
List prod = (List) request.getAttribute("products"); 
if(prod!=null && prod.size()>0) { %>	
<div id="list-grid-view">	
	<strong><%=LanguageUtil.get(pageContext,"product-view-legend")%></strong> <span class="viewinlist_active"><%=LanguageUtil.get(pageContext,"product-view-in-list")%></span>
    <a href ="<portlet:renderURL>
		<portlet:param name="struts_action" value ="/ext/products/browser/view"/>
			<portlet:param name="showType" value ="2"/>
		</portlet:renderURL>"><span class="viewingrid"><%=LanguageUtil.get(pageContext,"product-view-in-grid")%></span></a>
</div>
<% } %>
<!-- Styles gia koumpia Grid kai List , Epilogi Emfanisis lista proionton -->	
</div>

<div class="product_list">

<% if(prod!=null && prod.size()>0) { %>
<display:table id="product" name="products" requestURI="//ext/products/browser/view?actionURL=true" pagesize="<%=prPageSize%>" sort="list" export="false" style="width: 100%; border-spacing: 0">
	<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("product"); 
	boolean isAvailable=true;
	String availabilityClass = "";
	boolean newProduct = false;
	if (gnItem!=null ) {
//	Double ammount = new Double(StringUtils.check_null(gnItem.getField5(),"").replace(",","."));
		Double ammount = ((	java.math.BigDecimal)gnItem.getField5()).doubleValue();
	if(Validator.isNull(gnItem.getField5()) || (gnItem.getField5()!=null && ammount<=0))
		isAvailable=false;
	
	if (ammount<=0)
        availabilityClass = "availability-red";
	else if (ammount>orangeLevel) //if no orangeLevel is defined, positive availability is green, which is fine! 
		availabilityClass = "availability-green";
	else 
		availabilityClass = "availability-orange";
	
	newProduct = (gnItem.getField7() != null && (Boolean)gnItem.getField7());
	%>

	<display:setProperty name="basic.show.header" value="true"/>
		
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
            <img src="<%=thumb%>" alt="<%=LanguageUtil.get(pageContext,"product-image")%>"  align="left" /> 
        </span>
        
        <!--  (newProduct) ? "NEW PRODUCT" : ""  -->
        <%if (newProduct){%>
        <span class="new_product">
        <%--<span class="new_product_text"><%= LanguageUtil.get(pageContext, "ecommerce.product.newProduct") %></span>--%>
        </span>
        <%}%>
    
    
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
			
		  if(gnItem.getField12()!=null) 
				pURL.setParameter("productinstanceid" ,gnItem.getField12().toString());
		
			%>	
				
		
    <!-- Product Title -->	
	<span class="producttitle">
		<a href="<%=pURL.toString()%>"> <%= gnItem.getField1().toString() %></a>
     </span>
            <br>

	<!-- desciption -->
		<%  if(gnItem.getField2()!=null) { %>
	<span class="productdescription">
		<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField2(),"")).trim(),100)%>
    </span>
    <br />
	<%}%>







	<!-- price -->
	<% if(showPrices) {%>
	<br />	
	<c:if test="<%=ProductAdminService.getInstance().hasNonDefaultProductInstances(gnItem.getMainid()) %>">
        <%=LanguageUtil.get(pageContext, "from") %>
	</c:if>
	<span class="productprice">
		<%=ProductBrowserService.d2s(((java.math.BigDecimal)gnItem.getField3()).doubleValue())%>&euro;
    </span>
	<%}%>




<%if(manageInventory) {%>
<span class="productavailability">
<% if (availabilityClass.equals("availability-green")) {%>
    		<span style="color:#060"><%=LanguageUtil.get(pageContext,"product-is-available")%></span>
<%} else if (availabilityClass.equals("availability-red")) {%>
    		<span style="color:#F30"><%=LanguageUtil.get(pageContext,"product-is-not-available")%></span>
<%} else if (availabilityClass.equals("availability-orange")) {%>
            <span style="color:#F90"><%=LanguageUtil.get(pageContext,"product-has-limited-availability")%></span>
<%}%>
    </span>
<%}%>

<br />
<br />



<!-- button options -->


<% 
if(showCart) {

if(isAvailable || !manageInventory) {
	if(gnItem.getField12()!=null) {%>
	<div id="add_to_cart_btn">
	<a href="#" onclick="javascript:return <portlet:namespace/>addToCart(<%=gnItem.getField12().toString()%>,1)">
 	<img src="<%= themeDisplay.getPathThemeImages() %>/ecommerce/add-to-cart.gif" alt="<%=LanguageUtil.get(pageContext,"add-to-shopping-cart")%>" border="0" title="<%=LanguageUtil.get(pageContext,"add-to-shopping-cart")%>" /> 
 	</a></div>
	
	
	<%}else {

%>
 <div id="add_to_cart_btn">
<a href="<portlet:actionURL windowState="normal">
			<portlet:param name="struts_action" value="/ext/products/browser/loadProduct"/>
			<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
			<portlet:param name="loadaction" value="view"/>
			<portlet:param name="redirect" value="<%=currentURL%>"/>
			<portlet:param name="ppid" value="<%=myportletName%>"/>
			</portlet:actionURL>"> 
  	<img src="<%= themeDisplay.getPathThemeImages() %>/ecommerce/add-to-cart.gif" alt="<%=LanguageUtil.get(pageContext,"customize-add-to-shopping-cart")%>" border="0" />
 	</a></div>
 <%}
 }
 }%>


<% if(showTools) {%>
<div class="producttools">
	
<!--	<span class="addtowishlist"><a href=""> <%=LanguageUtil.get(pageContext,"add-to-wish-list")%></a></span>
    <br />
	<span class="picktocompare"><a href=""><%=LanguageUtil.get(pageContext,"pick-to-compare")%></a></span>
	-->
	<span class="sendtoafriend">
	<%//@ include file="/html/portlet/ext/ecommerce/product/browser/sendToFriendForm.jsp" %>
	
	<liferay-util:include page="/html/portlet/ext/ecommerce/product/browser/sendToFriendForm.jsp">
		<liferay-util:param name="titleParam" value="<%=gnItem.getField1().toString()%>"/>
		<liferay-util:param name="urlParam" value="<%=pURL.toString()%>"/>
		<liferay-util:param name="idParam" value="<%=gnItem.getMainid().toString()%>"/>
	</liferay-util:include>
	
    </span>
    
</div>
<%}%>
</display:column>

<%}%>
</display:table>
<% } else { %>
	<%=LanguageUtil.get(pageContext, "eshop.noproducts") %>
	
	<%List subCategoryProducts = (List)request.getAttribute("subCategoryProducts");
	if (subCategoryProducts != null && subCategoryProducts.size() > 0){
	%><BR>
	<%=LanguageUtil.get(pageContext, "eshop.checkInSubCategories") %>
	<BR><BR>
	<%} %>
<% } %>

</div>
