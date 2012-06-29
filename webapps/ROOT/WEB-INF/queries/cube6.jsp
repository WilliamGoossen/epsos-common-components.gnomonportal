<%@ page session="true" contentType="text/html; charset=UTF-8" %>
%@ taglib uri="/WEB-INF/jpivot/jpivot-tags.tld" prefix="jp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%
String lang = null;
if (lang == null) lang="el_GR";
%>

<jp:mondrianQuery id="query01" jdbcDriver="net.sourceforge.jtds.jdbc.Driver"
jdbcUrl="jdbc:jtds:sqlserver://194.219.31.206:1433/gi9_obsind;tds=8.0;lastupdatecount=true" jdbcUser="sa" jdbcPassword="olimpos"
dynLocale="<%=lang %>" dynResolver="mondrian.i18n.LocalizingDynamicSchemaProcessor"
catalogUri="/WEB-INF/queries/cube6.xml">

select {([mondian_Table6.deiktis],[mondian_Table6.Etos].[All mondian_Table6.etos],[mondian_Table6.nomos])} on rows,

{[Measures].[SUM of mondian_Table6.timi]} on columns
  from cube6
</jp:mondrianQuery>



