<%@ include file="/html/portlet/ext/cms/search/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.search.OpenSearch" %>
<%@ page import="com.liferay.portal.kernel.search.SearchException" %>
<%@ page import="com.liferay.portal.kernel.util.InstancePool" %>
<%@ page import="com.liferay.portal.search.OpenSearchUtil" %>
<%@ page import="com.liferay.portal.util.SAXReaderFactory" %>
<%@ page import="com.liferay.portlet.journal.service.JournalContentSearchLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.journal.model.JournalArticle" %>

<%@ page import="org.dom4j.Document" %>
<%@ page import="org.dom4j.Element" %>
<%@ page import="org.dom4j.io.SAXReader" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="com.ext.portlet.topics.service.TopicsTreeBuilder" %>
<%@ page import="com.ext.util.TreeViewDescription" %>
<%@ page import="gnomon.business.GeneralUtils" %>

<%
boolean showTopics = false;
int instanceTopicId = 0;

PortletPreferences portletPrefs = PortletPreferencesFactoryUtil.getPortletSetup(request, "GN_CMS_SEARCH", true, true);
showTopics = GetterUtil.getBoolean(portletPrefs.getValue("show-topics", StringPool.BLANK), false);
instanceTopicId = GetterUtil.getInteger(portletPrefs.getValue("topic-id", StringPool.BLANK));


long rootPlid = GetterUtil.getLong(portletPrefs.getValue("portlet-setup-link-to-plid", StringPool.BLANK));


boolean SHOW_SCORE = false;
String searchFlag = request.getParameter("search");
if (searchFlag == null) searchFlag = "false";

boolean topicArticlesEnabled = GetterUtil.getBoolean(PropsUtil.get(PortalUtil.getCompanyId(request), "journal.articles.topics.enabled"), false);
String journal_search_layout = PropsUtil.get(PortalUtil.getCompanyId(request), "journal.articles.topics.search.layout");
if (Validator.isNull(journal_search_layout)) journal_search_layout = "/web/guest/8/";

String defaultKeywords = LanguageUtil.get(pageContext, "search") + "...";
String unicodeDefaultKeywords = UnicodeFormatter.toString(defaultKeywords);
java.util.Comparator EntriesComparator =
new java.util.Comparator() {
	public int compare(Object obj1, Object obj2) {
		int result = -1;
		if (obj1 != null && obj2 != null &&
				obj1 instanceof Element && obj2 instanceof Element)
		{
			Element el1 = (Element)obj1;
			Element el2 = (Element)obj2;
			String score1 = el1.elementText(OpenSearchUtil.getQName("score", OpenSearchUtil.RELEVANCE_NAMESPACE));
			String score2 = el2.elementText(OpenSearchUtil.getQName("score", OpenSearchUtil.RELEVANCE_NAMESPACE));
			float float1 = 0;
			float float2 = 0;
			try {
				float1 = Float.parseFloat(score1);
			} catch (Exception f1) {}
			try {
				float2 = Float.parseFloat(score2);
			} catch (Exception f1) {}
			if (float1 == float2) result = 0;
			if (float1 < float2) result = 1;
			if (float1 > float2) result = -1;
		}
		return result;
	}

	public boolean equals(Object obj)
	{
		return super.equals(obj);
	}
};

String keywords = ParamUtil.getString(request, "keywords", "");

String allWords = ParamUtil.getString(request, "allWords", "");
String exactWords = ParamUtil.getString(request, "exactWords", "");
String anyWords = ParamUtil.getString(request, "anyWords", "");
String noWords = ParamUtil.getString(request, "noWords", "");
String topicId = ParamUtil.getString(request, "topicId", "");
boolean showAdvancedSearchFormOpen = false;
if (Validator.isNotNull(allWords) || Validator.isNotNull(exactWords)
	|| Validator.isNotNull(anyWords) || Validator.isNotNull(noWords)
	|| Validator.isNotNull(topicId))
{
	showAdvancedSearchFormOpen = true;
}

String metaDataProperty = ParamUtil.getString(request, "metaDataProperty");

String portletNameParameter = ParamUtil.getString(request, "portletNameParameter");


int chosenPortlet = 0;

