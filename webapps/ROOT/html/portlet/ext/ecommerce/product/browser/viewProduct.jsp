<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%
/***

EINAI SHMANTIKO NA MEINOUN TA IDS SE OLA TA DIVS KAI TA YPOLOIPA ELEMENTS
GIATI ALLIOS DEN THA DOULEUEI SOSTA H FORMA TO JS KAI TO KALATHI

DIATHESIMA PEDIA PRODUCT:
------------------------
MONADA METRHSHS->metric
PROMITHEYTIS->supplier
KATASKEYASTHS->manufacturer
name->view.getField3() //String
description->view.getField4() //String
productcode->view.getField5() //String
imagefile->view.getField6() //String
orderindex->view.getField7() //Integer
docfile->view.getField8() //String
inventory->view.getField9() //BigDecimal
price->view.getField10() //BigDecimal
------------------------
**/

long companyId = PortalUtil.getCompanyId(request);
boolean enablePrint = true;
boolean manageInventory = EShopPropsUtil.isManageInventory(companyId);
boolean showNoImageIfInstanceImageMissing = EShopPropsUtil.isShowNoImageIfInstanceImageMissing(companyId);
boolean showPrices = EShopPropsUtil.isShowPrices(companyId);
boolean showCart = EShopPropsUtil.isShowCart(companyId);
boolean showTools = EShopPropsUtil.isShowTools(companyId);
boolean showRating = EShopPropsUtil.isShowRating(companyId);
boolean showComments = EShopPropsUtil.isShowComments(companyId);
boolean hideInstanceIfNotAvailable = true;

//main product ViewResult, and relevant prepared objects
ViewResult view = (ViewResult) request.getAttribute("productItem");
List productSpecs = (List)request.getAttribute("productSpecs"); 
List productAttributesValues = (List)request.getAttribute("productAttributes"); 
List productPhotos = (List)request.getAttribute("productPhotos"); 
List productInstances = (List)request.getAttribute("productInstances");
String promotedComment = (String)request.getAttribute("promotedComment");
boolean isPromoted = promotedComment!=null;
String featuredComment = (String)request.getAttribute("featuredComment");
boolean isFeatured = featuredComment!=null;
String newComment = (String)request.getAttribute("newComment");
boolean isNew = newComment!=null;
String supplier = (String)request.getAttribute("supplier");
String manufacturer = (String)request.getAttribute("manufacturer");
String metric = (String)request.getAttribute("metric");

//main product fields
Integer productId = view.getMainid();
String productName = ViewResultUtil.getString(view, "field3");
String productDescription = ViewResultUtil.getString(view, "field4");
String productCode = ViewResultUtil.getString(view, "field5");
String productImageFile = ViewResultUtil.getString(view, "field6", "");
Integer productOrderindex = view.getField7()!=null? (Integer)view.getField7(): null;
String productDocFile = ViewResultUtil.getString(view, "field8");
BigDecimal productInventory = view.getField9()!=null? (BigDecimal)view.getField9(): BigDecimal.ZERO;
BigDecimal productPrice = view.getField10()!=null? (BigDecimal)view.getField10(): null;

//product fields extracted from main
boolean hasMultipleInstances = productInstances!=null && productInstances.size()>1; //counting default instance too 
boolean hasImage = Validator.isNotNull(productImageFile);
boolean hasMorePhotos = productPhotos!=null && productPhotos.size()>0;
boolean hasSpecs = productSpecs!=null && productSpecs.size()>0;
String filePath = GetterUtil.getString(PropsUtil.get(companyId, "ecommerce.product.store"), CommonDefs.DEFAULT_STORE_PATH);
String imageLocation = "/FILESYSTEM/" + companyId + "/" + filePath + productId + "/";
String productImageFullPath = "/FILESYSTEM/" + companyId + "/" + filePath + productId + "/" + productImageFile;
String noImageFullPath260 = themeDisplay.getPathThemeImages() + "/ecommerce/no-image-260.jpg";
String noImageFullPath100 = themeDisplay.getPathThemeImages() + "/ecommerce/no-image-100.jpg";

Double productInventoryDbl = productInventory.doubleValue();
boolean isAvailable = (productInventoryDbl > 0);
double orangeLevel = GetterUtil.getDouble(GnPropsUtil.get(companyId, "orangeInventoryLevel"), 0);
String availabilityClass = "";
if (productInventoryDbl<=0)
    availabilityClass = "availability-red";
else if (productInventoryDbl>orangeLevel) //if no orangeLevel is defined, positive availability is green, which is fine! 
    availabilityClass = "availability-green";
else 
    availabilityClass = "availability-orange"; 
Double productPriceDbl = productPrice!=null? productPrice.doubleValue(): null;


String quantity = "1";
quantity = Validator.isNotNull(request.getParameter(quantity))? request.getParameter(quantity): quantity;

String productinstanceid = request.getParameter("productinstanceid"); 
Hashtable selectedAttributes =(Hashtable) request.getAttribute("selectedAttributes");

//valid and active attribute combinations (extracted from productInstances)
Hashtable validAttributeValues = new Hashtable<String,String>();

