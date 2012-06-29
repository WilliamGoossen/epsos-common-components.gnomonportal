<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="gnomon.business.GeneralUtils" %>

<tiles:useAttribute id="rootID" name="rootID" classname="java.lang.String"/>
<tiles:useAttribute id="selectedID" name="selectedID" classname="java.lang.String"/>

<liferay-ui:error key="contacts.highrole.delete-error" message="contacts.highrole.delete-error"/>
<liferay-ui:error key="contacts.highrole.delete-from-orgchart-error" message="contacts.highrole.delete-from-orgchart-error"/>

<div class="uni-form">

<fieldset class="inline-labels">

<legend><%= LanguageUtil.get(pageContext, "contacts.orgchart.view") %></legend>

<% com.ext.portlet.parties.contacts.orgchart.LoadTreeDescriptionHelper.render(request); %>

<br>
<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
<br>

</fieldset>
</div>

