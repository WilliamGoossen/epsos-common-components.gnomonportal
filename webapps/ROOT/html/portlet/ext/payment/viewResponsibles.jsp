<%@ include file="/html/portlet/ext/payment/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<!-- Services List -->
<display:table id="item" name="itemsList" requestURI="//ext/payment/pmt_history_resp/view?actionURL=true" pagesize="10" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% User userResp=(User) pageContext.getAttribute("item"); %>
<display:column titleKey="pmt.service.responsible" sortable="true" style="width:100%">
<a href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/listPaymentsByResponsible"/>
		<portlet:param name="userId" value="<%= Long.toString(userResp.getUserId()) %>"/>
		<portlet:param name="loadaction" value="view"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>"><%= userResp.getFullName() %></a>
</display:column>

</display:table>
<br/><br/>
