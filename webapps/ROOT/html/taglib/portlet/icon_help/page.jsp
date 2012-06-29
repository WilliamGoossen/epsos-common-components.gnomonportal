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

<%@ include file="/html/taglib/init.jsp" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<c:if test="<%= portletDisplay.isShowHelpIcon() %>">
 <% 
    // String helpURL = portletDisplay.getURLHelp();
    String helpURL = com.ext.portlet.cms.help.ViewHelpAction.generatePopupHelpLink(request).toString();
    helpURL = helpURL + "&helpCallingCurrentURL=" + HttpUtil.encodeURL(currentURL);
    String url = "javascript:openDialog('"+helpURL+"',500,450);";
 %>
	<liferay-ui:icon image="../portlet/help" message="help" url="<%= url %>" toolTip="<%= false %>" />
	<%-- THIS WOULD BE NICE BUT DOES NOT WORK CORRECTLY 	
    <a class="thickbox" href="<%= url %>"><img align="absmiddle" border="0" src="<%= themeDisplay.getPathThemeImage() %>/portlet/help.png"/></a>
	--%>
</c:if>