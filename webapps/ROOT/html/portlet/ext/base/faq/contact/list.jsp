<%@ include file="/html/portlet/ext/base/faq/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
List contactList=(List) request.getAttribute("contactList");
%>

<!-- Events List -->
<display:table id="myContact" name="contactList" requestURI="//ext/faqs/listContact?actionURL=true" pagesize="5" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% BsFaqContact gnItem = (BsFaqContact) pageContext.getAttribute("myContact"); %>
<display:column titleKey="title" sortable="true" >
<b>
<a href="<portlet:actionURL>
				<portlet:param name="struts_action" value="/ext/faq/loadContact"/>
				<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
				<portlet:param name="loadaction" value="view"/>
				<portlet:param name="redirect" value="<%=currentURL%>"/>
				</portlet:actionURL>"><%= gnItem.getContactTitle() %></a>
</b>
<br/>
<%= gnItem.getContactName() %>, <%=gnItem.getContactEmail()%> , <%=gnItem.getContactType()%>
</display:column>


<display:column style="text-align: right; white-space:nowrap;">
<a href="#" onclick="javascript:_toggleMenu(event, 'browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>');return false;" style="white-space: nowrap;"><%=LanguageUtil.get(pageContext, "gn.link.actions") %></a><img src="<%= themeDisplay.getPathThemeImage() %>/base/more.gif" align="middle" border="0">
<br>
<div id="browse:actionsMenu_1_<%=gnItem.getMainid().toString()%>" style="position: absolute; display: none; padding-left: 2px;">
	<table class="moreActionsMenu" border="0" cellpadding="0" cellspacing="4">
	<tbody>
	<c:if test="<%= hasAdd || PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.REPLY_FAQ_POST) %>">
		<c:choose>
		<c:when test="<%=(gnItem.getReplied()==null) || (!gnItem.getReplied())%>">
			<c:if test="<%= PortletPermissionUtil.contains(permissionChecker, plid, portletID, ActionExtKeys.REPLY_FAQ_POST) %>">
			<tr>
            <td>
             <img src="<%= themeDisplay.getPathThemeImage() %>/common/reply.gif" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
                         </td>
			
				<td>
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/faq/loadContactReply"/>
							<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="edit"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "bs.faq.contact.link.reply") %>
					</a>
				</td>
			</tr>
			</c:if>
		</c:when>
		<c:otherwise>
			<c:if test="<%= hasAdd %>">
			<tr>
            <td>
             <img src="<%= themeDisplay.getPathThemeImage() %>/common/activate.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
             </td>

				<td>
               
					<a href="<portlet:actionURL>
							<portlet:param name="struts_action" value="/ext/faq/load"/>
							<portlet:param name="contactid" value="<%= gnItem.getMainid().toString() %>"/>
							<portlet:param name="loadaction" value="add"/>
							<portlet:param name="redirect" value="<%=currentURL%>"/>
							</portlet:actionURL>">
					<%=LanguageUtil.get(pageContext, "bs.faq.contact.link.add-to-faq") %>
					</a>
				</td>
			</tr>
			</c:if>
		</c:otherwise>
		</c:choose>
	</c:if>
	<c:if test="<%= hasEdit %>">
	<tr>
		<td>
        <img src="<%= themeDisplay.getPathThemeImage() %>/common/edit.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.edit") %>">
        </td>
			
		<td>
			
            <a href="<portlet:actionURL>
					<portlet:param name="struts_action" value="/ext/faq/loadContact"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="edit"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.edit") %>
			</a>
		</td>
	</tr>
	</c:if>
	<c:if test="<%= hasDelete %>">
	<tr>
		<td>
        <img src="<%= themeDisplay.getPathThemeImage() %>/common/delete.png" border="0" alt="<%=LanguageUtil.get(pageContext, "gn.link.delete") %>">
        </td>
	
		<td>
        
			<a href="<portlet:actionURL><portlet:param name="struts_action" value="/ext/faq/loadContact"/>
					<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
					<portlet:param name="loadaction" value="delete"/>
					<portlet:param name="redirect" value="<%=currentURL%>"/>
					</portlet:actionURL>">
			<%=LanguageUtil.get(pageContext, "gn.link.delete") %>
			</a>
		</td>
	</tr>
	</c:if>
	
	</tbody>
	</table>
</div>
</display:column>
</display:table>