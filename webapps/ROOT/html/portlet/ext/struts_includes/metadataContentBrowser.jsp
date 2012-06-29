<%@ include file="/html/common/init.jsp" %>

<%@ page import="javax.portlet.RenderResponse" %>
<%@ page import="javax.portlet.PortletRequest" %>
<%@ page import="javax.portlet.RenderRequest" %>
<%@ page import="javax.portlet.PortletPreferences" %>

<%@ page import="com.liferay.portal.util.WebKeys" %>
<%@ page import="com.liferay.portlet.RenderRequestImpl" %>
<%@ page import="com.liferay.portlet.ActionRequestImpl" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>

<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>

<%@ page import="gnomon.hibernate.model.gn.GnContent" %>

<%@ page import="gnomon.hibernate.model.gn.kms.ViewKmsPropertyValue" %>
<%@ page import="gnomon.hibernate.model.gn.kms.ViewKmsPropertyValueLanguage" %>
<%@ page import="gnomon.hibernate.model.gn.kms.ViewKmsContentMetadata" %>

<%@ page import="gnomon.business.GeneralUtils" %>

<%@ page import="com.ext.portlet.permissions.service.PermissionsService" %>

<tiles:useAttribute id="struts_action" name="struts_action" classname="java.lang.String"/>
<tiles:useAttribute id="tilesParamList" name="actionParamList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="tilesParamValueList" name="actionParamValueList" classname="java.util.List" ignore="true"/>
<tiles:useAttribute id="contentClassName" name="contentClass" classname="java.lang.String"/>
<tiles:useAttribute id="propertyName" name="propertyName" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="commandSpace" name="commandSpace" classname="java.lang.String" ignore="true"/>
<tiles:useAttribute id="rootMetadataId" name="metadataId" classname="java.lang.String" ignore="true"/>




