<%@ include file="/html/portlet/ext/paycenter/response/init.jsp" %>

<c:if test="<%=!SessionMessages.isEmpty(request) %>">
	<span class="portlet-msg-success">
	<%
	Iterator itr = SessionMessages.iterator(request);
	while (itr.hasNext()) {
		out.println(itr.next());
		out.println("<br/>");
	}
	//SessionMessages.clear(req);
	%>
	</span>
	<br /><br />
</c:if>

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

<c:if test="<%=!Validator.isNull(landURL) %>">
	<a <%="href=\"" + landURL + "\"" %>> 
	<%= LanguageUtil.get(pageContext, "continue") %>
	</a>
</c:if>