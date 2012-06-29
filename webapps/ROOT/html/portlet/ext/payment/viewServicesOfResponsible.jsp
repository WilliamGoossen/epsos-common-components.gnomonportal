<%@ include file="/html/portlet/ext/payment/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%List paymentsList=(List)request.getAttribute("itemsList"); 

boolean clearDate=true;
String fromDate=(String)request.getAttribute("fromDate");
String toDate=(String)request.getAttribute("toDate");
String bgcolour=null;
String colour=null;
String value=null;

String titleText="";
if(paymentsList==null || paymentsList.isEmpty())
	titleText="pmt.payments.payments_of_service.services_no_entry";
%>

<h1><%=LanguageUtil.get(pageContext,titleText) %></h1>


<br/><br/>

<%if(paymentsList !=null && !paymentsList.isEmpty()) {%>

<form name="PmtPeriodSearchForm" styleClass="uni-form"  action="<portlet:renderURL>
	<portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/listPaymentsByService"/>
	</portlet:renderURL>" method="post">
<%
String searchName = request.getParameter("searchName");
searchName = (searchName == null) ? "" : searchName;
%>
<div class="inline-labels">
<div class="ctrl-holder">
<label for="fofCourseTitle"><%= LanguageUtil.get(pageContext, "pmt.history.search_period") %></label>

<div class="ctrl-holder">
				<label style="color:<%= colour %>" for="fromDate"><%= LanguageUtil.get(pageContext, "pmt.history.search_period.fromDate") %></label>
				<input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="text" id="fromDate" name="fromDate"  styleId="fromDate" readonly="true" value="<%= (fromDate!= null? fromDate : "") %>">
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_fromDate" style="cursor: pointer; border: 1px solid blue;" title="Date selector"
    					onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
    		<%if (clearDate){%>
			    <img src="<%=themeDisplay.getPathThemeImage()+"/common/close.png"%>" id="f_fromDate" style="cursor: pointer; border: 1px solid red;" title="<%= LanguageUtil.get(pageContext, "clear") %>"
			    onclick="var dateEl = document.getElementById('fromDate');if (dateEl != null) {dateEl.value=''};" />
			  <%}%>
    		<% if (true) { %><em>*</em><% } %>

				<script type="text/javascript">
				    Calendar.setup({
				        inputField     :    "fromDate",     // id of the input field
				        button         :    "f_fromDate",  // trigger for the calendar (button ID)
				        align          :    "Tl",           // alignment (defaults to "Bl")
								ifFormat    : "<%=CommonDefs.DATE_FORMAT_JSCRIPT%>",
								daFormat : "<%=CommonDefs.DATE_FORMAT_JSCRIPT%>",
								showsTime :true,
				        singleClick    :    true,
				        firstDay       : "1"
				    });
				</script>

<br>
				<label style="color:<%= colour %>" for="toDate"><%= LanguageUtil.get(pageContext, "pmt.history.search_period.toDate") %></label>
				<input <% if (bgcolour != null) { %> style="background-color:<%= bgcolour %>" <% } %> type="text" id="toDate" name="toDate"  styleId="toDate" readonly="true" value="<%= (toDate!= null? toDate : "") %>">
				<img src="<%=  themeDisplay.getPathThemeImage() %>/common/calendar.png" id="f_toDate" style="cursor: pointer; border: 1px solid blue;" title="Date selector"
    					onmouseover="this.style.background='red';" onmouseout="this.style.background=''" />
    		<%if (clearDate){%>
			    <img src="<%=themeDisplay.getPathThemeImage()+"/common/close.png"%>" id="f_toDate" style="cursor: pointer; border: 1px solid red;" title="<%= LanguageUtil.get(pageContext, "clear") %>"
			    onclick="var dateEl = document.getElementById('toDate');if (dateEl != null) {dateEl.value=''};" />
			  <%}%>
    		<% if (true) { %><em>*</em><% } %>

				<script type="text/javascript">
				    Calendar.setup({
				        inputField     :    "toDate",     // id of the input field
				        button         :    "f_toDate",  // trigger for the calendar (button ID)
				        align          :    "Tl",           // alignment (defaults to "Bl")
								ifFormat    : "<%=CommonDefs.DATE_FORMAT_JSCRIPT%>",
								daFormat : "<%=CommonDefs.DATE_FORMAT_JSCRIPT%>",
								showsTime :true,
				        singleClick    :    true,
				        firstDay       : "1"
				    });
				</script>

</div>
<br>
<span><%= LanguageUtil.get(pageContext, "pmt.services.service_to_pay") %></span>
	<select name="serviceId">
		<option name="" value=""></option>
	<%
		
			for (int i=0; i<paymentsList.size(); i++)
			{
				ViewResult serv=(ViewResult)paymentsList.get(i);
				%>
				<option value="<%= serv.getMainid().toString() %>" ><%= LanguageUtil.get(pageContext, serv.getField1().toString()) %></option>
				<%
			}

		%>
	</select>
<br>
<input type="submit" value="<%=LanguageUtil.get(pageContext, "gn.button.search") %>" /> 
</div> 
</div>	
</form>

<%} %>
