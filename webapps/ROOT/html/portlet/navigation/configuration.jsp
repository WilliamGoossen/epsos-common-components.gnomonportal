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

<%@ include file="/html/portlet/navigation/init.jsp" %>

<%
LayoutLister layoutLister = new LayoutLister();

String rootNodeName = StringPool.BLANK;
LayoutView layoutView = layoutLister.getLayoutView(layout.getGroupId(), layout.isPrivateLayout(), rootNodeName, locale);

List layoutList = layoutView.getList();
%>

<%
String[] bulletStyleOptions = StringUtil.split(themeDisplay.getTheme().getSetting("bullet-style-options"));
%>

<liferay-portlet:preview
	portletName="<%= portletResource %>"
	queryString="struts_action=/navigation/view"
	width="100%"
/>

<div class="separator"><!-- --></div>

<form action="<liferay-portlet:actionURL portletConfiguration="true" />" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>" />

<table class="liferay-table">
<tr>
    <td>
        <liferay-ui:message key="root-layout" />
    </td>
    <td>
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
    </td>
</tr>

<tr>
	<td>
		<liferay-ui:message key="Orientation" />
	</td>
	<td>
		<select name="<portlet:namespace />viewOrientation">
			<option <%= (viewOrientation.equals("vertical")) ? "selected" : "" %> value="vertical"><%= LanguageUtil.get(pageContext, "vertical") %></option>
			<option <%= (viewOrientation.equals("horizontal")) ? "selected" : "" %> value="horizontal"><%= LanguageUtil.get(pageContext, "horizontal") %></option>
		</select>
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="display-style" />
	</td>
	<td>
		<select name="<portlet:namespace />displayStyle" id="<portlet:namespace />displayStyle">

			<%
			for (int i = 1; i <= 6; i++) {
			%>

				<option <%= (displayStyle.equals(String.valueOf(i))) ? "selected" : "" %> value="<%= i %>"><%= i %></option>

			<%
			}
			%>

			<option <%= displayStyle.equals("[custom]") ? "selected" : "" %> value="[custom]"><liferay-ui:message key="custom" /></option>
		</select>
	</td>
</tr>
<tr>
	<td>
		<liferay-ui:message key="bullet-style" />
	</td>
	<td>
		<select name="<portlet:namespace />bulletStyle">

			<%
			for (int i = 0; i < bulletStyleOptions.length; i++) {
			%>

				<option <%= (bulletStyleOptions[i].equals(bulletStyle)) ? "selected" : "" %> value="<%= bulletStyleOptions[i] %>"><%= bulletStyleOptions[i] %></option>

			<%
			}
			%>

			<c:if test="<%= bulletStyleOptions.length == 0 %>">
				<option value="">(<liferay-ui:message key="default" />)</option>
			</c:if>
		</select>
	</td>
</tr>
</table>

<table id="<portlet:namespace/>customDisplayStyle">
<tr>
	<td>
		<br />

		<table class="liferay-table">
		<tr>
			<td>
				<liferay-ui:message key="header" />
			</td>
			<td>
				<select name="<portlet:namespace />headerType">
					<option <%= headerType.equals("none") ? "selected" : "" %> value="none"><liferay-ui:message key="none" /></option>
					<option <%= headerType.equals("portlet-title") ? "selected" : "" %> value="portlet-title"><liferay-ui:message key="portlet-title" /></option>
					<option <%= headerType.equals("root-layout") ? "selected" : "" %> value="root-layout"><liferay-ui:message key="root-layout" /></option>
					<option <%= headerType.equals("breadcrumb") ? "selected" : "" %> value="breadcrumb"><liferay-ui:message key="breadcrumb" /></option>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<liferay-ui:message key="root-layout" />
			</td>
			<td>
				<select name="<portlet:namespace />rootLayoutType">
					<option <%= rootLayoutType.equals("absolute") ? "selected" : "" %> value="absolute"><liferay-ui:message key="parent-at-level" /></option>
					<option <%= rootLayoutType.equals("relative") ? "selected" : "" %> value="relative"><liferay-ui:message key="relative-parent-up-by" /></option>
				</select>
				<select name="<portlet:namespace />rootLayoutLevel">

					<%
					for (int i = 0; i <= 4; i++) {
					%>

						<option <%= (rootLayoutLevel == i) ? "selected" : "" %> value="<%= i %>"><%= i %></option>

					<%
					}
					%>

				</select>
			</td>
		</tr>
		<tr>
			<td>
				<liferay-ui:message key="included-layouts" />
			</td>
			<td>
				<select name="<portlet:namespace />includedLayouts">
					<option <%= includedLayouts.equals("auto") ? "selected" : "" %> value="auto"><liferay-ui:message key="auto" /></option>
					<option <%= includedLayouts.equals("all") ? "selected" : "" %> value="all"><liferay-ui:message key="all" /></option>
				</select>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>

<br />

<input type="button" value="<liferay-ui:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);" />

</form>

<script type="text/javascript">
	jQuery(
		function() {
			var selects = jQuery('#<portlet:namespace/>displayStyle');

			var toggleCustomFields = function() {
				var select = jQuery(this);

				var div = select.parent().next();
				var value = select.find('option:selected').val();

				var displayStyle = jQuery(this).val();

				if (displayStyle == '[custom]') {
					jQuery("#<portlet:namespace/>customDisplayStyle").show();
				}
				else {
					jQuery("#<portlet:namespace/>customDisplayStyle").hide();
				}
			}

			selects.change(toggleCustomFields);
			selects.each(toggleCustomFields);
		}
	)
</script>