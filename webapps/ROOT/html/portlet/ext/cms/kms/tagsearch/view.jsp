<%@ include file="/html/portlet/ext/cms/kms/tagsearch/init.jsp" %>

<%@ page import="com.liferay.portal.kernel.search.OpenSearch" %>
<%@ page import="com.liferay.portal.kernel.search.SearchException" %>
<%@ page import="com.liferay.portal.kernel.util.InstancePool" %>
<%@ page import="com.liferay.portal.search.OpenSearchUtil" %>
<%@ page import="com.liferay.portal.util.SAXReaderFactory" %>
<%@ page import="com.liferay.portlet.journal.service.JournalContentSearchLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<%@ page import="org.dom4j.Document" %>
<%@ page import="org.dom4j.Element" %>
<%@ page import="org.dom4j.io.SAXReader" %>
<%@ page import="java.util.Date" %>


<%
String defaultKeywords = LanguageUtil.get(pageContext, "search") + "...";
String unicodeDefaultKeywords = UnicodeFormatter.toString(defaultKeywords);
final java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm:sszzz");
final java.text.SimpleDateFormat simpleFormat = new java.text.SimpleDateFormat(com.ext.util.CommonDefs.DATE_FORMAT);
java.util.Comparator EntriesComparator =
new java.util.Comparator() {
	public int compare(Object obj1, Object obj2) {
		int result = -1;
		if (obj1 != null && obj2 != null &&
				obj1 instanceof Element && obj2 instanceof Element)
		{
			Element el1 = (Element)obj1;
			Element el2 = (Element)obj2;
			
			String dateStr1 = el1.elementText("updated");
			String dateStr2 = el2.elementText("updated");
			//System.err.println("#####"+el1.asXML() + " " + dateStr2);
			Date date1 = null;
			Date date2 = null;
			try {
				date1 = sdf.parse(dateStr1);
			} catch (Exception f1) {}
			try {
				date2 = sdf.parse(dateStr2);
			} catch (Exception f1) {}
			if (date1 == null && date2 == null) return 0;
			if (date1 == null && date2 != null) return -1;
			if (date1 != null && date2 == null) return 1;
			if (date1 != null && date2 != null)
				return date2.compareTo(date1);
		}
		return result;
	}
	
	public boolean equals(Object obj)
	{
		return super.equals(obj);
	}
};

String keywords = null;
String portletResource = "GN_KMS_TAG_SEARCH";
PortletPreferences portletPrefs = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource, true, true);
if (portletPrefs != null)
	keywords = portletPrefs.getValue("searchKeywords", StringPool.BLANK);

if (keywords == null ||keywords.equals(""))
	keywords = defaultKeywords;


String metaDataProperty = ParamUtil.getString(request, "metaDataProperty");

String portletNameParameter = ParamUtil.getString(request, "portletNameParameter");


int chosenPortlet = 0;

List portlets = PortletLocalServiceUtil.getPortlets(company.getCompanyId(), false, false);

Iterator itr = portlets.iterator();