<%
try {
Class contentClass = Class.forName(contentClassName);
if (GnContent.class.isAssignableFrom(contentClass))
{
	PortletRequest portletRequest = (PortletRequest)request.getAttribute(com.liferay.portal.kernel.util.JavaConstants.JAVAX_PORTLET_REQUEST);
	String portletId = null;
	PortletPreferences prefs = null;
	if (portletRequest instanceof RenderRequest)
	{
		RenderRequestImpl req = (RenderRequestImpl)portletRequest;
		portletId = req.getPortletName();
		prefs= req.getPreferences();
	}
	else
	{
		ActionRequestImpl req = (ActionRequestImpl)portletRequest;
		portletId = req.getPortletName();
		prefs = req.getPreferences();
	}
	//in case of an instanciable portlet, portlet name is <myportlet>_INSTANCE_<XX>
	//portletId = portletId.substring(0,portletId.indexOf("_INSTANCE"));
	PermissionsService permServ = PermissionsService.getInstance();
	String lang = GeneralUtils.getLocale(request);
	Long companyId = PortalUtil.getCompanyId(request);

Integer selCompanyId=null;


		 
	%>
	<table width="100%" border="0">
	<%
		GnPersistenceService serv = GnPersistenceService.getInstance(null);
		
		
		// if we dont have a property list the available field codes
		if(propertyName==null || propertyName.equals("")) {
			
				List<ViewResult> fieldTopics = null;
			fieldTopics = permServ.listCallMetadataFields(null,selCompanyId, contentClassName, lang);
			
			for (ViewResult childTopic: fieldTopics)
		{
			
		
			if (true) {  //|| childContentCount > 0*/) 
			%>
			<li><a href="<portlet:actionURL>
				<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
						<portlet:param name="propertyName" value="<%= childTopic.getField1().toString() %>"/>
				<%
				if (tilesParamList != null && tilesParamList.size() > 0) {
					for (int t=0; t<tilesParamList.size(); t++){
					%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
					<%
					}
				}
				%>
			</portlet:actionURL>"><%= childTopic.getField2().toString() %> </a></li>
			<%
			}
			else
			{
			%>
			<li><%= childTopic.getField2().toString() %> </li>
			<%
			}
		}
		}
		else {
		
		
		List<ViewResult> rootTopicsList = null;
		
		ViewKmsPropertyValue topic = null;	
		List<ViewKmsPropertyValue> currentTopics = null;

		if (rootMetadataId == null)
				rootMetadataId = request.getParameter("metadataid");
				
				
		if(rootMetadataId!=null && !rootMetadataId.equals("")) {
			String criteria ="table1.mainid=" + rootMetadataId + " and table1.className='" + contentClassName +"' ";
			if(selCompanyId!=null)
			criteria+= " and table1.partyId=" + selCompanyId;
			
			
			currentTopics = serv.listObjects(null,ViewKmsPropertyValue.class,criteria);
			
			if(currentTopics!=null && currentTopics.size()>0) {
				
				topic = currentTopics.get(0);
			}
		}
		
		
		rootTopicsList = permServ.listCallMetadataOptions(null,selCompanyId, contentClassName, propertyName,lang);
		%>
		<!--- PATH -->
			<tr>
    			<td colspan="3" scope="col" align="left">&nbsp;
    			<span class="title2">
    		<a href="<portlet:actionURL>
				<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
						<portlet:param name="propertyName" value=""/>
				<%
				if (tilesParamList != null && tilesParamList.size() > 0) {
					for (int t=0; t<tilesParamList.size(); t++){
					%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
					<%
					}
				}
				%>
			</portlet:actionURL>">ROOT </a>
			
			<%
			
				List<ViewResult> rootProperty= permServ.getCallMetadataField(null, selCompanyId, contentClassName,propertyName ,lang );
			if(rootProperty!=null && rootProperty.size()>0) {
				
			ViewResult	curPorperty = rootProperty.get(0);
			
			/// PRINT THE PROPERY FIRST%>
			
			>&nbsp;<a href="<portlet:actionURL>
				<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
						<portlet:param name="propertyName" value="<%= curPorperty.getField1().toString() %>"/>
				<%
				if (tilesParamList != null && tilesParamList.size() > 0) {
					for (int t=0; t<tilesParamList.size(); t++){
					%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
					<%
					}
				}
				%>
			</portlet:actionURL>"><%= curPorperty.getField2().toString() %> </a>
			
			<%}
					
		
		try {
			
			String[] fields = new String[]{"table1.mainid", "langs.name"};
		if (topic != null)
		{
			
		
			
			
			String allParents = topic.getAllParents();
			allParents += topic.getMainid()+",";
			String[] parentIds = allParents.split(",");
			// filter out parents that are above the root topics for this portlet
			int p = 0;
			for (p=0; p<parentIds.length; p++)
			{
				boolean foundRoot =  false;
				for (ViewResult rootTopicView: rootTopicsList)
				{%>
					
					<%
					if (rootTopicView.getField1().toString().equals(parentIds[p]))
					{
						foundRoot = true;
						break;
					}
				}
				if (foundRoot)
					break;
			}
			// p holds the index before which we want to ignore the parents
			if (p != parentIds.length)
			{
				String[] temp = new String[parentIds.length-p];
				System.arraycopy(parentIds, p, temp, 0 , parentIds.length-p-1);
				parentIds = temp;
			}
			%>
			<%
			if (parentIds.length>0) { %>
		
			<%
			for (p=0; p<parentIds.length; p++)
			{
				String parentId = parentIds[p];
				if (parentId != null && !parentId.equals(""))
				{
					ViewResult topicView = serv.getObjectWithLanguage(ViewKmsPropertyValue.class, Integer.valueOf(parentId), lang, fields);
					%>
						>&nbsp;<a class="beta1" href="
					<portlet:actionURL>
					<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
					<portlet:param name="metadataid" value="<%= parentId %>"/>
					<portlet:param name="propertyName" value="<%= propertyName %>"/>
					<%
					if (tilesParamList != null && tilesParamList.size() > 0) {
						for (int t=0; t<tilesParamList.size(); t++){
						%>
							<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
						<%
						}
					}
					%>
					</portlet:actionURL>"><%= topicView.getField2() %></a>
					<%
										
				}
			}
			%>
			
			<% }
			}%>
			
			
	
<%} catch(Exception e) {
	e.printStackTrace();
}%>
	
	</span><br>
				</td>
  			</tr>
  			
  			<tr><td>&nbsp;</td></tr>
			<!-- END PATH -->
			
			<%
		
		// now render children of topic
		List<ViewResult> childrenTopics = null;
		if (topic != null)
					childrenTopics = permServ.listCallMetadataOptions(null,selCompanyId, contentClassName, propertyName,topic.getMainid(),lang);
		else
			childrenTopics = rootTopicsList;
		%>
		<tr>
			<td colspan="3">
		<ul>
		<%
		for (ViewResult childTopic: childrenTopics)
		{
			int childContentCount = 0;
			String criteria ="(table1.viewKmsPropertyValue.mainid = "+childTopic.getMainid()+" or table1.viewKmsPropertyValue.allParents like '%,"+childTopic.getMainid()+",%' ) and table1.viewKmsPropertyValue.className = '"+ contentClassName+"' and  table1.viewKmsPropertyValue.mainid=table1.optionId and table1.lang='" +GeneralUtils.getLocale(request) +"'";
			if(selCompanyId!=null)
			criteria+= " and table1.partyId=" + selCompanyId;
			
			List contentCount = serv.listObjects(null,ViewKmsContentMetadata.class,criteria);
			
			
			childContentCount = contentCount.size();
		
			if ( childContentCount > 0)  {
			%>
			<li><a href="<portlet:actionURL>
				<portlet:param name="struts_action" value="<%= struts_action.toString() %>"/>
				<portlet:param name="metadataid" value="<%= childTopic.getMainid().toString() %>"/>
				<portlet:param name="propertyName" value="<%= childTopic.getField3().toString() %>"/>
				<%
				if (tilesParamList != null && tilesParamList.size() > 0) {
					for (int t=0; t<tilesParamList.size(); t++){
					%>
						<portlet:param name="<%= tilesParamList.get(t).toString() %>" value="<%= tilesParamValueList.get(t).toString() %>"/>
					<%
					}
				}
				%>
			</portlet:actionURL>"><%= childTopic.getField1().toString() %> <i>(<%= childContentCount %>)</i></a></li>
			<%
			}
			else
			{
			%>
			<li><%= childTopic.getField1().toString() %> <i>(<%= childContentCount %>)</i></li>
			<%
			}
		}
		%>
		
		</ul>
			</td>
		</tr>
		
	<%}%>
		</table>


		<table width="100%" border="0" style="none">
		<tr>
			<td width="160">&nbsp;</td>
			<td colspan="3">
				<% if ((commandSpace!=null) && (!commandSpace.equals(""))) { %>
					<tiles:insert page="<%=commandSpace%>" flush="true"/>
				<% } %>
			</td>
		</tr>
		</table>
		
	<% 
}
%>

<%  } catch (Exception e) { 
		e.printStackTrace();
	}%>
	
