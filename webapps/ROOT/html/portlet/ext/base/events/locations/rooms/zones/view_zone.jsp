<%@ include file="/html/portlet/ext/base/events/init.jsp" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<div class="journal-content-article">

<% 
ViewResult view = (ViewResult) request.getAttribute("zoneItem"); 
%>
<%-- 
		String[] fields = new String[] {langs.mainid",
										"table1.zoneCode",
										"langs.name", 
										"langs.lang",
										"langs.description"
										};
--%>


<strong><%= view.getField3().toString() + (Validator.isNotNull(view.getField2()) ? " (" + view.getField2()+")" : "")%></strong>

<br/><br/>

<%=view.getField5().toString()%>

<br/>

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

