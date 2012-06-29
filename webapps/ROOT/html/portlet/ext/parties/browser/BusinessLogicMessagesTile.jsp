<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<tiles:useAttribute id="propName" name="propName" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="errorNameSufix" name="errorNameSufix" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="posAlert" name="posAlert" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="messageFlag" name="messageFlag" classname="java.lang.String" ignore="true"/>

<%
	errorNameSufix = (errorNameSufix == null) ? "" : errorNameSufix;
	
	String propertyName = "";
	
	propName =  (propName == null) ? "BusinessLogicErrorMessage_" : propName;
	
	propertyName = propName + errorNameSufix;
	
	String classCss = (posAlert == null || posAlert.toLowerCase().equals("false")) ? "gamma1-neg-alert" : "gamma1-pos-alert";
	
	Object attr = request.getAttribute(propertyName);
	messageFlag = (messageFlag == null) ? "true" : messageFlag;
	
%>

<logic:notEmpty name="<%= propertyName%>">
<UL class="<%=classCss%>">
<html:messages id="message"  property="<%= propertyName%>" message="<%=messageFlag%>">
<LI><%= message %></LI>
</html:messages>

</UL>

</logic:notEmpty>

