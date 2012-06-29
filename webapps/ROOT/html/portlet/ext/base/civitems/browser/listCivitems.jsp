<%@ include file="/html/portlet/ext/base/civitems/init.jsp" %>
<%@ taglib prefix="display" uri="http://displaytag.sf.net" %>

<%
List Civitems=(List)request.getAttribute("civitems");


if(Civitems ==null || Civitems.isEmpty()){
%>
<%=LanguageUtil.get(pageContext, "fof.course_list.no_course")%>
<%} %>
<!-- CivItems List -->
<display:table id="civitem" name="civitems" requestURI="//ext/civitemsbrowser/list?actionURL=true" pagesize="10" sort="list" export="false" style="font-weight: normal; width: 100%; border-spacing: 0">
<% ViewResult gnItem = (ViewResult) pageContext.getAttribute("civitem"); %>
<display:column titleKey="title" sortable="true" style="width:100%">
<a href="<portlet:actionURL>
		<portlet:param name="struts_action" value="/ext/civitemsbrowser/load"/>
		<portlet:param name="mainid" value="<%= gnItem.getMainid().toString() %>"/>
		<portlet:param name="loadaction" value="view"/>
		<portlet:param name="redirect" value="<%=currentURL%>"/>
		</portlet:actionURL>"><%= gnItem.getField6().toString() %></a>
</display:column>

<%--display:column property="field3" titleKey="bs.civitems.code" sortable="true"/--%>



</display:table>
<br/><br/>

<% if (PortletPermissionUtil.contains(permissionChecker, plid, "GN_CIV_ITEMS", "add")) { %>
<%--form name="BsCivItemForm" action="/ext/civitemsbrowser/load" method="post">
<fieldset>
<legend><%= LanguageUtil.get(pageContext, "gn.button.add") %></legend>
	<span><%= LanguageUtil.get(pageContext, "bs.civitems.metadata.type") %></span>
	<select name="metadataClassId">
		<option name="" value=""></option>
	<%
		java.util.List classes = gnomon.hibernate.GnPersistenceService.getInstance(null).listObjects(null, 
			gnomon.hibernate.model.gn.kms.GnKmsClass.class, 
			"table1.className like 'bs.civitems.metadata.%' and table1.mainid in (select c.gnKmsClass.mainid from gnomon.hibernate.model.gn.kms.GnKmsClassAspect c where c.companyId = "+
			com.liferay.portal.util.PortalUtil.getCompanyId(request)+")", "table1.className");
		if (classes != null && classes.size() > 0) 
		{
			for (int i=0; i<classes.size(); i++)
			{
				gnomon.hibernate.model.gn.kms.GnKmsClass kmsClass = (gnomon.hibernate.model.gn.kms.GnKmsClass)classes.get(i);
				%>
				<option name="<%= kmsClass.getClassName() %>" value="<%= kmsClass.getMainid() %>"><%= LanguageUtil.get(pageContext, kmsClass.getClassName()) %></option>
				<%
			}
		}
		%>
	</select>
	<tiles:insert page="/html/portlet/ext/struts_includes/button.jsp" flush="true">
	  <tiles:put name="action"  value="/ext/civitemsbrowser/load" />
	  <tiles:put name="buttonName" value="addButton" />
	  <tiles:put name="buttonValue" value="gn.button.add" />
	  <tiles:put name="formName"   value="BsCivItemForm" />
	  <tiles:putList name="actionParamList">
	  	<tiles:add value="redirect"/>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add value="topicid"/>
	  	<% } %>
	  </tiles:putList>
	 	<tiles:putList name="actionParamValueList">
	  	<tiles:add><%=currentURL%></tiles:add>
	  	<% if (Validator.isNotNull(request.getParameter("topicid"))) { %>
	  		<tiles:add><%= request.getParameter("topicid") %></tiles:add>
	  	<% } %>
	  </tiles:putList>
	  <tiles:put name="actionParam" value="loadaction"/>
	  <tiles:put name="actionParamValue" value="add"/>
	  <tiles:put name="actionPermission" value="add"/>
	  <tiles:put name="partyRoleActionPermission" value="add"/>
	  <tiles:put name="portletId" value="<%=portletID %>"/>
	</tiles:insert>
</fieldset>	
</form--%>
<% } %>
