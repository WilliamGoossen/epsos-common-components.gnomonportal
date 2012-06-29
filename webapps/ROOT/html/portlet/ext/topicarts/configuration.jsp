<%@ include file="/html/portlet/ext/topicarts/init.jsp" %>
<%@ page import="gnomon.hibernate.model.gn.GnTopic" %>

<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>

<form action="<liferay-portlet:actionURL portletConfiguration="true"></liferay-portlet:actionURL>" method="post" name="<portlet:namespace />fm">
	<input name="<portlet:namespace /><%= Constants.CMD %>" type="hidden" value="<%= Constants.UPDATE %>">
	<table border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "topic") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<input type="hidden" name="<portlet:namespace />topicId" value="<%=instanceTopicId%>">
			<%
			String topicName = instanceTopicView==null ? 
					"" :
					(instanceTopicView.getField2()!=null?
							instanceTopicView.getField2().toString()
							:"ERROR: TOPICID="+instanceTopicView.getMainid());
			%>
			<input size="30" type="text" readonly="true" name="<portlet:namespace />topicId_Names" value="<%= topicName %>"> &nbsp;
			<a href="#" class="beta1" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?multiSelection=false&openerFormName=<portlet:namespace />fm&openerFormFieldName=<portlet:namespace />topicId', 400,350);"><%= LanguageUtil.get(pageContext,"gn.button.choose") %></a>
    			&nbsp;<a href="#" class="beta1" onClick="document.<portlet:namespace />fm.elements['<portlet:namespace />topicId'].value='';document.<portlet:namespace />fm.elements['<portlet:namespace />topicId_Names'].value='';"><%= LanguageUtil.get(pageContext,"gn.button.clear") %></a>
		</td>
	</tr>
	
	<tr>
		<td>
			<%= LanguageUtil.get(pageContext, "default-topic") %>
		</td>
		<td style="padding-left: 10px;"></td>
		<td>
			<input type="hidden" name="<portlet:namespace />recentContentTopicId" value="<%=instanceRecentContentTopicId%>">
			<%
			String recentContentTopicName = instanceRecentContentTopicView==null ? 
					"" :
					(instanceRecentContentTopicView.getField2()!=null?
							instanceRecentContentTopicView.getField2().toString()
							:"ERROR: TOPICID="+instanceRecentContentTopicView.getMainid());
			%>
			<input size="30" type="text" readonly="true" name="<portlet:namespace />recentContentTopicId_Names" value="<%= recentContentTopicName %>"> &nbsp;
			<a href="#" class="beta1" onClick="openDialog('/html/portlet/ext/struts_includes/topics/browseTopics.jsp?multiSelection=false&openerFormName=<portlet:namespace />fm&openerFormFieldName=<portlet:namespace />recentContentTopicId', 400,350);"><%= LanguageUtil.get(pageContext,"gn.button.choose") %></a>
    			&nbsp;<a href="#" class="beta1" onClick="document.<portlet:namespace />fm.elements['<portlet:namespace />recentContentTopicId'].value='';document.<portlet:namespace />fm.elements['<portlet:namespace />recentContentTopicId_Names'].value='';"><%= LanguageUtil.get(pageContext,"gn.button.clear") %></a>
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

	</table>
	<br>
	<input class="portlet-form-button" type="button" value="<bean:message key="save" />" onClick="submitForm(document.<portlet:namespace />fm);">
</form>