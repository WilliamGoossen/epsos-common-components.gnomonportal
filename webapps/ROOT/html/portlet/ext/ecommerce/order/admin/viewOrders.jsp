<%@ include file="/html/portlet/ext/ecommerce/init.jsp" %>
<%@ include file="/html/portlet/ext/ecommerce/order/admin/currentURLcomplement.jsp" %>

<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.model.ecommerce.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="org.apache.struts.Globals" %>
<%@ page import="org.apache.struts.action.ActionErrors" %>

<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
ActionErrors errors = (ActionErrors)request.getSession().getAttribute(Globals.ERROR_KEY);
if (errors != null && !errors.isEmpty())
{
	request.setAttribute(Globals.ERROR_KEY, errors);
	%> <html:errors property="ec.admin.order.state.confirm.inventory-error"/><br><br><%
}
boolean showPrices = EShopPropsUtil.isShowPrices(request);
%>
<tiles:insert page="/html/portlet/ext/ecommerce/order/admin/header.jsp" flush="true">
	<tiles:put name="tab"><%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_ORDERS %></tiles:put>
</tiles:insert>

<%
String tabs1 = ParamUtil.get(request, "tabs1", "recent");
String scenarioType = ParamUtil.get(request, "scenarioType", "time_today");
%>
	<liferay-ui:tabs
	    names="recent,search"
	    param="tabs1"
	    refresh="<%= false %>"
	    value="<%=tabs1%>"
	>
	
	    <liferay-ui:section>
            
            <html:form action="/ext/orders/admin/view?actionURL=true" method="post" styleClass="uni-form">
            <input type="hidden" name="tab" value="<%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_ORDERS %>">
            <input type="hidden" name="<portlet:namespace/>tabs1" value="recent">
            
            <%--<label for="<portlet:namespace/>scenarioType" ><liferay-ui:message key="show" /></label>--%>
            <select name="<portlet:namespace/>scenarioType" id="<portlet:namespace/>scenarioType">
                <option value="time_today" <%=scenarioType.equals("time_today")? "selected": "" %> class="form-text"><%=LanguageUtil.get(pageContext, "ec.admin.order.select.orders.today") %></option>
                <option value="time_last_week" <%=scenarioType.equals("time_last_week")? "selected": "" %> class="form-text"><%=LanguageUtil.get(pageContext, "ec.admin.order.select.orders.last.week") %></option>
                <option value="time_last_month" <%=scenarioType.equals("time_last_month")? "selected": "" %> class="form-text"><%=LanguageUtil.get(pageContext, "ec.admin.order.select.orders.last.month") %></option>
                <option value="top_recent_25" <%=scenarioType.equals("top_recent_25")? "selected": "" %> class="form-text"><%=LanguageUtil.format(pageContext, "ec.admin.order.select.orders.recent.x", new Integer[] {25}) %></option>
                <%--
                <option value="need_admin_action" <%=scenarioType.equals("need_admin_action")? "selected": "" %> class="form-text"><%=LanguageUtil.get(pageContext, "ec.admin.order.select.need.admin.action") %></option>
                <option value="have_been_delayed" <%=scenarioType.equals("have_been_delayed")? "selected": "" %> class="form-text"><%=LanguageUtil.get(pageContext, "ec.admin.order.select.have.been.delayed") %></option>
                --%>
            </select>
            
            <input type="submit" value="<%= LanguageUtil.get(pageContext, "show") %>">
            
            <c:if test="<%=tabs1.equals("recent") %>">                
                <%@ include file="/html/portlet/ext/ecommerce/order/admin/ordersList.jspf" %>
            </c:if>
            </html:form>
	    </liferay-ui:section>
	    <liferay-ui:section>
	        <html:form action="/ext/orders/admin/view?actionURL=true" method="post" styleClass="uni-form">
            <input type="hidden" name="tab" value="<%= com.ext.portlet.ecommerce.order.admin.ViewAction.TAB_ORDERS %>">
            <input type="hidden" name="<portlet:namespace/>tabs1" value="search">
				
			<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
                <tiles:put name="formName" value="EcOrderSearchForm"/>
			</tiles:insert>
			
			<div class="button-holder">
			<input type="submit" value="<%= LanguageUtil.get(pageContext, "ec.admin.order.button.search") %>">
			</div>
							
			<c:if test="<%=tabs1.equals("search") %>">
                <%@ include file="/html/portlet/ext/ecommerce/order/admin/ordersList.jspf" %>
            </c:if>
            </html:form>
		</liferay-ui:section>
	</liferay-ui:tabs>