//prepare a list with distinct product attributes
List<ViewResult> productAttributesDistinct = new ArrayList<ViewResult>();
String productAttributesDistinctIds = "";
for (int j=0; productAttributesValues!=null && j<productAttributesValues.size(); j++) {
    ViewResult attr = (ViewResult)productAttributesValues.get(j);
    Integer attrId = attr.getField3()!=null? (Integer)attr.getField3(): null; //e.g. 182, mainid of attribute Color (same for all product instances)
    String attrName = ViewResultUtil.getString(attr, "field1"); //e.g. Color (same for all product instances)
    if (productAttributesDistinctIds.indexOf("," + String.valueOf(attrId))==-1) {
    	productAttributesDistinctIds += "," +  String.valueOf(attrId);
    	productAttributesDistinct.add(new ViewResult(attrId, attrName)); //add attribute to distinct list
    }
}
//get first attribute if any
Integer firstAttrId = null;
String firstAttrName = null;
if (productAttributesDistinct != null && !productAttributesDistinct.isEmpty()){
    ViewResult firstAttr = (ViewResult)productAttributesDistinct.get(0);
    firstAttrId = firstAttr.getMainid(); //e.g. 182, mainid of attribute Color (same for all product instances)
    firstAttrName = ViewResultUtil.getString(firstAttr, "field1"); //e.g. Color (same for all product instances)
}

String viewTypeParam = request.getParameter("productViewType");
viewTypeParam = (Validator.isNull(viewTypeParam)) ? "1" : viewTypeParam;
%>


