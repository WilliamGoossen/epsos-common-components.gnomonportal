<%@ include file="/html/portlet/ext/base/init.jsp" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">

	<tr>
			<td>
			<%= LanguageUtil.get(pageContext, "browse-type") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<select name="<portlet:namespace />browse-type">
				<option <%= (instancePortletBrowseType.equals("default")) ? "selected" : "" %> value="default"><%= LanguageUtil.get(pageContext, "default") %></option>
				<option <%= (instancePortletBrowseType.equals("month")) ? "selected" : "" %> value="month"><%= LanguageUtil.get(pageContext, "month") %></option>
				<option <%= (instancePortletBrowseType.equals("week")) ? "selected" : "" %> value="week"><%= LanguageUtil.get(pageContext, "week") %></option>
			</select>
		</td>
	</tr>
	
	<tr>
		<td colspan="3">
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
				           <% if (Validator.isNull(instancePortletShowRelContentDescription) || instancePortletShowRelContentDescription.indexOf(pClassName) != -1) { out.print(" checked "); } %>
				           ></td>
				<td align="center">
					<% String orderIndex = prefs.getValue("showRelContentOrderIndex_"+pClassName, StringPool.BLANK); %>
					<input type="text" name="<portlet:namespace/>show_rel_content_orderIndex_<%= pClassName %>" size="2"
									value="<%= orderIndex %>">
				</td>
			</tr>
			<%
		   } 
		%>
		<tr align="center">
			<td align="center"><%= LanguageUtil.get(pageContext, "javax.portlet.title."+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_PORTLET) %></td>
			<td align="center"><input type="checkbox" name="<portlet:namespace/>show_rel_content" 
			           value="<%= com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME %>"
			           <% if (Validator.isNull(instancePortletShowRelContent) || instancePortletShowRelContent.indexOf(com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME) != -1) { out.print(" checked "); } %>
			           ></td>
			<td align="center"><input type="checkbox" name="<portlet:namespace/>show_rel_content_description" 
			           value="<%= com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME %>"
			           <% if (Validator.isNull(instancePortletShowRelContentDescription) || instancePortletShowRelContentDescription.indexOf(com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME) != -1) { out.print(" checked "); } %>
			           ></td>
			<td align="center">
			<% String articlesOrderIndex = prefs.getValue("showRelContentOrderIndex_"+com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME, StringPool.BLANK); %>
			<input type="text" name="<portlet:namespace/>show_rel_content_orderIndex_<%= com.ext.portlet.base.contentrel.ContentRelUtil.JOURNAL_CLASSNAME %>" size="2"
						value="<%= articlesOrderIndex %>"></td>
		</tr>
		</table>
		</fieldset>
		</td>
	</tr>

	
	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>