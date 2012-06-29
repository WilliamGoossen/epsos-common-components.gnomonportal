<%
/**
 * Copyright (c) 2000-2007 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
%>

<%@ include file="/html/portlet/journal_content/init.jsp" %>
<%@ page import="com.liferay.portal.util.LayoutLister" %>
<%@ page import="com.liferay.portal.util.LayoutView" %>

<%
String cur = ParamUtil.getString(request, "cur");

JournalArticle article = null;

String type = StringPool.BLANK;

String instancePortletShowRelContent = prefs.getValue("showRelContent", StringPool.BLANK);
String instancePortletShowRelContentDescription = prefs.getValue("showRelContentDescription", StringPool.BLANK);
com.ext.portlet.base.contentrel.ContentRelUtil relUtil = com.ext.portlet.base.contentrel.ContentRelUtil.getInstance();
String[] classNames = relUtil.getPortletClassNames();
String[] portletNames = relUtil.getPortletNames();

LayoutLister layoutLister = new LayoutLister();

String rootNodeName = StringPool.BLANK;
LayoutView layoutView = layoutLister.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName, locale);

List layoutList = layoutView.getList();


try {
	if (Validator.isNotNull(articleId)) {
		article = JournalArticleLocalServiceUtil.getLatestArticle(groupId, articleId);

		groupId = article.getGroupId();
		type = article.getType();
	}
}
catch (NoSuchArticleException nsae) {
}

groupId = ParamUtil.getLong(request, "groupId", groupId);
type = ParamUtil.getString(request, "type", type);
%>

<liferay-portlet:renderURL portletConfiguration="true" varImpl="portletURL" />

<script type="text/javascript">
	function <portlet:namespace />save() {
		AjaxUtil.submit(document.<portlet:namespace />fm1);
	}

	function <portlet:namespace />selectArticle(articleId) {
		document.<portlet:namespace />fm1.<portlet:namespace />articleId.value = articleId;
		document.<portlet:namespace />fm1.<portlet:namespace />templateId.value = "";
		submitForm(document.<portlet:namespace />fm1);
	}
</script>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm1">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />
<input name="<portlet:namespace />redirect" type="hidden" value="<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>" />
<input name="<portlet:namespace />groupId" type="hidden" value="<%= groupId %>" />
<input name="<portlet:namespace />articleId" type="hidden" value="<%= articleId %>" />
<input name="<portlet:namespace />templateId" type="hidden" value="<%= templateId %>" />

<table class="liferay-table">
<tr>
	<td>
		<liferay-ui:message key="portlet-id" />:
	</td>
	<td>
		<%= portletResource %>
	</td>
</tr>
</table>

<br />

<c:if test="<%= article != null %>">
	<div class="portlet-msg-info">
		<liferay-ui:message key="displaying-content" />: <%= articleId %>
	</div>

	<%
	String structureId = article.getStructureId();

	if (Validator.isNotNull(structureId)) {
		List templates = JournalTemplateLocalServiceUtil.getStructureTemplates(groupId, structureId);

		if (templates.size() > 0) {
			if (Validator.isNull(templateId)) {
				templateId = article.getTemplateId();
			}
	%>

			<table class="liferay-table">
			<tr>
				<td>
					<liferay-ui:message key="override-default-template" />
				</td>
				<td>
					<liferay-ui:table-iterator
						list="<%= templates %>"
						listType="com.liferay.portlet.journal.model.JournalTemplate"
						rowLength="3"
						rowPadding="30"
					>

						<%
						boolean templateChecked = false;

						if (templateId.equals(tableIteratorObj.getTemplateId())) {
							templateChecked = true;
						}

						if ((tableIteratorPos.intValue() == 0) && Validator.isNull(templateId)) {
							templateChecked = true;
						}
						%>

						<input <%= templateChecked ? "checked" : "" %> name="<portlet:namespace />radioTemplateId" type="radio" value="<%= tableIteratorObj.getTemplateId() %>" onClick="document.<portlet:namespace />fm1.<portlet:namespace />templateId.value = this.value; <portlet:namespace />save();">

						<a href="<portlet:renderURL windowState="<%= WindowState.MAXIMIZED.toString() %>"><portlet:param name="struts_action" value="/journal/edit_template" /><portlet:param name="redirect" value="<%= currentURL %>" /><portlet:param name="groupId" value="<%= String.valueOf(tableIteratorObj.getGroupId()) %>" /><portlet:param name="templateId" value="<%= tableIteratorObj.getTemplateId() %>" /></portlet:renderURL>">
						<%= tableIteratorObj.getName() %>
						</a>

						<c:if test="<%= tableIteratorObj.isSmallImage() %>">
							<br />

							<img border="0" hspace="0" src="<%= Validator.isNotNull(tableIteratorObj.getSmallImageURL()) ? tableIteratorObj.getSmallImageURL() : themeDisplay.getPathImage() + "/journal/template?img_id=" + tableIteratorObj.getSmallImageId() %>" vspace="0" />
						</c:if>
					</liferay-ui:table-iterator>
				</td>
			</tr>
			</table>

			<br />

	<%
		}
	}
	%>

	<table class="liferay-table">
	<tr>
		<td>
			<liferay-ui:message key="disable-caching" />
		</td>
		<td>
			<liferay-ui:input-checkbox param="disableCaching" defaultValue="<%= disableCaching %>" onClick="<%= renderResponse.getNamespace() + "save();" %>" />
		</td>
	</tr>
	<tr>
		<td>
			<liferay-ui:message key="show-available-locales" />
		</td>
		<td>
			<liferay-ui:input-checkbox param="showAvailableLocales" defaultValue="<%= showAvailableLocales %>" onClick="<%= renderResponse.getNamespace() + "save();" %>" />
		</td>
	</tr>
	<tr>
		<td>
			<liferay-ui:message key="enable-ratings" />
		</td>
		<td>
			<liferay-ui:input-checkbox param="enableRatings" defaultValue="<%= enableRatings %>" onClick="<%= renderResponse.getNamespace() + "save();" %>" />
		</td>
	</tr>
	<tr>
		<td>
			<liferay-ui:message key="enable-comments" />
		</td>
		<td>
			<liferay-ui:input-checkbox param="enableComments" defaultValue="<%= enableComments %>" onClick="<%= renderResponse.getNamespace() + "save();" %>" />
		</td>
	</tr>
	</table>
</c:if>

</form>

<c:if test="<%= Validator.isNotNull(articleId) %>">
	<div class="separator"><!-- --></div>
</c:if>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm2">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="" />
<input name="<portlet:namespace />redirect" type="hidden" value="<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>" />

<liferay-ui:error exception="<%= NoSuchArticleException.class %>" message="the-article-could-not-be-found" />

<%
DynamicRenderRequest dynamicRenderReq = new DynamicRenderRequest(renderRequest);

dynamicRenderReq.setParameter("type", type);
dynamicRenderReq.setParameter("groupId", String.valueOf(groupId));

ArticleSearch searchContainer = new ArticleSearch(dynamicRenderReq, portletURL);
%>

<liferay-ui:search-form
	page="/html/portlet/journal/article_search.jsp"
	searchContainer="<%= searchContainer %>"
>
	<liferay-ui:param name="groupId" value="<%= String.valueOf(groupId) %>" />
	<liferay-ui:param name="type" value="<%= type %>" />
</liferay-ui:search-form>

<div class="separator"><!-- --></div>

<%
OrderByComparator orderByComparator = JournalUtil.getArticleOrderByComparator(searchContainer.getOrderByCol(), searchContainer.getOrderByType());

ArticleSearchTerms searchTerms = (ArticleSearchTerms)searchContainer.getSearchTerms();
%>

<%@ include file="/html/portlet/journal/article_search_results.jspf" %>

<%
List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++) {
	JournalArticle curArticle = (JournalArticle)results.get(i);

	ResultRow row = new ResultRow(null, curArticle.getArticleId() + EditArticleAction.VERSION_SEPARATOR + curArticle.getVersion(), i);

	StringMaker sm = new StringMaker();

	sm.append("javascript: ");
	sm.append(renderResponse.getNamespace());
	sm.append("selectArticle('");
	sm.append(curArticle.getArticleId());
	sm.append("');");

	String rowHREF = sm.toString();

	// Article id

	row.addText(curArticle.getArticleId(), rowHREF);

	// Version

	row.addText(String.valueOf(curArticle.getVersion()), rowHREF);

	// Title

	row.addText(curArticle.getTitle(), rowHREF);

	// Display date

	row.addText(dateFormatDateTime.format(curArticle.getDisplayDate()), rowHREF);

	// Author

	row.addText(PortalUtil.getUserName(curArticle.getUserId(), curArticle.getUserName()), rowHREF);

	// Add result row

	resultRows.add(row);
}
%>

<liferay-ui:search-iterator searchContainer="<%= searchContainer %>" />

<liferay-ui:search-paginator searchContainer="<%= searchContainer %>" />
	
	
	</form>
	

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
<input type="hidden" name="cmd" value="updaterelcontent">
<input name="<portlet:namespace />redirect" type="hidden" value="<%= portletURL.toString() %>&<portlet:namespace />cur=<%= cur %>" />
		<fieldset>
		<legend>
			<%= LanguageUtil.get(pageContext, "javax.portlet.title.bs_content_rels") %>
		</legend>
		<table width="100%">
		<tr align="center">
		<td align="center"><strong><%= LanguageUtil.get(pageContext, "bs.related.content.classname") %>&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
		<td align="center"><strong><%= LanguageUtil.get(pageContext, "bs.related.content.show-content") %>&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
		<td align="center"><strong><%= LanguageUtil.get(pageContext, "bs.related.content.show-description") %>&nbsp;&nbsp;&nbsp;&nbsp;</strong></td>
		<td align="center"><strong><%= LanguageUtil.get(pageContext, "bs.related.content.orderIndex") %></strong></td>
		<td align="center"><strong><%= LanguageUtil.get(pageContext, "bs.related.content.langkey") %></strong></td>
		<td align="center"><strong><%= LanguageUtil.get(pageContext, "bs.related.content.portaltab") %></strong></td>
		</tr>
		<%
		for (int i=0; i<classNames.length; i++) {
				String pName = portletNames[i];
				String pClassName = classNames[i];
			%>
			<tr align="center">
				<td align="center"><%= LanguageUtil.get(pageContext, "javax.portlet.title."+pName) %></td>
				<td align="center"><input type="checkbox" name="<portlet:namespace/>show_rel_content" 
				           value="<%= pClassName %>" 
				           <% if (Validator.isNull(instancePortletShowRelContent) || instancePortletShowRelContent.indexOf(pClassName) != -1) { out.print(" checked "); } %>
				           ></td>
				<td align="center"><input type="checkbox" name="<portlet:namespace/>show_rel_content_description" 
				           value="<%= pClassName %>"
				           <% if (Validator.isNull(instancePortletShowRelContentDescription) || instancePortletShowRelContentDescription.indexOf(pClassName) != -1) { out.print(""); } %>
				           ></td>
				<td align="center">
					<% String orderIndex = prefs.getValue("showRelContentOrderIndex_"+pClassName, StringPool.BLANK); %>
					<input type="text" name="<portlet:namespace/>show_rel_content_orderIndex_<%= pClassName %>" size="2"
									value="<%= orderIndex %>">
				</td>
				
				
					<td align="center">
					<% String langKey = prefs.getValue("showRelContentLangKey_"+pClassName, StringPool.BLANK); %>
					<input type="text" name="<portlet:namespace/>show_rel_content_langKey_<%= pClassName %>" size="15"
									value="<%= langKey %>">
				</td>
				
					<td>
						
								<% long rootPlid = GetterUtil.getLong(prefs.getValue("show_rel_content_rootPlid_"+pClassName, StringPool.BLANK));%>
				<select name="<portlet:namespace />show_rel_content_rootPlid_<%= pClassName %>">
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
				
				
				
			</tr>
			<%
		   } 
		%>
			<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "embed-related-audio-video-img") %>
		</td>
		<td style="padding-left: 10px;"></td>
		
			<td>
			<select name="<portlet:namespace />embed_rel_media">
				<option <%= (instanceEmbedMedia.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "no") %></option>
				<option <%= (instanceEmbedMedia.equals("yes")) ? "selected" : "" %> value="yes"><%= LanguageUtil.get(pageContext, "yes") %></option>
				
			</select>
		</td>
		
	</tr>
	
	
	
		<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "show_topics") %>
		</td>
		<td style="padding-left: 10px;"></td>
		
			<td>
			<select name="<portlet:namespace />rel_show_topics">
				<option <%= (instanceRelShowTopics.equals("no")) ? "selected" : "" %> value="no"><%= LanguageUtil.get(pageContext, "no") %></option>
				<option <%= (instanceRelShowTopics.equals("yes")) ? "selected" : "" %> value="yes"><%= LanguageUtil.get(pageContext, "yes") %></option>
				
			</select>
		</td>
		
	</tr>
	
		</table>
		</fieldset>
	
	
	
	
		<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>
	
	
	
	
	
	
	

	
	



<c:if test="<%= renderRequest.getWindowState().equals(WindowState.MAXIMIZED) %>">
	<script type="text/javascript">
		Liferay.Util.focusFormField(document.<portlet:namespace />fm2.<portlet:namespace />searchArticleId);
	</script>
</c:if>