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


<c:if test="<%=Validator.isNotNull(redirect) %>">
<br/><br/>
<a href="<%=redirect %>">
<%= LanguageUtil.get(pageContext, "back") %>
</a>
</c:if>