<%@ include file="/html/portlet/ext/base/courses/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="com.ext.portlet.base.courses.BsCourseForm" %>

<%
BsCourseForm formBean = (BsCourseForm)request.getAttribute("BsCourseForm");
long partyLayoutid = GetterUtil.getLong(prefs.getValue("partyLayout", StringPool.BLANK), 0);
%>

<form name="BsCourseForm" action="some/url" method="post" class="uni-form">

<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.course.action.view")  %></legend>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "bs.course.name") %></label>

<span><%= formBean.getName() %></span>

</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "bs.course.code") %></label>

<span><%= formBean.getCode() %></span>

</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "bs.course.ects") %></label>

<span><%= formBean.getEcts() %></span>

</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "bs.course.coordinator") %></label>

<% if (Validator.isNotNull(formBean.getCoordinatorid())) { %>
<a href="<%= partyLayoutid > 0 ? com.ext.portlet.parties.contacts.ContactsService.generatePartyLink(Integer.valueOf(formBean.getCoordinatorid()), partyLayoutid, LiferayWindowState.NORMAL, true, request).toString() :
com.ext.portlet.parties.contacts.ContactsService.generateMaximizedPartyLink(Integer.valueOf(formBean.getCoordinatorid()), true, request).toString() %>">
<% } else { %>
<span>
<% } %>
<%
String[] selectValues = formBean.getCoordinatorIds();
String[] selectLabels = formBean.getCoordinatorNames();
String selectId = formBean.getCoordinatorid();
if (selectValues != null && selectValues.length > 0 && Validator.isNotNull(selectId)) {
		List<String> selectList = Arrays.asList(selectValues);
	int valueIndex = selectList.indexOf(selectId);
	if (valueIndex >= 0 && valueIndex < selectLabels.length) {
		String selectedValue = selectLabels[valueIndex];
		%>
		<%= (selectedValue!= null? selectedValue : " - ") %>
		<%
	} else {
		out.print(" - ");
	}
} else {
	out.print(" - ");
}
%>
<% if (Validator.isNotNull(formBean.getCoordinatorid())) { %>
</a>
<% } else { %>
</span>
<% } %>
</div>

<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "bs.course.description") %></label>

<span><%= formBean.getDescription() %></span>

</div>


<div class="ctrl-holder">
<label><%= LanguageUtil.get(pageContext, "bs.course.topics") %></label>

<span>

<%  
try {
	GnPersistenceService serv = GnPersistenceService.getInstance(null);
	String[] topicIds = formBean.getTopicIds().split(",");
	String[] topicNameField = {"langs.name"};
	String lang = gnomon.business.GeneralUtils.getLocale(request);
	String newValue = "";
	for (int v=0; v<topicIds.length; v++)
	{
		Integer topicId = Integer.valueOf(topicIds[v]);
		ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, topicId, lang, topicNameField);
		newValue += (String)topicView.getField1();
		if (v<topicIds.length-1)
			newValue += ", ";
	}
	out.print(newValue);
} catch (Exception e) {}
%>



</span>

</div>
</fieldset>


<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.course.teachers") %></legend>
<label>
</label>

<% List<ViewResult> courseTeachers = (List<ViewResult>)request.getAttribute("courseTeachers"); %>

<% if (courseTeachers != null && courseTeachers.size() > 0 ) {
	%><table width="40%"><%
	for (ViewResult p: courseTeachers) { %>
	<tr>
	<td align="left">
	<tiles:insert page="/html/portlet/ext/parties/contacts/view/partyViewLinkTile.jsp" flush="true">
		  <tiles:put name="mainid"  value="<%= p.getMainid() %>" />
		  <tiles:put name="partyName"  value="<%= p.getField1().toString() %>" />
		  <tiles:put name="partyLayoutid"  value="<%= partyLayoutid %>" />
	</tiles:insert>
	</td></tr>
<% } %>
	</table>
<% } %>



</fieldset>


<fieldset class="inline-labels">
<legend><%= LanguageUtil.get(pageContext, "bs.course.departments") %></legend>
<label>
</label>

<%
String tmimaRole = prefs.getValue("departmentRole", StringPool.BLANK);
if (Validator.isNotNull(tmimaRole) && !tmimaRole.equals("$FREETEXT$")) { 
	List<ViewResult> courseDepartments = (List<ViewResult>)request.getAttribute("courseDepartments"); 

if (courseDepartments != null && courseDepartments.size() > 0 ) { %>
<table width="40%">
	<%	for (ViewResult p2: courseDepartments) { %>
	<tr>
	<td align="left"><%= p2.getField1() %></td></tr>
<% } %>
</table>
<% }
} else { %>
<span><%= Validator.isNotNull(formBean.getTmimata()) ? formBean.getTmimata() : "" %></span>
<% } %>
</fieldset>


<tiles:insert page="/html/portlet/ext/struts_includes/metaData_div.jsp" flush="true">
	<tiles:put name="formName" value="BsCourseForm"/>
	<tiles:put name="className" value="gnomon.hibernate.model.base.courses.BsCourse"/>
	<%	 if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="readOnly" value="true"/>
</tiles:insert>

</form>

<br><br>

<tiles:insert page="/html/portlet/ext/base/contentrel/relatedContentTile.jsp" flush="true">
	<tiles:put name="className" value="<%= gnomon.hibernate.model.base.courses.BsCourse.class.getName() %>"/>
	<tiles:put name="primaryKey"><%= formBean.getMainid().toString()%></tiles:put>
</tiles:insert>

<br><br>

<%--  ratings --%>
<c:if test="<%= enableRatings %>">

	<liferay-ui:ratings
		className="<%= gnomon.hibernate.model.base.courses.BsCourse.class.getName() %>"
		classPK="<%= formBean.getMainid().longValue() %>"
		url='<%= themeDisplay.getPathMain() + "/ext/courses/rate" %>'
	/>
</c:if>

<%--  comments --%>
<c:if test="<%= enableComments  %>">
	<br />

	<portlet:actionURL var="discussionURL">
		<portlet:param name="struts_action" value="/ext/courses/edit_discussion" />
	</portlet:actionURL>
	
	<liferay-ui:discussion
		formName="fm2"
		formAction="<%= discussionURL %>"
		className="<%= gnomon.hibernate.model.base.courses.BsCourse.class.getName() %>"
		classPK="<%= formBean.getMainid().longValue()  %>"
		userId="<%= PortalUtil.getUserId(request)>0 ? PortalUtil.getUserId(request) : UserLocalServiceUtil.getDefaultUserId(PortalUtil.getCompanyId(request)) %>"
		subject="<%= formBean.getName().toString()+" ( "+formBean.getEcts()+ " ) " %>"
		redirect="<%= currentURL + "&tab=comments" %>"
	/>
</c:if>

<br><br>

<c:if test="<%=Validator.isNotNull(redirect) %>">
<a href="<%= redirect %>" title="<%= LanguageUtil.get(pageContext, "back") %>">
<img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png" alt="<%= LanguageUtil.get(pageContext, "back") %>"><%= LanguageUtil.get(pageContext, "back") %></a>
</c:if>

