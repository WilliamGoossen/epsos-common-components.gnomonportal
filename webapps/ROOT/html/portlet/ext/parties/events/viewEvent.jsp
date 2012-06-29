<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="com.ext.portlet.parties.events.*" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="java.util.Vector" %>

<% 
portletName= LanguageUtil.get(pageContext, "parties.events.list.title"); 
Vector fields = EventsJspHelper.generateEventForm(request);
request.setAttribute("eventFields", fields);
String curFormName="Parties_Events_Event_Form";
%>


<!-- Event Form -->
<h2 class="title1"><%= LanguageUtil.get(pageContext, "parties.events.form.title") %> </h2>
<form name="Parties_Events_Event_Form" action="some/url" method="post">
	<tiles:insert  page="/html/portlet/ext/struts_includes/struts_dynamic_fields.jsp" flush="true">
		<tiles:put name="formName" value="Parties_Events_Event_Form"/>
		<tiles:put name="attributeName" value="eventFields"/>
	</tiles:insert>
</form>
	
	<br>
	
<input type="button" class="gamma1-FormButton" value="<%= LanguageUtil.get(pageContext, "parties.events.button.back") %>" onClick="history.back();">
<input type="button" class="gamma1-FormButton" value="<%= LanguageUtil.get(pageContext, "parties.events.button.close") %>" onClick="window.close();">

