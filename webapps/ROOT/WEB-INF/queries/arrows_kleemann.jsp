<%@ page session="true" contentType="text/html; charset=ISO-8859-1" %>
<%@ taglib uri="http://www.tonbeller.com/jpivot" prefix="jp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>

<%--
  the values for "arrow=xxx" are the names of the images jpivot/jpivot/table/arrow-xxx.gif
--%>

<jp:mondrianQuery id="query01" jdbcDriver="net.sourceforge.jtds.jdbc.Driver" jdbcUrl="jdbc:jtds:sqlserver://194.219.31.206:1433/kleemann;tds=8.0;lastupdatecount=true" jdbcUser="sa" jdbcPassword="olimpos" 
catalogUri="/WEB-INF/queries/test1.xml">
select {[OR_OrderLine.suborderid].[All or_orderline.suborderid]} on columns,
 {[OR_OrderLine.price].[All OR_OrderLine.price]} on rows
  from test2
</jp:mondrianQuery>

<c:set var="title01" scope="session">Arrows</c:set>