while (itr.hasNext()) {
	Portlet portlet = (Portlet)itr.next();

	if (Validator.isNull(portlet.getOpenSearchClass())) {
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
portletURL.setParameter("struts_action", "/ext/kms/tagsearch/view");
portletURL.setParameter("keywords", keywords);

List headerNames = new ArrayList();

headerNames.add("#");
headerNames.add("summary");
headerNames.add("date");

propHashMaps[0] = new java.util.HashMap<String, Integer>();
searchContainers[0] = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM + "_", SearchContainer.DEFAULT_DELTA, portletURL, headerNames, LanguageUtil.format(pageContext, "no-results-were-found-that-matched-the-keywords-x", "<b>" + keywords + "</b>"));
List totalEntries = new ArrayList();
boolean isJournalPortlet = false;

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

	String portletTitle = PortalUtil.getPortletTitle(portlet, application, locale);
	
	OpenSearch openSearch = (OpenSearch)InstancePool.get(portlet.getOpenSearchClass());
	PortletURL portletURLInner = renderResponse.createRenderURL();
	portletURLInner.setWindowState(WindowState.MAXIMIZED);
	portletURLInner.setParameter("struts_action", "/ext/kms/tagsearch/view");
	portletURLInner.setParameter("keywords", keywords);
	portletURLInner.setParameter("portletNameParameter", portletTitle);
	SearchContainer searchContainer = new SearchContainer(renderRequest, null, null, SearchContainer.DEFAULT_CUR_PARAM + i, SearchContainer.DEFAULT_DELTA, portletURLInner, headerNames, LanguageUtil.format(pageContext, "no-results-were-found-that-matched-the-keywords-x", "<b>" + keywords + "</b>"));

	propHashMaps[i+1] = new java.util.HashMap<String, Integer>();

	//if (i > 0) {
	//	searchContainer.setDelta(5);
	//}

	
	if (Validator.isNotNull(portletNameParameter) && portletTitle.equals(portletNameParameter))
		chosenPortlet = i+1;
	
	int total = 0;

	List resultRows = new ArrayList();

	try {
		if (keywords == null) keywords = "";
		String xml = openSearch.search(request, keywords+"**", searchContainer.getCurValue(), searchContainer.getDelta());

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

			if (!isJournalPortlet)
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
				sm.append("</a><br>");
				sm.append("<span >");
				sm.append(summary);
				sm.append("</span><br/>");
		
				row.addText(StringUtil.highlight(sm.toString(), keywords));
			}
			else
			{
				String journalDescription = entryTitle+"<br>"+summary;
				String articleId = entryHref.substring(PortletKeys.JOURNAL_CONTENT_SEARCH.length()+1);
				List hitLayoutIds = JournalContentSearchLocalServiceUtil.getLayoutIds(layout.getGroupId(), layout.isPrivateLayout(), articleId);
				if(hitLayoutIds !=null && hitLayoutIds.size() > 0) {
					journalDescription +="<span style=\"font-size: xx-small;\">";

					for (int lay = 0; lay < hitLayoutIds.size(); lay++) {
						Long hitLayoutId = (Long)hitLayoutIds.get(lay);
						Layout hitLayout = LayoutLocalServiceUtil.getLayout(layout.getGroupId(), layout.isPrivateLayout(), hitLayoutId.longValue());
						String hitLayoutURL = PortalUtil.getLayoutURL(hitLayout, themeDisplay);
						journalDescription += "<br><a href=\""+hitLayoutURL+"\">"+
							PortalUtil.getPortalURL(request) + StringUtil.shorten(hitLayoutURL, 100)+ "</a>";

					}
					journalDescription += "</span>";
				}
				else
				{
					total--;
					continue; //skip this journal
				}
				row.addText(journalDescription);
			}

			// Score

			String score = el.elementText("updated");
			try {
				score =	simpleFormat.format(sdf.parse(score));
			} catch (Exception edf) {}
			row.addText(score);

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
			String journalDescription = entryTitle+"<br>"+summary;
			String articleId = entryHref.substring(PortletKeys.JOURNAL_CONTENT_SEARCH.length()+1);
			List hitLayoutIds = JournalContentSearchLocalServiceUtil.getLayoutIds(layout.getGroupId(), layout.isPrivateLayout(), articleId);
			if(hitLayoutIds !=null && hitLayoutIds.size() > 0) {
				journalDescription +="<span style=\"font-size: xx-small;\">";

				for (int lay = 0; lay < hitLayoutIds.size(); lay++) {
					Long hitLayoutId = (Long)hitLayoutIds.get(lay);
					Layout hitLayout = LayoutLocalServiceUtil.getLayout(layout.getGroupId(), layout.isPrivateLayout(), hitLayoutId.longValue());
					String hitLayoutURL = PortalUtil.getLayoutURL(hitLayout, themeDisplay);
					journalDescription += "<br><a href=\""+hitLayoutURL+"\">"+
						PortalUtil.getPortalURL(request) + StringUtil.shorten(hitLayoutURL, 100)+ "</a>";

				}
				journalDescription += "</span>";
			}
			else
				continue; //skip this journal
			row.addText(journalDescription);
		}
		else
		{
			StringMaker sm = new StringMaker();
			sm.append("<a href=\"");
			sm.append(entryHref);
			sm.append("\"");
			sm.append(">");
			sm.append(entryTitle);
			sm.append("</a><br>");
			sm.append("<span >");
			sm.append(summary);
			sm.append("</span><br/>");
	
			row.addText(StringUtil.highlight(sm.toString(), keywords));
		}

		// Score
		String score = el.elementText("updated");
		try {
			score =	simpleFormat.format(sdf.parse(score));
		} catch (Exception edf) {}
		row.addText(score);

		// Add result row
		totalResultRows.add(row);
		
		orderCounter++;
	}
}
catch (Exception e) {
}
%>

