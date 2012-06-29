<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.GregorianCalendar" %>

<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.liferay.portlet.RenderRequestImpl" %>
<%@ page import="com.liferay.portlet.ActionRequestImpl" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>
<%@ page import="gnomon.hibernate.model.gn.GnContent" %>
<%@ page import="gnomon.hibernate.model.gn.GnContentTopic" %>
<%@ page import="gnomon.hibernate.model.gn.GnPortletSetting" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%@ page import="com.ext.portlet.permissions.service.PermissionsService" %>

<tiles:useAttribute id="struts_action" name="struts_action" classname="java.lang.String"/>
<tiles:useAttribute id="tilesParamList" name="actionParamList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="tilesParamValueList" name="actionParamValueList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="contentClassName" name="contentClass" classname="java.lang.String"/>
<tiles:useAttribute id="rootTopicId" name="topicid" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="commandSpace" name="commandSpace" classname="java.lang.String" ignore="true"/>

<%

GregorianCalendar d = new GregorianCalendar();
String monthParam="";
String yearParam="";

String lucene_month = request.getParameter("lucene_month");
String lucene_year = request.getParameter("lucene_year");
String lucene_searchItem = request.getParameter("lucene_searchItem");

String sel_month = request.getParameter("sel_month");
String sel_year = request.getParameter("sel_year");
String topic_month=null;
String topic_year =null;

PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
	String portletId = null;
	PortletPreferences prefs = null;
	if (portletRequest instanceof RenderRequest)
	{
		RenderRequestImpl req = (RenderRequestImpl)portletRequest;
		portletId = req.getPortletName();
		prefs= req.getPreferences();
	}
	else
	{
		ActionRequestImpl req = (ActionRequestImpl)portletRequest;
		portletId = req.getPortletName();
		prefs = req.getPreferences();
	}


String portletSearch = GetterUtil.getString(prefs.getValue("portlet-search", StringPool.BLANK));
if(portletSearch.equals("calendar") || portletSearch.equals("month-year")) {
	monthParam = ParamUtil.getString(request,"sel_month",d.get(Calendar.MONTH)+"");
	yearParam = ParamUtil.getString(request,"sel_year",d.get(Calendar.YEAR)+"");
	if(Validator.isNull(sel_month ) && Validator.isNull(sel_year )) {
		sel_month =monthParam;
		sel_year = yearParam;
	}
	if (portletSearch.equals("month-year") &&
		 Validator.isNotNull(lucene_month) && 
		 Validator.isNotNull(lucene_year)) {
		topic_month =lucene_month;
		topic_year=lucene_year;
	}
	if (portletSearch.equals("calendar") &&
			 Validator.isNotNull(sel_month) && 
			 Validator.isNotNull(sel_year)) {
			topic_month =(new Integer(sel_month)+1) +"";
			topic_year=sel_year;
	}
}


Class contentClass = Class.forName(contentClassName);
boolean isPublishable = true;



String topicStyle = prefs.getValue("topic-style", "1");

boolean topicsOnOff = GetterUtil.getBoolean(prefs.getValue("topicsOnOff", "false"), false);
String topicFieldSetkey = GetterUtil.getString(prefs.getValue("topicFieldSetkey", StringPool.BLANK));


String viewtopicids = (String)request.getAttribute("viewtopicids");
%>

