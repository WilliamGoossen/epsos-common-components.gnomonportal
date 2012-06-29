<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="org.apache.struts.action.ActionMessages" %>
<%@ page import="org.apache.struts.action.ActionMessage" %>


<tiles:useAttribute id="propName" name="propName" classname="java.lang.String"/>
<tiles:useAttribute id="posAlert" name="posAlert" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="header" name="header" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="currentPage" name="currentPage" classname="java.lang.String" ignore="true"/>

<%	
	String classCss = (posAlert == null || posAlert.toLowerCase().equals("false")) ? "gamma1-neg-alert" : "gamma1-pos-alert";
	
	Object attr = request.getAttribute(propName);
	
	header = (header != null) ? LanguageUtil.get(pageContext, header) : "ffff";
	int currentPageNum = -1;
	
	try{
		currentPageNum = new Integer(currentPage).intValue();
	}catch(Exception ex){}
%>

<logic:notEmpty name="<%= propName%>">
<h3 class="title2">
</h3>
<% int i = 0;%>
<OL class="<%=classCss%>">
<%
	ActionMessages actionMessages = (ActionMessages)request.getAttribute(propName);
	
	java.util.Iterator iter = actionMessages.get();
	while (iter.hasNext()){
		ActionMessage msg = (ActionMessage)iter.next();
		String key = msg.getKey();
	%>
	<% i++; %>
	<%if (i == currentPageNum) {%><B><%}%>
	<LI><%=LanguageUtil.get(pageContext, key)%>
	<%if (i == currentPageNum) {%></B><%}%>
	<%
	}
%>
</OL>

<h3 class="title2">
</h3>

</logic:notEmpty>