%>
<script language="JavaScript" type="text/Javascript">
function <%= namespace %>isSearchFormEmpty() {
	if ((document.<%= namespace %>fm.elements['<%= namespace %>keywords'].value == null || 
		 document.<%= namespace %>fm.elements['<%= namespace %>keywords'].value == '') &&
		(document.<%= namespace %>fm.elements['<%= namespace %>allWords'].value == null || 
		 document.<%= namespace %>fm.elements['<%= namespace %>allWords'].value == '') &&
		(document.<%= namespace %>fm.elements['<%= namespace %>exactWords'].value == null || 
		 document.<%= namespace %>fm.elements['<%= namespace %>exactWords'].value == '') &&
		(document.<%= namespace %>fm.elements['<%= namespace %>anyWords'].value == null || 
		 document.<%= namespace %>fm.elements['<%= namespace %>anyWords'].value == '') &&
		(document.<%= namespace %>fm.elements['<%= namespace %>noWords'].value == null || 
		 document.<%= namespace %>fm.elements['<%= namespace %>noWords'].value == ''))
		 return true;
	else
		return false;
}
</script><noscript></noscript>



<%if(rootPlid<=0) {%>





<form action="<liferay-portlet:renderURL portletName="GN_CMS_SEARCH" windowState="<%= WindowState.MAXIMIZED.toString() %>"><liferay-portlet:param name="struts_action" value="/ext/cms/search/search" /></liferay-portlet:renderURL>" method="post" name="<%= namespace %>fm" onsubmit="submitForm(this); return false;">
<%} else {%>
<form action="<liferay-portlet:renderURL portletName="GN_CMS_SEARCH" ><liferay-portlet:param name="struts_action" value="/ext/cms/search/search" /></liferay-portlet:renderURL>" method="post" name="<%= namespace %>fm" onsubmit="submitForm(this); return false;">
<%}%>
<legend><%= LanguageUtil.get(pageContext, "portal.search") %></legend>
<input type="hidden" name="search" value="true"/>
<table >
  <tr>
    <td>
    	<input title="keywords"  name="<%= namespace %>keywords" size="20" type="text" value="<%= keywords.replace("\"","&quot;") %>" />
    </td>
    <td>
    	<input type="image" title="<liferay-ui:message key="search" />" alt="<liferay-ui:message key="search" />"  src="<%= themeDisplay.getPathThemeImages() %>/custom/search2.gif"   
    	 onclick="if (document.<%= namespace %>fm.elements['<%= namespace %>keywords'].value == null || 
   		 document.<%= namespace %>fm.elements['<%= namespace %>keywords'].value == '') { alert('<%= LanguageUtil.get(pageContext, "cms.search.please-input-criterion") %>'); return false; }" onkeypress="if (document.<%= namespace %>fm.elements['<%= namespace %>keywords'].value == null || 
   		 document.<%= namespace %>fm.elements['<%= namespace %>keywords'].value == '') { alert('<%= LanguageUtil.get(pageContext, "cms.search.please-input-criterion") %>'); return false; }"/>
    </td>
  </tr>
</table>


<script type="text/javascript">
	function showElement(layer){
	var myLayer = document.getElementById(layer);
	if(myLayer.style.display=="none"){
	myLayer.style.display="block";
	myLayer.backgroundPosition="top";
	} else {
	myLayer.style.display="none";
	}
	}
</script>
<noscript>
<table>

<tr>
	<td><%= LanguageUtil.get(pageContext, "cms.search.criteria.all-words") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.all-words") %>" name="<%= namespace %>allWords" type="text" value="<%= allWords.replace("\"","&quot;") %>" /></td>
  </tr>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.exact-match") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.exact-match") %>" name="<%= namespace %>exactWords" type="text" value="<%= exactWords.replace("\"","&quot;") %>" /></td>
  </tr>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.one-word") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.one-word") %>" name="<%= namespace %>anyWords" type="text" value="<%= anyWords.replace("\"","&quot;") %>" /></td>
  </tr>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.no-words") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.no-words") %>" name="<%= namespace %>noWords" type="text" value="<%= noWords.replace("\"","&quot;") %>" /></td>
  </tr>