<table>
<tr>
<td>
<%= LanguageUtil.get(pageContext, "gn.button.search") +" : " %>
<a href="<portlet:renderURL>
	<portlet:param name="struts_action" value="/ext/kms/tagsearch/view"/>
	<portlet:param name="keywords" value="<%= keywords %>"/></portlet:renderURL>">
	<%= keywords %>	
</a>

&nbsp;&nbsp;&nbsp;

<liferay-ui:icon image="../portlet/configuration" message="configuration" url="<%= portletDisplay.getURLConfiguration() %>" toolTip="<%= false %>" />

</td>
</tr>
<tr><td>
&nbsp;&nbsp;<br>
</td></tr>
<tr>
<td>
<fieldset><legend><%= LanguageUtil.get(pageContext, "cms.search.per-portlet") %></legend>
<ul>
<% for (int i = 0; i < portletNames.length; i++) {
    if (portletTotals[i] != null && !portletTotals[i].equals("") && !portletTotals[i].equals("0")) {%>
	<li>
	<a href="<portlet:renderURL>
	<portlet:param name="struts_action" value="/ext/kms/tagsearch/view"/>
	<portlet:param name="keywords" value="<%= keywords %>"/>
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
	<fieldset><legend><%= LanguageUtil.get(pageContext, "cms.search.per-metadataproperty") %></legend>
	<ul>
	<%
	    java.util.Iterator<String> keys = propHashMaps[0].keySet().iterator();
		while (keys.hasNext()) {
			String prop = keys.next();
			String value = "("+propHashMaps[0].get(prop)+")";
			%>
			<li><a href="<portlet:renderURL>
			<portlet:param name="struts_action" value="/ext/kms/tagsearch/view"/>
			<portlet:param name="keywords" value="<%= keywords %>"/>
			<portlet:param name="metaDataProperty" value="<%= prop %>"/>
			</portlet:renderURL>">
			<%= prop + " " + value %>
			</a></li>
			<% 
		}
		%>
		</ul>
		</fieldset>
</td>
<% } %>
</tr>
</table>

<br>
<h2><%= LanguageUtil.get(pageContext, "cms.search.results.list") %> 
<% 
if (chosenPortlet > 0) { 
	out.print(" - " + portletNames[chosenPortlet-1]); 
} else if (Validator.isNotNull(metaDataProperty)) {
	out.print(" - " + metaDataProperty); 
}
%>
</h2>
<br>
<% 
if (chosenPortlet > 0 && propHashMaps[chosenPortlet] != null && propHashMaps[chosenPortlet].size() > 0) {
		java.util.Iterator<String> keys = propHashMaps[chosenPortlet].keySet().iterator();
		while (keys.hasNext()) {
			String prop = keys.next();
			String value = "("+propHashMaps[chosenPortlet].get(prop)+")";
			%>
			<a href="<portlet:renderURL>
			<portlet:param name="struts_action" value="/ext/kms/tagsearch/view"/>
			<portlet:param name="keywords" value="<%= keywords %>"/>
			<portlet:param name="metaDataProperty" value="<%= prop %>"/>
			<portlet:param name="portletNameParameter" value="<%= portletNames[chosenPortlet-1] %>"/>
			</portlet:renderURL>">
			<%= prop + " " + value %>
			</a>
			<% if (keys.hasNext()) 
				out.print(", ");
		}
		%>
		<br><br><%
} %>

<liferay-ui:search-iterator searchContainer="<%= searchContainers[chosenPortlet] %>" />
<liferay-ui:search-paginator searchContainer="<%= searchContainers[chosenPortlet] %>" />

<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		Liferay.Util.focusFormField(document.<%= namespace %>fm.<%= namespace %>keywords);
	</script>
</c:if>

