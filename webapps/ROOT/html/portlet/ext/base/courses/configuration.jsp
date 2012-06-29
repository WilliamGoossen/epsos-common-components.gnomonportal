<%@ include file="/html/portlet/ext/base/init.jsp" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>
<% 
Integer instanceCoordinator = GetterUtil.getInteger(prefs.getValue("coordinatorRole", StringPool.BLANK), 0);
Integer instanceTeacher = GetterUtil.getInteger(prefs.getValue("teacherRole", StringPool.BLANK), 0);
String instanceDepartment = GetterUtil.getString(prefs.getValue("departmentRole", StringPool.BLANK), "");
long partyLayoutid = GetterUtil.getLong(prefs.getValue("partyLayout", StringPool.BLANK), 0);

List<ViewResult> roleTypes = (List<ViewResult>)request.getAttribute("roleTypes"); 

%>
<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm" class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<div class="inline-labels">

	<%@ include file="/html/portlet/ext/base/configurationBaseElems.jspf"%>

	<fieldset class="inline-labels"><legend><%= LanguageUtil.get(pageContext, "bs.configuration.courses-specific") %></legend>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "bs.course.configuration.role.coordinator") %></label>
	<select name="<portlet:namespace />coordinatorRole">
	<option value=""></option>
	<% for (ViewResult v: roleTypes) { %>
		<option value="<%= v.getMainid().toString() %>"  <%= (instanceCoordinator.equals(v.getMainid())) ? "selected" : "" %>><%= v.getField1() %></option>
	<% } %>
	</select>
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "bs.course.configuration.role.teacher") %></label>
	<select name="<portlet:namespace />teacherRole">
	<option value=""></option>
	<% for (ViewResult v: roleTypes) { %>
		<option value="<%= v.getMainid().toString() %>"  <%= (instanceTeacher.equals(v.getMainid())) ? "selected" : "" %>><%= v.getField1() %></option>
	<% } %>
	</select>
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "bs.course.configuration.role.department") %></label>
	<select name="<portlet:namespace />departmentRole">
	<option value=""></option>
	<option value="$FREETEXT$" <%= (instanceDepartment.equals("$FREETEXT$")) ? "selected" : "" %> ><%= LanguageUtil.get(pageContext, "text") %></option>
	<% for (ViewResult v: roleTypes) { %>
		<option value="<%= v.getMainid().toString() %>"  <%= (instanceDepartment.equals(v.getMainid().toString())) ? "selected" : "" %>><%= v.getField1() %></option>
	<% } %>
	</select>
	</div>
	
	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "bs.course.configuration.partyLayout") %></label>
	<select name="<portlet:namespace/>partyLayout">
	<%
			for (int j = 0; j < layoutList.size(); j++) {

				// id | parentId | ls | obj id | name | img | depth

				String layoutDesc = (String)layoutList.get(j);

				String[] nodeValues = StringUtil.split(layoutDesc, "|");

				long objId = GetterUtil.getLong(nodeValues[3]);
				String layoutName = nodeValues[4];

				int depth = 0;

				if (j != 0) {
					depth = GetterUtil.getInteger(nodeValues[6]);
				}

				for (int k = 0; k < depth; k++) {
					layoutName = "-&nbsp;" + layoutName;
				}
			%>

				<option <%= (partyLayoutid == objId) ? "selected" : "" %> value="<%= objId %>">
					<%= objId!=0?layoutName: "&nbsp;[&nbsp" + LanguageUtil.get(pageContext, "current-page") + "&nbsp;]&nbsp"%>
				</option>

			<%
			}
			%>
	</select>
	</div>
	</fieldset>
		
	</div>
	<div class="button-holder">
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>