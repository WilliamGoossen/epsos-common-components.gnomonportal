<%@ include file="/html/portlet/ext/ecommerce/cart/init.jsp" %>

<%
String url=themeDisplay.getPathMain() + "/ext/ecommerce/cart/save";
String mainStorePage = GnPropsUtil.get(PortalUtil.getCompanyId(request),"mainStorePage");
Long companyId = com.liferay.portal.util.PortalUtil.getCompanyId(request);
boolean showDiscount = false;
if (com.ext.portlet.ecommerce.pricing.EcommercePriceUpdaterUtil.useCatalogs(companyId) &&
		 com.ext.portlet.ecommerce.pricing.EcommercePriceUpdaterUtil.getEcommercePriceUpdater(companyId).userCustomerSpecificDiscount()) 
	showDiscount = true;

%>

<div id="cart-1">

	<div id="<portlet:namespace/>cart">
		<%-- this div fills dynamically on load and on every cart change --%>
	
	</div>
	<%--
	<div id="<portlet:namespace/>myItem" style="padding-top:10px;">
		<a href="javascript:<portlet:namespace/>clearCart()"><%=LanguageUtil.get(pageContext, "empty-shopping-cart") %></a>
	</div>
	--%>	
	
	<script type="text/javascript")>
		_$J(document).ready(function(){
			<portlet:namespace />getShoppingCart();
		});

		function <portlet:namespace />clearCart() {

			if (confirm('<%= UnicodeLanguageUtil.get(pageContext, "are-you-sure-you-want-to-empty-your-shopping-cart") %>')) {
			var callurl = '<%= themeDisplay.getPathMain() %>/ext/ecommerce/cart/update';
	
			jQuery.ajax(
					{
						url: callurl,
						data: {
							cmd: 'clear'
						},
						type: 'POST',
						dataType: 'json',
						success: function(data, textStatus) {
							<portlet:namespace />populateCart("#<portlet:namespace />cart", data);
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
		}
		
		function <portlet:namespace />deleteFromCart(id) {
			var callurl = '<%= themeDisplay.getPathMain() %>/ext/ecommerce/cart/delete';
	
			jQuery.ajax(
					{
						url: callurl,
						data: {
							productInstanceId: id
						},
						type: 'POST',
						dataType: 'json',
						success: function(data, textStatus) {
							<portlet:namespace />populateCart("#<portlet:namespace />cart", data);
						},
						error: function(XMLHttpRequest, textStatus, errorThrown) {
							<portlet:namespace />handleJSONError('delete', XMLHttpRequest, textStatus, errorThrown);
						}
					}
				);	
		}
		
		function <portlet:namespace />getShoppingCart() {
			var callurl = '<%= themeDisplay.getPathMain() %>/ext/ecommerce/cart/get';
	
			jQuery.ajax(
					{
						url: callurl,
						type: 'POST',
						dataType: 'json',
						success: function(data, textStatus) {
							<portlet:namespace />populateCart("#<portlet:namespace />cart", data);
						},
						error: function(XMLHttpRequest, textStatus, errorThrown) {
							<portlet:namespace />handleJSONError('retrieve', XMLHttpRequest, textStatus, errorThrown)
						}
					}
				);	
		}
		
		function <portlet:namespace />populateCart(elementid, data) {
			_$J("#<portlet:namespace />cart").empty();
			if (data.length>0) {
				var s = "";
				s += "<ul id=\"cart-items\">";
				
				for (var i=0; i<data.length; i++) {
					var productInstanceId = data[i].productInstanceId;
					var productId = data[i].productId;
					var quantity = decodeURI(data[i].quantity==null || data[i].quantity=='' || data[i].quantity=='null'? 1: data[i].quantity); //data[i].quantity;
					var price = decodeURI(data[i].price); //data[i].price;
					var priceBeforeDiscount = decodeURI(data[i].priceBeforeDiscount);
					var discount = decodeURI(data[i].discount);
					var title = decodeURI(data[i].title); //data[i].title;
					var itemHREF = "<%=mainStorePage%>/~/product/view/normal/view/" + productId + "/" + productInstanceId + "/0";
					var itemImgHTML = "<a href=\"" + itemHREF + "\"><img src=\"iphone.jpg\" title=\"iphone\" /></a>";					
					var itemDetailsHTML = "<a href=\"" + itemHREF + "\">" + title + " (<%=LanguageUtil.get(pageContext, "quantity")%> " + quantity + ")" + "</a>";
					var itemDeleteHTML = "<a href=\"javascript:<portlet:namespace/>deleteFromCart('" + data[i].productInstanceId  + "')\"><img src=\"<%=themeDisplay.getPathThemeImages()%>/ecommerce/remove.gif\" title=\"<%=LanguageUtil.get(pageContext, "remove-item") %>\" style=\"vertical-align:middle;padding-left:1px;\" /></a>";


					s += "<li>";
					//s += "<div class=\"cart-item-image\">";
					//s += itemImgHTML;
					//s += "</div>";
					s += "<div class=\"cart-item-details\">";
					s += itemDetailsHTML;
					s += itemDeleteHTML;
					s += "<br/>";
					<c:if test="<%=EShopPropsUtil.isShowPrices(request) %>">
						s += "<span class=\"quantity\">";
						s += quantity;
						s += "</span>";
						s += " x ";
						<% if (showDiscount) { %>
						s += " (&euro; "+priceBeforeDiscount+" - "+discount+"%) ";
						<% } %>
						s += "<span class=\"price\">";
						s += "&euro; ";
						s += price;
						s += "</span>";
					</c:if>
					s += "</div>";
					s += "</li>";

				}

				s += "</ul>";

				//add clear basket link
				_$J("#<portlet:namespace />cart").append("<div>").append("<a class=\"clear_cart_link\" href=\"javascript:<portlet:namespace/>clearCart()\"><%=LanguageUtil.get(pageContext, "empty-shopping-cart") %></a>").append("</div>");
				//add checkout button
				s += "<br/>";
				s += "<div class=\"cart-checkout\"><a href=\"<%=checkoutURL%>?<portlet:namespace/>redirect=<%=currentURL%>\" title=\"<%=LanguageUtil.get(pageContext, "checkout") %>\"><span><%=LanguageUtil.get(pageContext, "checkout") %></span></a></div>";

				_$J("#<portlet:namespace />cart").append(s);
			} else {
				_$J("#<portlet:namespace />cart").append("<p><%=LanguageUtil.get(pageContext, "your-shopping-cart-is-empty") %>.</p>");
			}
		}
		
		function <portlet:namespace />handleJSONError(action, XMLHttpRequest, textStatus, errorThrown) {
			//alert('Oups! An error accured while trying to perform "' + action + '" to your favorites');
		}
	</script>
	<noscript></noscript>


</div>