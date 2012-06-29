<%@ include file="/html/portlet/ext/ecommerce/erpsync/init.jsp" %>

<%
String lastSyncBy = GetterUtil.getString(prefs.getValue("last-sync-by", StringPool.BLANK));
String lastSyncDateStr = GetterUtil.getString(prefs.getValue("last-sync-date", StringPool.BLANK));
//String erp = GetterUtil.getString(prefs.getValue("last-sync-by", StringPool.BLANK));

String erp = erpCon.getClass().getName();
%>

<c:choose>
	<c:when test="<%=Validator.isNotNull(lastSyncDateStr) %>">
	   <%=LanguageUtil.format(pageContext, "last-synchronization-was-executed-by-x-at-y", new String[] {lastSyncBy,lastSyncDateStr})%>
	</c:when>
	<c:otherwise>
	   <%=LanguageUtil.format(pageContext, "welcome-to-synchronization-portlet-with-erp-x", new String[] {erp})%>
	</c:otherwise>
</c:choose>


<portlet:renderURL var="syncProductsURL">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="products"/>
</portlet:renderURL>

<portlet:renderURL var="syncCustomersURL">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="customers"/>
</portlet:renderURL>

<portlet:renderURL var="syncInventoryURL">
    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/do"/>
    <portlet:param name="tab" value="inventory"/>
</portlet:renderURL>

<ul class="sync-list">
    <li> 
        <a href="<%=syncProductsURL%>"><%=LanguageUtil.get(pageContext, "synchronize-products")%></a>
    </li>
    <li> 
        <a href="<%=syncCustomersURL%>"><%=LanguageUtil.get(pageContext, "synchronize-customers")%></a>
    </li>
    <%--
    <li>
        <a href="<%=syncInventoryURL%>"><%=LanguageUtil.get(pageContext, "synchronize-inventory")%></a>
    </li>
    
    <portlet:actionURL var="fixCosmosTradeDefaultInstancesURL">
	    <portlet:param name="struts_action" value="/ext/ecommerce/erpsync/fixCosmosTradeDefaultInstances"/>
	    <portlet:param name="tab" value="inventory"/>
	</portlet:actionURL>
    <li>
        <a href="<%=fixCosmosTradeDefaultInstancesURL%>">Fix Cosmos Trade Default Instances</a>
    </li>
    --%>
<ul>