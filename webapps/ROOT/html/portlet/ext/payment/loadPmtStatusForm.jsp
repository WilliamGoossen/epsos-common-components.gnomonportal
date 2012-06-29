<%@ include file="/html/portlet/ext/payment/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>

<%String[] paymentStati=new String[]{CommonDefs.PAYMENT_APPROVED,CommonDefs.PAYMENT_DISCARD,
									 CommonDefs.PAYMENT_FAILED,CommonDefs.PAYMENT_PENDING_APPROVAL
									 }; 

String fromDate=(String)request.getAttribute("fromDate");
String toDate=(String)request.getAttribute("toDate");
ViewResult itemView=(ViewResult)request.getAttribute("itemView");
String titleText="pmt.service.history.changeStatus";

%>

<br>


<% if (PortletPermissionUtil.contains(permissionChecker, plid, "PMT_SERVICE_ADMIN", "edit")) { %>
<form name="PmtStatusForm" action="<portlet:renderURL>
	<portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/changePmtStatus"/>
	</portlet:renderURL>" method="post">
<fieldset>
<legend><%= LanguageUtil.get(pageContext, titleText) %></legend>
	<span><%= LanguageUtil.get(pageContext, "egov.tax.UOSP_Status") %></span>
	<select name="pmtStatus">
		<option name="" value=""></option>
	<%
		
		if (paymentStati != null) 
		{
			for (int i=0; i<4; i++)
			{
				%>
				<option value="<%= paymentStati[i] %>" <%String sel="no"; if(paymentStati[i].equals(itemView.getField9().toString())){%> selected="yes" <%} %>  ><%= LanguageUtil.get(pageContext, paymentStati[i]) %></option>
				<%
			}
		}
		%>
	</select>
	<input type="hidden" name="pmtHistoryId" value="<%=itemView.getMainid().toString()%>"/>
	<input type="hidden" name="serviceId" value="<%=itemView.getField12().toString()%>"/>
	<input type="hidden" name="fromDate" value="<%=fromDate %>"/>
	<input type="hidden" name="toDate" value="<%=toDate %>"/>
		<br>
	<strong>Comments:</strong><br>
	<textarea name="comments" id="comments" cols="40" rows="8"></textarea>	
	<br>
	
	<input type="submit" value="<%=LanguageUtil.get(pageContext, "pmt.button.changeStatus") %>">
</fieldset>
<br>	
	<tiles:insert page="/html/portlet/ext/struts_includes/historyButton.jsp" flush="true">
		<tiles:put name="formName"  value="PmtStatusForm" />
		<tiles:put name="buttonName"  value="history" />
		<tiles:put name="relatedObjectId"  value="<%=itemView.getMainid().toString()%>" />
		<tiles:put name="relatedObject" value="gnomon.hibernate.model.payment.PmtHistory"/>
	</tiles:insert>

</form>
<% } %>

<br/><br/>
<a href="<portlet:renderURL>
	<portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/listPaymentsByService"/>
	<portlet:param name="serviceId" value="<%=itemView.getField12().toString() %>"/>
	<portlet:param name="fromDate" value="<%=fromDate %>"/>
	<portlet:param name="toDate" value="<%=toDate %>"/>
	</portlet:renderURL>">
<%= LanguageUtil.get(pageContext, "back") %>
</a>





	

