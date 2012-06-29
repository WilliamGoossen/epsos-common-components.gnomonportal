<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="gnomon.hibernate.Utils" %>
<%@ page import="gnomon.hibernate.model.parties.PsPartyRoleType" %>
<%@ page import="gnomon.hibernate.model.parties.PaPartyTopic" %>
<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.ext.portlet.parties.lucene.PartiesLuceneUtilities" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>


<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>
<%
PortletPreferences prefs = renderRequest.getPreferences();

String portletResource = ParamUtil.getString(request, "portletResource");

if (Validator.isNotNull(portletResource)) {
	prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
}

long partyLayoutid = GetterUtil.getLong(prefs.getValue("partyLayout", StringPool.BLANK), 0);

String partyRoleIds = GetterUtil.getString(prefs.getValue("partyRoleId", StringPool.BLANK));
Vector<String> selectedRoles = new Vector<String>();
if (Validator.isNotNull(partyRoleIds)) {
	selectedRoles.addAll(Arrays.asList(partyRoleIds.split(",")));
}

String departmentId = GetterUtil.getString(prefs.getValue("departmentId", StringPool.BLANK), "");

String instanceUseTopicNav = GetterUtil.getString(prefs.getValue("use-topic-nav", "no"));

LayoutLister layoutLister = new LayoutLister();
String rootNodeName = StringPool.BLANK;
LayoutView layoutView = layoutLister.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName, locale);
List layoutList = layoutView.getList();

List<ViewResult> partyRoleTypes = GnPersistenceService.getInstance(null).listObjectsWithLanguage(null, PsPartyRoleType.class, GeneralUtils.getLocale(request), new String[]{"langs.name"}, null, "langs.name");

List<ViewResult> deps = GnPersistenceService.getInstance(null).listObjectsWithLanguage(PortalUtil.getCompanyId(request), PaParty.class, 
		GeneralUtils.getLocale(request), new String[]{"langs.description"},
		" table1.mainid in (select pt.paParty.mainid from gnomon.hibernate.model.parties.PaPartyTopic pt) and table1.mainid in (select o.mainid from gnomon.hibernate.model.parties.PaOrganization o) ", 
		"langs.description");
%>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm" class="uni-form">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<div class="inline-labels">


	<div class="ctrl-holder">
	<label><%= LanguageUtil.get(pageContext, "use-topic-nav") %></label>
	
			<select name="<portlet:namespace />use-topic-nav">
				<option <%= (instanceUseTopicNav.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "no") %></option>
				<option <%= (instanceUseTopicNav.equals("yes")) ? "selected" : "" %> value="yes"><%= LanguageUtil.get(pageContext, "yes") %></option>
				
			</select>
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
	<label><%= LanguageUtil.get(pageContext, "contacts.search.only-in-party-roles") %></label>
	<select name="<portlet:namespace />partyRoleId" size="6" multiple="true">
				<% if(partyRoleTypes == null || partyRoleTypes.size() == 0) { %>
				<option value="">*</option>
				<% } else { 
					for (int p=0; p<partyRoleTypes.size(); p++) {
						ViewResult roleView = partyRoleTypes.get(p);
					%>
					<option value="<%= roleView.getMainid().toString() %>"
						<% if (selectedRoles.contains(roleView.getMainid().toString())) { out.print("selected"); } %> >
						<%= roleView.getField1().toString() %>
					 </option>
					<% } 
				}%>
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

	</div>
	
	<div class="button-holder">
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
	</div>
</form>