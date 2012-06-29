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
    List<EntersoftErpItemCustomer> items = (List<EntersoftErpItemCustomer>)session.getAttribute("erpCustomerItems");
    request.setAttribute("erpCustomerItemsReqAttr", items);
    int i=0;
%>

<portlet:actionURL var="syncURL">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="customers"/>
</portlet:actionURL>

<portlet:renderURL var="viewURLRefresh">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="customers"/>
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
	<display:table id="item" name="erpCustomerItemsReqAttr" requestURI="//ext/ecommerce/erpsync/do?actionURL=false" pagesize="100" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	    <% 
	        EntersoftErpItemCustomer cusItem = (EntersoftErpItemCustomer) pageContext.getAttribute("item");
	        i++;
	    %>
	    
	    <%--
	    <display:column sortable="false" style="width:1%" title="${headerCheck}">
	       <c:if test="<%=!previousMasterCode.equals(cusItem.getMasterCode()) %>">
			<input 
			    type="checkbox" 
			    name="prd_<%=cusItem.getSKUCode()%>"
			    id="<portlet:namespace/>_prd_<%=cusItem.getSKUCode()%>"
			    <%=GetterUtil.getBoolean(ParamUtil.getString(request,"prd_"+cusItem.getSKUCode()))? "checked": "" %>
			/>
           <%
           previousMasterCode = cusItem.getMasterCode();
           %>
            </c:if>
        </display:column>
	    --%>
	    
        <display:column sortable="false" style="width:1%" title="${headerCheck}">
            <input 
                type="checkbox" 
                name="cus_<%=cusItem.getTradeAccountCode()%>"
                id="<portlet:namespace/>_cus_<%=cusItem.getTradeAccountCode()%>"
                <%=GetterUtil.getBoolean(ParamUtil.getString(request,"cus_"+cusItem.getTradeAccountCode()))? "checked": "" %>
            />
        </display:column>
	    
        <display:column titleKey="status" sortable="true" style="white-space:nowrap; width:1%;">
            <c:choose>
            <c:when test="<%=cusItem.getPartyId()==null%>">
                <img src="<%=themeDisplay.getPathThemeImages()%>/ecommerce/newsynch_product.png" title="<%=LanguageUtil.get(pageContext, "new") %>" />
            </c:when>
            <c:otherwise>
                <img src="<%=themeDisplay.getPathThemeImages()%>/ecommerce/resynch_product.png" title="<%=LanguageUtil.get(pageContext, "changed") %>" />
            </c:otherwise>
            </c:choose>
        </display:column>
	    <%--
	    <display:column titleKey="inactive" sortable="true" >
            <%=cusItem.getInactive()%>
        </display:column>
	    --%>
	    <display:column titleKey="erp-code" sortable="true" >
	        <%=cusItem.getTradeAccountCode()%>
	    </display:column>

        <display:column titleKey="name" sortable="true" >
            <%=cusItem.getName()%>
        </display:column>
        
        <display:column titleKey="email" sortable="true" >
            <%=cusItem.getEMailAddress()%>
        </display:column>
        
        <display:column titleKey="afm" sortable="true" style="white-space:nowrap;" >
            <%=cusItem.getTaxRegistrationNumber()%>
        </display:column>
        
        <display:column titleKey="balance-limit" sortable="true" style="white-space:nowrap;" >
            <%=cusItem.getBalance()%>
        </display:column>
        
        <display:column titleKey="balance-limit-open-total-notes" sortable="true" style="white-space:nowrap;" >
            <%=cusItem.getInvoiceBalance()%>
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
        <portlet:param name="tab" value="customers"/>
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