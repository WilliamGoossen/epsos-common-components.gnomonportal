<%@ include file="/html/portlet/ext/messages/init.jsp" %>

<%@ page import="gnomon.hibernate.model.gn.GnNotification" %>

<%
GnNotification notification = (GnNotification)request.getAttribute("notification");
%>
<br>

<fieldset class="uni-form">
<div class="block-labels">

<div class="ctrl-holder">
<label for="sendDate">
<%= LanguageUtil.get(pageContext, "gn.messages.sentDate") %>
</label>

<div id="sendDate" name="sendDate">
<%= com.ext.portlet.messages.ListPortalMessagesAction.format.format(notification.getSendDate()) %>
</div>
</div>


<div class="ctrl-holder">
<label for="fromName">
<%= LanguageUtil.get(pageContext, "gn.messages.fromName") %>
</label>

<div id="fromName" name="fromName">
<%= notification.getSentFromName() %>
</div>
</div>


<div class="ctrl-holder">
<label for="subject">
<%= LanguageUtil.get(pageContext, "gn.messages.subject") %>
</label>

<div id="subject" name="subject">
<%= notification.getSubject()%>
</div>
</div>


<div class="ctrl-holder">
<label for="body">
<%= LanguageUtil.get(pageContext, "gn.messages.body") %>
</label>

<div id="body" name="body">
<%= notification.getBody()%>
</div>
</div>

</div>
</fieldset>

<br>

<a href="<portlet:actionURL/>"><img src="<%= themeDisplay.getPathThemeImage() %>/common/back.png"><%= LanguageUtil.get(pageContext, "gn.protocol.back") %></a>