<%@ include file="/html/portlet/ext/base/guestbook/init.jsp" %>
<%@ page import="com.ext.sql.StrutsFormFields" %>
<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.ext.util.CommonDefs" %>

<%
try {
//com.ext.portlet.base.faq.BsFaqForm aFormBean = (com.ext.portlet.base.faq.BsFaqForm)request.getAttribute("BsFaqForm");
//System.out.println(aFormBean.toString());

String loadaction = (String)request.getAttribute("loadaction");
//String loadaction = (String)request.getParameter("loadaction");
String formUrl = "/ext/guestbook/update?actionURL=true" ;
String buttonText = "gn.button.update";
String titleText = "bs.guestbook.action.update";
if (!Validator.isNull(loadaction) && loadaction.equals("delete"))
{
 	formUrl = "/ext/guestbook/delete?actionURL=true" ;
 	buttonText = "gn.button.delete";
 	titleText = "bs.guestbook.action.delete";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("add"))
{
	formUrl = "/ext/guestbook/add?actionURL=true" ;
	if(hasPublish)
	buttonText = "gn.button.add";
	else
	buttonText = "send";
	titleText = "bs.guestbook.action.add";
}
else if (!Validator.isNull(loadaction) && loadaction.equals("trans"))
{
	formUrl = "/ext/guestbook/add?actionURL=true" ;
	buttonText = "gn.button.add-translation";
	titleText = "bs.guestbook.action.add-translation";
}
%>

<h1 class="title1"><%= LanguageUtil.get(pageContext, titleText) %></h1>

<html:errors property="<%= org.apache.struts.action.ActionMessages.GLOBAL_MESSAGE %>"/>


<html:form action="<%= formUrl %>" method="post" enctype="multipart/form-data">
<input type="hidden" name="loadaction" value="<%= loadaction %>">
<c:if test="<%=Validator.isNotNull(redirect) %>">
<input type="hidden" name="redirect" value="<%= redirect %>">
</c:if>

<table width="100%">
<tiles:insert page="/html/portlet/ext/struts_includes/struts_fields.jsp" flush="true">
<tiles:put name="formName" value="BsCommentForm"/>
<tiles:put name="noTable" value="true"/>
</tiles:insert>

<tiles:insert page="/html/portlet/ext/struts_includes/metaData.jsp" flush="true">
	<tiles:put name="formName" value="BsCommentForm"/>
	<tiles:put name="className" value="gnomon.hibernate.model.base.guestbook.BsGuestbook"/>
	<% com.ext.portlet.base.guestbook.BsCommentForm formBean = (com.ext.portlet.base.guestbook.BsCommentForm) request.getAttribute("BsCommentForm");
	   if (formBean != null && formBean.getMainid() != null) {%>
	<tiles:put name="primaryKey" value="<%= formBean.getMainid().toString() %>"/>
	<% } %>
	<tiles:put name="noTable" value="true"/>
</tiles:insert>

<% if (loadaction.equals("add")) { %>
<tr><td></td>
		<td>
		<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>" var="captchaURL">
			<portlet:param name="struts_action" value="/ext/guestbook/captcha" />
		</portlet:actionURL>
		<liferay-ui:captcha url="<%= captchaURL %>" />
</td>
<td>
<html:errors property="captcha-error"/>
</td>
</tr>
<% } %>
</table>


<logic:notEqual name="BsCommentForm" property="lang" value="<%= defLang %>">
	<c:if test="<%=!loadaction.equals("trans")%>">
		<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
		  <tiles:put name="action"  value="/ext/guestbook/delete" />
		  <tiles:put name="buttonName" value="deleteButton" />
		  <tiles:put name="buttonValue" value="gn.button.delete-translation" />
		  <tiles:put name="formName"   value="BsCommentForm" />
		  <tiles:put name="confirm" value="gn.messages.are-you-sure-you-want-to-delete-this-translation"/>
		  <tiles:put name="actionParam" value="deleteDetail"/>
		  <tiles:put name="actionParamValue" value="1"/>
		</tiles:insert>
	</c:if>
</logic:notEqual>

<%--
<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2">Translations</h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/faq/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="view"/>
	    <tiles:put name="addAction"  value="/ext/faq/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>
--%>
<html:submit styleClass="portlet-form-button"><%= LanguageUtil.get(pageContext, buttonText ) %></html:submit>

<c:choose>
	<c:when test="<%=Validator.isNotNull(redirect)%>">
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "cancel") %>' onClick="self.location = '<%= redirect %>';">
	</c:when>
	<c:otherwise>
	<input class="portlet-form-button" type="button" value='<%= LanguageUtil.get(pageContext, "back") %>' onClick="history.go(-1);">
	</c:otherwise>
</c:choose>

</html:form>

<br/>
<c:if test="<%=loadaction.equals("edit")%>">
	<br>
	<p><h3 class="title2"><%= LanguageUtil.get(pageContext, "gn.translations" ) %></h3><p>
	<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
		<tiles:put name="editAction"  value="/ext/guestbook/load" />
		<tiles:put name="editActionParam" value="loadaction"/>
	    <tiles:put name="editActionParamValue" value="edit"/>
	    <tiles:put name="addAction"  value="/ext/guestbook/load" />
		<tiles:put name="addActionParam" value="loadaction"/>
	    <tiles:put name="addActionParamValue" value="trans"/>
	</tiles:insert>
</c:if>

<%--
<c:if test="<%=loadaction.equals("edit")%>">
<table width="100%">
<tr>
	<td colspan="2" class="beta-gradient">
		<b><%=LanguageUtil.get(pageContext, "gn.content.translations.information")%></b>
	</td>
	<td class="beta-gradient" align="right">
		<span style="font-size: xx-small;">
		<a href="javascript: void(0);" onclick="Liferay.Util.toggleByIdSpan(this, '<portlet:namespace />translations'); self.focus();">
			<span style="display: ;">
			<img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_plus.gif" alt="<%=LanguageUtil.get(pageContext,"show")%>" />
			</span>
			<span style="display: none">
			<img src="<%= themeDisplay.getPathThemeImage() %>/arrows/02_minus.gif" alt="<%=LanguageUtil.get(pageContext,"hide")%>" />
			</span>
		</a>
		</span>
	</td>
</tr>
<tr>
	<td colspan="3">
		<div id="<portlet:namespace />translations" class="beta-gradient" style="display: none;">
			<br>
			<tiles:insert page="/html/portlet/ext/struts_includes/translationButtons.jsp" flush="true">
				<tiles:put name="editAction"  value="/ext/faq/load" />
				<tiles:put name="editActionParam" value="loadaction"/>
			    <tiles:put name="editActionParamValue" value="edit"/>
			    <tiles:put name="addAction"  value="/ext/faq/load" />
				<tiles:put name="addActionParam" value="loadaction"/>
			    <tiles:put name="addActionParamValue" value="trans"/>
			</tiles:insert>
			<br><br>
		</div>
	</td>
</tr>
</table>
</c:if>
--%>
<% } catch (Exception e) { e.printStackTrace(); } %>