<% if (showTopics) { %>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.topic") %></td>
</tr>
<tr>
  <td><select title="<%= namespace %>topicId" name="<%= namespace %>topicId">
    <option value=""></option>
    <%
TreeViewDescription topicsTree = null;
if (instanceTopicId >0) {
	topicsTree =TopicsTreeBuilder.buildTopicsTree(PortalUtil.getCompanyId(request),  instanceTopicId, GeneralUtils.getLocale(request), "", null, null, null, "",request);
} else
{
	topicsTree =TopicsTreeBuilder.buildTopicsTree(PortalUtil.getCompanyId(request),  (Integer)null, GeneralUtils.getLocale(request), "", null, null, null, "",request);
}
List<ViewResult> topicViews = TopicsTreeBuilder.flattenTreeViewDescription(topicsTree);
if (topicViews != null) {
	for (ViewResult topView: topicViews) {
		boolean isSelected = topView.getMainid().toString().equals(topicId);
		%>
    <option value="<%= topView.getMainid().toString() %>" <%= (isSelected? "selected=\"selected\"" : "") %>><%= topView.getField1() %></option>
    <%
	}
}
%>
  </select></td>
  </tr>
<% } %>
</table>
</noscript>



<a title="<%= LanguageUtil.get(pageContext, "cms.search.advanced") %>" href="#" class="button" onclick="javascript:showElement('v-menu')">
<span><%= LanguageUtil.get(pageContext, "cms.search.advanced") %></span>
</a>
<div id="v-menu" class="v-menu" style="display:none;">
   
   <table>

<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.all-words") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.all-words") %>" name="<%= namespace %>allWords" type="text" value="<%= allWords.replace("\"","&quot;") %>" /></td>
  </tr>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.exact-match") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.exact-match") %>" name="<%= namespace %>exactWords" type="text" value="<%= exactWords.replace("\"","&quot;") %>" /></td>
  </tr>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.one-word") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.one-word") %>" name="<%= namespace %>anyWords" type="text" value="<%= anyWords.replace("\"","&quot;") %>" /></td>
  </tr>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.no-words") %></td>
</tr>

<tr>
  <td><input title="<%= LanguageUtil.get(pageContext, "cms.search.criteria.no-words") %>" name="<%= namespace %>noWords" type="text" value="<%= noWords.replace("\"","&quot;") %>" /></td>
  </tr>


<% if (showTopics) { %>
<tr><td><%= LanguageUtil.get(pageContext, "cms.search.criteria.topic") %></td>
</tr>
<tr>
  <td><select title="<%= namespace %>topicId" name="<%= namespace %>topicId">
    <option value=""></option>
    <%
TreeViewDescription topicsTree = null;
if (instanceTopicId >0) {
	topicsTree =TopicsTreeBuilder.buildTopicsTree(PortalUtil.getCompanyId(request),  instanceTopicId, GeneralUtils.getLocale(request), "", null, null, null, "",request);
} else
{
	topicsTree =TopicsTreeBuilder.buildTopicsTree(PortalUtil.getCompanyId(request),  (Integer)null, GeneralUtils.getLocale(request), "", null, null, null, "",request);
}
List<ViewResult> topicViews = TopicsTreeBuilder.flattenTreeViewDescription(topicsTree);
if (topicViews != null) {
	for (ViewResult topView: topicViews) {
		boolean isSelected = topView.getMainid().toString().equals(topicId);
		%>
    <option value="<%= topView.getMainid().toString() %>" <%= (isSelected? "selected=\"selected\"" : "") %>><%= topView.getField1() %></option>
    <%
	}
}
%>
  </select></td>
  </tr>
<% } %>
</table>
   
</div>





</form>
<br />

<%
boolean IS_GUEST = false;
gnomon.hibernate.model.parties.PaPerson person = gnomon.hibernate.PartiesService.getInstance().getPaPerson(user.getUserId());
if (person == null)
	IS_GUEST = true;

List portlets = PortletLocalServiceUtil.getPortlets(company.getCompanyId(), false, false);

Iterator itr = portlets.iterator();

while (itr.hasNext()) {
	Portlet portlet = (Portlet)itr.next();
	//System.out.println(portlet.getPortletId());
	if (IS_GUEST && (portlet.getPortletId().equals("PA_PARTIES_BROWSER") || portlet.getPortletId().equals("PA_CONTACTS")))
		itr.remove();

	else if (Validator.isNull(portlet.getOpenSearchClass())) {
		itr.remove();
	}
	else {
		OpenSearch openSearch = (OpenSearch)InstancePool.get(portlet.getOpenSearchClass());

		if (!openSearch.isEnabled()) {
			itr.remove();
		}
	}
}

