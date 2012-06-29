<%@ include file="/html/portlet/ext/ecommerce/erpsync/entersoft/init.jsp" %>

<c:if test="<%=!SessionErrors.isEmpty(request) %>">
    <span class="portlet-msg-error">
    <%
    Iterator itr2 = SessionErrors.iterator(request);
    while (itr2.hasNext()) {
        out.println(itr2.next());
        out.println("<br/>");
    }
    //SessionErrors.clear(req);
    %>
    </span>
    <br /><br />
</c:if>

<%
    List<EntersoftErpItemSKUInventory> items = (List<EntersoftErpItemSKUInventory>)session.getAttribute("erpSKUInventoryItems");
    request.setAttribute("erpSkuInventoryItemsReqAttr", items);
    int i=0;
%>

<portlet:actionURL var="syncURL">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="inventory"/>
</portlet:actionURL>

<portlet:renderURL var="viewURLRefresh">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="inventory"/>
    <portlet:param name="refresh" value="true"/>
</portlet:renderURL>

<a href="<%=viewURLRefresh %>"><%=LanguageUtil.get(pageContext, "reload") %></a>

<c:choose>
<c:when test="<%=items!=null && items.size()>0 %>">
    <form id="<portlet:namespace />fm" name="<portlet:namespace />fm" method="post" action="<%=syncURL%>" class="uni-form">
    <input type="hidden" name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="update"/>
    <input type="hidden" name="<portlet:namespace/>redirect" id="<portlet:namespace/>redirect" value="<%=currentURL %>"/>

    <script type="text/javascript">
		checked = false;
		function <portlet:namespace />toggleCheckAll() {
		    var aa = document.getElementById('<portlet:namespace />fm');
		    if (checked == false) {
			    checked = true
			} else {
			    checked = false
			}
			if (aa!=null) {
				for (var i =0; i < aa.elements.length; i++) {
					aa.elements[i].checked = checked;
				}
			}
		}
	</script>
    
    <%
    String test = "<input type=\"checkbox\" onclick=\"" + renderResponse.getNamespace() + "toggleCheckAll();\">";
    request.setAttribute("headerCheck", test);
    String previousMasterCode = "";
    %>
	<display:table id="item" name="erpSkuInventoryItemsReqAttr" requestURI="//ext/ecommerce/erpsync/do?actionURL=false" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	    <% 
	        EntersoftErpItemSKUInventory skuInventoryItem = (EntersoftErpItemSKUInventory) pageContext.getAttribute("item");
	        i++;
	    %>
	    
	    <%--
	    <display:column sortable="false" style="width:1%" title="${headerCheck}">
	       <c:if test="<%=!previousMasterCode.equals(skuInventoryItem.getMasterCode()) %>">
			<input 
			    type="checkbox" 
			    name="prd_<%=skuInventoryItem.getSKUCode()%>"
			    id="<portlet:namespace/>_prd_<%=skuInventoryItem.getSKUCode()%>"
			    <%=GetterUtil.getBoolean(ParamUtil.getString(request,"prd_"+skuInventoryItem.getSKUCode()))? "checked": "" %>
			/>
           <%
           previousMasterCode = skuInventoryItem.getMasterCode();
           %>
            </c:if>
        </display:column>
	    --%>
	    
        <display:column sortable="false" style="width:1%" title="${headerCheck}">
            <input 
                type="checkbox" 
                name="prd_<%=skuInventoryItem.getSKUCode()%>"
                id="<portlet:namespace/>_prd_<%=skuInventoryItem.getSKUCode()%>"
                <%=GetterUtil.getBoolean(ParamUtil.getString(request,"prd_"+skuInventoryItem.getSKUCode()))? "checked": "" %>
            />
        </display:column>
	    <%--
        <display:column titleKey="status" sortable="true" style="white-space:nowrap; width:1%;">
            <c:choose>
            <c:when test="<%=skuInventoryItem.getProductInstanceId()==null%>">
                <img src="<%=themeDisplay.getPathThemeImages()%>/ecommerce/newsynch_product.png" title="<%=LanguageUtil.get(pageContext, "new") %>" />
            </c:when>
            <c:otherwise>
                <img src="<%=themeDisplay.getPathThemeImages()%>/ecommerce/resynch_product.png" title="<%=LanguageUtil.get(pageContext, "changed") %>" />
            </c:otherwise>
            </c:choose>
        </display:column>
	    --%>
	    
	    <display:column group="1" titleKey="master-code" sortable="true" >
	        <%=skuInventoryItem.getMasterCode()%>
	    </display:column>

        <display:column group="1" titleKey="description" sortable="true" >
            <%=skuInventoryItem.getDescription()%>
        </display:column>
        
        <display:column titleKey="sku" sortable="true" style="white-space:nowrap;">
            <%=gnomon.business.StringUtils.myreplaceALL(skuInventoryItem.getSKUCode(),"$"," ")%>
        </display:column>

        <display:column titleKey="inventory-detail" sortable="true" style="white-space:nowrap;" >
            <strong><%=skuInventoryItem.getDetailBalance()!=null? skuInventoryItem.getDetailBalance().doubleValue(): ""%></strong>
        </display:column>
        
        <display:column titleKey="inventory-detail-pending-sales-orders" sortable="true" style="white-space:nowrap;" >
            <%=skuInventoryItem.getDetailPendingSalesOrders()!=null? skuInventoryItem.getDetailPendingSalesOrders().doubleValue(): ""%>
        </display:column>
        
        <display:column titleKey="inventory-detail-reserved-stock" sortable="true" >
            <%=skuInventoryItem.getDetailReservedStock()!=null? skuInventoryItem.getDetailReservedStock().doubleValue(): ""%>
        </display:column>
        <%--
        <display:column titleKey="inventory-master" sortable="true" >
            <strong><%=skuInventoryItem.getMasterBalance()!=null? skuInventoryItem.getMasterBalance().doubleValue(): ""%></strong>
        </display:column>
        
        <display:column titleKey="inventory-master-pending-sales-orders" sortable="true" style="white-space:nowrap;" >
            <%=skuInventoryItem.getDetailPendingSalesOrders()!=null? skuInventoryItem.getDetailPendingSalesOrders().doubleValue(): ""%>
        </display:column>
        
        <display:column titleKey="inventory-master-reserved-stock" sortable="true" >
            <%=skuInventoryItem.getMasterReservedStock()!=null? skuInventoryItem.getMasterReservedStock().doubleValue(): ""%>
        </display:column>
        --%>
        <display:column titleKey="inventory-balance" sortable="true" >
            <%=skuInventoryItem.getBalance()!=null? skuInventoryItem.getBalance().doubleValue(): ""%>
        </display:column>
        
        <display:column titleKey="inventory-available-quantity" sortable="true" >
            <%=skuInventoryItem.getAvailableQuantity()!=null? skuInventoryItem.getAvailableQuantity().doubleValue(): ""%>
        </display:column>
        
        <%--
        --%>
	</display:table>
	
    <div style="text-align:right;">
        <input type="button" value="<liferay-ui:message key="import" />" onClick="submitForm(document.<portlet:namespace />fm);"/>
    </div>
    
	</form>
</c:when>
<c:when test="<%=!SessionErrors.isEmpty(request) && (items==null || items.size()==0) %>">
    <%--
    <portlet:renderURL var="reload">
        <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
        <portlet:param name="tab" value="inventory"/>
    </portlet:renderURL>
    
    <a href="<%=reload%>"><%=LanguageUtil.get(pageContext, "reload")%></a>
    --%>
</c:when>
<c:otherwise>
    <p>
    Already synchronized!
    </p>
</c:otherwise>
</c:choose>