<%@ include file="/html/portlet/ext/base/yellowpages/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>

<liferay-ui:error exception="<%= com.ext.portlet.base.yellowpages.ua.WebSpaceTemplateException.class %>" message="bs.yellowpages.ua.template-problem" />
<liferay-ui:error exception="<%= com.liferay.portal.GroupNameException.class %>" message="bs.yellowpages.ua.web-space-already-exists-2" />


<h1 class="title1"><%= LanguageUtil.get(pageContext, "bs.yellowpages.ua.assign-user") %></h1>

<html:form action="/ext/yellowpages/editUA?actionURL=true" method="post" styleClass="uni-form">

<input type="hidden" name="cmd" value="update">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<tiles:insert page="/html/portlet/ext/struts_includes/struts_div_fields.jsp" flush="true">
<tiles:put name="formName" value="BsYellowPageForm"/>
<tiles:put name="useTabs" value="false"/>
</tiles:insert>

<div class="button-holder">
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, "bs.yellowpages.ua.save" ) %></html:submit>

<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
</div>

</html:form>