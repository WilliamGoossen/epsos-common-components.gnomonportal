<%@ include file="/html/portlet/ext/topicnav/init.jsp" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="gnomon.hibernate.model.parties.PaPartyTopic" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>



<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<%
LayoutLister layoutLister = new LayoutLister();

String rootNodeName = StringPool.BLANK;
LayoutView layoutView = layoutLister.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName, locale);

List layoutList = layoutView.getList();

String departmentId = GetterUtil.getString(prefs.getValue("departmentId", StringPool.BLANK), "");
List<ViewResult> deps = GnPersistenceService.getInstance(null).listObjectsWithLanguage(PortalUtil.getCompanyId(request), PaParty.class, 
		GeneralUtils.getLocale(request), new String[]{"langs.description"},
		" table1.mainid in (select pt.paParty.mainid from gnomon.hibernate.model.parties.PaPartyTopic pt) and table1.mainid in (select o.mainid from gnomon.hibernate.model.parties.PaOrganization o) ", 
		"langs.description");

%>



<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm" class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<div class="inline-labels">
	<div class="ctrl-holder">
		<label><%= LanguageUtil.get(pageContext, "secondary") %></label>
			<liferay-ui:input-checkbox param="secondary" defaultValue="<%=instanceIsSecondary%>" />
	</div>
	
	<div class="ctrl-holder">
		<label><%= LanguageUtil.get(pageContext, "topic") %></label>

			<input type="hidden" name="<portlet:namespace />topicId" value="<%=instanceTopicId%>">
			<%
			String topicName = instanceTopicView==null ? 
					"" :
					(instanceTopicView.getField2()!=null?
							instanceTopicView.getField2().toString()
							:"ERROR: TOPICID="+instanceTopicView.getMainid());
			%>
			<input size="30" type="text" readonly="true" name="<portlet:namespace />topicId_Names" value="<%= topicName %>"> &nbsp;
			<a href="#" class="beta1" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?multiSelection=false&openerFormName=<portlet:namespace />fm&openerFormFieldName=<portlet:namespace />topicId', 400,350);"><%= LanguageUtil.get(pageContext,"gn.button.choose") %></a>
    			&nbsp;<a href="#" class="beta1" onClick="document.<portlet:namespace />fm.elements['<portlet:namespace />topicId'].value='';document.<portlet:namespace />fm.elements['<portlet:namespace />topicId_Names'].value='';"><%= LanguageUtil.get(pageContext,"gn.button.clear") %></a>
	</div>
	
	<div class="ctrl-holder">
		<label>
			<%= LanguageUtil.get(pageContext, "parties.contacts.topics.config.departmentId") %></label>
		<select name="<portlet:namespace />departmentId" value="<%= departmentId %>">
		<option value=""></option>
		<% if (deps != null) { for (ViewResult d: deps) { %>
			<option value="<%= d.getMainid().toString() %>" <% if (d.getMainid().toString().equals(departmentId)) { out.print("selected"); } %>><%= d.getField1() %></option>
		<% } } %>
		</select>
	</div>
	
	<div class="ctrl-holder">
		<label>
			<%= LanguageUtil.get(pageContext, "display-style") %></label>

			<select name="<portlet:namespace />listStyle">
				<option <%= (instancePortletListStyle.equals("1")) ? "selected" : "" %> value="1"><%=LanguageUtil.get(pageContext, "style") %> - 1</option>
				<option <%= (instancePortletListStyle.equals("2")) ? "selected" : "" %> value="2"><%=LanguageUtil.get(pageContext, "style") %> - 2</option>
				<option <%= (instancePortletListStyle.equals("3")) ? "selected" : "" %> value="3"><%=LanguageUtil.get(pageContext, "style") %> - 3</option>
				<option <%= (instancePortletListStyle.equals("4")) ? "selected" : "" %> value="4"><%=LanguageUtil.get(pageContext, "style") %> - <%=LanguageUtil.get(pageContext, "shortcut") %></option>
				<%--
				<option <%= (instancePortletListStyle.equals("4")) ? "selected" : "" %> value="4">4</option>
				--%>
			</select>

	</div>

	<div class="ctrl-holder">
		<label><%= LanguageUtil.get(pageContext, "portaltab") %></label>

		<select name="<portlet:namespace />rootPlid">
				<option <%= (rootPlid == -1) ? "selected" : "" %> value="-1">
					<%= "&nbsp;[&nbsp;" + LanguageUtil.get(pageContext, "root") + "&nbsp;]&nbsp"%>
				</option>

			<%
			for (int i = 0; i < layoutList.size(); i++) {

				// id | parentId | ls | obj id | name | img | depth

				String layoutDesc = (String)layoutList.get(i);

				String[] nodeValues = StringUtil.split(layoutDesc, "|");

				long objId = GetterUtil.getLong(nodeValues[3]);
				String layoutName = nodeValues[4];

				int depth = 0;

				if (i != 0) {
					depth = GetterUtil.getInteger(nodeValues[6]);
				}

				for (int j = 0; j < depth; j++) {
					layoutName = "-&nbsp;" + layoutName;
				}
			%>

				<option <%= (rootPlid == objId) ? "selected" : "" %> value="<%= objId %>">
					<%= objId!=0?layoutName: "&nbsp;[&nbsp" + LanguageUtil.get(pageContext, "current-page") + "&nbsp;]&nbsp"%>
				</option>

			<%
			}
			%>

		</select>
			
			
	</div>

	</div>
	
	<div class="button-holder">
		<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>