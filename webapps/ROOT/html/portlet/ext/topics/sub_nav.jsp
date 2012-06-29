<%
/**
 * Copyright (c) 2000-2003 Liferay Corporation
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

<%@ include file="/html/portlet/ext/topics/init.jsp" %>

<table  width="100%" border="0" cellpadding="0" cellspacing="0">
<tr height=30>
	<td>
	
		
	
	<%String myparentid="-1";
if (request.getParameter("topicid") != null && !request.getParameter("topicid").toString().equals("") ) 
	myparentid = request.getParameter("topicid").toString();%>
	
		
		
		<img src="/html/themes/portlet/gnomon_theme/img/bulet_admin_subnav.gif"><a class="alpha1" href="<liferay:actionURL windowState="maximized" portletName="GN_TOPICS"><liferay:param name="struts_action" value="/ext/topics/edit_topic"/><liferay:param name="cmd" value="edit"/><liferay:param name="parentid" value="<%=myparentid%>"/></liferay:actionURL>">
		<%= LanguageUtil.get(pageContext, "add-topic") %></a> - 

		
		<img src="/html/themes/portlet/gnomon_theme/img/bulet_admin_subnav.gif"><a class="alpha1" href="<liferay:actionURL windowState="maximized" portletName="GN_TOPICS"><liferay:param name="struts_action" value="/ext/topics/view_topics"/><liferay:param name="parentid" value="<%=myparentid%>"/></liferay:actionURL>"><%= LanguageUtil.get(pageContext, "topics-list") %></a>
	</td>
</tr>
</table>

<hr class="alpha1" width="100%" size="1" noshade>
</hr>