<%
if (GnContent.class.isAssignableFrom(contentClass))
{
	
	//in case of an instanciable portlet, portlet name is <myportlet>_INSTANCE_<XX>
	//portletId = portletId.substring(0,portletId.indexOf("_INSTANCE"));
	PermissionsService permServ = PermissionsService.getInstance();
	String lang = GeneralUtils.getLocale(request);
	Long companyId = com.liferay.portal.util.PortalUtil.getCompanyId(request);
	//out.println(companyId);
	//out.println(portletId);
	// if the current portlet has topics enabled
	isPublishable = permServ.isPortletPublishingEnabled(companyId, portletId);
	if (permServ.isPortletTopicsEnabled(companyId, portletId) != GnPortletSetting.TOPICS_ENABLED_FALSE)
	{ %>
	<table width="100%" border="0" class="mytopicbrowsercss">
	<%
		GnPersistenceService serv = GnPersistenceService.getInstance(portletRequest);
		String[] fields = new String[]{"table1.mainid", "langs.name", "langs.description","table1.systemCode"};
		List<ViewResult> rootTopicsList = null;
		String portletResource = ParamUtil.getString(request, "portletResource");
		if (Validator.isNotNull(portletResource)) {
		    prefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
		}
		String portletInstanceTopicId = prefs.getValue("topic-id", StringPool.BLANK);

		if (Validator.isNotNull(portletInstanceTopicId) && !portletInstanceTopicId.equals("0"))
		{
			// SOUMELIDIS: Added to show contents of root topic on first view, and not the topic itself
			if (Validator.isNull(request.getParameter("topicid")))
				rootTopicId = portletInstanceTopicId;
			ViewResult portletInstanceTopicView = serv.getObjectWithLanguage(GnTopic.class, Integer.valueOf(portletInstanceTopicId), lang, fields);
			rootTopicsList = new ArrayList();
			rootTopicsList.add(portletInstanceTopicView);
		}
		else
			rootTopicsList = permServ.listPortletTopics(companyId,portletId, lang);
		GnTopic topic = null;
		try {
			if (rootTopicId == null)
				rootTopicId = request.getParameter("topicid");
			topic = (GnTopic)serv.getObject(GnTopic.class, Integer.valueOf(rootTopicId));
		} catch (Exception topicE) {}
		// if topic != null also render path to topic
		
		
			
		// now render children of topic
		List<ViewResult> childrenTopics = null;
		if (topic != null)
		{
			if (viewtopicids!=null && !viewtopicids.equals("") && GetterUtil.getBoolean(PropsUtil.get("gn.topics.permissions.strict"), false)) {
				childrenTopics = serv.listObjectsWithLanguage(companyId,GnTopic.class, lang, fields, "table1.gnTopic.mainid = "+topic.getMainid()+" and table1.mainid in ("+viewtopicids+")", "langs.name");
			}
			else
			{
				childrenTopics = serv.listObjectsWithLanguage(companyId,GnTopic.class, lang, fields, "table1.gnTopic.mainid = "+topic.getMainid(), "langs.name");
			}
		}
		else
			childrenTopics = rootTopicsList;
		
		
		
		
		if (topic != null)
		{
			String allParents = topic.getAllParents();
			allParents += topic.getMainid()+",";
			String[] parentIds = allParents.split(",");
			// filter out parents that are above the root topics for this portlet
			int p = 0;
			for (p=0; p<parentIds.length; p++)
			{
				boolean foundRoot =  false;
				for (ViewResult rootTopicView: rootTopicsList)
				{
					if (rootTopicView.getField1().toString().equals(parentIds[p]))
					{
						foundRoot = true;
						break;
					}
				}
				if (foundRoot)
					break;
			}
			// p holds the index before which we want to ignore the parents
			if (p != parentIds.length)
			{
				String[] temp = new String[parentIds.length-p];
				System.arraycopy(parentIds, p, temp, 0 , parentIds.length-p-1);
				parentIds = temp;
			}
			%>
			<%
			if (parentIds.length>0) { %>
			<tr>
    			<td colspan="3" scope="col" align="left">&nbsp;
			<span class="title2">
			<%
			for (p=0; p<parentIds.length; p++)
			{
				String parentId = parentIds[p];
				if (parentId != null && !parentId.equals(""))
				{
					ViewResult topicView = serv.getObjectWithLanguage(GnTopic.class, Integer.valueOf(parentId), lang, fields);
					%>
					<a class="beta1" href="
					<portlet:actionURL>
					<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
					<portlet:param name="topicid" value="<%= parentId %>"/>
					<portlet:param name="sel_month" value="<%= monthParam %>"/>
					<portlet:param name="sel_year" value="<%= yearParam %>"/>
					<%
					if (tilesParamList != null && tilesParamList.size() > 0) {
						for (int t=0; t<tilesParamList.size(); t++){
						%>
							<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
						<%
						}
					}
					%>
					<% if (Validator.isNotNull(lucene_searchItem)) { %>
						<portlet:param name="lucene_searchItem" value="<%= lucene_searchItem %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_month)) { %>
						<portlet:param name="lucene_month" value="<%= lucene_month %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_year)) { %>
						<portlet:param name="lucene_year" value="<%= lucene_year %>"/>
					<% } %>
					</portlet:actionURL>"><%= topicView.getField2() %></a>
					<%
					if (p<parentIds.length-1) { %>
						>&nbsp;
					<% }
				}
			}
			%>
			<%
			if(topicStyle.equals("2")) {
				 if (topic != null && ( !topic.getMainid().toString().equals(portletInstanceTopicId) || ( topic.getMainid().toString().equals(portletInstanceTopicId) && childrenTopics.size()>0)) || !topicStyle.equals("2")) { 
				ViewResult topicView = serv.getObjectWithLanguage(GnTopic.class, topic.getMainid(), lang, fields);
				%>
					<%= topicView.getField2() %>
				<%}
			}
			
			%>
			</span>
				</td>
  			</tr>
			<% }
			}%>
			
			
			
			
		<%	if(!topicStyle.equals("2")) {%>
			 
			<tr>
				<% if (topic != null) { %>
				<td width="160">
					<table cellpadding="0" cellspacing="4">
					<%
						ViewResult topicView = serv.getObjectWithLanguage(GnTopic.class, topic.getMainid(), lang, fields);
					%>
					<tr>
						<td>
							<div>
								<img id="browse:space-logo" src="<%= themeDisplay.getPathThemeImage() %>/base/space-icon-default.gif" alt="space-icon" style="padding-right:4px;" >
							</div>
						</td>
						<td>
							<div class="mainTitle">
								<span id="browse:msg2"><%//=topicView.getField2()%>
									<%= topicView.getField2() %>
								</span>
							</div>
							<% if (topicView.getField3()!=null) { %>
							<div class="mainSubText">
								<span id="browse:msg3"><%=topicView.getField3()%></span>
							</div>
							<% } %>
						</td>
					</tr>
					</table>
				</td>
				<% } else { %>
				<td width="160">&nbsp;</td>
				<% } %>
				<td colspan="2">
					<% if ((commandSpace!=null) && (!commandSpace.equals(""))) { %>
						<tiles:insert page="<%=commandSpace%>" flush="true"/>
					<% } %>
				</td>
			</tr>
		
		<%}%>
		<tr>
			<td colspan="3">
				
				<% if(topicsOnOff==true && childrenTopics!=null && childrenTopics.size()>0) {%>
					<fieldset>
		
		
		<a href="#" onclick="Liferay.Util.toggle('childtopics',true);">
            <legend><img src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_plus.gif" alt="<%= LanguageUtil.get(pageContext, topicFieldSetkey) %>" style="padding-right:4px; "><%= LanguageUtil.get(pageContext, topicFieldSetkey) %></legend></a>
       		
            <div id="childtopics" style="display:none;">  
				
			<%}%>	
		<table width="100%">
		<%
		int ct = 0;
		for (ViewResult childTopic: childrenTopics)
		{
			int childContentCount = 0;
			if (contentClassName.equals(gnomon.hibernate.model.base.events.BsEvent.class.getName()))
			{
				// special case for events, to cover for recurrent events correct counting
				String criterion = " event.mainid in (select table2.gnContent.mainid from gnomon.hibernate.model.gn.GnContentTopic table2 where table2.gnTopic.mainid = " + childTopic.getField1() + 
						" or table2.gnTopic.allParents like '%,"+childTopic.getField1()+",%' ) ";
				if (viewtopicids!=null && !viewtopicids.equals("")) {
					criterion += " and event.mainid in (select table2.gnContent.mainid from gnomon.hibernate.model.gn.GnContentTopic table2 where table2.gnTopic.mainid in (" + viewtopicids +")) ";
				}
				if (isPublishable)
					criterion +=  " and  (event.published = 1 and (event.expiresNever = 1 or "+
					"((event.publishDateStart <= current_date() and event.publishDateEnd is null) or "+
					"(event.publishDateStart <= current_date() and event.publishDateEnd >= current_date())))) ";

			
				Date now = null, then = null;
				Calendar cal = null;
				if (Validator.isNotNull(sel_month) && Validator.isNotNull(sel_year)) {
					int month = Integer.valueOf(sel_month); // remember that in jsp calendar months start counting from 0
					cal = Calendar.getInstance();
					cal.set(Calendar.YEAR, Integer.parseInt(sel_year));
					cal.set(Calendar.MONTH, month);
					cal.set(Calendar.DAY_OF_MONTH, 1);
					Date fromFirstOfMonth = cal.getTime();
					cal.add(Calendar.MONTH, 1);
					Date toLastOfMonth = cal.getTime();
					now = fromFirstOfMonth;
					then = toLastOfMonth;
				}
				else
				{
					cal = Calendar.getInstance();
					cal.set(Calendar.DAY_OF_MONTH, 1);
					now = cal.getTime();
					cal.add(Calendar.MONTH, 1);
					then = cal.getTime();
				}
				boolean eventsNoRecurrentEventsInList = GetterUtil.getBoolean(prefs.getValue("eventsNoRecurrentEventsInList", StringPool.BLANK), false);
				String instancePortletSearch = GetterUtil.getString(prefs.getValue("portlet-search", StringPool.BLANK));
				if (Validator.isNull(instancePortletSearch)) {
					now = null; then = null; eventsNoRecurrentEventsInList = true;
				}
				boolean showOnlyMine = GetterUtil.getBoolean(prefs.getValue("showOnlyMine", StringPool.BLANK), false);
				if (showOnlyMine)
				{
					if (criterion.length() > 0)
						criterion += " and ";
					criterion += " event.creatorid = "+user.getUserId();
				}
				List events = com.ext.portlet.base.events.RecurrenceUtil.getInstance().listAllEvents(now, then, criterion, lang, !eventsNoRecurrentEventsInList);
				if (events != null)
					childContentCount = events.size();
			}
			else {
				String dateCriterion = null;
				String formbeanName=com.ext.portlet.base.contentrel.ContentRelUtil.getInstance().getFormBeanNameForClassName(contentClassName);
				if (Validator.isNotNull(topic_month) && Validator.isNotNull(topic_year))  {
				try{
					com.ext.portlet.cms.generic.GnContentForm cForm = (com.ext.portlet.cms.generic.GnContentForm)Class.forName(formbeanName).newInstance();
					dateCriterion= 	cForm.getTopicCountDateCriterion(topic_month , topic_year);
				}
				catch (Exception e) {
					e.printStackTrace();
					}
				}
				
				// The portlet action can decide if for any reason (i.e. for admin) the showOnlyMine flag shoud be ignored.
				String ignoreShowOnlyMine = (String)request.getAttribute("ignoreShowOnlyMine");
				boolean ignoreShowOnlyMineFlag = Validator.isNotNull(ignoreShowOnlyMine); 
				boolean showOnlyMine = GetterUtil.getBoolean(prefs.getValue("showOnlyMine", StringPool.BLANK), false);
				List contentCount = serv.listObjects(null,GnContentTopic.class,
				" (table1.gnTopic.mainid = "+childTopic.getField1()+" or table1.gnTopic.allParents like '%,"+childTopic.getField1()+",%' ) and table1.gnContent.className = '"+ contentClassName+"'"
				+" and table1.gnContent.companyId = " + companyId +
				(isPublishable?
					" and table1.gnContent.published = 1 and (table1.gnContent.expiresNever = 1 or (table1.gnContent.publishDateStart <= current_date() and table1.gnContent.publishDateEnd >= current_date() ))"
					: "") +
					((viewtopicids!=null && !viewtopicids.equals(""))? " and table1.gnContent.mainid in (select table2.gnContent.mainid from gnomon.hibernate.model.gn.GnContentTopic table2 where table2.gnTopic.mainid in (" + viewtopicids +"))" :"") +
					(dateCriterion!=null? " and " + dateCriterion : "") +
					(!ignoreShowOnlyMineFlag && showOnlyMine? " and table1.gnContent.creatorid = " +user.getUserId() : "")
				);
				
				
			
				
				childContentCount = contentCount.size();
			}
			
			
			
			//out.println("SIZE=" + childContentCount);
			//out.println(serv.isPortletPublishingEnabled());
			if (true || childContentCount > 0) {
			
				if(topicStyle.equals("2")) { out.print("<tr>"); }
			else
				if (ct==0 || (ct>1 && ct%2 == 0)) { out.print("<tr>"); }
			%>
			<td><!--<img src="<%= themeDisplay.getPathThemeImage() %>/navigation/bullet_over.png" alt="<%= LanguageUtil.get(pageContext, "gn.topics.topic.name") %>">-->
		
			<%
			int personalSpace=-1;
			if (Validator.isNotNull(childTopic.getField4())) 
			{
			personalSpace =	childTopic.getField4().toString().indexOf("personalSpace");
			}
			if(personalSpace>=0 &&
					!com.ext.portlet.topics.service.permission.GnTopicPermission.contains(permissionChecker, (Integer)childTopic.getField1(), com.liferay.portal.kernel.security.permission.ActionExtKeys.VIEW)) { }
					else {%>
			
			    <a href="<portlet:actionURL>
				<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
				<portlet:param name="topicid" value="<%= childTopic.getField1().toString() %>"/>
				<portlet:param name="sel_month" value="<%= monthParam %>"/>
				<portlet:param name="sel_year" value="<%= yearParam %>"/>
				<%
				if (tilesParamList != null && tilesParamList.size() > 0) {
					for (int t=0; t<tilesParamList.size(); t++){
					%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
					<%
					}
				}
				%>
				<% if (Validator.isNotNull(lucene_searchItem)) { %>
						<portlet:param name="lucene_searchItem" value="<%= lucene_searchItem %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_month)) { %>
						<portlet:param name="lucene_month" value="<%= lucene_month %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_year)) { %>
						<portlet:param name="lucene_year" value="<%= lucene_year %>"/>
					<% } %>
			</portlet:actionURL>"><%= childTopic.getField2().toString() %> <i>(<%= childContentCount %>)</i></a>
			<%}%>
			</td>
			<%
			}
			else
			{
			%>
			<td><img src="<%= themeDisplay.getPathThemeImage() %>/navigation/bullet_over.png" alt="<%= LanguageUtil.get(pageContext, "gn.topics.topic.name") %>">
			    <%= childTopic.getField2().toString() %> <i>(<%= childContentCount %>)</i></td>
			<%
			}
			
				if(topicStyle.equals("2")) { out.print("</tr>"); }
			else
			if (ct==1 || ct%2 == 1) { out.print("</tr>"); } 
			ct++;
		}
		%>
		</table>
				<% if(topicsOnOff==true && childrenTopics!=null && childrenTopics.size()>0) {%>
	</div>
</fieldset>
<%}%>
		
		<br>
		<% TreeMap<String, List<ViewResult>> gnContent_otherTopics_map = (TreeMap<String, List<ViewResult>>)request.getAttribute("gnContent_otherTopics_map");
		   if (gnContent_otherTopics_map != null && gnContent_otherTopics_map.size() > 0) { 
			   Set<String> keys = gnContent_otherTopics_map.keySet();
			   String extra_topicid = request.getParameter("extra_topicid");
		   %>
		<fieldset>
			<% if(topicsOnOff==true) {%>
		
		<a href="#" onclick="Liferay.Util.toggle('additionaltopic',true);">
            <legend><img src="<%= themeDisplay.getPathThemeImage() %>/arrows/01_plus.gif" alt="<%= LanguageUtil.get(pageContext, topicFieldSetkey) %>" style="padding-right:4px; "><%= LanguageUtil.get(pageContext, topicFieldSetkey) %></legend></a>
       		
            <div id="additionaltopic" style="display:none;">  
            
		<%}%>
		<table width="100%">
		<tr>
		<td>
		<table width="100%">
		<%
		for (String key:keys) {
			%>
			<tr>
			<td>
			<em><%= key %>: &nbsp;</em>
			</td>
			<td>
			<table width="100%">
			<%
			int i=0;
			List<ViewResult> keyList = gnContent_otherTopics_map.get(key);
			for (ViewResult topicKeyView: keyList) {
				if (Validator.isNull(extra_topicid) || extra_topicid.equals(topicKeyView.getMainid().toString())) {
					if (i==0 || (i>1 && i%2 == 0)) { out.print("<tr>"); }
				%>
				<td>
				<img src="<%= themeDisplay.getPathThemeImage() %>/navigation/bullet.png" alt="<%= LanguageUtil.get(pageContext, "gn.topics.select.to.filter") %>" />
						
				<a title="<%= LanguageUtil.get(pageContext, "gn.topics.select.to.filter") %>" href="<portlet:actionURL>
				<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
				<portlet:param name="topicid" value="<%= topic.getMainid().toString() %>"/>
				<portlet:param name="extra_topicid" value="<%= topicKeyView.getMainid().toString() %>"/>
				<portlet:param name="sel_month" value="<%= monthParam %>"/>
				<portlet:param name="sel_year" value="<%= yearParam %>"/>
				<%
				if (tilesParamList != null && tilesParamList.size() > 0) {
					for (int t=0; t<tilesParamList.size(); t++){
					%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
					<%
					}
				}
				%>
				<% if (Validator.isNotNull(lucene_searchItem)) { %>
						<portlet:param name="lucene_searchItem" value="<%= lucene_searchItem %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_month)) { %>
						<portlet:param name="lucene_month" value="<%= lucene_month %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_year)) { %>
						<portlet:param name="lucene_year" value="<%= lucene_year %>"/>
					<% } %>
			    </portlet:actionURL>">
				<%= topicKeyView.getField1() + " ("+topicKeyView.getField2()+") "%>
				</a>
				</td>
				<%
					if (i==1 || i%2 == 1) { out.print("</tr>"); } 
					i++;
				}
			} %>
			</table>
			</td>
			</tr>
			<%
		} %>
		</table>
		</td>
		<%
		if (Validator.isNotNull(extra_topicid)) { %>
			<td valign="top">
			<a title="<%= LanguageUtil.get(pageContext, "gn.topics.select.to.unfilter") %>" href="<portlet:actionURL>
				<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
				<portlet:param name="topicid" value="<%= topic.getMainid().toString() %>"/>
				<portlet:param name="sel_month" value="<%= monthParam %>"/>
				<portlet:param name="sel_year" value="<%= yearParam %>"/>
				<%
				if (tilesParamList != null && tilesParamList.size() > 0) {
					for (int t=0; t<tilesParamList.size(); t++){
					%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
					<%
					}
				}
				%>
				<% if (Validator.isNotNull(lucene_searchItem)) { %>
						<portlet:param name="lucene_searchItem" value="<%= lucene_searchItem %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_month)) { %>
						<portlet:param name="lucene_month" value="<%= lucene_month %>"/>
					<% } %>
					<% if (Validator.isNotNull(lucene_year)) { %>
						<portlet:param name="lucene_year" value="<%= lucene_year %>"/>
					<% } %>
			    </portlet:actionURL>">
				<img src="<%= themeDisplay.getPathThemeImage() %>/common/top.png">
				</a>
				</td>
				<%
		}
		%>
		</tr>
		</table>
		
			<% if(topicsOnOff==true) {%>
		 </div>
		 <%}%>
		</fieldset>
		<% }  %>
			</td>
		</tr>
		</table>
		<%
	} else { %>
		<table width="100%" border="0" style="none">
		<tr>
			<td width="160">&nbsp;</td>
			<td colspan="3">
				<% if ((commandSpace!=null) && (!commandSpace.equals(""))) { %>
					<tiles:insert page="<%=commandSpace%>" flush="true"/>
				<% } %>
			</td>
		</tr>
		</table>
	<% }
}
%>


<%
/*** PERSONAL SPACE **/
boolean isPersonalSpace =  GetterUtil.getBoolean(PropsUtil.get("userPersonalSpace"), false); 
boolean hasEdit = PortletPermissionUtil.contains(permissionChecker, plid, portletId, ActionExtKeys.EDIT) ;
String systemCode = portletId+"personalSpace" + user.getUserId();
String lang = GeneralUtils.getLocale(request);
ViewResult personalTopic = com.ext.portlet.topics.service.TopicsService.getInstance().getTopicBySystemCode( PortalUtil.getCompanyId(request),  systemCode,  lang);
if(hasEdit && isPersonalSpace && personalTopic==null) {%>
<a href ="<liferay-portlet:actionURL portletName="2"> 
					<liferay-portlet:param name="struts_action" value="/my_account/addpersonal"/>
					<liferay-portlet:param name="portletid" value="<%=portletId%>"/>
					<liferay-portlet:param name="systemCode" value="<%=systemCode%>"/>
				</liferay-portlet:actionURL>"> <%=LanguageUtil.get(pageContext,"create-personal-space")%></a>
	
<%}%>
