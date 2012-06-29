<%@ include file="/html/portlet/ext/payment/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<tiles:insert page="/html/portlet/ext/struts_includes/titleData.jsp" flush="true"/>
<br>
<%
boolean clearDate=true;
String fromDate=(String)request.getAttribute("fromDate");
String toDate=(String)request.getAttribute("toDate");
String bgcolour=null;
String colour=null;
String value=null;

List paymentsList=(List)request.getAttribute("itemsList");
  String serviceIdStr=(String)request.getAttribute("serviceId");
  
String titleText="";
if(paymentsList==null || paymentsList.isEmpty())
	titleText="pmt.payments.payments_of_service.no_entry";


%>
<form name="PmtPeriodSearchForm" styleClass="uni-form"  action="<portlet:renderURL>
	<portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/listPaymentsByService"/>
	<portlet:param name="serviceId" value="<%=serviceIdStr %>"/>
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

</div>
<br>
<div class="ctrl-holder">
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

<input type="submit" value="<%=LanguageUtil.get(pageContext, "gn.button.search") %>" /> 
</div> 
</div>	
</form>


<br>
<h1><%=LanguageUtil.get(pageContext,titleText) %></h1>
<br>

<!-- Payments List -->
<display:table id="item" name="itemsList" requestURI="//ext/payment/pmt_history_resp/view?actionURL=true" pagesize="10" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem=(ViewResult) pageContext.getAttribute("item"); %>
<display:column titleKey="pmt.service.history.transactionDate" property="field4" decorator="org.displaytag.sample.LongDateTimeWrapper" sortable="true" />
<display:column titleKey="debt.DebtSystemNo" property="field11" sortable="true" />
<display:column titleKey="pmt.service.customer" property="field5" sortable="true" />
<display:column titleKey="pmt.service.name" property="field7" sortable="true" />
<display:column titleKey="pmt.service.history.amount" property="field1" sortable="true" style="text-align: right"/>
<display:column titleKey="debt.ExtraAmount" property="field10" sortable="true" style="text-align: right"/>
<display:column titleKey="pmt.service.pmtType" sortable="true" >
<%= gnItem.getField6() %><br>
<%= gnItem.getField2() %><br>
<%= gnItem.getField3() %>
</display:column>
<display:column titleKey="pmt.service.history.errorDescription" property="field8" sortable="true" />
<display:column titleKey="egov.tax.UOSP_Status" property="field9" sortable="true" />
<display:column sortable="true" >
    <a href="<portlet:actionURL windowState="<%= WindowState.NORMAL.toString() %>">
                                <portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/viewPmt"/>
                                <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
                                <portlet:param name="fromDate" value="<%= fromDate %>"/>
                                <portlet:param name="toDate" value="<%= toDate %>"/>
                                <portlet:param name="redirect" value="<%=currentURL%>"/>
                                </portlet:actionURL>">
                        <%=LanguageUtil.get(pageContext, "details") %>
    </a>
    &nbsp;
	<a href="<portlet:actionURL windowState="<%= WindowState.NORMAL.toString() %>">
								<portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/loadPmtStatusForm"/>
								<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
								<portlet:param name="fromDate" value="<%= fromDate %>"/>
								<portlet:param name="toDate" value="<%= toDate %>"/>
								<portlet:param name="redirect" value="<%=currentURL%>"/>
								</portlet:actionURL>">
						<%=LanguageUtil.get(pageContext, "pmt.button.changeStatus") %>
	</a>
</display:column>


</display:table>
<br/><br/>
<html:link styleClass="beta1" action="/ext/payment/pmt_history_resp/view">
<%= LanguageUtil.get(pageContext, "back") %>
</html:link>
