<%@ include file="/html/portlet/ext/jbpm/init.jsp" %>

<%--html:link styleClass="beta1" page="/ext/jbpm/listTasks?onlyMyTasks=1" >
	<img src="<%=themeDisplay.getPathThemeImage()%>/common/back.gif" border="0" align="absmiddle">
	<%= LanguageUtil.get(pageContext, "projectMgmt.onlyMyTasks") %>
</html:link--%>
<display:table id="aListItem" name="userTasks" pagesize="50" requestURI="//ext/jbpm/listTasks?actionURL=true" sort="list" >

<%org.apache.commons.beanutils.BasicDynaBean bean = (org.apache.commons.beanutils.BasicDynaBean) aListItem;
	String taskIdStr = null;
	String instanceIdStr = null;
String taskName="";
String procId=null;
	if (bean  != null){
		taskIdStr = (bean.get("taskId") != null) ? bean.get("taskId").toString() : null;
		instanceIdStr = (bean.get("instanceId") != null) ? bean.get("instanceId").toString() : null;
		taskName=(String)bean.get("taskName");
			procId=(bean.get("procId") != null) ? bean.get("procId").toString() : null;
	}

%>


<!--display:column property="taskId" title="taskId" /-->
<!-- display:column property="instanceId" title="instanceId" / -->


<!--display:column titleKey=".jbpm.userTasks.defName"-->
<%//= LanguageUtil.get(pageContext, (String)bean.get("DEFNAME"))%>
<!--/display:column-->

<display:column titleKey="jbpm.userTasks.taskName" sortable="true" sortProperty="taskName">
	<a  href="<liferay-portlet:actionURL >
				<liferay-portlet:param name='struts_action' value='/ext/jbpm/viewTask' />
				<liferay-portlet:param name='taskName' value='<%=taskName%>' />
				<%if(taskIdStr!=null){%><liferay-portlet:param name='taskId' value='<%=instanceIdStr%>' /><%}%>
				<%if(instanceIdStr!=null){%><liferay-portlet:param name='instanceId' value='<%=taskIdStr%>' /><%}%>
				<%if(procId!=null){%><liferay-portlet:param name='proccessId' value='<%=procId%>' /><%}%>
			</liferay-portlet:actionURL>">
<%= LanguageUtil.get(pageContext, "jbpm.userTasks."+(String)bean.get("taskName"))%></a>
</display:column>
<display:column property="createDate" titleKey="jbpm.userTasks.createDate" sortable="true" decorator="org.displaytag.sample.LongDateTimeWrapper"/>
<%--display:column property="startDate" titleKey=".jbpm.userTasks.startDate" sortable="true" decorator="org.displaytag.sample.LongDateWrapper"/>

<display:column property="endDate" titleKey=".jbpm.userTasks.endDate" sortable="true" decorator="org.displaytag.sample.LongDateWrapper"/--%>
<display:column property="varValue" titleKey="jbpm.userTasks.description" sortable="true"/>

</display:table>



