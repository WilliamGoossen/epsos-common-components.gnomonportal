<%@ include file="/html/portlet/ext/base/bookmarks/init.jsp" %>

<% String filePath = GetterUtil.getString(PropsUtil.get("base.bookmarks.store"), CommonDefs.DEFAULT_STORE_PATH); %>
<% ViewResult view = (ViewResult) request.getAttribute("bookmarkItem"); %>
<%-- edw tha mpei to view tou new --%>
<%--
		String[] fields = new String[] {"langs.title",
				"langs.url",
				"langs.description",
				"table1.visits",
				"table1.urlOpenIn"};

--%>
<%  try { %>
<a target="<%= StringUtils.check_null(view.getField5(),"") %>" href="<%= StringUtils.check_null(view.getField2(),"") %>"><%= StringUtils.check_null(view.getField1(),"") %></a>
<br/>
<em><%= StringUtils.check_null(view.getField3(),"") %></em>

<%-- 	    	ews edw 			--%>


<c:if test="<%= hasEdit || hasDelete %>">
<br/><br/>
<form name="BsBookmarkForm" action="/ext/bookmarks/load" method="post">

<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	<tiles:put name="action"  value="/ext/bookmarks/load" />
	<tiles:put name="buttonName" value="editButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.edit") %>" />
	<tiles:put name="formName"   value="BsBookmarkForm" />
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
	<tiles:put name="action"  value="/ext/bookmarks/load" />
	<tiles:put name="buttonName" value="deleteButton" />
	<tiles:put name="buttonValue" value="<%=LanguageUtil.get(pageContext, "gn.button.delete") %>" />
	<tiles:put name="formName"   value="BsBookmarkForm" />
	<tiles:putList name="actionParamList">
	  	<tiles:add value="loadaction"/>
	  	<tiles:add value="mainid"/>
	  	<tiles:add value="redirect"/>
	</tiles:putList>
  	<tiles:putList name="actionParamValueList">
	  	<tiles:add value="delete"/>
	  	<tiles:add><%=view.getMainid().toString()%></tiles:add>
	  	<tiles:add><%=currentURL%></tiles:add>
  	</tiles:putList>
		<%--tiles:put name="actionParam" value="loadaction"/>
	<tiles:put name="actionParamValue" value="add"/--%>
	<tiles:put name="actionPermission" value="delete"/>
	<tiles:put name="portletId" value="<%=portletID%>"/>
</tiles:insert>
</form>

<br/>
</c:if>

<br/><br/>

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<c:choose>
			<c:when test="<%=Validator.isNull(redirect)%>">
				<a href="javascript:history.back();">
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/back.png" border="0" alt="back" align="middle">&nbsp;<%= LanguageUtil.get(pageContext, "back") %>
				</a>
			</c:when>
		<c:otherwise>
				<a <%="href=\"" + redirect + "\"" %>>
				<%= LanguageUtil.get(pageContext, "more") %>
				</a>
		</c:otherwise>
		</c:choose>
	</td>
</tr>
</table>

<br><br>

<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
	<tiles:put name="className" value="<%= gnomon.hibernate.model.base.bookmarks.BsBookmark.class.getName() %>"/>
	<tiles:put name="primaryKey" value="<%= view.getMainid().toString() %>"/>
	<%-- <tiles:put name="style" value="position:relative;left:10px"/> --%>
</tiles:insert>

<%--  ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.bookmarks.BsBookmark.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		url='<%= themeDisplay.getPathMain() + "/ext/bookmarks/rate" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/bookmarks/edit_discussion" />
	</portlet:actionURL>
	
	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= gnomon.hibernate.model.base.bookmarks.BsBookmark.class.getName() %>"
		classPK="<%= view.getMainid() %>"
		userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(PortalUtil.getCompanyId(request)) %>"
		subject="<%= view.getField1().toString() %>"
		redirect="<%= currentURL + "&tab=comments" %>"
	/>
</c:if>

<% } catch (Exception e) {e.printStackTrace();}%>