String[] portletNames = new String[portlets.size()];
String[] portletTotals = new String[portlets.size()];
SearchContainer[] searchContainers = new SearchContainer[portlets.size()+1];
java.util.HashMap<String, Integer>[] propHashMaps = new java.util.HashMap[portlets.size()+1];

PortletURL portletURL = renderResponse.createRenderURL();
portletURL.setWindowState(WindowState.MAXIMIZED);
portletURL.setParameter("struts_action", "/ext/cms/search/search");
portletURL.setParameter("keywords", keywords);
portletURL.setParameter("search", "true");

List headerNames = new ArrayList();

headerNames.add("#");
headerNames.add("summary");
if (SHOW_SCORE)
	headerNames.add("score");

propHashMaps[0] = new java.util.HashMap<String, Integer>();
searchContainers[0] = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM + "_", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, LanguageUtil.format(pageContext, "no-results-were-found-that-matched-the-keywords-x", keywords ));
List totalEntries = new ArrayList();
boolean isJournalPortlet = false;
boolean isDocumentsPortlet = false;
String DOCUMENT_PORTLET_NAME = "bs_documents";

// build keywords based on all fields (using if possible advanced search fields)
if (keywords == null) keywords = "";
if (Validator.isNotNull(exactWords))
	keywords += " +\""+exactWords+"\"";
if (Validator.isNotNull(anyWords))
	keywords += " +("+anyWords + ")";
if (Validator.isNotNull(noWords))
	keywords += " -("+noWords+")";
if (Validator.isNotNull(allWords))
{
	String[] tokens = allWords.split("\\s");
	for (String token: tokens)
	{
		//System.err.println("### token:'"+token+"'");
		keywords += " +"+token;
	}
}

//System.err.println("##### KEYWORDS = "+keywords);

