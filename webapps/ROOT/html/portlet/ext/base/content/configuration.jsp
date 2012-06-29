<%@ include file="/html/portlet/ext/base/content/init.jsp" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>


<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<%
//Get all topics that we are allowed to get

String managetopicids= com.ext.portlet.topics.service.permission.GnTopicPermission.getAllResources(PortalUtil.getCompanyId(request), "gnomon.hibernate.model.gn.GnTopic",permissionChecker,"MANAGECONTENT");
LayoutLister layoutLister = new LayoutLister();

String rootNodeName = StringPool.BLANK;
LayoutView layoutView = layoutLister.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName, locale);

List layoutList = layoutView.getList();

%>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">

<table border="0" cellpadding="0" cellspacing="0">
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "show-calendar") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="showCalendar" defaultValue="<%=showCalendar%>" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "vertical-bar") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="showCalendarVertical" defaultValue="<%=showCalendarVertical%>" />
	</td>
</tr>
<%--
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "content-class") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%
		String[] availableClasses = StringUtil.split(
			GetterUtil.getString(PropsUtil.get("gn.cms.content.classes.in.recent.options")),",");
		%>
		<c:choose>
			<c:when test="<%=PropsUtil.get("gn.cms.content.classes.in.recent.options")!=null %>">
				<select name="<portlet:namespace />contentClass">
					<% for (int i=0; i<availableClasses.length; i++) { %>
					<option <%= (contentClass.equals(availableClasses[i])) ? "selected" : "" %> value="<%=availableClasses[i]%>"><%= LanguageUtil.get(pageContext, availableClasses[i]+".key") %></option>
					<% } %>					
				</select>
			</c:when>
			<c:otherwise>
				<input  name="<portlet:namespace />contentClass" style="width: 250px;" type="text" value="<%= Validator.isNull(contentClass)? GetterUtil.getString(PropsUtil.get("gn.cms.content.classes.in.recent.default"),"") : contentClass %>">
			</c:otherwise>
		</c:choose>
	</td>
</tr>
--%>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "loader-class") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<%
		String[] availableLoaderClasses = StringUtil.split(
			GetterUtil.getString(PropsUtil.get("gn.cms.loader.classes.in.recent.options")),",");
		%>
		<c:choose>
			<c:when test="<%=PropsUtil.get("gn.cms.loader.classes.in.recent.options")!=null %>">
				<select name="<portlet:namespace />loaderClass">
					<% for (int i=0; i<availableLoaderClasses.length; i++) { %>
					<option <%= (loaderClass.equals(availableLoaderClasses[i])) ? "selected" : "" %> value="<%=availableLoaderClasses[i]%>"><%= LanguageUtil.get(pageContext, availableLoaderClasses[i]+".key") %></option>
					<% } %>					
				</select>
			</c:when>
			<c:otherwise>
				<input  name="<portlet:namespace />contentClass" style="width: 250px;" type="text" value="<%= Validator.isNull(loaderClass)? GetterUtil.getString(PropsUtil.get("gn.cms.loader.classes.in.recent.default"),"") : loaderClass %>">
			</c:otherwise>
		</c:choose>
	</td>
</tr>