<script type="text/javascript">
	
	function <portlet:namespace />addCombinationToCart() {

		var formObj = document.getElementById("BS_PRODUCT_COMBINATION");
		
		var prInst=formObj.elements["prInst"];
		var quantity =formObj.elements["quantity"];
		if (quantity.value==null || quantity.value=='' || quantity.value=='null')
			quantity.value = 1
		
		return <portlet:namespace />addToCart(prInst.value, quantity.value);
	}
	
	function <portlet:namespace />addInstanceIdToCart(id) {
			var formObj = document.getElementById("BS_PRODUCT_COMBINATION");
		
		var quantityName= "quantity"+id;
		
		var quantity =formObj.elements[quantityName];
		if (quantity.value==null || quantity.value=='' || quantity.value=='null')
               quantity.value = 1
               
		return <portlet:namespace />addToCart(id, quantity.value);
	}
	
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

    var manageInventory=<%=manageInventory%>;

    //structure to hold product instance objects
    function ProductInstances(id, name, imageFile,finalprice,inventory,erpcode,productcode,featuresIds, featuresValuesIds)
	{
		this.id = id;
		this.name = name;
		this.imageFile = imageFile;
		this.finalprice = finalprice;
		this.inventory = inventory;
		
		//if((inventory=="null" || inventory=="0" || inventory=="0.00") && manageInventory==false)
		if( manageInventory==false)
			this.inventory=1;
		
		this.erpcode = erpcode;
		this.productcode = productcode;
		this.featuresIds = featuresIds;
		this.featureValueIds = featuresValuesIds;
	}

	//fill in product instances object array
    var productInstanceArr = new Array(
	    <% 
	    String id = "";
		String name = "";
		String imageFile = "";
		String finalprice = "";
		Double inventory = 0.0;
		String erpcode = "";
		String productcode = "";
		String featureIds="";
		String featureValuesIds="";
		String featureValuesNames[]={""};
		
	    for (int p=0; p<productInstances.size(); p++) {
	    	ViewResult prodInst = (ViewResult)productInstances.get(p); 
			
	    	id = ViewResultUtil.getString(prodInst, "field12", "");
			name = ViewResultUtil.getString(prodInst, "field1");
			imageFile = ViewResultUtil.getString(prodInst, "field4");
			finalprice = ViewResultUtil.getString(prodInst, "field3", ""); //prodInst.getField3().toString();
			BigDecimal prodInstInventory = prodInst.getField5()!=null? (BigDecimal)prodInst.getField5(): BigDecimal.ZERO;
			inventory = prodInstInventory.doubleValue();
			erpcode = ViewResultUtil.getString(prodInst, "field6");
			productcode = ViewResultUtil.getString(prodInst, "field7");
			featureIds = ViewResultUtil.getString(prodInst, "field9"); //183,182 (feature ids of size, color respectively: same for all instances)
			featureValuesIds = ViewResultUtil.getString(prodInst, "field10"); //284,292 (feature value ids for M2/W4, Aspro)
			featureValuesNames = ViewResultUtil.getString(prodInst, "field8", "").split(","); //M2/W4, Aspro
			//System.out.println(featureIds);
			//System.out.println(featureValuesIds);
			//System.out.println(featureValuesNames);
			name = name.replaceAll("\"","'");
	 	%>

	 	    new ProductInstances("<%= id %>", "<%=name %>", "<%= imageFile %>", "<%= finalprice %>", "<%= inventory %>"
	 				  , "<%= erpcode %>","<%= productcode %>","<%=featureIds%>", "<%=featureValuesIds%>")
	       <% if (p<productInstances.size()-1) { %> , <% } %>
	    
	    <% } //end for all instances loop %>
    ); //end new javascript Array
    
    
    function findCombination(formObj) {
		var attributes;
		var attributeIds;
		var attributeValues="";
		var prInstance;
		var featuresIds;
		var featuresValues;
		var valueObj;
		var combinationValues;
		var attrFound;
		var selectedInstance;

		initializeAttributesSelectElements(<%=hideInstanceIfNotAvailable%>);
				
		if (productInstanceArr.length==1) {
		    selectedInstance = productInstanceArr[0];
		} else if (formObj.elements["attributes"]!=null) {
		    attributes = formObj.elements["attributes"].value;
		    attributeIds = attributes.split(",");
		    for (var i=0; i<attributeIds.length;i++) {
		        if(i!=0)
		            attributeValues +=",";
		        var valueObj = formObj.elements["attr"+attributeIds[i]];
		        attributeValues += valueObj.options[valueObj.selectedIndex].value
		    }
		    combinationValues=attributeValues.split(",");

			for (var j=0; j<productInstanceArr.length;j++) {
				prInstance = productInstanceArr[j];
				featuresIds = prInstance.featuresIds.split(",");
				featuresValues = prInstance.featureValueIds.split(",");
				attrFound=0;
			
				for(i=0; i<attributeIds.length; i++) {
						for(k=0; k<featuresIds.length; k++) {
								if(attributeIds[i]==featuresIds[k]) {
									if(combinationValues[i]==featuresValues[k])
										attrFound++;
									
								}
						}
				}
						
				if(attrFound==attributeIds.length) {
					selectedInstance=prInstance;
					break;
				}
			}
		} //end if one attribute then else
		
		var productpriceButton = document.getElementById("productpricebutton");
		var productprice = document.getElementById("productprice");
		var productavailability = document.getElementById("productavailability");
		var productimage = document.getElementById("productimage");
		var producttitle = document.getElementById("producttitle");
		var product_code = document.getElementById("product_code");
		var prInst = formObj.elements["prInst"];
		var quantity = formObj.elements["quantity"];
	    var imagePath = "<%=imageLocation%>";
	    var availabilityClass = '';
	    
	    if(eval(selectedInstance)) {
			if(selectedInstance.inventory>0) {
			    //if(selectedInstance.inventory!="0" && selectedInstance.inventory!="0.00" && selectedInstance.inventory!="null") {
                productpriceButton.style.visibility="visible";
				if(eval(productprice))
					productprice.style.visibility="visible";
				if(eval(productavailability))
					productavailability.innerHTML="<%=LanguageUtil.get(pageContext,"product-is-available")%>";
				if(eval(productprice))
					productprice.innerHTML=selectedInstance.finalprice + " &euro;";

				formObj.elements["prprice"].value=selectedInstance.finalprice;

				if (selectedInstance.inventory<=0)
				    availabilityClass = "availability-red";
				else if (selectedInstance.inventory> <%=orangeLevel%>) //if no orangeLevel is defined, positive availability is green, which is fine! 
				    availabilityClass = "availability-green";
				else 
				    availabilityClass = "availability-orange";
				if (eval(quantity))
				    quantity.className = availabilityClass;
			} else {
			    productpriceButton.style.visibility="hidden";
			    if(eval(productprice))
			        productprice.style.visibility="hidden";
			    if(eval(productavailability))
			        productavailability.innerHTML="<%=LanguageUtil.get(pageContext,"product-is-not-available")%>";
			} //end if(selectedInstance.inventory>0)

			if(selectedInstance.imageFile!="null" && selectedInstance.imageFile!="") {
			    imagePath+=selectedInstance.imageFile;
			} else {
                <%if (hasImage) {%>
                imagePath+="<%=productImageFile%>";
                <%} else {%>
                imagePath="<%=noImageFullPath260%>";
                <%}%>
            } //end if(selectedInstance.imageFile!="null" && selectedInstance.imageFile!="") {

		    producttitle.innerHTML="<strong>" + selectedInstance.name +"</strong>";
		    product_code.innerHTML='<%=LanguageUtil.get(pageContext,"ecommerce.product.productcode")%>' + ' : ' + selectedInstance.productcode;
		    prInst.value=selectedInstance.id;
		    
		} else {
		    productpriceButton.style.visibility="hidden";
		    if(eval(productprice))
		        productprice.style.visibility="hidden";
		    if(eval(productavailability))
		        productavailability.innerHTML="<%=LanguageUtil.get(pageContext,"product-is-not-available")%>";
            <%if(hasImage) {%>
            imagePath+="<%=productImageFile%>";
            <%} else {%>
            imagePath="<%=noImageFullPath260%>";
            <%}%>
        }
        if(eval(productimage)) {
            var imgHtml = "<a href='" + imagePath +"' class='thickbox' title='<%=LanguageUtil.get(pageContext,"product-image")%>'>";
            imgHtml += "<img src='" + imagePath +"' alt='<%=LanguageUtil.get(pageContext,"product-image")%>'  hspace='5' vspace='5' align='left' width='260' />";
            imgHtml += "</a>";
            productimage.innerHTML = imgHtml;
            //workaround to attach thickbox onclick event to the newly created a href dom element
            tb_init('a.thickbox, area.thickbox, input.thickbox');
        }
    } //end function findCombination
 
	function changeViewType(showType) {
		var productInstanceDiv = document.getElementById("productinstances");
		var productInfoDiv = document.getElementById("productInfo");
		
		if(showType=="1") {
			productInstanceDiv.style.display="none";
			productInfoDiv.style.display="block";
		} else {
			productInstanceDiv.style.display="block";
			productInfoDiv.style.display="none";
		}
	}

	/**
	 * Iterate through all product instances and check if the instance corresponding to the
	 * specified attribute combination is valid, and optionally (when checkHasInventory==true) if it has inventory > 0.
	 * By default the combination will be hidden. That is if there is no product instance at all for the specified 
	 * combination, return false.
	 
	 * attrIdsCommaSep : The attribute ids to be checked
	 * attrValuesCommaSep : The attribute values, in the same order of the corresponding attribute id in
	 *						parameter attrIdsCommaSep
	 * checkHasInventory : If the function should also check for the existence of positive inventory
	 */
	function checkShowCombination(attrIdsCommaSep, attrValuesCommaSep, checkHasInventory){
		var retFlag = false;
		
		var attrIdsArr = attrIdsCommaSep.split(",");
		var attrIdValuesArr = attrValuesCommaSep.split(",");
		
		for (var i = 0; i < productInstanceArr.length; i++){
			var instAttrIdsArr = productInstanceArr[i].featuresIds.split(",");
			var instAttrValuesArr = productInstanceArr[i].featureValueIds.split(",");
		
			// Check if the current product instance corresponds to the specified attribute combination
			var numOfMatchedAttrs = 0;
			for (var j = 0; j < attrIdsArr.length; j++){
				for (var k = 0; k < instAttrIdsArr.length; k++){
					if (attrIdsArr[j] == instAttrIdsArr[k] && attrIdValuesArr[j] == instAttrValuesArr[k]) {
						numOfMatchedAttrs++;
					}
				}
			}
		
			if (numOfMatchedAttrs == attrIdsArr.length) {
				// The prod instance corresponds to the specified attribute combination.
				if (checkHasInventory) {
				    // Check inventory
				    retFlag = (productInstanceArr[i].inventory > 0);
				} else {
					// Combination is valid, return true
					retFlag = true
				}
				break;
			}
			
		}
		return retFlag;
	}
  
	/**
	 * Rebuilds the select element containing the product attributes, according to
	 * the availability of product instance , resulting from the attribute's 
	 * combination 
	 */
	function initializeAttributesSelectElements(checkHasInventory){
		var currSelectEl = null;
		var currSelVal = '';
		
		var firstSelectEl = document.getElementsByName('<%="attr" + firstAttrId%>')[0];
		var firstSelVal = (firstSelectEl!=null && firstSelectEl!=undefined? firstSelectEl.options[firstSelectEl.selectedIndex].value: '');

        <% if (productAttributesValues!=null && productAttributesValues.size() >0) {
			int prev_attr=0;
			int attrId=0;
			String attrName="";
			String attrValueName="";
			int attrValue;
			String attrIds="";
			for(int j=0; j<productAttributesValues.size(); j++) {
			    ViewResult attr = (ViewResult)productAttributesValues.get(j);
			    attrName = attr.getField1().toString();
			    attrValueName = attr.getField2().toString();
			    attrValue = ((Integer)attr.getField4()).intValue();
			    attrId = ((Integer)attr.getField3()).intValue();
			    
			    if (attrId == firstAttrId.intValue()) {
			   	 prev_attr= attrId;
			    	 continue;
			    }
			    if(attrId!=prev_attr) {
			        if(prev_attr!=0) {
			            attrIds+="," +  String.valueOf(attrId);
                    %>		
						//</select><br>
						if (currSelectEl != null && currSelectEl.options.length == 0){
						 currSelectEl.options[currSelectEl.options.length]=new Option('', '0', false, true);
						}
                    <%
                    } else {
                	    attrIds= String.valueOf(attrId);
                	}
			        prev_attr=attrId;
                    %>

					// Clear currSelectEl.options 
					currSelectEl = document.getElementsByName('<%="attr" + attrId%>')[0];
					if (currSelectEl != null && currSelectEl != undefined) {
					    currSelVal = currSelectEl.options[currSelectEl.selectedIndex].value;
					    currSelectEl.options.length = 0;
					}
					//alert(currSelVal);
                <%} //end if(attrId!=prev_attr) %>
                
                var prodInstVisible = checkShowCombination('<%=firstAttrId%>'+','+'<%=attrId%>' , firstSelVal+','+'<%=attrValue%>', checkHasInventory);
				//alert(prodInstHasInv);
				// new Option(text, value, defaultSelected, selected)
                <%
                boolean selOpt = (selectedAttributes!=null && selectedAttributes.get(String.valueOf(attrId))!=null && selectedAttributes.get(String.valueOf(attrId)).toString().equals(String.valueOf(attrValue)));%>
				if (prodInstVisible){
				    currSelectEl.options[currSelectEl.options.length]=new Option('<%=attrValueName%>', '<%=attrValue%>', false, <%=selOpt%>);
				    //alert(currSelVal+', '+'<%=attrValue%>'+(currSelVal == '<%=attrValue%>'));
                    if (currSelVal == '<%=attrValue%>'){
                        currSelectEl.selectedIndex = currSelectEl.options.length-1;
                    }
                }
            <%} //end for(int j=0; j<productAttributesValues.size(); j++)%>
     
			if (currSelectEl != null && currSelectEl.options.length == 0){
				currSelectEl.options[currSelectEl.options.length]=new Option('', '0', false, true);
			}
        <%} //end if(productAttributesValues!=null ...%>
    } //end function initializeAttributesSelectElements()
    <%--
    jQuery(document).ready(function() {
        var featuresSelectionArea = jQuery('#featuresSelectionArea');
    });

    function prepareProductCombinationsList() {
        var firstAttributeCombobox = jQuery('#<portlet:namespace/>_attr<%=firstAttrId%>');
        if (firstAttributeCombobox.length>0) {
            var firstAttributeValueId = firstAttributeCombobox.val(); //id of the first attribute value
             
        }
    }
    --%>
