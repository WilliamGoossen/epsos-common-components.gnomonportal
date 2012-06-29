<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<div class="journal-content-article">

<% 
ViewResult view = (ViewResult) request.getAttribute("ticketTypeItem"); 
%>
<%-- 
		String[] fields = new String[] {langs.mainid",
										"table1.ticketTypeCode",
									    "table1.defaultDiscount",
										"langs.name", 
										"langs.lang",
										"langs.description"
										};
--%>


<strong><%= view.getField4().toString() + (Validator.isNotNull(view.getField2()) ? " (" + view.getField2()+")" : "")%></strong>

<br/>
<% if (Validator.isNotNull(view.getField3())) { %>
<%= LanguageUtil.get(pageContext, "bs.events.tickettype.discount") + " : "+ ((java.math.BigDecimal)view.getField3()).setScale(2, java.math.BigDecimal.ROUND_HALF_UP).toString() + "%" %>
<% } %>
<br/>

<%=view.getField6().toString()%>

<br/>

<br>

		<c:choose>
			<c:when test="<%=Validator.isNull(redirect)%>">
				<a href="#" onClick="history.go(-1);"> 
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" alt="back" align="middle">&nbsp;<%= LanguageUtil.get(pageContext, "back") %>
				</a>
			</c:when>
		
        <c:otherwise>
				<a <%="href=\"" + redirect + "\"" %>> 
				<%= LanguageUtil.get(pageContext, "more") %>
				</a>			
		</c:otherwise>
		</c:choose>
	

<br>
</div>