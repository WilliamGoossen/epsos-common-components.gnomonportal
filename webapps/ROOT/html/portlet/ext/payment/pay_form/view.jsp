<%@ include file="/html/portlet/ext/payment/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
List Services=(List)request.getAttribute("services");

%>

<br/><br/>


<form name="PmtForm" action="/ext/payment/pay_form/loadForm" method="post">
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "pmt.service.pay.choose_service") %></legend>
	<span><%= LanguageUtil.get(pageContext, "pmt.services.service_to_pay") %></span>
	<select name="mainid">
		<option name="" value=""></option>
	<%
		
		if (Services != null && Services.size() > 0) 
		{
			for (int i=0; i<Services.size(); i++)
			{
				ViewResult serv = (ViewResult)Services.get(i);
				%>
				<option name="<%= serv.getField4().toString() %>" value="<%= serv.getMainid().toString() %>"><%= LanguageUtil.get(pageContext, serv.getField4().toString()) %></option>
				<%
			}
		}
		%>
	</select>
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/payment/pay_form/loadForm" />
	  <tiles:put name="buttonName" value="chooseButton" />
	  <tiles:put name="buttonValue" value="gn.button.choose" />
	  <tiles:put name="formName"   value="PmtForm" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add value="topicid"/>
	  	<% } %>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add><%= request.getParameter("topicid") %></tiles:add>
	  	<% } %>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="view"/>
	  <tiles:put name="actionPermission" value="view"/>
	  <tiles:put name="partyRoleActionPermission" value="view"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</fieldset>	
</form>

