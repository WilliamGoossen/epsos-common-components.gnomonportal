<%@ include file="/html/portlet/ext/parties/init.jsp" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.beanutils.*" %>

<table width="100%">

<tr>

<td valign=top>
<tiles:insert page="/html/portlet/ext/struts_includes/treeView.jsp" flush="true"/>
</td>

<td>

</td>

</tr>
</table>
<br>
<hr>
<html:link styleClass="beta1" action="/ext/parties/orgchart/viewCharts"><img src="/html/themes/classic/images/common/back.png" border="0" align="absmiddle">&nbsp;<%= LanguageUtil.get(pageContext, "parties.orgchart.back-to-orgcharts") %></html:link>

