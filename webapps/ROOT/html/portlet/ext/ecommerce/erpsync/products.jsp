<%@ include file="/html/portlet/ext/ecommerce/erpsync/init.jsp" %>

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
    List items = (List)request.getAttribute("items");
    //String[] items = new String[] {"test", "test2"};
    //request.setAttribute("items", items);
    int i=0;
%>

<portlet:actionURL var="syncProductsURL">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/products"/>
</portlet:actionURL>

<c:choose>
<c:when test="<%=items!=null && items.size()>0 %>">
    <form name="<portlet:namespace />fm" method="post" action="<%=syncProductsURL%>" class="uni-form">
    <input type="hidden" name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="update"/>
    <input type="hidden" name="<portlet:namespace/>redirect" id="<portlet:namespace/>redirect" value="<%=currentURL %>"/>
    
	<display:table id="item" name="items" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
	    <% 
	        //CartItem item = (CartItem) pageContext.getAttribute("cartItem");
	        i++;
	    %>
	    
	    <display:column sortable="false" style="width:1%">
            <input 
                type="checkbox" 
                name="prd_<%=i %>"
                <%=GetterUtil.getBoolean(ParamUtil.getString(request,"prd_"+i))? "checked": "" %>
            />
        </display:column>
	    
	    <display:column sortable="false" style="width:1%">
	        <%=i%>
	    </display:column>
	    
	    <display:column titleKey="product" sortable="false" >
	        <%=item%>
	    </display:column>
	
	</display:table>
	
    <div style="text-align:right;">
        <input type="submit" value="<liferay-ui:message key="import" />"/>
    </div>
    
	</form>
</c:when>
<c:when test="<%=!SessionErrors.isEmpty(request) && (items==null || items.size()==0) %>">
    
    <portlet:renderURL var="syncProductsURL">
        <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/products"/>
    </portlet:renderURL>
    
    <a href="<%=syncProductsURL%>"><%=LanguageUtil.get(pageContext, "retry")%></a>
    
</c:when>
<c:otherwise>
    Already synchronized!
</c:otherwise>
</c:choose>