<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "topic") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<input type="hidden" name="<portlet:namespace />topicId" value="<%=instanceTopicId%>">
			<%
			//int instanceTopicId = GetterUtil.getInteger(prefs.getValue("topic-id", StringPool.BLANK));
			String topicName = "";
			GnPersistenceService serv = GnPersistenceService.getInstance(null);
     	 	String[] topicNameField = {"langs.name"};
     	 	//String lang = gnomon.business.GeneralUtils.getLocale(request);
     	 	if (instanceTopicId>0) {
     	 		ViewResult topicView = (ViewResult)serv.getObjectWithLanguage(GnTopic.class, new Integer(instanceTopicId), lang, topicNameField);
     	 		topicName = ((topicView==null || topicView.getField1()==null)? "<INVALID>" : (String)topicView.getField1());
     	 		//topicName = (String)topicView.getField1();
     	 	}
     	 	//PortletRequest portletRequest = (PortletRequest)request.getAttribute(WebKeys.JAVAX_PORTLET_REQUEST);
			String portletId = null;
			if (Validator.isNotNull(portletResource)) {
				portletId = portletResource;
			} else {
				if (portletRequest instanceof RenderRequest)
				{
					RenderRequestImpl req = (RenderRequestImpl)portletRequest;
					portletId = req.getPortletName();
				}
				else
				{
					ActionRequestImpl req = (ActionRequestImpl)portletRequest;
					portletId = req.getPortletName();
				}
			}
   	   	    String portletTopicIds = "";
   	   		List<ViewResult> portletTopics = PermissionsService.getInstance().listPortletTopics(PortalUtil.getCompanyId(request),portletId, lang);
   	   		for (int t=0; t<portletTopics.size(); t++)
   	   		{
   	   			portletTopicIds += ((ViewResult)portletTopics.get(t)).getField1();
   	   			if (t<portletTopics.size()-1)
   	   				portletTopicIds += ",";
   	   		}
			%>
			<input type="text" readonly="true" name="<portlet:namespace />topicId_Names" value="<%= topicName %>"> &nbsp;
			<a href="#" class="beta1" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?managetopics=<%=managetopicids%>&multiSelection=false&openerFormName=<portlet:namespace />fm&openerFormFieldName=<portlet:namespace />topicId&rootTopicIds=<%=portletTopicIds%>', 400,350);"><%= LanguageUtil.get(pageContext,"gn.button.choose") %></a>
    			&nbsp;<a href="#" class="beta1" onClick="document.<portlet:namespace />fm.elements['<portlet:namespace />topicId'].value='';document.<portlet:namespace />fm.elements['<portlet:namespace />topicId_Names'].value='';"><%= LanguageUtil.get(pageContext,"gn.button.clear") %></a>
		</td>
	</tr>


<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "number-of-items") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input  name="<portlet:namespace />numOfItems" style="width: 50px;" type="text" value="<%= numberOfItems %>">
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "content-parameters") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<textarea class="form-text" rows="7" cols="50" name="<portlet:namespace />contentParams"><%= contentParams %></textarea>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "show-images") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="showImages" defaultValue="<%=showImages%>"/>
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "show-upcoming-events") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="showUpcomingEvents" defaultValue="<%=showUpcomingEvents%>" />
	</td>
</tr>
<tr>
	<td>
		<%= LanguageUtil.get(pageContext, "show-upcoming-events-month-count") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<input style="width: 50px;" type="text" name="<portlet:namespace />showUpcomingEventsMonthCount" value="<%=showUpcomingEventsMonthCount%>" />
	</td>
</tr>
<tr>
		<td>
		<%= LanguageUtil.get(pageContext, "bs.events.do-not-list-recurrent-events-separately") %>
	</td>
	<td style="padding-left: 10px;"></td>
	<td>
		<liferay-ui:input-checkbox param="eventsNoRecurrentEventsInList" defaultValue="<%= eventsNoRecurrentEventsInList%>" />
	</td>
</tr>
<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "display-style") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<select name="<portlet:namespace />listStyle">
				<option <%= (instancePortletListStyle.equals("1")) ? "selected" : "" %> value="1">1</option>
				<option <%= (instancePortletListStyle.equals("2")) ? "selected" : "" %> value="2">2</option>
				<option <%= (instancePortletListStyle.equals("3")) ? "selected" : "" %> value="3">3</option>
				<option <%= (instancePortletListStyle.equals("4")) ? "selected" : "" %> value="4">4</option>
			</select>
		</td>
	</tr>
	
<tr>	
		<td><%= LanguageUtil.get(pageContext, "bs.related.content.portaltab") %></td>	
		<td style="padding-left: 10px;"></td>
		<td>
		
		<% long rootPlid = GetterUtil.getLong(prefs.getValue("show_rootPlid", StringPool.BLANK));%>
				<select name="<portlet:namespace />show_rootPlid">
				<option <%= (rootPlid == -1) ? "selected" : "" %> value="-1">
					<%= "&nbsp;[&nbsp;" + LanguageUtil.get(pageContext, "root") + "&nbsp;]&nbsp"%>
				</option>

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

				<option <%= (rootPlid == objId) ? "selected" : "" %> value="<%= objId %>">
					<%= objId!=0?layoutName: "&nbsp;[&nbsp" + LanguageUtil.get(pageContext, "current-page") + "&nbsp;]&nbsp"%>
				</option>

			<%
			}
			%>

		</select>
		
		
		</td>
</table>
<br>
<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">

</form>

<script type="text/javascript">
	document.<portlet:namespace />fm.<portlet:namespace />numOfItems.focus();
</script>