<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:useAttribute id="filePath" name="filePath" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="myportletName" name="myportletName" classname="java.lang.String" ignore="true"/>

<%
try {
boolean manageInventory = EShopPropsUtil.isManageInventory(request);

boolean showPrices = EShopPropsUtil.isShowPrices(request);
boolean showCart = EShopPropsUtil.isShowCart(request);
boolean showTools = EShopPropsUtil.isShowTools(request);

List gnitems = (List) request.getAttribute("products");
Integer itemsInGrid = GetterUtil.getInteger(GnPropsUtil.get("itemsInGrid"), 3);
Integer prPageSize = GetterUtil.getInteger(GnPropsUtil.get("gridPrPageSize"), 10);

org.displaytag.util.ParamEncoder param_encoder = new org.displaytag.util.ParamEncoder("product");
String pencoded=param_encoder.encodeParameterName("p");
String pageNumStr = request.getParameter(pencoded);
int pageNum=1;

if(Validator.isNotNull(pageNumStr))
pageNum = new Integer(pageNumStr).intValue();

Integer gnrownum= (prPageSize*itemsInGrid)*(pageNum-1);

Integer uppage = gnrownum + prPageSize*itemsInGrid;
PortletURLImpl pURL=null;
if(rootPlid1<=0)
rootPlid1=themeDisplay.getPlid();

List products = (List)request.getAttribute("products");
%>



	<script type="text/javascript")>
		function <portlet:namespace />addToCart(id, qty) {
			var callurl = '<%= themeDisplay.getPathMain() %>/ext/ecommerce/cart/add';
			/*callurl = '<portlet:actionURL>
				<portlet:param name="struts_action" value="/ext/ecommerce/cart/save"/>
				</portlet:actionURL>';*/
	
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
							//eval("var myFavorites1={"+data +"}");
							//alert(data.entries);
							//alert(data.entries[0].url);
							//alert(data.entries[0].title);
						},
						error: function(XMLHttpRequest, textStatus, errorThrown) {
							<portlet:namespace />handleJSONError('update', XMLHttpRequest, textStatus, errorThrown)
						}
					}
				);
			//alert('111');
		}
<%--
		function <portlet:namespace />populateCart(elementid, data) {
			_$J("#_EC_SHOPPING_CART_cart").empty();
			for (var i=0; i<data.length; i++) {
				var fav = "<img src=\"<%=themeDisplay.getPathThemeImages()%>/custom/bullet1.gif\" title=\"go\" style=\"vertical-align:middle;padding-right:7px;\" /><a href=\"" + data[i].productInstanceId + "\">" + "sample product" + " (" + decodeURI(data[i].quantity) + " items)" + "</a>";
				var favdel = "<a href=\"javascript:<portlet:namespace/>deleteFromCart('" + data[i].productInstanceId + "', '" + data[i].quantity + "')\"><img src=\"<%=themeDisplay.getPathThemeImages()%>/ecommerce/remove.gif\" title=\"<%=LanguageUtil.get(pageContext, "delete.from.cart") %>\" style=\"vertical-align:middle;padding-left:7px;\" /></a>";
				//alert(favdel);
				_$J("#_EC_SHOPPING_CART_cart").append(fav);
				_$J("#_EC_SHOPPING_CART_cart").append(favdel);
				_$J("#_EC_SHOPPING_CART_cart").append("<br/>");
			}
			//_$J("#<portlet:namespace />howto").empty();
		}
		--%>
	</script><noscript></noscript>
	
	
<%if(products!= null && products.size()>0) { %>

<div class="featuredgrid">
<display:table id="gridproduct" name="products" requestURI="//ext/products/browser/view?actionURL=true"  sort="list" export="false" style="width: 100%; border-spacing: 0" >

<display:setProperty name="basic.show.header" value="false"/>
<display:setProperty name="css.tr.even" value="gridrow"/>
<display:setProperty name="css.tr.odd" value="gridrow"/>
<display:setProperty name="css.table" value="gridtable"/>	
	
<% int disprownum = (Integer) pageContext.getAttribute("gridproduct_rowNum"); %>


<display:column titleKey="title" sortable="false" >
	

<% if(disprownum%2==0) {%>

	<div class="listing-type-grid-even ">
	
<%} else {%>
  <div class="listing-type-grid-odd ">
  <%}                 	
 if(gnrownum<gnitems.size() && gnrownum<uppage) {      %> 

	<ol class="grid-row ">
	
	<% 
	for(int j=0; j<itemsInGrid;j++) {
	
	if(gnrownum<gnitems.size() && gnrownum<uppage) {
		
		ViewResult gnItem = (ViewResult) gnitems.get(gnrownum);
		gnrownum=gnrownum+1;
	
	%>
	  
	<% boolean isAvailable=true;
	if (gnItem!=null ) {
	Double ammount = ((	java.math.BigDecimal)gnItem.getField5()).doubleValue();
	if(Validator.isNull(gnItem.getField5()) || (gnItem.getField5()!=null && ammount<=0))
		isAvailable=false;
	%>

	
		<li class="griditem">
    	<%
		String thumb = "";
		if (gnItem.getField4()==null && gnItem.getField13()==null)
			thumb = themeDisplay.getPathThemeImages() + "/ecommerce/no-image-120.jpg";
		else {
			String imagepath = "/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + gnItem.getMainid() + "/" +  StringUtils.check_null(gnItem.getField4(),StringUtils.check_null(gnItem.getField13(),""));
			thumb = gnomon.business.GeneralUtils.createThumbnailPath(imagepath);
			thumb=thumb.replace("thumbnail","thumbnail2");
		}
		%>
    	
    	<img src="<%=thumb%>" alt="<%=LanguageUtil.get(pageContext,"product-image")%>"  /> <br>
    	
    	
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
            <br>

	<!-- desciption -->
		<%  if(gnItem.getField12()!=null) { %>
	<%=StringUtils.subStr(StringUtils.stripHTML(StringUtils.check_null(gnItem.getField2(),"")).trim(),50)%>
	<%}%>

	<!-- price -->
	<% if(showPrices) {%>
	<c:if test="<%=ProductAdminService.getInstance().hasNonDefaultProductInstances(gnItem.getMainid()) %>">
        <%=LanguageUtil.get(pageContext, "from") %>
    </c:if>
	<span class="productprice">
		<%=ProductBrowserService.d2s(((java.math.BigDecimal)gnItem.getField3()).doubleValue())%>&euro;
    </span>

<%}%>
	
</li>


	
	<%}
	}
	}%>
	</ol>
<%}%>
	<div>
	</display:column>
	

</display:table>
</div>

<%}%>



<%} catch (Exception e) {
	e.printStackTrace();
	}%>

