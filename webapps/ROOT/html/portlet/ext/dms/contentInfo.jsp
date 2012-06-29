<%@ include file="/html/portlet/ext/dms/init.jsp" %>
<%
com.ext.portlet.dms.util.AlfrescoRow ar = (com.ext.portlet.dms.util.AlfrescoRow)request.getAttribute("ar");
org.alfresco.webservice.util.AuthenticationDetails details=(org.alfresco.webservice.util.AuthenticationDetails)request.getSession().getAttribute("authdetails");
String parentuuid = request.getParameter("parentuuid");
if (Validator.isNull(parentuuid)) parentuuid=ar.getParentuuid();
%>
<liferay-portlet:renderURL portletConfiguration="false" varImpl="portletURL" />
<% String breadcrumbs = AlfrescoContentUtil.createBreadcrumb(details,parentuuid,(com.liferay.portlet.PortletURLImpl)portletURL,instanceUuid); %>
<portlet:actionURL windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>" var="downloadURL">
	<portlet:param name="struts_action" value="/ext/dms/getfile" />
	<portlet:param name="uuid" value="<%= ar.getUuid() %>" />
	<portlet:param name="instanceUuid" value="<%= instanceUuid %>" />
	<portlet:param name="filename" value="<%= ar.getName() %>" />
</portlet:actionURL>
<table
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.folder") %></td>
<td><%=breadcrumbs%></td>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.name") %></td>
<td><a href="<%=downloadURL%>"><%=ar.getName()%></a></td>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.title") %></td>
<td><%=ar.getTitle()%></td>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.description") %></td>
<td><%=ar.getDescription()%></td>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.creator") %></td>
<td>
<%
String alfresco_useridtype=PropsUtil.get("alfresco.useridtype");
%>
<%= gnomon.business.SynchronizeAccountUtil.getInstance().getAlfrescoLoginName(alfresco_useridtype,ar.getCreator()+"") %>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.mofifier") %></td>
<td>
<%= gnomon.business.SynchronizeAccountUtil.getInstance().getAlfrescoLoginName(alfresco_useridtype,ar.getModifier()+"") %>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.created") %></td>
<td><%=gnomon.business.DateUtils.convertDate(ar.getCreated(),"yyyy-MM-dd'T'hh:mm:ss.SSS","dd-MM-yyyy HH:mm:ss")%></td>
</tr>
<tr>
<td><%= LanguageUtil.get(pageContext, "dms.modified") %></td>
<td><%=gnomon.business.DateUtils.convertDate(ar.getModified(),"yyyy-MM-dd'T'hh:mm:ss.SSS","dd-MM-yyyy HH:mm:ss")%></td>
</tr>
</table>