if (Validator.isNotNull(keywords) && searchFlag.equals("true")) {
	for (int i = 0; i < portlets.size(); i++) {
		Portlet portlet = (Portlet)portlets.get(i);
		if (portlet.getPortletId().equals(PortletKeys.JOURNAL_CONTENT_SEARCH))
		{
			isJournalPortlet = true;
		}
		else
		{
			isJournalPortlet = false;
		}
		if (portlet.getPortletId().equals("bs_documents"))
		{
			isDocumentsPortlet = true;
		}
		else
		{
			isDocumentsPortlet = false;
		}

		String portletTitle = PortalUtil.getPortletTitle(portlet, application, locale);
		if (isDocumentsPortlet)
			DOCUMENT_PORTLET_NAME = portletTitle;

		OpenSearch openSearch = (OpenSearch)InstancePool.get(portlet.getOpenSearchClass());
		PortletURL portletURLInner = renderResponse.createRenderURL();
		portletURLInner.setWindowState(WindowState.MAXIMIZED);
		portletURLInner.setParameter("struts_action", "/ext/cms/search/search");
		portletURLInner.setParameter("keywords", keywords);
		portletURLInner.setParameter("search", "true");
		portletURLInner.setParameter("portletNameParameter", portletTitle);
		SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM + i, SearchContainer.DEFAULT_DELTA, portletURLInner, headerNames, LanguageUtil.format(pageContext, "no-results-were-found-that-matched-the-keywords-x", keywords ));

		propHashMaps[i+1] = new java.util.HashMap<String, Integer>();

		//if (i > 0) {
		//	searchContainer.setDelta(5);
		//}


		if (Validator.isNotNull(portletNameParameter) && portletTitle.equals(portletNameParameter))
			chosenPortlet = i+1;

		int total = 0;

		List resultRows = new ArrayList();

		try {
			String xml = openSearch.search(request, keywords, searchContainer.getCurValue(), searchContainer.getDelta());

			SAXReader reader = SAXReaderFactory.getInstance();

			Document doc = reader.read(new StringReader(xml));

			Element root = doc.getRootElement();

			//portletTitle = root.elementText("title");

			List rootEntries = root.elements("entry");
			List entries = new ArrayList();
			entries.addAll(rootEntries);
			java.util.Collections.sort(entries, EntriesComparator);
			totalEntries.addAll(entries);

			total = GetterUtil.getInteger(root.elementText(OpenSearchUtil.getQName("totalResults", OpenSearchUtil.OS_NAMESPACE)));
			portletNames[i] = portletTitle;

			searchContainer.setTotal(total);

			resultRows = searchContainer.getResultRows();
			int innerOrderCounter = 1;
			for (int j = 0; j < entries.size(); j++) {
				Element el = (Element)entries.get(j);

				ResultRow row = new ResultRow(doc, String.valueOf(j), j);

				// Position

				row.addText(searchContainer.getStart() + innerOrderCounter + StringPool.PERIOD);

				// Summary

				String entryTitle = el.elementText("title");
				String entryHref = el.element("link").attributeValue("href");
				String summary = el.elementText("summary");
				String matchedProperties = el.elementText("matchedPropertyNames");
				if (matchedProperties != null) {
					String[] props = matchedProperties.split(",");
					for (String prop:props) {
						if (propHashMaps[0].containsKey(prop))
						{
							Integer counter = propHashMaps[0].get(prop);
							propHashMaps[0].put(prop, counter+1);
						}
						else
							propHashMaps[0].put(prop, 1);
						if (propHashMaps[i+1].containsKey(prop))
						{
							Integer counter = propHashMaps[i+1].get(prop);
							propHashMaps[i+1].put(prop, counter+1);
						}
						else
							propHashMaps[i+1].put(prop, 1);
					}
				}

				if (Validator.isNotNull(metaDataProperty)) {
					if (Validator.isNull(matchedProperties) ||
							matchedProperties.indexOf(metaDataProperty) == -1)
						continue; // skip this entry
				}

				if (isDocumentsPortlet)
				{
					StringMaker sm = new StringMaker();

					sm.append("<a href=\"");
					sm.append(entryHref);
					sm.append("\"");
					if (isJournalPortlet) {
						sm.append(" target=\"_blank\"");
					}
					sm.append(">");
					sm.append(entryTitle);
					sm.append("</a><br/>");
					sm.append("<span >");
					sm.append(summary);
					sm.append("</span><br/>");
					
					if (summary != null && (summary.startsWith("<a href") || summary.startsWith("<object") || summary.startsWith("<div"))) {
						row.addText(summary);
					}
					else
						row.addText(StringUtil.highlight(sm.toString(), keywords));
				}
				else if (isJournalPortlet)
				{
					String journalDescription = entryTitle+"<br/>"+ StringUtils.stripHTML(StringUtils.unescapeHTML(summary,0));
					String articleId = entryHref.substring(PortletKeys.JOURNAL_CONTENT_SEARCH.length()+1);
					List hitLayoutIds = JournalContentSearchLocalServiceUtil.getLayoutIds(layout.getGroupId(), layout.isPrivateLayout(), articleId);
					if(hitLayoutIds !=null && hitLayoutIds.size() > 0) {
						journalDescription +="<span style=\"font-size: xx-small;\">";

						for (int lay = 0; lay < hitLayoutIds.size(); lay++) {
							Long hitLayoutId = (Long)hitLayoutIds.get(lay);
							Layout hitLayout = LayoutLocalServiceUtil.getLayout(layout.getGroupId(), layout.isPrivateLayout(), hitLayoutId.longValue());
							String hitLayoutURL = PortalUtil.getLayoutURL(hitLayout, themeDisplay);
							journalDescription += "<br/><a href=\""+hitLayoutURL+"\">"+
								PortalUtil.getPortalURL(request) + StringUtil.shorten(hitLayoutURL, 100)+ "</a>";

						}
						journalDescription += "</span>";
					}
					else
					{
						if (topicArticlesEnabled) {
							try {
								JournalArticle al = JournalArticleLocalServiceUtil.getArticle(layout.getGroupId(), articleId);
								journalDescription +="<span style=\"font-size: xx-small;\">";
								journalDescription += "<br/><a href=\""+journal_search_layout+"~/topicarts/view/"+al.getId()+"\">"+
								PortalUtil.getPortalURL(request) + "</a>";
								journalDescription += "</span>";
							} catch (Exception eart) {
						total--;
						continue; //skip this journal
					}
						}
						else
						{
							total--;
							continue; //skip this journal
						}
					}
					row.addText(StringUtil.highlight(journalDescription, keywords));
				}
				else
				{
					StringMaker sm = new StringMaker();

					sm.append("<a href=\"");
					sm.append(entryHref);
					sm.append("\"");

					if (isJournalPortlet) {
						sm.append(" target=\"_blank\"");
					}

					sm.append(">");
					sm.append(entryTitle);
					sm.append("</a><br/>");
					sm.append("<span >");
					sm.append(summary);
					sm.append("</span><br/>");

					row.addText(StringUtil.highlight(sm.toString(), keywords));
				}

				// Score
				if (SHOW_SCORE) {
					String score = el.elementText(OpenSearchUtil.getQName("score", OpenSearchUtil.RELEVANCE_NAMESPACE));
					row.addText(score);
				}
				// Add result row
				resultRows.add(row);

				innerOrderCounter++;
			}
			if (isJournalPortlet)
				portletTotals[i] = ""+ total;
				else
			portletTotals[i] = ""+ searchContainer.getTotal();//""+(innerOrderCounter-1);

			searchContainers[i+1] = searchContainer;
		}
		catch (Exception e) { e.printStackTrace();
		}
	}
}

