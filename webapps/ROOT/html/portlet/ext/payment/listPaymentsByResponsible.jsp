<%@ include file="/html/portlet/ext/payment/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<!-- Services List -->
<display:table id="item" name="itemsList" requestURI="//ext/payment/pmt_history_resp/view?actionURL=true" pagesize="10" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem=(ViewResult) pageContext.getAttribute("item"); %>
<display:column titleKey="pmt.service.history.client" property="field5" sortable="true" style="width:100%"/>
<display:column titleKey="pmt.service.history.amount" property="field1" sortable="true" style="width:100%"/>
<display:column titleKey="pmt.service.name" property="field7" sortable="true" style="width:100%"/>
<display:column titleKey="pmt.service.pmtType" property="field6" sortable="true" style="width:100%"/>
<display:column titleKey="pmt.service.history.transactionCode" property="field2" sortable="true" style="width:100%"/>
<display:column titleKey="pmt.service.history.transactionDetails" property="field3" sortable="true" style="width:100%"/>
<display:column titleKey="status" property="field9" sortable="true" style="text-align: right"/>
<display:column sortable="true" >
    <a href="<portlet:actionURL windowState="<%= WindowState.NORMAL.toString() %>">
                                <portlet:param name="struts_action" value="/ext/payment/pmt_history_resp/viewPmt"/>
                                <portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
                                <portlet:param name="redirect" value="<%=currentURL%>"/>
                                </portlet:actionURL>">
                        <%=LanguageUtil.get(pageContext, "details") %>
    </a>
</display:column>
</display:table>
<br/><br/>
