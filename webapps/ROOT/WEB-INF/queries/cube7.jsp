<%@ page contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="/WEB-INF/jpivot/jpivot-tags.tld" prefix="jp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>

<%
String lang = null;
if (lang == null) lang="el_GR";
%>
<jp:mondrianQuery id="query01"
jdbcDriver="net.sourceforge.jtds.jdbc.Driver"
jdbcUrl="jdbc:jtds:sqlserver://192.168.1.20:1433/gi9_eproject_II_TEST_update_scripts_7;tds=8.0;lastupdatecount=true" jdbcUser="sa" jdbcPassword="olimpos"
 catalogUri="/WEB-INF/queries/cube7.xml">
select {([VW_REP_REPORTED_TIME_BY_CONSULTANT2.CONSULTANT].[All VW_REP_REPORTED_TIME_BY_CONSULTANT2.CONSULTANT]
)} on rows,
 {[Measures].[SUM of VW_REP_REPORTED_TIME_BY_CONSULTANT2.REAL_HOURS],
  [Measures].[SUM of VW_REP_REPORTED_TIME_BY_CONSULTANT2.HOURS_CONV]
  } on columns
  from a1
</jp:mondrianQuery>

