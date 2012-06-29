<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<liferay-ui:tabs names="error" backURL="javascript: history.go(-1);" />

<%//=request.getAttribute("error") %>


<c:if test="<%=!SessionErrors.isEmpty(request) %>">
    <%--<span class="portlet-msg-error">--%>
    <%
    Iterator itr2 = SessionErrors.iterator(request);
    while (itr2.hasNext()) {
        out.println(itr2.next());
        out.println("<br/>");
    }
    //SessionErrors.clear(req);
    %>
    <%--</span>--%>
    <br /><br />
</c:if>