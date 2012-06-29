<%@ include file="/html/portlet/ext/base/news/init.jsp" %>


<%--tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/--%>
<div class="journal-content-article" id="news-view">

<% String filePath = GetterUtil.getString(PropsUtil.get("base.news.store"), CommonDefs.DEFAULT_STORE_PATH); %>
<% ViewResult view = (ViewResult) request.getAttribute("newsItem"); %>
<%-- edw tha mpei to view tou new --%>
<%-- 
		String[] fields = new String[] {"langs.mainid",				view.getField1().toString()
										"langs.lang",				view.getField2().toString()
										"langs.title",				view.getField3().toString()
										"langs.description",		view.getField4().toString()
										"langs.source",				view.getField5().toString()
										"langs.sourceUrl",			view.getField6().toString()
										"langs.image",				view.getField7().toString()
										"table1.newType",			view.getField8().toString()
										"table1.newDate"};			view.getField9().toString()
--%>

<!--<c:if test="<%=view.getField7()!=null%>">
	<img src="<%="/FILESYSTEM/" + com.liferay.portal.util.PortalUtil.getCompanyId(request) + "/" + filePath + view.getMainid() + "/" + StringUtils.check_null(view.getField7(),"")%>" alt="news-image" width="87" height="69" hspace="5" vspace="5" align="left" />
</c:if>-->
	
<div class="news-view-date">
<c:if test="<%=view.getField9()!=null%>"><span>
<%=FastDateFormat.getInstance("dd MMM yy").format((Date)view.getField9())%></span>
</c:if>
</div>
<div class="news-view-title"><span>
<%=view.getField3().toString()%></span>
</div>	
<div class="news-view-content">
<%=view.getField4().toString()%>

</div>
<%-- 	    	ews edw 			--%>


<c:if test="<%= hasEdit || hasDelete %>">
<br/><br/>
<form name="BsNewForm" action="/ext/news/load" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/news/load" />
	<tiles:put name="buttonName" value="editButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" />
	<tiles:put name="formName"   value="BsNewForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="edit"/>
	  	<tiles:add><%=view.getMainid().toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="edit"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/news/load" />
	<tiles:put name="buttonName" value="deleteButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" />
	<tiles:put name="formName"   value="BsNewForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="delete"/>
	  	<tiles:add><%=view.getMainid().toString()%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="delete"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>
</form>

<br/>
</c:if>

<br/>

		<c:choose>
			<c:when test="<%=Validator.isNull(redirect)%>">
				<a href="#" onClick="history.go(-1);"> 
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" alt="back" align="middle">&nbsp;<%= LanguageUtil.get(pageContext, "back") %>
				</a>
			</c:when>
		
        <c:otherwise>
        <div class="news-view-back">
				<a <%="href=\"" + redirect + "\"" %>> 
				<%= LanguageUtil.get(pageContext, "back") %>
				</a>	
                </div>		
		</c:otherwise>
		</c:choose>
	

<br><br>

	<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
		<tiles:put name="className" value="<%= gnomon.hibernate.model.base.news.BsNew.class.getName() %>"/>
		<tiles:put name="primaryKey" value="<%= view.getMainid().toString() %>"/>
		<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
	</tiles:insert>	
	
	
<%--  ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.news.BsNew.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		url='<%= themeDisplay.getPathMain() + "/ext/news/rate" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/news/edit_discussion" />
	</portlet:actionURL>
	
	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= gnomon.hibernate.model.base.news.BsNew.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(PortalUtil.getCompanyId(request)) %>"
		subject="<%= view.getField3().toString() %>"
		redirect="<%= currentURL + "&tab=comments" %>"
	/>
</c:if>	
</div>