// build total resultRows sorted by descending score
try {
	List totalResultRows = searchContainers[0].getResultRows();
	java.util.Collections.sort(totalEntries, EntriesComparator);
	int orderCounter = 1;
	for (int j = 0; j < SearchContainer.DEFAULT_DELTA; j++) {
		Element el = (Element)totalEntries.get(j);
		ResultRow row = new ResultRow(el, String.valueOf(j), j);
		// Position
		row.addText(searchContainers[0].getStart() + orderCounter + StringPool.PERIOD);
		// Summary
		String entryTitle = el.elementText("title");
		String entryHref = el.element("link").attributeValue("href");
		String summary = el.elementText("summary");
		String matchedProperties = el.elementText("matchedPropertyNames");
		if (Validator.isNotNull(metaDataProperty)) {
			if (Validator.isNull(matchedProperties) ||
					matchedProperties.indexOf(metaDataProperty) == -1)
				continue; // skip this entry
		}
		if (entryHref != null && entryHref.startsWith(PortletKeys.JOURNAL_CONTENT_SEARCH+"_"))
		{
			String journalDescription = entryTitle+"<br/>"+ StringUtils.stripHTML(StringUtils.unescapeHTML(summary,0));
			String articleId = entryHref.substring(PortletKeys.JOURNAL_CONTENT_SEARCH.length()+1);
			List hitLayoutIds = JournalContentSearchLocalServiceUtil.getLayoutIds(layout.getGroupId(), layout.isPrivateLayout(), articleId);
			if(hitLayoutIds !=null && hitLayoutIds.size() > 0) {
				journalDescription +="<span style=\"font-size: xx-small;\">";

				for (int lay = 0; lay < hitLayoutIds.size(); lay++) {
					Long hitLayoutId = (Long)hitLayoutIds.get(lay);
					Layout hitLayout = LayoutLocalServiceUtil.getLayout(layout.getGroupId(), layout.isPrivateLayout(), hitLayoutId.longValue());
					String hitLayoutURL = PortalUtil.getLayoutURL(hitLayout, themeDisplay);
					journalDescription += "<br/><a href=\""+hitLayoutURL+"\">"+
						PortalUtil.getPortalURL(request) + StringUtil.shorten(hitLayoutURL, 100)+ "</a>";

				}
				journalDescription += "</span>";
			}
			else
			{
				if (topicArticlesEnabled) {
					try {
						JournalArticle al = JournalArticleLocalServiceUtil.getArticle(layout.getGroupId(), articleId);
						journalDescription +="<span style=\"font-size: xx-small;\">";
						journalDescription += "<br/><a href=\""+journal_search_layout+"~/topicarts/view/"+al.getId()+"\">"+
						PortalUtil.getPortalURL(request) + "</a>";
						journalDescription += "</span>";
					} catch (Exception eart) {
						continue;
					}
				}
				else
				{
				continue; //skip this journal
				}
			}
			row.addText(StringUtil.highlight(journalDescription, keywords));
				
		}
		else if (entryTitle.startsWith(DOCUMENT_PORTLET_NAME) && 
				 summary != null && (summary.startsWith("<a href") || summary.startsWith("<object") || summary.startsWith("<div")))
		{
			row.addText(summary);
		}
		else
		{
			StringMaker sm = new StringMaker();
			sm.append("<a href=\"");
			sm.append(entryHref);
			sm.append("\"");
			sm.append(">");
			sm.append(entryTitle);
			sm.append("</a><br/>");
			sm.append("<span >");
			sm.append(summary);
			sm.append("</span><br/>");

			row.addText(StringUtil.highlight(sm.toString(), keywords));
		}

		// Score
		if (SHOW_SCORE) {
			String score = el.elementText(OpenSearchUtil.getQName("score", OpenSearchUtil.RELEVANCE_NAMESPACE));
			row.addText(score);
		}

		// Add result row
		totalResultRows.add(row);

		orderCounter++;
	}
}
catch (Exception e) {
}
%>
<%
if (Validator.isNotNull(keywords) && searchFlag.equals("true")) {
%>
<table>
<tr>
<td>
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "cms.search.per-portlet") %></legend>
<ul>
<% for (int i = 0; i < portletNames.length; i++) {
    if (portletTotals[i] != null && !portletTotals[i].equals("") && !portletTotals[i].equals("0")) {%>
	<li>
	<a title="<%= portletNames[i]+ " (" + portletTotals[i] + ")" %>" href="<portlet:renderURL>
	<portlet:param name="struts_action" value="/ext/cms/search/search"/>
	<portlet:param name="keywords" value="<%= keywords %>"/>
	<portlet:param name="search" value="true"/>
	<portlet:param name="portletNameParameter" value="<%= portletNames[i] %>"/>
	</portlet:renderURL>">
	<%= portletNames[i]+ " (" + portletTotals[i] + ")" %>
	</a>
	</li>
<% }
}%>
</ul>
</fieldset>
</td>

