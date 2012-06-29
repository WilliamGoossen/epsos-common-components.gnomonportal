<%@ include file="/html/portlet/ext/jbpm/init.jsp" %>
<%@page import="org.displaytag.decorator.DecoratorFactory"%>
<%@page import="org.displaytag.sample.LongDateWrapper"%>
<script language="JavaScript" src="/html/js/editor/modalwindow.js"></script>


<%@ page import="gnomon.hibernate.model.parties.PaParty" %>
<%@ page import="gnomon.hibernate.model.parties.PaPerson" %>
<%@ page import="gnomon.hibernate.model.views.ViewResult" %>
<%@ page import="gnomon.hibernate.GnPersistenceService" %>
<%@ page import="gnomon.hibernate.PartiesService" %>
<%@ page import="gnomon.business.GeneralUtils" %>
<%@ page import="com.liferay.portal.kernel.portlet.LiferayWindowState" %>


<%
try
{
String lang=GeneralUtils.getLocale(request);
%>

<table border="0" width="100%">
<% if  (request.getAttribute("definitions")!=null && !((List)request.getAttribute("definitions")).isEmpty()) { %>
<tr>
<td width="100%">

<%

PortletURL redirectURL = new PortletURLImpl(request, "93", plid, false);
redirectURL.setParameter("struts_action", "/workflow/eview");

PortletURL rowURL = new PortletURLImpl(request, "93", plid, true);
rowURL.setWindowState(WindowState.MAXIMIZED);
rowURL.setPortletMode(PortletMode.VIEW);
List results = (List)request.getAttribute("definitions");
DefinitionSearch searchContainer = new DefinitionSearch(renderRequest, rowURL);
searchContainer.setResults(results);
List resultRows = searchContainer.getResultRows();

for (int i = 0; i < results.size(); i++)
{
	WorkflowDefinition definition = (WorkflowDefinition)results.get(i);
	String definitionId = String.valueOf(definition.getDefinitionId());
	ResultRow row = new ResultRow(definition, definitionId, i);
	//rowURL = renderResponse.createRenderURL();
	rowURL.setWindowState(WindowState.MAXIMIZED);
	rowURL.setParameter("struts_action", "/workflow/edit_instance");
	rowURL.setParameter("redirect", redirectURL.toString());
	rowURL.setParameter("definitionId", definitionId);
	rowURL.setParameter(Constants.CMD, Constants.ADD);
	// row.setParameter("rowHREF", rowURL.toString());
	// Definition name
	row.addText(LanguageUtil.get(pageContext, definition.getName()), rowURL);
	// Definition version
	// row.addText(String.valueOf(definition.getVersion()), rowURL);
	// Action
	row.addJSP("right", SearchEntry.DEFAULT_VALIGN, "/html/portlet/ext/jbpm/definition_action.jsp");
	// Add result row
	resultRows.add(row);


%>
				<tr>
					<td><a href="<%=  rowURL.toString()%>"><%= LanguageUtil.get(pageContext, definition.getName()) %></a></td>
					<%} %>
					</td>
				</tr>

</td>
</tr>
<% } %>

</table>


<%
}
catch(Exception ex){
	ex.printStackTrace();
}
%>
