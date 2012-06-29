<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>

<portlet:actionURL var="submitURL">
	<portlet:param name="struts_action" value="/ext/orders/user/findOrder"/>
</portlet:actionURL>

<%
	String referenceCode = ParamUtil.getString(request, "referenceCode");
%>

<liferay-ui:error exception="<%= com.ext.portlet.ecommerce.order.exception.OrderNotFoundException.class %>" message="order-not-found" />

<%-- Form to search for a guest order --%>
<form class="uni-form" action="<%=submitURL %>" method="post" name="<portlet:namespace />fm">
<input name="<portlet:namespace/>cmd" id="<portlet:namespace/>cmd" value="search" type="hidden" /> 
<fieldset class="block-labels">
	<legend><%=LanguageUtil.get(pageContext,"search-for-order-status") %></legend>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>referenceCode"> <liferay-ui:message key="reference-code" /></label>
		<input name="<portlet:namespace/>referenceCode" id="<portlet:namespace/>referenceCode" value="<%=referenceCode%>" size="35" maxlength="50" type="text" class="textInput" />
	</div>
	
	<div class="ctrl-holder">
		<label for="<portlet:namespace/>confirmationCode"> <liferay-ui:message key="confirmation-code" /></label>
		<input name="<portlet:namespace/>confirmationCode" id="<portlet:namespace/>confirmationCode" value="" size="15" maxlength="50" type="password" class="textInput" />
	</div>

	<div class="button-holder">
		<input type="submit" class="primaryAction" value="<liferay-ui:message key="find" />"/>
	</div>

</fieldset>
</form>