<% if (propHashMaps[0] != null && propHashMaps[0].size() > 0) {%>
<td>&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td valign="top">
	<fieldset>
    <legend><%= LanguageUtil.get(pageContext, "cms.search.per-metadataproperty") %></legend>
	<ul>
	<%
	    java.util.Iterator<String> keys = propHashMaps[0].keySet().iterator();
		while (keys.hasNext()) {
			String prop = keys.next();
			String value = "("+propHashMaps[0].get(prop)+")";
			%>
			<li>
            <a title="<%= prop + " " + value %>" href="<portlet:renderURL>
			<portlet:param name="struts_action" value="/ext/cms/search/search"/>
			<portlet:param name="keywords" value="<%= keywords %>"/>
			<portlet:param name="search" value="true"/>
			<portlet:param name="metaDataProperty" value="<%= prop %>"/>
			</portlet:renderURL>">
			<%= prop + " " + value %>
			</a>
            </li>
			<%
		}
		%>
		</ul>
		</fieldset>
</td>
<% } %>
</tr>
</table>

<br/>
<h2><%= LanguageUtil.get(pageContext, "cms.search.results.list") %>
<%
if (chosenPortlet > 0) {
	out.print(" - " + portletNames[chosenPortlet-1]);
} else if (Validator.isNotNull(metaDataProperty)) {
	out.print(" - " + metaDataProperty);
}
%>
</h2>
<br/>
<%
if (chosenPortlet > 0 && propHashMaps[chosenPortlet] != null && propHashMaps[chosenPortlet].size() > 0) {
		java.util.Iterator<String> keys = propHashMaps[chosenPortlet].keySet().iterator();
		while (keys.hasNext()) {
			String prop = keys.next();
			String value = "("+propHashMaps[chosenPortlet].get(prop)+")";
			%>
			<a title="<%= prop + " " + value %>" href="<portlet:renderURL>
			<portlet:param name="struts_action" value="/ext/cms/search/search"/>
			<portlet:param name="keywords" value="<%= keywords %>"/>
			<portlet:param name="search" value="true"/>
			<portlet:param name="metaDataProperty" value="<%= prop %>"/>
			<portlet:param name="portletNameParameter" value="<%= portletNames[chosenPortlet-1] %>"/>
			</portlet:renderURL>">
			<%= prop + " " + value %>
			</a>
			<% if (keys.hasNext())
				out.print(", ");
		}
		%>
		<br/><br/><%
} %>

<liferay-ui:search-iterator searchContainer="<%= searchContainers[chosenPortlet] %>" />
<liferay-ui:search-paginator searchContainer="<%= searchContainers[chosenPortlet] %>" />
<% } %>
<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		Liferay.Util.focusFormField(document.<%= namespace %>fm.<%= namespace %>keywords);
	</script>
    <noscript></noscript>
</c:if>