</script>
<noscript></noscript>
 
 
<%-- Combo box to allow user select the preferred view (parathesi olwn twn syndyasmwn, ftiaxe ton syndyasmo sou) --%>
<c:if test="<%=hasMultipleInstances %>">
    <div class="product_instance_view">
        <%=LanguageUtil.get(pageContext,"ecommerce.product.show-type")%>  &nbsp; 
        <select name="view-type" onchange="changeViewType(this.options[this.selectedIndex].value)"> 
            <option value="1" <%=(viewTypeParam.equals("1")) ? "selected" : "" %>> <%=LanguageUtil.get(pageContext,"ecommerce.product.show-combination")%></option>
            <option value="2" <%=(viewTypeParam.equals("2")) ? "selected" : "" %>> <%=LanguageUtil.get(pageContext,"ecommerce.product.show-all-instances")%></option>
        </select>
    </div>
</c:if>


<%-- main product view area --%>
<div class="productpage">
    
	<form name="BS_PRODUCT_COMBINATION" id="BS_PRODUCT_COMBINATION">
	<input name="prprice" type="hidden" value="<%=StringUtils.check_null(productPrice,"")%>">
	<input name="prInst" type="hidden" value="">    
    
    <%-- Ftiaxe ton diko sou syndyasmo page --%>
    <div id="productInfo">
        <%--
        prepei na fortosoume tin eikona k tis plirofories tou epilegmenou product instance 
        --%>
        <%-- eikona master eidous --%>
        <div class="productimage" >
            <div class="img" id="productimage">
	            <c:choose>
	            <c:when test="<%=hasImage%>">
	                <a href="<%= productImageFullPath%>" class="thickbox" title="<%=LanguageUtil.get(pageContext,"product-image")%>">
	                <img src="<%=productImageFullPath%>" alt="<%=LanguageUtil.get(pageContext,"product-image")%>" />
	                </a>
	            </c:when>
	            <c:otherwise>
	                <img src="<%=noImageFullPath260%>" alt="<%=LanguageUtil.get(pageContext,"product-image-not-available")%>" align="left"  />
	            </c:otherwise>
	            </c:choose>
            </div>
            
            <%-- extra eikones master eidous --%>
	        <c:if test="<%=hasImage && hasMorePhotos%>">
		        <br>
		        <div class="imagegallery">
		            <% for (int i=0; i<productPhotos.size();i++) {
		                ViewResult productphoto = (ViewResult)productPhotos.get(i);
		                String imagefile = StringUtils.check_null(productphoto.getField2(),"");
		                if (Validator.isNotNull(imagefile)) {
		                    String imagepath ="/FILESYSTEM/" + companyId + "/" + filePath + productId + "/" + imagefile;
		                    String thumb = gnomon.business.GeneralUtils.createThumbnailPath(imagepath);
		                    %>
		                    <a href="<%= imagepath%>" class="thickbox" title="<%=StringUtils.check_null(productphoto.getField1(),"")%>">
		                    <img src="<%= thumb%>" alt="<%=StringUtils.check_null(productphoto.getField1(),"")%>" >
		                    </a> &nbsp;
		                <%}%>
		            <%}%>
		        </div>
	        </c:if>
        </div>
        
        <%if (isNew){%>
        <span class="new_product">
        <%--<span class="new_product_text"><%= LanguageUtil.get(pageContext, "ecommerce.product.newProduct") %></span>--%>
        </span>
        <%}%>
        
		<%-- plirofories master eidous --%>
		<div class="productInfo" >
	
		    <!-- titlos master eidous -->
		    <div class="producttitle" id="producttitle">
		        <strong><%=productName%></strong>
		    </div>
		    
			<!--- promoted new feature comments -->
			<c:if test="<%=Validator.isNotNull(promotedComment) %>">
			   <div class="productcomments">
			       <%=promotedComment%>
			   </div>
			</c:if>
		    <c:if test="<%=Validator.isNotNull(featuredComment) %>">
			   <div class="productcomments">
			       <%=featuredComment%>
			   </div>
			</c:if>
			<c:if test="<%=Validator.isNotNull(newComment) %>">
				<div class="productcomments">
				  <%=newComment%>
		        </div>
		    </c:if>
		
			<%-- kodikos master eidous --%>
			<c:if test="<%=Validator.isNotNull(productCode) %>">
		        <div class="product-field" id="product_code">
		            <%=LanguageUtil.get(pageContext,"ecommerce.product.productcode")%> : <%=productCode%>
		        </div>
		    </c:if>    
		
			<%-- monada metrisis master eidous --%>
			<c:if test="<%=Validator.isNotNull(metric) %>">
				<div class="product-field" id="product_count_info">
				   <%=LanguageUtil.get(pageContext,"ecommerce.product.prMetric")%> : <%=metric%>
				</div>
			</c:if>
			    
			<%-- perigrafi master eidous --%>
			<c:if test="<%=Validator.isNotNull(productDescription) %>">
		        <div class="productdescription">
		            <%=productDescription%>
		        </div>
		    </c:if>
		    
			<%-- timi master eidous --%>
			<c:if test="<%=showPrices && productPrice!=null%>">
		        <div class="productprice" id="productprice">
		            <%=productPrice.toString()%> &euro;
		        </div>
		    </c:if>
		    
		    <%-- diathesimo, add to cart, add to wishlist --%>
		    <c:if test="<%=manageInventory%>">
			    <div class="productavailability" id="productavailability">
			        <% if (availabilityClass.equals("availability-green")) {%>
			            <span style="color:#060"><%=LanguageUtil.get(pageContext,"product-is-available")%></span>
			        <%} else if (availabilityClass.equals("availability-red")) {%>
			            <span style="color:#F30"><%=LanguageUtil.get(pageContext,"product-is-not-available")%></span>
			        <%} else {%>
			            <span style="color:#330"><%=LanguageUtil.get(pageContext,"product-has-limited-availability")%></span>
			        <%}%>
				</div>
			</c:if>
			
			<%-- combo boxes fortosis syndyasmwn --%>
			<%-- disabled as this is an incomplete effort (nikos) --%>
			<c:if test="<%= false && hasMultipleInstances %>">
                <div class="productcombination" id="featuresSelectionArea">
	                <%--
	                1. Prepei na dimiourgithoun combo boxes me vash ta attributes tou product i more safely me vash to union twn attributes sta eidh
	                2. To kathe combo box tha exei ena index number (1 to proto, 2 to deytero klp). Mallon mesw tou rel
	                3. Sto 1o combo box tha fortothoun oi distinct times tou attribute se ola ta instances
	                4. Ta ypoloipa tha einai hidden k adeia
	                5. On change tou kathe combo box, tha ginontai clear k hide ta epomena, populate k show to amesws epomeno
	                   To population tha ginetai xrisimopoiwntas ta attribute values twn instances
	                --%>
	                
	                
	                <%-- render first combo box on server side--%>
	                <div>
	                    <label for="<portlet:namespace/>_attr<%=firstAttrId%>" class="PrdMSTRFLchartitle"><%=firstAttrName%></label>
		                <select id="<portlet:namespace/>_attr<%=firstAttrId%>" name="<%="_attr" + firstAttrId%>" onchange="findCombination(this.form)">
		                    <%for (int j=0; j<productAttributesValues.size(); j++) {
			                    ViewResult attr = (ViewResult)productAttributesValues.get(j);
			                    Integer attrId = attr.getField3()!=null? (Integer)attr.getField3(): null; //e.g. 182, mainid of attribute Color (same for all product instances)
			                    String attrName = ViewResultUtil.getString(attr, "field1"); //e.g. Color (same for all product instances)
			                    String attrValueName = ViewResultUtil.getString(attr, "field2"); //e.g. Aspro
			                    Integer attrValueId = attr.getField4()!=null? (Integer)attr.getField4(): null; //e.g. 292, mainid of value Aspro
			                    if (attrId.equals(firstAttrId)) {
			                    %>
		                           <option name="<%=attrValueName%>" value="<%=attrValueId%>"  <%if(selectedAttributes!=null && selectedAttributes.get(String.valueOf(attrId))!=null && selectedAttributes.get(String.valueOf(attrId)).toString().equals(String.valueOf(attrValueId))) {%> selected <%}%>><%=attrValueName%> </option>
		                        <%} //end if %>
		                    <%} //end for all attributes+values %>
		                </select>
	                </div>
	                
	                <%-- any others will be rendered from javascript --%>
	                <% for (int j=1; j<productAttributesDistinct.size(); j++) {
	                	ViewResult attr = (ViewResult)productAttributesDistinct.get(j);
	                	Integer attrId = attr.getMainid();
	                	String attrName = ViewResultUtil.getString(attr, "field1");
	                %>
                        <div>
	                        <label for="<portlet:namespace/>_attr<%=attrId%>" class="PrdMSTRFLchartitle"><%=attrName%></label>
							<select id="<portlet:namespace/>_attr<%=attrId%>" name="<%="_attr" + attrId%>" onchange="findCombination(this.form)">
							</select>
						</div>
                    <%}%>
                </div>
            </c:if>
			
			<c:if test="<%=hasMultipleInstances %>">
		        <div class="productcombination">
				<%
				int prev_attr=0;
				String attrIds="";
				for (int j=0; j<productAttributesValues.size(); j++) {
				    ViewResult attrValue = (ViewResult)productAttributesValues.get(j);
				    int attrId = attrValue.getField3()!=null? (Integer)attrValue.getField3(): 0; //e.g. 182, mainid of attribute Color (same for all product instances)
				    String attrName = ViewResultUtil.getString(attrValue, "field1");
				    String attrValueName = ViewResultUtil.getString(attrValue, "field2");
				    int attrValueId = ((Integer)attrValue.getField4()).intValue(); //e.g. 292, mainid of value Aspro
				    if (attrId != prev_attr) {
				        if (prev_attr!=0) {
				            attrIds += "," +  String.valueOf(attrId);
                            %>		
                            </select><br>	
	                    <%} else {
	                    	attrIds = String.valueOf(attrId);
	                    }
	                    prev_attr = attrId;
	                    %>
	                    <div class="PrdMSTRFLchartitle">
	                        <%=attrName%>
	                    </div>
	                    <select name="<%="attr" + attrId%>" onchange="findCombination(this.form)">		
	                <%} %>
	                <option name="<%=attrValueName%>" value="<%=attrValueId%>"  <%if(selectedAttributes!=null && selectedAttributes.get(String.valueOf(attrId))!=null && selectedAttributes.get(String.valueOf(attrId)).toString().equals(String.valueOf(attrValueId))) {%> selected <%}%>><%=attrValueName%> </option>	
	            <%}	%>
	            </select>
	            <input type="hidden" name="attributes" value="<%=attrIds%>">
	            </div>
	        </c:if>
	        
			<div class="productbuttons" id="productpricebutton">
				<!-- Always show the quantity. It will be hidden by java script. -->
				<input name="quantity" type="text" value="<%=quantity%>" size="7">
				<a href="#" onclick="javascript:return <portlet:namespace/>addCombinationToCart();">
	                <img title="<%=LanguageUtil.get(pageContext,"add-to-shopping-cart")%>" src="<%= themeDisplay.getPathThemeImages() %>/ecommerce/add-to-cart.gif" alt="<%=LanguageUtil.get(pageContext,"add-to-shopping-cart")%>" border="0" align="absmiddle" />
				</a>    
			</div>
	    </div> <%-- end div class="productInfo" --%>
    </div> <%-- end div id="productInfo" --%>
    <%-- end ftiaxe ton diko sou syndyasmo page --%>

	<%-- Deite olous tous syndyasmous page --%>
	<c:if test="<%=hasMultipleInstances %>">
	    <div class="productInfo" id="productinstances">
		<% 
	    for( int i=0; i<productInstances.size(); i++) {
	        ViewResult prInst = (ViewResult)productInstances.get(i);
	        Integer prInstProductId = prInst.getMainid(); //master productId, not instanceId!!
	        Integer prInstId = prInst.getField12()!=null? (Integer)prInst.getField12(): null;
	        String prInstName = ViewResultUtil.getString(prInst, "field1");
	        String prInstDescription = ViewResultUtil.getString(prInst, "field2");
	        BigDecimal prInstPrice = prInst.getField3()!=null? (BigDecimal)prInst.getField3(): null;
	        String prInstImageFile = ViewResultUtil.getString(prInst, "field4", "");
	        String prInstProductImageFile = ViewResultUtil.getString(prInst, "field13"); //master product image file
	        BigDecimal prInstInventory = prInst.getField5()!=null? (BigDecimal)prInst.getField5(): BigDecimal.ZERO;
	        Double prInstInventoryDbl = prInstInventory.doubleValue();
	        boolean prInstIsAvailable = (prInstInventoryDbl > 0);
	        String prInstErpCode = ViewResultUtil.getString(prInst, "field6");
	        String prInstCode = ViewResultUtil.getString(prInst, "field7");
	        String prInstFeatNames = ViewResultUtil.getString(prInst, "field8");
	        String prInstFeatIds = ViewResultUtil.getString(prInst, "field9");
	        String prInstProductFeatIds = ViewResultUtil.getString(prInst, "field10");
	        Boolean prInstIsDefault = (Boolean)prInst.getField11();
	        BigDecimal prInstTaxRate = prInst.getField14()!=null? (BigDecimal)prInst.getField14(): BigDecimal.ZERO;
	        Double prInstTaxRateDbl = prInstTaxRate.doubleValue();
	        
	        String instAvailabilityClass = "";
	        if (prInstInventoryDbl<=0)
	        	instAvailabilityClass = "availability-red";
	        else if (prInstInventoryDbl>orangeLevel) //if no orangeLevel is defined, positive availability is green, which is fine! 
	            instAvailabilityClass = "availability-green";
	        else 
	            instAvailabilityClass = "availability-orange";
	        //show instance if show instance even if not-available-setting is on, or instance is available
	        boolean showInstance = (!hideInstanceIfNotAvailable) || 
	              	(hideInstanceIfNotAvailable && (!manageInventory || (manageInventory && prInstIsAvailable)));
	        
	        String imagepath ="/FILESYSTEM/" + companyId + "/" + filePath + prInstProductId + "/" + StringUtils.check_null(prInstImageFile,"");
	        String thumb = gnomon.business.GeneralUtils.createThumbnailPath(imagepath);
	        %>
	        
	        <c:if test="<%=showInstance %>">
		        <div class="productline">
			    	<div class="productimage" >
						<c:choose>
						<c:when test="<%=Validator.isNotNull(prInstImageFile)%>">
							<a href="<%= imagepath%>" class="thickbox" title="<%=StringUtils.check_null(prInstName,"")%>">
							  <img src="<%= thumb%>" alt="<%=prInstImageFile%>" >
							</a>
						</c:when>
						<c:when test="<%=Validator.isNull(prInstImageFile) && hasImage && !showNoImageIfInstanceImageMissing %>">
							<a href="<%="/FILESYSTEM/" + companyId + "/" + filePath + productId + "/" + productImageFile%>" class="thickbox" title="<%=StringUtils.check_null(prInstName,"")%>">
							   <img src="<%= "/FILESYSTEM/" + companyId + "/" + filePath + productId + "/" +gnomon.business.GeneralUtils.createThumbnailPath(productImageFile)%>" alt="<%=LanguageUtil.get(pageContext,"product-image")%>" >
							</a>
						</c:when>
						<c:otherwise>
						    <img src="<%=noImageFullPath100%>" alt="<%=LanguageUtil.get(pageContext,"product-image-not-available")%>" align="left"  />
						</c:otherwise>
						</c:choose>
			        </div>
			        
	                <div class="producttitle">
	                    <%=prInstName%>
	                </div>
	                
					<c:if test="<%=showPrices && prInstPrice!=null %>">
					    <span class="productprice">
					        <%=prInstPrice.toString()%> &euro;
					    </span>
					</c:if>
			        
			        <c:choose>
					<c:when test="<%=manageInventory %>">
						<c:if test="<%=prInstIsAvailable %>">
						    <span class="quantity"> 
						        <input type="text" name="quantity<%=prInstId%>" size="3" class="<%=instAvailabilityClass%>">
						    </span>
						    <div id="add_to_cart_btn">
						        <a href="#" onclick="javascript:return <portlet:namespace/>addInstanceIdToCart(<%=prInstId%>);return false;">
						        <img src="<%= themeDisplay.getPathThemeImages() %>/ecommerce/add-to-cart.gif" alt="<%=LanguageUtil.get(pageContext,"add-to-shopping-cart")%>" border="0" align="absmiddle" /></a>
						    </div>
						</c:if>
					</c:when>
					<c:otherwise>
						<span class="quantity">
						    <input type="text" name="quantity<%=prInstId%>" size="3">
						</span>
						<div id="add_to_cart_btn">  
						    <a href="#" onclick="javascript:return <portlet:namespace/>addInstanceIdToCart(<%=prInstId%>)">
						    <img src="<%= themeDisplay.getPathThemeImages() %>/ecommerce/add-to-cart.gif" alt="<%=LanguageUtil.get(pageContext,"add-to-shopping-cart")%>" border="0"  /></a>
						</div>
			        </c:otherwise>
			        </c:choose>
	            </div> <%-- end div class="productline"--%>
	        </c:if>      
	    <%
	    } //end for each instance loop
	    %>
	    </div>
	</c:if> <%-- end if hasMultipleInstances --%>
	<%-- end deite olous tous syndyasmous page --%>
	
	
	<c:if test="<%=showTools %>">
		<div class="clearproduct">&nbsp;</div>
		<div class="producttools">
			<%--
			<li> <a href=""><%=LanguageUtil.get(pageContext,"add-to-wish-list")%> </a></li>
			<li><a href=""><%=LanguageUtil.get(pageContext,"pick-to-compare")%></a></li>
			--%>
			<liferay-util:include page="/html/portlet/ext/ecommerce/product/browser/sendToFriendForm.jsp">
				<liferay-util:param name="urlParam" value="<%=PortalUtil.getPortalURL(request)+currentURL%>"/>
				<liferay-util:param name="titleParam" value="<%=productName%>"/>
				<liferay-util:param name="idParam" value="<%=productId.toString()%>"/>
			</liferay-util:include>		
		</div>
	</c:if>
	
	<div class="clearproduct">&nbsp;</div>
	
	<%--  list of features --%>
	<div class="productfeatures">
	    <c:if test="<%=Validator.isNotNull(supplier) %>">
	        <div class="row-odd">
		        <div class="PrdMSTRFLchartitle">
		            <%=LanguageUtil.get(pageContext,"ecommerce.product.prSupplier")%>:
		        </div>
		        <div class="PrdMSTRFLchars"> 
		            <%=supplier%>
		        </div>
	        </div>
	    </c:if>
	    
	    <c:if test="<%=Validator.isNotNull(manufacturer) %>">
			<div class="row-odd">
				<div class="PrdMSTRFLchartitle"><%=LanguageUtil.get(pageContext,"ecommerce.product.prManufacturer")%>:</div>
				<div class="PrdMSTRFLchars"> <%=manufacturer%></div>
			</div>
	    </c:if>
	    
	    <c:if test="<%=hasSpecs %>">
	        <%
	        for(int i=0; i<productSpecs.size(); i++) {
	            ViewResult feature = (ViewResult)productSpecs.get(i);
	        %>
			<div class="row-odd">
	            <div class="PrdMSTRFLchartitle"><%=feature.getField1()%>:</div>
	            <div class="PrdMSTRFLchars"> <%=feature.getField2().toString()%></div>
			</div>
	        <%}%>
	    </c:if>
	    
	    <%-- datasheet doc file if exists --%>
	    
	</div> <%-- end div class="productfeatures" --%>
	</form> <%-- end product form, because ratings and comments will inject their own forms %>
	
	<%--  product ratings --%>
	<c:if test="<%= showRating %>">
		<liferay-ui:ratings
			className="<%= PrProductinstance.class.getName() %>"
			classPK="<%= productId %>"
			url='<%= themeDisplay.getPathMain() + "/ext/products/browser/rate_product" %>'
		/>
	</c:if>
	
	<%--  comments --%>
	<c:if test="<%= showComments %>" >
		<br />
		<portlet:actionURL var="discussionURL">
			<portlet:param name="struts_action" value="/ext/products/browser/edit_product_discussion" />
		</portlet:actionURL>
		
		<liferay-ui:discussion
			formName="fm2"
			formAction="<%= discussionURL %>"
			className="<%= PrProductinstance.class.getName() %>"
			classPK="<%= productId %>"
			userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(companyId) %>"
			subject="<%= productName %>"
			redirect="<%= currentURL + "&tab=comments" %>"
		/>
	</c:if>
	
	
	<br>
	<div class="button-back">
	    <a href="javascript:history.go(-1);" title="go back to previous page"><%=LanguageUtil.get(pageContext,"back")%></a> 
	</div>

</div><%-- end div class="productpage" --%>

<br><br>
<c:choose>
<c:when test="<%=hasEdit==true %>">
	<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
		<tiles:put name="className" value="<%= gnomon.hibernate.model.ecommerce.product.PrProduct.class.getName() %>"/>
		<tiles:put name="primaryKey" value="<%= productId.toString() %>"/>
		<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
	</tiles:insert>
</c:when>
<c:otherwise>
	<tiles:insert page="/html/portlet/ext/base/contentrel/relatedProductsTile.jsp" flush="true">
		<tiles:put name="className" value="<%= gnomon.hibernate.model.ecommerce.product.PrProduct.class.getName() %>"/>
		<tiles:put name="primaryKey" value="<%= productId.toString() %>"/>
		<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
	</tiles:insert>	
</c:otherwise>
</c:choose>
</div>

<c:if test="<%=hasMultipleInstances %>">
	<script type="text/javascript">	
		findCombination(document.getElementById("BS_PRODUCT_COMBINATION"));
		//prepareProductCombinationsList();
	    changeViewType(<%=viewTypeParam%>);
	</script>
</c:if>