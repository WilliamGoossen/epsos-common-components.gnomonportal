<table border="0" cellpadding="0" cellspacing="0" width="95%">

<%
if(myqueryString==null || myqueryString.equals("")) {
	if(request.getParameter("myquerystring")!=null)
	myqueryString = request.getParameter("myquerystring").toString();
}
 %>	

 <input type="hidden" name="myquerystring" value="<%=myqueryString %>">
 

<%if(genException!=null) { %>
<span class="bg1" ><span class="bg-neg-alert"><%=genException.getMessage() %></span></span>
<% }%>


<liferay:if test="<%= SessionErrors.contains(request,generalException) %>">
	<%
throwedExceptions = (Vector) SessionErrors.get(request, generalException);

for(throwedIndex=0; throwedIndex< throwedExceptions.size(); throwedIndex++) {
	ae = (ActionException)throwedExceptions.get(throwedIndex);
	%>
	
<span class="bg1" ><span class="bg-neg-alert">	<%= ae.getMessage().toString() %></span></span>
<%}%>

	</liferay:if>

<%


for (exceptionsIndex=0; exceptionsIndex<commonExceptions.length; exceptionsIndex++ ){%>
<liferay:if test="<%= SessionErrors.contains(request, commonExceptions[exceptionsIndex]) %>">
	<%

	throwedExceptions = (Vector) SessionErrors.get(request,  commonExceptions[exceptionsIndex]);

for(throwedIndex=0; throwedIndex< throwedExceptions.size(); throwedIndex++) {
	ae = (ActionException)throwedExceptions.get(throwedIndex);
commonExceptionsFields[exceptionsIndex] =commonExceptionsFields[exceptionsIndex] + ",--" + ae.getMessage().toString() +"--";
}


	// ae = (ActionException) SessionErrors.get(request,  commonExceptions[exceptionsIndex]);
	//commonExceptionsFields[exceptionsIndex]=ae.getMessage().toString();
	%>

	</liferay:if>
	<%} %>