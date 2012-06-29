
<logic:notEmpty name="BusinessLogicErrorMessage">
<%
	Object obj = request.getAttribute("BusinessLogicErrorMessage");
	//System.out.println("\t BusinessLogicErrorMessage = "+obj);
%>
<BR>
<UL class="gamma1-neg-alert">

<html:messages id="message"  property="BusinessLogicErrorMessage" message="true">
<LI><%= message %></LI>
</html:messages>

</UL>
<BR>
</logic:notEmpty>

