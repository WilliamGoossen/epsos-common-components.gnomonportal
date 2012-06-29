<%@ page session="true" contentType="text/html; charset=ISO-8859-1" %>
<%@ taglib uri="http://www.tonbeller.com/jpivot" prefix="jp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<jp:mondrianQuery id="query01" jdbcDriver="net.sourceforge.jtds.jdbc.Driver" jdbcUrl="jdbc:jtds:sqlserver://194.219.31.206:1433/gi9_obsind;tds=8.0;lastupdatecount=true" jdbcUser="sa" jdbcPassword="olimpos" 
catalogUri="/WEB-INF/queries/obsind.xml">
select {([mondrian.etos].[All mondrian.etos],[mondrian.perfecture].[All mondrian.perfecture])} on columns,
 {[mondrian.deiktis].[All mondrian.deiktis]} on rows
  from obsind
</jp:mondrianQuery>

