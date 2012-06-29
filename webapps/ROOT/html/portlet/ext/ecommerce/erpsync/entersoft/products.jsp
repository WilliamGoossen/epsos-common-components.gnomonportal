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
    List<EntersoftErpItemSKU> items = (List<EntersoftErpItemSKU>)session.getAttribute("erpSkuItems");
    request.setAttribute("erpSkuItemsReqAttr", items);
    int i=0;
%>

<portlet:actionURL var="syncProductsURL">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="products"/>
</portlet:actionURL>

<portlet:renderURL var="viewProductsURLRefresh">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="products"/>
    <portlet:param name="refresh" value="true"/>
</portlet:renderURL>

<a href="<%=viewProductsURLRefresh %>"><%=LanguageUtil.get(pageContext, "reload") %></a>

<c:choose>
<c:when test="<%=items!=null && items.size()>0 %>">
    <form id="<portlet:namespace />fm" name="<portlet:namespace />fm" method="post" action="<%=syncProductsURL%>" class="uni-form">
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
	<display:table id="item" name="erpSkuItemsReqAttr" requestURI="//ext/ecommerce/erpsync/do?actionURL=false" pagesize="300" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	    <% 
	        EntersoftErpItemSKU skuItem = (EntersoftErpItemSKU) pageContext.getAttribute("item");
	        i++;
	    %>
	    
	    <%--
	    <display:column sortable="false" style="width:1%" title="${headerCheck}">
	       <c:if test="<%=!previousMasterCode.equals(skuItem.getMasterCode()) %>">
			<input 
			    type="checkbox" 
			    name="prd_<%=skuItem.getSKUCode()%>"
			    id="<portlet:namespace/>_prd_<%=skuItem.getSKUCode()%>"
			    <%=GetterUtil.getBoolean(ParamUtil.getString(request,"prd_"+skuItem.getSKUCode()))? "checked": "" %>
			/>
           <%
           previousMasterCode = skuItem.getMasterCode();
           %>
            </c:if>
        </display:column>
	    --%>
	    
        <display:column sortable="false" style="width:1%" title="${headerCheck}">
            <input 
                type="checkbox" 
                name="prd_<%=skuItem.getSKUCode()%>"
                id="<portlet:namespace/>_prd_<%=skuItem.getSKUCode()%>"
                <%=GetterUtil.getBoolean(ParamUtil.getString(request,"prd_"+skuItem.getSKUCode()))? "checked": "" %>
            />
        </display:column>
	    
	    <display:column titleKey="status" sortable="true" style="white-space:nowrap; width:1%;">
            <c:choose>
            <c:when test="<%=skuItem.getProductInstanceId()==null%>">
                <img src="<%=themeDisplay.getPathThemeImages()%>/ecommerce/newsynch_product.png" title="<%=LanguageUtil.get(pageContext, "new") %>" />
            </c:when>
            <c:otherwise>
                <img src="<%=themeDisplay.getPathThemeImages()%>/ecommerce/resynch_product.png" title="<%=LanguageUtil.get(pageContext, "changed") %>" />
            </c:otherwise>
            </c:choose>
        </display:column>
	    
	    <display:column group="1" titleKey="master-code" sortable="true" >
	        <%=skuItem.getMasterCode()%>
	    </display:column>

        <display:column group="1" titleKey="description" sortable="true" >
            <%=skuItem.getDescription()%>
        </display:column>
        
        <display:column group="2" titleKey="color" sortable="true" >
            <%=skuItem.getColorDescr()%>
        </display:column>

        <display:column titleKey="size" sortable="true" style="white-space:nowrap;" >
            <%=skuItem.getSizeDescr()%>
        </display:column>
        
        <%--
        <display:column titleKey="sku-code" sortable="true" style="white-space:nowrap;">
            <%=skuItem.getSKUCode()%>
        </display:column>
        --%>    
        
        
        <display:column titleKey="for-web" sortable="true" >
            <%=skuItem.getWEB()%>
        </display:column>
        
        <display:column titleKey="create-date" sortable="true" >
            <%=skuItem.getESDCreated()!=null?org.apache.tools.ant.util.DateUtils.format(skuItem.getESDCreated(), "dd/MM/yy"):""%>
        </display:column>
        
        <display:column titleKey="last-modified" sortable="true" >
            <%=skuItem.getESDModified()!=null?org.apache.tools.ant.util.DateUtils.format(skuItem.getESDModified(), "dd/MM/yy"):""%>
        </display:column>
        
        <display:column titleKey="price" sortable="true" >
            <%=skuItem.getPrice()!=null?skuItem.getPrice().doubleValue():""%>
        </display:column>
        <%--
        <display:column titleKey="retail-price" sortable="true" >
            <%=skuItem.getRetailPrice()!=null?skuItem.getRetailPrice().doubleValue():""%>
        </display:column>
        --%>
        <%--
        <display:column titleKey="category-code" sortable="true" >
            <%=skuItem.getFItemCategoryCode()%>
        </display:column>
        --%>
        
        <%--
        <display:column titleKey="family-code" sortable="true" >
            <%=skuItem.getFItemFamilyCode()%>
        </display:column>
        
        <display:column titleKey="group-code" sortable="true" >
            <%=skuItem.getFItemGroupCode()%>
        </display:column>
        --%>
        
        <display:column titleKey="group-code" sortable="true" >
            <%=skuItem.getFItemSubcategoryCode()%>
        </display:column>
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
        <portlet:param name="tab" value="products"/>
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