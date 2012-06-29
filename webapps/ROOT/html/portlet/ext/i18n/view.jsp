<%@ include file="/html/portlet/ext/i18n/init.jsp" %>

<%
String portalMessages = ParamUtil.getString(request, "portalMessages");
//if (Validator.isNull(portalMessages))
	portalMessages = (String)request.getAttribute("portalMessages");
%>

<portlet:actionURL var="updateURL">
	<portlet:param name="struts_action" value="/ext/i18n/view"/>
</portlet:actionURL>

<form class="uni-form" action="<%=updateURL%>" method="post" name="fm">
<input name="cmd" id="cmd" value="update" type="hidden" /> 
<input name="redirect" id="redirect" value="<%=currentURL %>" type="hidden" /> 

	<legend><%=LanguageUtil.get(pageContext,"translations") %></legend>	
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>portalMessages"> <liferay-ui:message key="messages" /></label>
		<textarea name="<portlet:namespace/>portalMessages" id="<portlet:namespace/>portalMessages" rows="20" cols="80"><%=portalMessages %></textarea>
	</div>
	
	<div class="button-holder">
		<input type="submit" class="primaryAction" value="<liferay-ui:message key="update" />"/>
	</div>
	
</form>