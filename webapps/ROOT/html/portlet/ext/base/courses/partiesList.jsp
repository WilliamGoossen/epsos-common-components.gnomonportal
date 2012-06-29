<%@ include file="/html/portlet/ext/base/courses/init.jsp" %>

<h3><%= com.ext.portlet.base.courses.BsCourseForm.COURSE_TEACHER_REL.equals(request.getParameter("reltype")) ? 
		LanguageUtil.get(pageContext, "bs.course.teachers") : LanguageUtil.get(pageContext, "bs.course.departments")%></h3>

<br>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
		
<form name="BS_COURSE_PARTIES_SEARCH" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/courses/listAvailableParties"/></portlet:actionURL>" 
      method="post" class="uni-form">
<input type="hidden" name="reltype" value="<%= request.getParameter("reltype") %>">
<input type="hidden" name="courseid" value="<%= request.getParameter("courseid") %>">
<input type="hidden" name="redirect" value="<%= redirect %>">

<div class="inline-labels">
<div class="ctrl-holder">
<label for="searchItem"><%= LanguageUtil.get(pageContext, "name") %></label>
<input type="text" name="searchItem" value="<%= GetterUtil.getString(request.getParameter("searchItem"), "") %>">
</div>
</div>

<div class="button-holder">
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "search") %>">
</div>
</form>

<% List<ViewResult>parties = (List<ViewResult>)request.getAttribute("parties"); %>

<form name="BS_COURSE_PARTIES_ADD_FORM" action="<portlet:actionURL><portlet:param name="struts_action" value="/ext/courses/addParties"/></portlet:actionURL>" 
      method="post" class="uni-form">
<input type="hidden" name="reltype" value="<%= request.getParameter("reltype") %>">
<input type="hidden" name="courseid" value="<%= request.getParameter("courseid") %>">
<input type="hidden" name="redirect" value="<%= redirect %>">

<display:table id="party" name="parties" requestURI="//ext/courses/listAvailableParties?actionURL=true" pagesize="20" sort="list" export="false" style="width: 100%;">
<% ViewResult p = (ViewResult)party; %>
<display:column>
<input type="checkbox" name="partyid" value="<%= p.getMainid().toString() %>">
</display:column>
<display:column property="field1" titleKey="name" sortable="true"/>
</display:table>

<% if (parties != null && parties.size() > 0) { %>
<div class="button-holder">
<input type="submit" class="portlet-form-button" value="<%= LanguageUtil.get(pageContext, "add") %>">
</div>
<% } %>
</form>

<br><br>

<c:if test="<%=Validator.isNotNull(redirect) %>">
<a href="<%= redirect %>" title="<%= LanguageUtil.get(pageContext, "back") %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="<%= LanguageUtil.get(pageContext, "back") %>"><%= LanguageUtil.get(pageContext, "back") %></a>
</c:if>
