<%@ include file="/html/portlet/ext/base/mlists_display/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/mlists_display/subscribe?actionURL=true" ;
String buttonText = "bs.mlists.action.subscribe";
String titleText = "bs.mlists.action.subscribe";
List mlists = gnomon.hibernate.GnPersistenceService.getInstance(null).listObjects(com.liferay.portal.util.PortalUtil.getCompanyId(request), gnomon.hibernate.model.base.mlists.BsMlist.class);
%>

<% if (mlists != null && mlists.size() > 0) { %>
<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" styleClass="uni-form">
	<input type="hidden" name="loadaction" value="<%= loadaction %>">

	<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
        <tiles:put name="formName" value="BsMListSubscriptionForm"/>
        </tiles:insert>

	<div class="button-holder">
        <html:submit styleClass="portlet-form-button" ><%= LanguageUtil.get(pageContext, buttonText ) %>
        </html:submit>
	</div>
</html:form>

<% } else { %>
<%= LanguageUtil.get(pageContext, "bs.mlists.no-lists-found") %>
<% }  %>
<br/>
